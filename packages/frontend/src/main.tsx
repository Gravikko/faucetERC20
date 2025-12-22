// src/main.tsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

console.log("MAIN TSX LOADED"); // <- проверь браузерную консоль

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
