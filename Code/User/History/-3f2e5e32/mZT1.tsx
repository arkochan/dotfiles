"use client";

import { useEffect, useRef } from "react";

export default function page() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  useEffect(() => {
    const canvas = canvasRef.current as HTMLCanvasElement;
    const ctx = canvas.getContext("2d") as CanvasRenderingContext2D;

    const width = canvas.width;
    const height = canvas.height;

    const dpr = window.devicePixelRatio || 1;

    canvas.width = width * dpr;
    canvas.height = height * dpr;
    ctx.scale(dpr, dpr);

    ctx.fillStyle = "white";
    ctx.fillRect(0, 0, width, height);
  }, []);

  return (
    <div>
      <canvas
        ref={canvasRef}
        className="w-[1366] h-[768] border-black rounded-xl border"
      />
    </div>
  );
}
