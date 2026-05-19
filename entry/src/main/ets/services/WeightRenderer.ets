import { drawing, text } from '@kit.ArkGraphics2D';
import {
  COLOR_ACCENT_ARGB,
  COLOR_DIM_ARGB,
  COLOR_INK_ARGB
} from '../constants/SpecimenConfig';
import {
  colorOf,
  defaultTypeface,
  drawCenteredBlob,
  fillBackground,
  makeBrush
} from './RendererUtils';

interface WeightVariant {
  weight: text.FontWeight;
  label: string;
  axisValue: number;
}

const VARIANTS: WeightVariant[] = [
  { weight: text.FontWeight.W100, label: 'Thin\n', axisValue: 100 },
  { weight: text.FontWeight.W400, label: 'Normal\n', axisValue: 400 },
  { weight: text.FontWeight.W700, label: 'Bold\n', axisValue: 700 },
  { weight: text.FontWeight.W900, label: 'Black', axisValue: 900 }
];

function buildVariantParagraph(layoutWidth: number): text.Paragraph {
  const fc: text.FontCollection = text.FontCollection.getGlobalInstance();
  const paragraphStyle: text.ParagraphStyle = {
    align: text.TextAlign.CENTER,
    maxLines: 6
  };
  const builder: text.ParagraphBuilder = new text.ParagraphBuilder(paragraphStyle, fc);
  for (const variant of VARIANTS) {
    const style: text.TextStyle = {
      fontWeight: variant.weight,
      fontSize: 30,
      color: colorOf(COLOR_INK_ARGB)
    };
    builder.pushStyle(style);
    builder.addText(variant.label);
    builder.popStyle();
  }
  const paragraph: text.Paragraph = builder.build();
  paragraph.layoutSync(layoutWidth);
  return paragraph;
}

function describeAxisFootprint(): string {
  const base: drawing.Typeface = defaultTypeface();
  let registered: number = 0;
  try {
    for (const variant of VARIANTS) {
      const args: drawing.TypefaceArguments = new drawing.TypefaceArguments();
      args.addVariation('wght', variant.axisValue);
      base.makeFromCurrent(args);
      registered++;
    }
  } catch (_err) {
    return 'wght axis';
  }
  return `wght · ${registered} stops`;
}

function drawFooter(
  canvas: drawing.Canvas,
  widthPx: number,
  heightPx: number,
  message: string
): void {
  const footFont: drawing.Font = new drawing.Font();
  footFont.setTypeface(defaultTypeface());
  footFont.setSize(13);
  const blob: drawing.TextBlob = drawing.TextBlob.makeFromString(
    message,
    footFont,
    drawing.TextEncoding.TEXT_ENCODING_UTF8
  );
  drawCenteredBlob(canvas, blob, makeBrush(COLOR_DIM_ARGB), widthPx / 2, heightPx - 56);
}

export function renderWeight(canvas: drawing.Canvas, widthPx: number, heightPx: number): void {
  fillBackground(canvas, widthPx, heightPx);

  const layoutWidth: number = widthPx * 0.72;
  const paragraph: text.Paragraph = buildVariantParagraph(layoutWidth);

  const x: number = (widthPx - layoutWidth) / 2;
  const y: number = (heightPx - paragraph.getHeight()) / 2 - 8;
  paragraph.paint(canvas, x, y);

  const accentRule: drawing.Brush = makeBrush(COLOR_ACCENT_ARGB);
  canvas.attachBrush(accentRule);
  const ruleY: number = y + paragraph.getHeight() + 4;
  canvas.drawRect({
    left: widthPx / 2 - 18,
    top: ruleY,
    right: widthPx / 2 + 18,
    bottom: ruleY + 2
  });
  canvas.detachBrush();

  drawFooter(canvas, widthPx, heightPx, describeAxisFootprint());
}
