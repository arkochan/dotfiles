"use client";

import { useEffect, useRef, useState } from "react";

export default function page() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  useEffect(() => {
    const canvas = canvasRef.current as HTMLCanvasElement;
    const ctx = canvas.getContext("2d") as CanvasRenderingContext2D;

    const width = canvas.width;
    const height = canvas.height;

    const dpr = window.devicePixelRatio || 1;

    canvas.width = width * dpr;
    canvas.height = height * dpr;
    ctx.scale(dpr, dpr);
  }, []);

  function startDrawing() {
    setIsDrawing(true);
  }
  function Draw() {
    if (!isDrawing) return;
  }

  return (
    <div>
      <canvas
        ref={canvasRef}
        className="w-[1366] h-[768] border-black rounded-xl border"
      />
    </div>
  );
}
