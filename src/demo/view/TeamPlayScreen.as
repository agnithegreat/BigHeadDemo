/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.view {
import demo.utils.components.Screen;

import gui.TeamPlay;

public class TeamPlayScreen extends Screen {

    public function TeamPlayScreen() {
    }

    override protected function initialize():void {
        createFromFlash(new TeamPlay());
    }
}
}
