import { drawing } from '@kit.ArkGraphics2D';
import {
  COLOR_DIM_ARGB,
  COLOR_INK_ARGB,
  SAMPLE_WORD
} from '../constants/SpecimenConfig';
import {
  defaultTypeface,
  drawCenteredBlob,
  fillBackground,
  makeBrush
} from './RendererUtils';

const SIZE_RAMP_PX: number[] = [18, 28, 42, 58];
const LABEL_SIZE_PX: number = 14;
const LABEL_GAP_PX: number = 6;
const ROW_GAP_PX: number = 14;

interface SampleLayout {
  sampleFont: drawing.Font;
  sampleAscent: number;
  sampleDescent: number;
  labelFont: drawing.Font;
  labelAscent: number;
  labelDescent: number;
  rowHeight: number;
}

function buildLayout(typeface: drawing.Typeface, sizePx: number): SampleLayout {
  const sampleFont: drawing.Font = new drawing.Font();
  sampleFont.setTypeface(typeface);
  sampleFont.setSize(sizePx);
  const sampleMetrics: drawing.FontMetrics = sampleFont.getMetrics();

  const labelFont: drawing.Font = new drawing.Font();
  labelFont.setTypeface(typeface);
  labelFont.setSize(LABEL_SIZE_PX);
  const labelMetrics: drawing.FontMetrics = labelFont.getMetrics();

  const sampleAscent: number = -sampleMetrics.ascent;
  const sampleDescent: number = sampleMetrics.descent;
  const labelAscent: number = -labelMetrics.ascent;
  const labelDescent: number = labelMetrics.descent;
  const rowHeight: number = sampleAscent + sampleDescent + LABEL_GAP_PX
    + labelAscent + labelDescent;

  return {
    sampleFont,
    sampleAscent,
    sampleDescent,
    labelFont,
    labelAscent,
    labelDescent,
    rowHeight
  };
}

export function renderSize(canvas: drawing.Canvas, widthPx: number, heightPx: number): void {
  fillBackground(canvas, widthPx, heightPx);

  const typeface: drawing.Typeface = defaultTypeface();
  const inkBrush: drawing.Brush = makeBrush(COLOR_INK_ARGB);
  const dimBrush: drawing.Brush = makeBrush(COLOR_DIM_ARGB);

  const layouts: SampleLayout[] = [];
  let totalHeight: number = 0;
  for (const sizePx of SIZE_RAMP_PX) {
    const layout: SampleLayout = buildLayout(typeface, sizePx);
    layouts.push(layout);
    totalHeight += layout.rowHeight + ROW_GAP_PX;
  }
  totalHeight -= ROW_GAP_PX;

  const centerX: number = widthPx / 2;
  let rowTop: number = (heightPx - totalHeight) / 2;

  for (let i: number = 0; i < SIZE_RAMP_PX.length; i++) {
    const sizePx: number = SIZE_RAMP_PX[i];
    const layout: SampleLayout = layouts[i];

    const sampleBaseline: number = rowTop + layout.sampleAscent;
    const sampleBlob: drawing.TextBlob = drawing.TextBlob.makeFromString(
      SAMPLE_WORD,
      layout.sampleFont,
      drawing.TextEncoding.TEXT_ENCODING_UTF8
    );
    drawCenteredBlob(canvas, sampleBlob, inkBrush, centerX, sampleBaseline);

    const labelBaseline: number = sampleBaseline + layout.sampleDescent
      + LABEL_GAP_PX + layout.labelAscent;
    const labelBlob: drawing.TextBlob = drawing.TextBlob.makeFromString(
      `${sizePx}px`,
      layout.labelFont,
      drawing.TextEncoding.TEXT_ENCODING_UTF8
    );
    drawCenteredBlob(canvas, labelBlob, dimBrush, centerX, labelBaseline);

    rowTop += layout.rowHeight + ROW_GAP_PX;
  }
}
