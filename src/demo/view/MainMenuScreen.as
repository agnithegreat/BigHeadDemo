/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.view {
import demo.utils.GUIFactory;
import demo.utils.view.Screen;

import gui.MainMenuScreen;

public class MainMenuScreen extends Screen {

    public function MainMenuScreen() {
        GUIFactory.createScreen(this, new gui.MainMenuScreen());
    }
}
}
