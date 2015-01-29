package {
import demo.Application;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import starling.core.Starling;

[SWF (frameRate=60, width=1080, height=1920, backgroundColor=0)]
public class Main extends Sprite {

    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
    }

    private function handleAddedToStage(e: Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        var starling: Starling = new Starling(Application, stage);
        starling.showStats = true;
        starling.start();
    }
}
}
