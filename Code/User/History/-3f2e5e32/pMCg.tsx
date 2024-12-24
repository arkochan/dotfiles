"use client";

import { useRef } from "react";

export default function page() {
  const dpr = window.devicePixelRatio || 1;
  const canvasRef = useRef(null);

  return (
    <div>
      <canvas
        ref={canvasRef}
        className="w-[1366] h-[768] border-black rounded-xl border"
      />
    </div>
  );
}
