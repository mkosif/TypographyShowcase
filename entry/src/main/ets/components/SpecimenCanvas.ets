import { drawing } from '@kit.ArkGraphics2D';
import { DrawContext, FrameNode, NodeController, RenderNode, UIContext } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN: number = 0x0000;
const TAG: string = 'SpecimenCanvas';

export type SpecimenRenderer = (canvas: drawing.Canvas, widthPx: number, heightPx: number) => void;

class SpecimenRenderNode extends RenderNode {
  private renderer: SpecimenRenderer = () => {};
  private widthVp: number = 0;
  private heightVp: number = 0;

  bindRenderer(renderer: SpecimenRenderer): void {
    this.renderer = renderer;
  }

  resize(widthVp: number, heightVp: number): void {
    this.widthVp = widthVp;
    this.heightVp = heightVp;
    this.frame = { x: 0, y: 0, width: widthVp, height: heightVp };
    this.invalidate();
  }

  draw(context: DrawContext): void {
    if (this.widthVp <= 0 || this.heightVp <= 0) {
      return;
    }
    const sizePx: Size = context.sizeInPixel;
    this.renderer(context.canvas, sizePx.width, sizePx.height);
  }
}

export class SpecimenController extends NodeController {
  private root: FrameNode | null = null;
  private renderNode: SpecimenRenderNode = new SpecimenRenderNode();

  bind(renderer: SpecimenRenderer): SpecimenController {
    this.renderNode.bindRenderer(renderer);
    return this;
  }

  makeNode(uiContext: UIContext): FrameNode | null {
    this.root = new FrameNode(uiContext);
    const rootRender: RenderNode | null = this.root.getRenderNode();
    if (rootRender !== null) {
      try {
        rootRender.appendChild(this.renderNode);
      } catch (err) {
        hilog.error(DOMAIN, TAG, 'appendChild failed: %{public}s', JSON.stringify(err));
      }
    }
    return this.root;
  }

  resize(widthVp: number, heightVp: number): void {
    this.renderNode.resize(widthVp, heightVp);
  }
}

@Component
export struct SpecimenCanvas {
  controller: SpecimenController = new SpecimenController();

  build() {
    NodeContainer(this.controller)
      .width('100%')
      .height('100%')
      .onAreaChange((_oldArea: Area, newArea: Area) => {
        const widthVp: number = Number(newArea.width);
        const heightVp: number = Number(newArea.height);
        if (widthVp > 0 && heightVp > 0) {
          this.controller.resize(widthVp, heightVp);
        }
      })
  }
}
