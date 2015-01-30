/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.utils {
import demo.utils.components.AbstractComponent;
import demo.utils.components.Button;
import demo.utils.components.Label;
import demo.utils.components.Picture;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

import starling.textures.Texture;

import starling.utils.AssetManager;

public class GUIFactory {

    private static var assetManager: AssetManager;

    public static function init(inAssetManager: AssetManager):void {
        assetManager = inAssetManager;
    }

    public static function createView(parent: AbstractComponent, inView: DisplayObjectContainer):AbstractComponent {
        for (var i:int = 0; i < inView.numChildren; i++) {
            var child: DisplayObject = inView.getChildAt(i);

            var newChild: AbstractComponent;
            if (child is Shape) {
                var shape: Shape = child as Shape;
                var rect: Rectangle = shape.getBounds(shape);
                var bitmapData: BitmapData = new BitmapData(shape.width, shape.height, true, 0);
                bitmapData.draw(shape, new Matrix(1, 0, 0, 1, -rect.x, -rect.y));
                shape.transform.matrix = new Matrix(1, 0, 0, 1, rect.x, rect.y);
                newChild = new Picture(Texture.fromBitmapData(bitmapData));
            } else if (child is Bitmap) {
                var bitmap:Bitmap = child as Bitmap;
                newChild = new Picture(Texture.fromBitmap(bitmap));
//                var bitmapName:String = getQualifiedClassName(bitmap.bitmapData);
//                newChild = new Picture(assetManager.getTexture(bitmapName));
            } else if (child is TextField) {
                var textField: TextField = child as TextField;
                var textFormat: TextFormat = textField.getTextFormat();
                newChild = new Label(textField.width, textField.height, textField.text, textFormat.font, int(textFormat.size), int(textFormat.color), textFormat.bold);
            } else if (child is DisplayObjectContainer) {
                if (child.name.search("btn_") == 0) {
                    newChild = new Button();
                } else {
                    newChild = new AbstractComponent();
                }
                newChild.createFromFlash(child as DisplayObjectContainer);
            }

            trace(child, child.name, newChild);
            if (newChild) {
                newChild.name = child.name;
                newChild.transformationMatrix = child.transform.matrix;
                parent.addChild(newChild);
            }
        }

        return parent;
    }
}
}
