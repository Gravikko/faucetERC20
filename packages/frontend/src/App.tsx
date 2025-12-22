// src/App.tsx
import React from "react";
import { Providers } from "./providers";
import Header from "./components/Header"; 
import '@rainbow-me/rainbowkit/styles.css';

export default function App() {
  return (
    <Providers>
      <Header />
      <main>
        {/* сюда будет рендериться основной контент (page) */}
        <h1>Привет, Vite + React</h1>
      </main>
    </Providers>
  );
}
