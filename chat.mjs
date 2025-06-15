import dotenv from "dotenv";
dotenv.config();

import readline from "readline";
import { GoogleGenAI } from "@google/genai";

const ai = new GoogleGenAI({ apiKey: process.env.API_KEY });

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question("¿Qué quieres preguntarle a Ichy?\n> ", async (pregunta) => {
  const response = await ai.models.generateContent({
    model: "gemini-2.0-flash",
    contents: pregunta,
  });

  console.log("\nRespuesta de Ichy:\n", response.text);
  rl.close();
});

