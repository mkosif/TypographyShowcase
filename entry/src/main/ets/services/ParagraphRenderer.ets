import { drawing, text } from '@kit.ArkGraphics2D';
import {
  COLOR_ACCENT_ARGB,
  COLOR_INK_ARGB
} from '../constants/SpecimenConfig';
import { colorOf, fillBackground } from './RendererUtils';

function buildSpecimenParagraph(layoutWidth: number): text.Paragraph {
  const fc: text.FontCollection = text.FontCollection.getGlobalInstance();
  const paragraphStyle: text.ParagraphStyle = {
    align: text.TextAlign.CENTER,
    maxLines: 8,
    wordBreak: text.WordBreak.NORMAL,
    breakStrategy: text.BreakStrategy.GREEDY
  };
  const builder: text.ParagraphBuilder = new text.ParagraphBuilder(paragraphStyle, fc);

  const titleStyle: text.TextStyle = {
    fontWeight: text.FontWeight.W700,
    fontSize: 20,
    color: colorOf(COLOR_ACCENT_ARGB),
    letterSpacing: 1.6
  };
  const bodyStyle: text.TextStyle = {
    fontWeight: text.FontWeight.W400,
    fontSize: 16,
    color: colorOf(COLOR_INK_ARGB),
    heightScale: 1.32
  };
  const emphasisStyle: text.TextStyle = {
    fontWeight: text.FontWeight.W600,
    fontStyle: text.FontStyle.ITALIC,
    fontSize: 16,
    color: colorOf(COLOR_ACCENT_ARGB),
    heightScale: 1.32
  };

  builder.pushStyle(titleStyle);
  builder.addText('SPECIMEN\n');
  builder.popStyle();

  builder.pushStyle(bodyStyle);
  builder.addText('Typography on a round watch must stay legible at arm length. ');
  builder.popStyle();

  builder.pushStyle(emphasisStyle);
  builder.addText('Specimens');
  builder.popStyle();

  builder.pushStyle(bodyStyle);
  builder.addText(' validate readability per glyph.');
  builder.popStyle();

  const paragraph: text.Paragraph = builder.build();
  paragraph.layoutSync(layoutWidth);
  return paragraph;
}

export function renderParagraph(canvas: drawing.Canvas, widthPx: number, heightPx: number): void {
  fillBackground(canvas, widthPx, heightPx);

  const layoutWidth: number = widthPx * 0.74;
  const paragraph: text.Paragraph = buildSpecimenParagraph(layoutWidth);

  const x: number = (widthPx - layoutWidth) / 2;
  const y: number = (heightPx - paragraph.getHeight()) / 2;
  paragraph.paint(canvas, x, y);
}
