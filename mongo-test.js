import dotenv from "dotenv";
dotenv.config();

import { MongoClient } from "mongodb";

const uri = process.env.MONGO_URI;
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const db = client.db("hackworm"); // nombre de base de datos
    const collection = db.collection("prueba"); // nombre de colección

    await collection.insertOne({
      mensaje: "esto es otra prueba",
      fecha: new Date(),
    });

    console.log("✅ Documento insertado");
  } catch (e) {
    console.error("❌ Error:", e);
  } finally {
    await client.close();
  }
}

run();
