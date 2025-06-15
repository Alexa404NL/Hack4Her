from user_setup import *
from verification import *
from credentials_setting import *

#user_setup()
state=verify()
if state:
    speak("Verification successful. Welcome back!")
else:
    speak("set up a new user.")
    user_setup()
    speak("User setup completed. You can now try to verify again.")
    verify()



