/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.utils.view {
import starling.display.DisplayObject;
import starling.display.Sprite;

public dynamic class AbstractView extends Sprite {

    public function AbstractView() {
    }

    override public function addChild(child: DisplayObject):DisplayObject {
        if (child && child.name) {
            this[child.name] = child;
        }
        return super.addChild(child);
    }

    override public function removeChild(child: DisplayObject, dispose: Boolean = false):DisplayObject {
        if (child && child.name) {
            delete this[child.name];
        }
        return super.removeChild(child, dispose);
    }
}
}
