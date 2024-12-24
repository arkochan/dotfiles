"use client";

import { useEffect, useRef } from "react";

export default function page() {
  useEffect(() => {
    const canvas = canvasRef.current;
    const ctx = canvas.getContext("2d");

    const width = canvas.width;
    const height = canvas.height;

    const dpr = window.devicePixelRatio || 1;

    canvas.width = width * dpr;
    canvas.height = height * dpr;
    ctx.scale(dpr, dpr);

    ctx.fillStyle = "black";
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
