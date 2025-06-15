import whisper
import sounddevice as sd
from scipy.io.wavfile import write
from hash_salt import *
import re
import yaml
import os
from system_speak import *
from dotenv import load_dotenv, dotenv_values
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv
load_dotenv()


#load model
path = os.getenv("ANSWERS_PATH")
model = whisper.load_model("small")
fs = 44100  # Sample rate
seconds = 3  # Duration of recording
load_dotenv("./Code./env")
config = dotenv_values(".env")
uri = os.getenv("MONGO_URI")
client = MongoClient(uri, server_api=ServerApi('1'))



# Enviar un ping para confirmar una conexión exitosa
try:
    # Connect to MongoDB
    client = MongoClient(uri, server_api=ServerApi('1'))
    db = client.myDatabase
    users_collection = db["users"]

    # Ping to confirm connection
    client.admin.command("ping")
    print("Pinged your deployment. Successfully connected to MongoDB!")

except ConnectionFailure as e:
    print("Failed to connect to MongoDB:", e)
    exit(1)


#setting username
def username_setup():
    usernameList = []  # Dummy list for testing
    speak("Please speak into the microphone your desire username 1 time.")
    speak("Now setting the username")
    for i in range(1):
        speak("This is recording number " + str(i + 1))
        username_record = sd.rec(int(seconds * fs), samplerate=fs, channels=2)
        print("recording...")
        sd.wait()
        print("finished")
        write(path + "username.mp3", fs, username_record)
        result = model.transcribe(path + "username.mp3")
        output = result["text"].lower()
        usernameList.append(re.sub('\W+','', output)) #eliminate special characters and spaces
    return usernameList


#setting password    
def pass_setup():
    passList = []  # Dummy list for testing
    speak("Please speak into the microphone your desire passphrase 1 time.")
    speak("Now setting up password")
    for i in range(1):
        speak("This is recording number " + str(i + 1))
        myrecording = sd.rec(int(seconds * fs), samplerate=fs, channels=2)
        print("recording...")
        sd.wait()  # Wait until recording is finished
        print("finished")
        write(path + "audio" + str(i) + ".mp3", fs, myrecording)  # Save as mp3 file  
        result = model.transcribe(path + "audio" + str(i) + ".mp3")
        output = result["text"].lower() 
        passList.append(re.sub('\W+','', output)) #eliminate special characters and spaces
    return passList

#Compare the user's attempts to prompt for retry
def compareElements(list):
    element = list[0]
    check = True
    # Comparing each element with first item
    for item in list:
        if element != item:
            check = False
            break
    if (check == True):
        return check
    else:
        return False

output_file = os.path.join(path, "output.yaml")
d = {}
def database(username, pwd):
    global d

    # Check if user already exists
    existing_user = users_collection.find_one({"username": username})
    if existing_user:
        print(f"User '{username}' already exists in the database.")
    else:
        hashed = hash_salt(pwd)
        # Save to MongoDB
        users_collection.insert_one({"username": username, "password": hashed.decode('utf-8')})
        print(f"User '{username}' added to MongoDB.")

        # Save to YAML file
        d[username] = hashed
        if not os.path.exists(output_file):
            with open(output_file, 'w') as file:
                yaml.dump(d, file)
        else:
            with open(output_file, 'a') as file:
                yaml.dump(d, file)
    return d

