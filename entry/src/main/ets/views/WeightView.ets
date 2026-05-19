import { SpecimenCanvas, SpecimenController } from '../components/SpecimenCanvas';
import { renderWeight } from '../services/WeightRenderer';

@Component
export struct WeightView {
  @Consume('pathStack') pathStack: NavPathStack;
  private controller: SpecimenController = new SpecimenController().bind(renderWeight);

  build() {
    NavDestination() {
      Column() {
        Text('Weight Axis')
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
