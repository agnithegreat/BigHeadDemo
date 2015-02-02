/**
 * Created by kirillvirich on 02.02.15.
 */
package perspective {
import flash.utils.Dictionary;

import starling.animation.IAnimatable;
import starling.display.Sprite3D;

public class PerspectiveView extends Sprite3D implements IAnimatable {

    public static const VISIBLE_ROWS: int = 15;

    private var _field: Sprite3D;
    private var _dict: Dictionary;

    private var _offset: Number;
    private var _row: int;
    private var _oldest: int;

    public function PerspectiveView() {
        _field = new Sprite3D();
        _field.pivotX = 300;
        _field.x = 300;
        _field.rotationX = Math.PI/4;
        addChild(_field);

        init();
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

    public function advanceTime(time: Number):void {
        _offset += time * 5;

        _field.pivotY = _offset * 100;

        while (_offset + VISIBLE_ROWS > _row) {
            addRow(true);
        }

        while (_offset > _oldest) {
            removeOldRow();
        }
    }

    private function addRow(animate: Boolean = false):void {
        for (var i:int = 0; i < 6; i++) {
            if (Math.random() < 0.8) {
                var cell: CellView = new CellView(i, _row);
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
        for (var i:int = 0; i < 6; i++) {
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
