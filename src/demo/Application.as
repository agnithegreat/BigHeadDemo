/**
 * Created by kirillvirich on 29.01.15.
 */
package demo {
import demo.utils.view.Flipper;
import demo.utils.components.Screen;
import demo.view.MainMenuScreen;
import demo.view.TeamPlayScreen;

import flash.utils.Dictionary;

import perspective.PerspectiveView;

import starling.core.Starling;
import starling.display.Sprite3D;
import starling.events.Event;

public class Application extends Sprite3D {

    private var _screens: Dictionary;
//    private var _assets: AssetManager;
    private var _flipper: Flipper;

    private var _stack: Vector.<Screen>;

    public function start():void {
//        _assets = new AssetManager();
//        GUIFactory.init(_assets);
//
//        _assets.verbose = false;
//        _assets.enqueue(File.applicationDirectory.resolvePath("assets"));
//        _assets.loadQueue(function (progress: Number):void {
//            if (progress == 1) {
//                ready();
//            }
//        });

        testPerspective();
//        ready();
    }

    private function ready():void {
        _screens = new Dictionary();
        _screens[MainMenuScreen] = new MainMenuScreen();
        _screens[MainMenuScreen].addEventListener(MainMenuScreen.TEAMGAME, handleTouch);
        _screens[TeamPlayScreen] = new TeamPlayScreen();

        _stack = new <Screen>[];
        _stack.push(_screens[MainMenuScreen]);
        _stack.push(_screens[TeamPlayScreen]);

        _flipper = new Flipper();
        addChild(_flipper);

        rotationX = -Math.PI/30;
        z = 200;

        updatePage();
    }

    private function updatePage():void {
        var page: Screen = _stack.shift();
        _stack.push(page);
        _flipper.front = page;
        _flipper.reset();

        if (page == _screens[TeamPlayScreen]) {
            flip();
        }
    }

    private function flip():void {
        _flipper.back = _stack[0];
        _flipper.flip();
        _flipper.addEventListener(Event.COMPLETE, handleFlipComplete);
    }

    private function handleTouch(e: Event):void {
        flip();
    }

    private function handleFlipComplete(e: Event):void {
        _flipper.removeEventListener(Event.COMPLETE, handleFlipComplete);

        updatePage();
    }




    private function testPerspective():void {
        var perspectiveView: PerspectiveView = new PerspectiveView();
        perspectiveView.scaleY = -1;
        perspectiveView.y = 600;
        perspectiveView.rotationX = -Math.PI/2;
        addChild(perspectiveView);

        Starling.juggler.add(perspectiveView);
    }
}
}
