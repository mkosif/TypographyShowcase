export enum SpecimenId {
  Size = 'specimenSize',
  Weight = 'specimenWeight',
  Blob = 'specimenBlob',
  Paragraph = 'specimenParagraph'
}

export interface SpecimenItem {
  id: SpecimenId;
  title: string;
  subtitle: string;
}
