// Cargar variables de entorno desde .env
import dotenv from "dotenv";
dotenv.config();

// Importamos la librería de Gemini
import { GoogleGenerativeAI } from "@google/generative-ai";

// Importamos readline para recibir texto del usuario
import readline from "readline";

// Creamos la interfaz de consola
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Tomamos la API key desde el archivo .env
const API_KEY = process.env.API_KEY;
const ai = new GoogleGenerativeAI(API_KEY);

// Función principal
async function main() {
  rl.question("¿Qué quieres preguntarle a Gemini?\n> ", async (input) => {
    const model = ai.getGenerativeModel({ model: "gemini-1.5-flash" });

    const result = await model.generateContent(input);
    const response = await result.response;

    console.log("\n🧠 Respuesta de Gemini:");
    console.log(response.text());

    rl.close();
  });
}

main();


