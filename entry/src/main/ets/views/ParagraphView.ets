import { SpecimenCanvas, SpecimenController } from '../components/SpecimenCanvas';
import { renderParagraph } from '../services/ParagraphRenderer';

@Component
export struct ParagraphView {
  @Consume('pathStack') pathStack: NavPathStack;
  private controller: SpecimenController = new SpecimenController().bind(renderParagraph);

  build() {
    NavDestination() {
      Column() {
        Text('Paragraph')
          .fontSize(14)
          .fontColor('#A0A0A8')
          .margin({ top: 14, bottom: 2 })
        SpecimenCanvas({ controller: this.controller })
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.pathStack.pop();
      return true;
    })
  }
}
