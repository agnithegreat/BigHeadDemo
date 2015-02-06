/**
 * Created by kirillvirich on 02.02.15.
 */
package perspective {
import flash.utils.Dictionary;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.Sprite3D;
import starling.textures.Texture;

public class PerspectiveView extends Sprite3D implements IAnimatable {

    public static const VISIBLE_ROWS: int = 24;

    private var _cellTexture: Texture;

    private var _field: Sprite3D;
    private var _dict: Dictionary;

    private var _offset: Number;
    private var _row: int;
    private var _oldest: int;

    public function PerspectiveView(texture: Texture) {
        _cellTexture = texture;

        _field = new Sprite3D();
        _field.x = 300;
        addChild(_field);

//        init();
        initField();
    }

    private function init():void {
        _row = 0;
        _oldest = 0;
        _offset = 0;

        _dict = new Dictionary();

        for (var i:int = 0; i < VISIBLE_ROWS; i++) {
            addRow();
        }
    }

    private function initField():void {
        _row = 0;
        _oldest = 0;
        _offset = 0;

        _dict = new Dictionary();

        for (var i:int = 0; i < VISIBLE_ROWS; i++) {
            for (var j:int = 0; j < VISIBLE_ROWS; j++) {
//                if (Math.random() < 0.8) {
                    var cx: int = i-VISIBLE_ROWS/2;
                    var cy: int = j-VISIBLE_ROWS/2;
                    var cell: CellView = CellView.getCell(_cellTexture);
                    cell.place(cx, cy);
                    _dict[cx+"."+cy] = cell;
                    _field.addChild(cell);
//                }
            }
        }

        Starling.juggler.delayCall(fallField, 2);
    }

    private function fallField():void {
        var rands: Array = [0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1, 2.4, 2.7, 3];
        for each (var cell:CellView in _dict) {
            var rand: int = Math.random() * rands.length;
            Starling.juggler.delayCall(cell.animateRemove, rands[rand]);
        }
    }

    public function advanceTime(time: Number):void {
//        _offset += time * 5;
//
//        _field.pivotY = _offset * 100;
//
//        while (_offset + VISIBLE_ROWS > _row) {
//            addRow(true);
//        }
//
//        while (_offset > _oldest) {
//            removeOldRow();
//        }

        _offset += time * 0.5;
        _field.rotationZ = _offset;
    }

    private function addRow(animate: Boolean = false):void {
        for (var i:int = -3; i < 3; i++) {
            if (Math.random() < 0.8) {
                var cell: CellView = CellView.getCell(_cellTexture);
                cell.place(i, _row);
                _dict[i+"."+_row] = cell;
                _field.addChild(cell);

                if (animate) {
                    cell.animateAppear();
                }
            }
        }

        _row++;
    }

    private function removeOldRow():void {
        for (var i:int = -3; i < 3; i++) {
            var cell: CellView = _dict[i+"."+_oldest];
            if (cell) {
                cell.animateRemove();

                delete _dict[i+"."+_oldest];
            }
        }

        _oldest++;
    }
}
}
