from fastapi import FastAPI
from verification import verify
from user_setup import user_setup
from credentials_setting import *
from fastapi.responses import JSONResponse

app = FastAPI()

@app.get("/login")
def login():
    try:
        result = verify()
        if result:
            speak("Verification successful. Welcome back!")
            return {"status": "success", "message": "Verified"}
        else:
            speak("Verification failed.")
            return {"status": "fail", "message": "Verification failed"}
    except Exception as e:
        return JSONResponse(status_code=501, content={"error": str(e)})

# @app.post("/signup")
# def signup():
#     try:
#         speak("Setting up new user.")
#         user_setup()
#         speak("User setup completed.")
#         return {"status": "success", "message": "User created"}
#     except Exception as e:
#         return JSONResponse(status_code=500, content={"error": str(e)})




