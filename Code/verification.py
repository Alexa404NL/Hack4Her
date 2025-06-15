import whisper
import sounddevice as sd
from scipy.io.wavfile import write
from hash_salt import *
import re
import bcrypt
from credentials_setting import *
from system_speak import *
from user_setup import *
import os
from dotenv import load_dotenv
load_dotenv()

#load model
path = os.getenv("ANSWERS_PATH")
model = whisper.load_model("small")
fs = 44100  # Sample rate
seconds = 3  # Duration of recording
load_dotenv("./env")
config = dotenv_values(".env")
uri = os.getenv("MONGO_URI")
client = MongoClient(uri, server_api=ServerApi('1'))
db = client.myDatabase
users_collection = db["users"]


def verify_hash(stored_password, provided_password):
    try:
        print("Verifying hash...")
        hashed = hash_salt(provided_password)
       # print("Stored password:", stored_password)
       # print("Hashed provided password:", hashed)
        return stored_password == hashed
    except Exception as e:
        print("Error verifying hash:", e)
        return False


def verify():
    speak("Welcome to the verification process. Please follow the instructions.")
    options = ["yes", "no"]
    speak("Use existing user? Please say yes or no.")
    recording = sd.rec(int(seconds * fs), samplerate=fs, channels=2)
    sd.wait()
    write(path + "verification_answer.mp3", fs, recording)
    print(path + "verification_answer.mp3")
    result = model.transcribe(path + "verification_answer.mp3")
    answer = result["text"].lower()
    answer = re.sub("[^A-Z]", "", answer, 0, re.IGNORECASE) 
    #answer = "yes"  # For testing purposes, replace with actual input
    print(answer)   
    if users_collection.count_documents({}) == 0 or answer == "no":
        speak("Let's set up a new user.")
        user_setup()
        return
    elif answer == "yes" or answer == "Yes":
        speak("Proceeding with user verification.")
        # Username input
        speak("Please say your username")
        recording = sd.rec(int(seconds * fs), samplerate=fs, channels=2)
        sd.wait()
        write(path + "username_input.mp3", fs, recording)
        result = model.transcribe(path + "username_input.mp3")
        username = result["text"].lower()
        username = re.sub('\W+', '', username)
        #username="john"# For testing purposes, replace with actual input
        print(username)
        #Password input
        speak("Please say your passphrase")
        recording = sd.rec(int(seconds * fs), samplerate=fs, channels=2)
        sd.wait()
        write(path + "passphrase_input.mp3", fs, recording)
        result = model.transcribe(path + "passphrase_input.mp3")
        pwd = result["text"].lower()
        pwd = re.sub('\W+', '', pwd)
        #pwd = "admin"# For testing purposes, replace with actual input
        print(pwd)
        user_record = users_collection.find_one({"username": username})
        if not user_record:
            print("User not found.")
            return False

    stored_password = user_record["password"].encode('utf-8')  # convert back to bytes
    provided_password = pwd.encode()

    print("Stored password:", stored_password)
    print("Provided password:", pwd)

    print("Verifying hash...")
    if bcrypt.checkpw(provided_password, stored_password):
        print("Password match.")
        return True
    else:
        print("Password does not match.")
        return False