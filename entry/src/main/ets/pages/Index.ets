import { SpecimenId } from '../model/Specimen';
import { BlobView } from '../views/BlobView';
import { HomeView } from '../views/HomeView';
import { ParagraphView } from '../views/ParagraphView';
import { SizeView } from '../views/SizeView';
import { WeightView } from '../views/WeightView';

@Entry
@Component
struct Index {
  @Provide('pathStack') pathStack: NavPathStack = new NavPathStack();

  @Builder
  routeMap(name: string) {
    if (name === SpecimenId.Size) {
      SizeView()
    } else if (name === SpecimenId.Weight) {
      WeightView()
    } else if (name === SpecimenId.Blob) {
      BlobView()
    } else if (name === SpecimenId.Paragraph) {
      ParagraphView()
    }
  }

  build() {
    Navigation(this.pathStack) {
      HomeView()
    }
    .mode(NavigationMode.Stack)
    .hideToolBar(true)
    .hideTitleBar(true)
    .navDestination(this.routeMap)
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}
