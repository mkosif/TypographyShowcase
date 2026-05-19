import { SPECIMENS } from '../constants/SpecimenConfig';
import { SpecimenItem } from '../model/Specimen';

@Component
export struct HomeView {
  @Consume('pathStack') pathStack: NavPathStack;

  build() {
    Column() {
      Text('Typography')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#F5F5F7')
        .margin({ top: 16, bottom: 2 })
      Text('Specimens')
        .fontSize(12)
        .fontColor('#6FA8FF')
        .margin({ bottom: 8 })
      List({ space: 5 }) {
        ForEach(SPECIMENS, (item: SpecimenItem) => {
          ListItem() {
            this.specimenTile(item)
          }
          .onClick(() => {
            this.pathStack.pushPathByName(item.id, null);
          })
        }, (item: SpecimenItem) => item.id)
      }
      .layoutWeight(1)
      .padding({
        left: 22,
        right: 22,
        bottom: 60
      })
      .scrollBar(BarState.Off)
      .alignListItem(ListItemAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }

  @Builder
  specimenTile(item: SpecimenItem) {
    Column({ space: 2 }) {
      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#F5F5F7')
      Text(item.subtitle)
        .fontSize(11)
        .fontColor('#A0A0A8')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({
      left: 14,
      right: 14,
      top: 8,
      bottom: 8
    })
    .backgroundColor('#1C1C1F')
    .borderRadius(14)
  }
}
