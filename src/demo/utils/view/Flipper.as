/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.utils.view {
import flash.geom.Vector3D;

import starling.animation.Transitions;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.display.Sprite3D;
import starling.events.Event;

public class Flipper extends Sprite3D {

    private var _front: Sprite;
    public function set front(value: DisplayObject):void {
        _front.unflatten();
        _front.removeChildren();
        _front.addChild(value);
        _front.flatten();
    }
    public function get front():DisplayObject {
        return _front.getChildAt(0);
    }

    private var _back: Sprite;
    public function set back(value: DisplayObject):void {
        _back.unflatten();
        _back.removeChildren();
        _back.addChild(value);
        _back.x = _back.width;
        _back.flatten();
    }
    public function get back():DisplayObject {
        return _back.getChildAt(0);
    }

    private var _flipped: Boolean;

    private var _helperPoint3D: Vector3D;

    public function Flipper() {
        _front = new Sprite();
        addChild(_front);

        _back = new Sprite();
        _back.scaleX = -1;
        _back.visible = false;
        addChild(_back);

        _helperPoint3D = new Vector3D();
    }

    public function flip():void {
        x = _front.width/2;
        y = _front.height/2;
        pivotX = _front.width/2;
        pivotY = _front.height/2;

        Starling.juggler.removeTweens(this);
        Starling.juggler.tween(this, 1, {
            rotationY: _flipped ? 0 : Math.PI,
            onComplete: handleComplete,
            transition: Transitions.EASE_IN_OUT
        });

        _flipped = !_flipped;

        addEventListener(Event.ENTER_FRAME, updateVisibility);
    }

    public function reset():void {
        rotationY = 0;
        _flipped = false;
        updateVisibility(null);
    }

    private function updateVisibility(e: Event):void {
        stage.getCameraPosition(this, _helperPoint3D);

        _front.visible = _helperPoint3D.z <= 0;
        _back.visible = _helperPoint3D.z > 0;

        if (scaleX * scaleY < 0) {
            _front.visible = !_front.visible;
            _back.visible  = !_back.visible;
        }
    }

    private function handleComplete():void {
        removeEventListener(Event.ENTER_FRAME, updateVisibility);

        dispatchEventWith(Event.COMPLETE);
    }
}
}
