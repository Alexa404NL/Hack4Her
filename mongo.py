import os
from dotenv import load_dotenv, dotenv_values
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

# Cargamos las variables de entorno desde el archivo .env
load_dotenv()
config = dotenv_values(".env")

# Usamos la URI desde el archivo .env
uri = config["MONGO_URI"]  # Asegúrate de tener MONGO_URI en tu .env

# Crear un nuevo cliente y conectarse al servidor
client = MongoClient(uri, server_api=ServerApi('1'))

# Enviar un ping para confirmar una conexión exitosa
try:
    client.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)

