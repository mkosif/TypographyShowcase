import { common2D, drawing } from '@kit.ArkGraphics2D';
import { COLOR_BG_ARGB } from '../constants/SpecimenConfig';

export function colorOf(argb: number): common2D.Color {
  return {
    alpha: (argb >>> 24) & 0xFF,
    red: (argb >>> 16) & 0xFF,
    green: (argb >>> 8) & 0xFF,
    blue: argb & 0xFF
  };
}

export function makeBrush(argb: number): drawing.Brush {
  const brush: drawing.Brush = new drawing.Brush();
  brush.setAntiAlias(true);
  brush.setColor(colorOf(argb));
  return brush;
}

export function defaultTypeface(): drawing.Typeface {
  const probeFont: drawing.Font = new drawing.Font();
  return probeFont.getTypeface();
}

export function fillBackground(canvas: drawing.Canvas, widthPx: number, heightPx: number): void {
  const bg: drawing.Brush = makeBrush(COLOR_BG_ARGB);
  canvas.attachBrush(bg);
  canvas.drawRect({
    left: 0,
    top: 0,
    right: widthPx,
    bottom: heightPx
  });
  canvas.detachBrush();
}

export function drawCenteredBlob(
  canvas: drawing.Canvas,
  blob: drawing.TextBlob,
  brush: drawing.Brush,
  centerX: number,
  baselineY: number
): void {
  const bounds: common2D.Rect = blob.bounds();
  const width: number = bounds.right - bounds.left;
  const x: number = centerX - width / 2 - bounds.left;
  canvas.attachBrush(brush);
  canvas.drawTextBlob(blob, x, baselineY);
  canvas.detachBrush();
}
