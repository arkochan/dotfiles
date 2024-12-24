'use client';

import { useEffect, useRef, useState } from 'react';
import Atrament from 'atrament';

const DrawingCanvas = () => {
  const canvasRef = useRef(null);
  const [points, setPoints] = useState([]);

  useEffect(() => {
    const canvas = canvasRef.current;

    // Adjust canvas size for HiDPI screens
    const adjustCanvasForDPI = () => {
      const dpi = window.devicePixelRatio || 1;
      canvas.width = canvas.offsetWidth * dpi;
      canvas.height = canvas.offsetHeight * dpi;
      const context = canvas.getContext('2d');
      context.scale(dpi, dpi);
    };

    adjustCanvasForDPI();

    // Initialize Atrament
    const atrament = new Atrament(canvas, {
      smoothness: 10,
      adaptiveStroke: true,
    });

    // Capture points and timestamps during drawing
    const drawingPoints = [];
    atrament.addEventListener('strokestart', () => {
      drawingPoints.push([]);
    });

    atrament.addEventListener('strokeend', () => {
      setPoints((prevPoints) => [...prevPoints, ...drawingPoints]);
    });

    atrament.addEventListener('stroke', (event) => {
      const { x, y } = event.detail;
      const timestamp = Date.now();
      drawingPoints[drawingPoints.length - 1].push({ x, y, timestamp });
    });

    // Clean up
    return () => {
      atrament.destroy();
    };
  }, []);

  return (
    <div style={{ width: '100%', height: '100%', position: 'relative' }}>
      <canvas
        ref={canvasRef}
        style={{ width: '100%', height: '100%', border: '1px solid #ccc' }}
      />
    </div>
  );
};

export default DrawingCanvas;
