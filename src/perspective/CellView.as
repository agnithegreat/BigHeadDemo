/**
 * Created by kirillvirich on 02.02.15.
 */
package perspective {
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.GlowFilter;

import starling.animation.Transitions;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite3D;
import starling.textures.Texture;

public class CellView extends Sprite3D {

    private static var cellTexture: Texture = getTexture();

    private static function getTexture():Texture {
        var rect: Sprite = new Sprite();
        rect.graphics.lineStyle(2, 0x00FF00);
        rect.graphics.drawRoundRect(5, 5, 90, 90, 20, 20);
        rect.filters = [new GlowFilter(0xFFFFFF, 0.3, 3, 3, 3, 3)];

        var bitmapData: BitmapData = new BitmapData(100, 100, true, 0);
        bitmapData.draw(rect);

        return Texture.fromBitmapData(bitmapData);
    }



    private var _cell: Image;

    public function CellView(x: int, y: int) {
        _cell = new Image(cellTexture);
        _cell.x = x * 100;
        _cell.y = y * 100;
        addChild(_cell);

        alpha = 0.99;
    }

    public function animateAppear():void {
        alpha = 0;
        z = -200;

        Starling.juggler.tween(this, 0.5, {z: 0, alpha: 0.99, transition: Transitions.EASE_OUT});
    }

    public function animateRemove():void {
        Starling.juggler.tween(this, 0.5, {z: 200, alpha: 0, transition: Transitions.EASE_IN, onComplete: destroy});
    }

    public function destroy():void {
        removeChild(_cell, true);
        _cell = null;

        removeFromParent(true);
    }
}
}
