"use client";

import { useRef, useState, useEffect } from "react";

interface Point {
  x: number;
  y: number;
  time: number;
}

export default function DrawingApp() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [points, setPoints] = useState<Point[]>([]);
  const [lineWidth, setLineWidth] = useState(3);
  const [smoothness, setSmoothness] = useState(0.2); // Adjust smoothness factor

  // Rescale canvas for crisp rendering
  const setCanvasDPI = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    const dpr = window.devicePixelRatio || 1;
    canvas.width = canvas.offsetWidth * dpr;
    canvas.height = canvas.offsetHeight * dpr;
    ctx.scale(dpr, dpr);
  };

  useEffect(() => {
    setCanvasDPI();
    window.addEventListener("resize", setCanvasDPI);
    return () => window.removeEventListener("resize", setCanvasDPI);
  }, []);

  const startDrawing = (e: React.MouseEvent | React.TouchEvent) => {
    const { offsetX, offsetY } = getPointerPosition(e);
    setPoints([{ x: offsetX, y: offsetY, time: Date.now() }]);
    setIsDrawing(true);
  };

  const draw = (e: React.MouseEvent | React.TouchEvent) => {
    if (!isDrawing) return;

    const { offsetX, offsetY } = getPointerPosition(e);
    const newPoint = { x: offsetX, y: offsetY, time: Date.now() };
    setPoints((prev) => [...prev, newPoint]);

    const canvas = canvasRef.current;
    const ctx = canvas?.getContext("2d");
    if (ctx && points.length > 1) {
      ctx.lineJoin = "round";
      ctx.lineCap = "round";
      ctx.lineWidth = lineWidth;
      ctx.strokeStyle = "#000";

      const lastPoint = points[points.length - 1];
      const midX = (lastPoint.x + offsetX) / 2;
      const midY = (lastPoint.y + offsetY) / 2;

      ctx.beginPath();
      ctx.moveTo(lastPoint.x, lastPoint.y);
      ctx.quadraticCurveTo(lastPoint.x, lastPoint.y, midX, midY);
      ctx.stroke();
    }
  };

  const stopDrawing = () => {
    setIsDrawing(false);
  };

  const getPointerPosition = (
    e: React.MouseEvent | React.TouchEvent
  ): { offsetX: number; offsetY: number } => {
    const canvas = canvasRef.current;
    if (!canvas) return { offsetX: 0, offsetY: 0 };

    const rect = canvas.getBoundingClientRect();
    if ("touches" in e) {
      const touch = e.touches[0];
      return {
        offsetX: touch.clientX - rect.left,
        offsetY: touch.clientY - rect.top,
      };
    } else {
      return {
        offsetX: e.nativeEvent.offsetX,
        offsetY: e.nativeEvent.offsetY,
      };
    }
  };

  return (
    <div className="flex flex-col items-center justify-center h-screen bg-gray-100">
      <canvas
        ref={canvasRef}
        className="border bg-white w-[90vw] h-[70vh]"
        onMouseDown={startDrawing}
        onMouseMove={draw}
        onMouseUp={stopDrawing}
        onMouseLeave={stopDrawing}
        onTouchStart={startDrawing}
        onTouchMove={draw}
        onTouchEnd={stopDrawing}
      ></canvas>
      <div className="mt-4 space-y-2">
        <div>
          <label className="mr-2">Line Width:</label>
          <input
            type="range"
            min="1"
            max="10"
            value={lineWidth}
            onChange={(e) => setLineWidth(Number(e.target.value))}
          />
        </div>
        <div>
          <label className="mr-2">Smoothness:</label>
          <input
            type="range"
            min="0.1"
            max="0.5"
            step="0.1"
            value={smoothness}
            onChange={(e) => setSmoothness(Number(e.target.value))}
          />
        </div>
      </div>
    </div>
  );
}
