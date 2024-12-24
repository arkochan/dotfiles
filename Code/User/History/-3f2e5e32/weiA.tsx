"use client";

import React from "react";

export default function page() {
  const dpr = window.devicePixelRatio || 1;

  return (
    <div>
      <canvas
        ref={canvasMain}
        className="w-[1366] h-[768] border-black rounded-xl border"
      />
    </div>
  );
}
