import { common2D, drawing } from '@kit.ArkGraphics2D';
import { COLOR_DIM_ARGB, COLOR_INK_ARGB } from '../constants/SpecimenConfig';
import { defaultTypeface, drawCenteredBlob, fillBackground, makeBrush } from './RendererUtils';

const POS_TEXT: string = 'TYPE';
const REUSE_TEXT: string = 'Reuse';
const REUSE_FONT_PX: number = 28;
const POS_FONT_PX: number = 48;
const LEGEND_FONT_PX: number = 13;

interface EchoStop {
  offsetX: number;
  alpha: number;
}

const ECHO_STOPS: EchoStop[] = [
  { offsetX: -86, alpha: 0x40 },
  { offsetX: 0, alpha: 0xFF },
  { offsetX: 86, alpha: 0x90 }
];

function buildPositions(centerX: number, centerY: number): common2D.Point[] {
  return [
    { x: centerX - 92, y: centerY + 14 },
    { x: centerX - 32, y: centerY - 10 },
    { x: centerX + 24, y: centerY - 10 },
    { x: centerX + 82, y: centerY + 14 }
  ];
}

function drawEchoReuse(
  canvas: drawing.Canvas,
  blob: drawing.TextBlob,
  centerX: number,
  baselineY: number
): void {
  const bounds: common2D.Rect = blob.bounds();
  const width: number = bounds.right - bounds.left;
  const baseX: number = centerX - width / 2 - bounds.left;
  for (const stop of ECHO_STOPS) {
    const brush: drawing.Brush = new drawing.Brush();
    brush.setAntiAlias(true);
    brush.setColor({ alpha: stop.alpha, red: 0x6F, green: 0xA8, blue: 0xFF });
    canvas.attachBrush(brush);
    canvas.drawTextBlob(blob, baseX + stop.offsetX, baselineY);
    canvas.detachBrush();
  }
}

function drawPositionedGlyphs(
  canvas: drawing.Canvas,
  font: drawing.Font,
  centerX: number,
  centerY: number
): void {
  const points: common2D.Point[] = buildPositions(centerX, centerY);
  const posBlob: drawing.TextBlob = drawing.TextBlob.makeFromPosText(
    POS_TEXT,
    POS_TEXT.length,
    points,
    font
  );
  const inkBrush: drawing.Brush = makeBrush(COLOR_INK_ARGB);
  canvas.attachBrush(inkBrush);
  canvas.drawTextBlob(posBlob, 0, 0);
  canvas.detachBrush();
}

function drawCaption(
  canvas: drawing.Canvas,
  text: string,
  centerX: number,
  baselineY: number
): void {
  const labelFont: drawing.Font = new drawing.Font();
  labelFont.setTypeface(defaultTypeface());
  labelFont.setSize(LEGEND_FONT_PX);
  const blob: drawing.TextBlob = drawing.TextBlob.makeFromString(
    text,
    labelFont,
    drawing.TextEncoding.TEXT_ENCODING_UTF8
  );
  drawCenteredBlob(canvas, blob, makeBrush(COLOR_DIM_ARGB), centerX, baselineY);
}

export function renderBlob(canvas: drawing.Canvas, widthPx: number, heightPx: number): void {
  fillBackground(canvas, widthPx, heightPx);

  const typeface: drawing.Typeface = defaultTypeface();
  const centerX: number = widthPx / 2;

  const reuseFont: drawing.Font = new drawing.Font();
  reuseFont.setTypeface(typeface);
  reuseFont.setSize(REUSE_FONT_PX);
  const reuseBlob: drawing.TextBlob = drawing.TextBlob.makeFromString(
    REUSE_TEXT,
    reuseFont,
    drawing.TextEncoding.TEXT_ENCODING_UTF8
  );

  const echoBaseline: number = heightPx * 0.32;
  drawEchoReuse(canvas, reuseBlob, centerX, echoBaseline);
  drawCaption(canvas, `1 blob × ${ECHO_STOPS.length} paints`, centerX, echoBaseline + 22);

  const posFont: drawing.Font = new drawing.Font();
  posFont.setTypeface(typeface);
  posFont.setSize(POS_FONT_PX);
  const posCenterY: number = heightPx * 0.66;
  drawPositionedGlyphs(canvas, posFont, centerX, posCenterY);
  drawCaption(canvas, 'makeFromPosText', centerX, posCenterY + 44);
}
