import { SpecimenId, SpecimenItem } from '../model/Specimen';

export const SPECIMENS: SpecimenItem[] = [
  {
    id: SpecimenId.Size,
    title: 'Size Ramp',
    subtitle: 'drawing.Font + TextBlob'
  },
  {
    id: SpecimenId.Weight,
    title: 'Weight Axis',
    subtitle: 'Typeface + Arguments'
  },
  {
    id: SpecimenId.Blob,
    title: 'Glyph Blob',
    subtitle: 'positioned TextBlob'
  },
  {
    id: SpecimenId.Paragraph,
    title: 'Paragraph',
    subtitle: 'text.ParagraphBuilder'
  }
];

export const COLOR_INK_ARGB: number = 0xFFF5F5F7;
export const COLOR_DIM_ARGB: number = 0xFFA0A0A8;
export const COLOR_ACCENT_ARGB: number = 0xFF6FA8FF;
export const COLOR_BG_ARGB: number = 0xFF000000;

export const SAMPLE_LATIN: string = 'AaBbCc';
export const SAMPLE_WORD: string = 'Type';
export const SAMPLE_SCRIPT: string = 'Aa  Bb  Cc';

export const SAMPLE_PARAGRAPH: string =
  `Typography on a round watch must stay legible at arm length. Specimens validate readability per glyph.`;
