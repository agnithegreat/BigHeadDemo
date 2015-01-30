/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.view {
import demo.utils.GUIFactory;
import demo.utils.view.Screen;

import gui.MainMenuScreen;
import gui.TeamPlayScreen;

public class TeamPlayScreen extends Screen {

    public function TeamPlayScreen() {
        GUIFactory.createView(this, new gui.TeamPlayScreen());
    }
}
}
