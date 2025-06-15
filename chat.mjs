// Importamos la librería oficial de Gemini
import { GoogleGenerativeAI } from "@google/generative-ai";

// Coloca tu API Key aquí entre comillas
const ai = new GoogleGenerativeAI(API_KEY);

// Función principal
async function main() {
  // Activamos el modelo
  const model = ai.getGenerativeModel({ model: "gemini-1.5-flash" });

  // Enviamos el mensaje
  const result = await model.generateContent("You are a worm that works very hard like the bees");

  // Mostramos la respuesta en la consola
  const response = await result.response;
  console.log(response.text());
}


