/**
 * Created by kirillvirich on 02.02.15.
 */
package perspective {
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.GlowFilter;
import flash.geom.Point;

import starling.animation.Transitions;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite3D;
import starling.textures.Texture;

public class CellView extends Sprite3D {

    public static var size: int = 50;

    private static var stack: Vector.<CellView> = new <CellView>[];
    public static function getCell():CellView {
        return stack.length > 0 ? stack.shift() : new CellView();
    }

    private static var cellTexture: Texture = getTexture();
    private static function getTexture():Texture {
        var rect: Sprite = new Sprite();
        rect.graphics.lineStyle(2, 0xFFFFFF);
        rect.graphics.drawRoundRect(size*0.05, size*0.05, size*0.9, size*0.9, size*0.5);
        rect.filters = [new GlowFilter(0xFFFFFF, 0.3, 3, 3, 3, 3)];

        var bitmapData: BitmapData = new BitmapData(size, size, true, 0);
        bitmapData.draw(rect);

        return Texture.fromBitmapData(bitmapData);
    }



    private var _cell: Image;

    public function CellView() {
        _cell = new Image(cellTexture);
        _cell.alpha = 0.99;
        addChild(_cell);
    }

    override public function hitTest(localPoint: Point, forTouch: Boolean = false):DisplayObject {
        return super.hitTest(localPoint, forTouch) ? this : null;
    }

    public function place(x: int, y: int):void {
        this.x = x * size;
        this.y = y * size;
    }

    public function animateAppear():void {
        alpha = 0;
        z = -500;

        Starling.juggler.tween(this, 0.5, {z: 0, alpha: 0.99, transition: Transitions.EASE_OUT});
    }

    public function animateRemove():void {
        touchable = false;
        Starling.juggler.tween(this, 0.5, {z: 500, alpha: 0, transition: Transitions.EASE_IN, onComplete: destroy});
    }

    public function destroy():void {
        removeFromParent();

        stack.push(this);
    }
}
}
