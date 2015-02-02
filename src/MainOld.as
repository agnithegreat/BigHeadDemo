package {
import demo.Application;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.display3D.Context3DRenderMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.system.Capabilities;

import starling.core.Starling;
import starling.events.ResizeEvent;

[SWF (frameRate=60, width=768, height=1024, backgroundColor=0)]
public class MainOld extends Sprite {

    private var _starling: Starling;

    public function MainOld() {
        addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
    }

    private function handleAddedToStage(e: Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        var ios: Boolean = (Capabilities.version.toLowerCase().indexOf("ios") > -1);
        var android: Boolean = (Capabilities.version.toLowerCase().indexOf("and") > -1);
        var mobile: Boolean = ios || android;

        var art: Rectangle = new Rectangle(0, 0, 768, 1024);

        var viewport: Rectangle = mobile ? new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight) : new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);

        _starling = new Starling(Application, stage, viewport, null, Context3DRenderMode.AUTO);
        _starling.stage.stageWidth = art.width;
        _starling.stage.stageHeight = art.height;
        _starling.showStats = true;

        _starling.addEventListener(starling.events.Event.ROOT_CREATED, handleRootCreated);

        addEventListener(ResizeEvent.RESIZE, handleResize);
    }

    private function handleResize(e: ResizeEvent):void {
        _starling.viewPort.width = e.width;
        _starling.viewPort.height = e.height;
    }

    private function handleRootCreated(event: Object,  app: Application):void {
        _starling.removeEventListener(starling.events.Event.ROOT_CREATED, handleRootCreated);

        app.start();
        _starling.start();
    }
}
}
