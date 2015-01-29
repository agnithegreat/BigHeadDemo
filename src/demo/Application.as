/**
 * Created by kirillvirich on 29.01.15.
 */
package demo {
import demo.utils.GUIFactory;
import demo.utils.view.Flipper;
import demo.utils.view.Screen;
import demo.view.MainMenuScreen;
import demo.view.TeamPlayScreen;

import flash.filesystem.File;

import starling.display.Sprite;
import starling.display.Sprite3D;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class Application extends Sprite {

    private var _assets: AssetManager;
    private var _flipper: Flipper;

    private var _stack: Vector.<Screen>;

    public function Application() {
        _assets = new AssetManager();
        _assets.enqueue(File.applicationDirectory.resolvePath("assets"));
        _assets.verbose = false;
        _assets.loadQueue(function (progress: Number):void {
            if (progress == 1) {
                ready();
            }
        });

        GUIFactory.init(_assets);
    }

    private function ready():void {
        _stack = new <Screen>[];
        _stack.push(new MainMenuScreen());
        _stack.push(new TeamPlayScreen());

        _flipper = new Flipper();
        addChild(_flipper);

        updatePage();
    }

    private function updatePage():void {
        var page: Screen = _stack.shift();
        _stack.push(page);
        _flipper.front = page;
        _flipper.reset();

        _flipper.addEventListener(TouchEvent.TOUCH, handleTouch);
    }

    private function handleTouch(e: TouchEvent):void {
        var touch: Touch = e.getTouch(e.currentTarget as Sprite3D, TouchPhase.BEGAN);
        if (touch) {
            _flipper.removeEventListener(TouchEvent.TOUCH, handleTouch);

            _flipper.back = _stack[0];
            _flipper.flip();
            _flipper.addEventListener(Event.COMPLETE, handleFlipComplete);
        }
    }

    private function handleFlipComplete(e: Event):void {
        _flipper.removeEventListener(Event.COMPLETE, handleFlipComplete);

        updatePage();
    }
}
}
