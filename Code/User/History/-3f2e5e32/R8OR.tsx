"use client";

import { get } from "http";
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
  function stopDrawing() {
    setIsDrawing(false);
  }
  function mouseDraw(event: MouseEvent) {
    if (!isDrawing) return;
    console.log(getMousePosition(event));
  }
  function pointerDraw() {
    if (!isDrawing) return;
  }
  function getMousePosition(event: MouseEvent) {
    const canvas = canvasRef.current as HTMLCanvasElement;
    const rect = canvas.getBoundingClientRect();
    return {
      x: event.clientX - rect.left,
      y: event.clientY - rect.top,
    };
  }
  function getPointerPosition(event: PointerEvent) {
    const canvas = canvasRef.current as HTMLCanvasElement;
    const rect = canvas.getBoundingClientRect();
    return {
      x: event.clientX - rect.left,
      y: event.clientY - rect.top,
    };
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
