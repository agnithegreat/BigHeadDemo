/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.view {
import demo.utils.components.Button;
import demo.utils.components.Screen;

import gui.MainMenu;

import starling.events.Event;

public class MainMenuScreen extends Screen {

    public static const QUICKGAME: String = "QUICKGAME_MainMenuScreen";
    public static const TEAMGAME: String = "TEAMGAME_MainMenuScreen";

    private function get btn_quickgame():Button {
        return _links["btn_quickgame"];
    }

    private function get btn_teamgame():Button {
        return _links["btn_teamgame"];
    }

    public function MainMenuScreen() {
    }

    override protected function initialize():void {
        createFromFlash(new MainMenu());

        btn_quickgame.addEventListener(Event.TRIGGERED, handleTriggered);
        btn_teamgame.addEventListener(Event.TRIGGERED, handleTriggered);
    }

    private function handleTriggered(e: Event):void {
        switch (e.currentTarget) {
            case btn_quickgame:
                dispatchEventWith(QUICKGAME);
                break;
            case btn_teamgame:
                dispatchEventWith(TEAMGAME);
                break;
        }
    }
}
}
