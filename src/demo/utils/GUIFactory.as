/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.utils {
import avmplus.getQualifiedClassName;

import demo.utils.components.AbstractComponent;
import demo.utils.components.Button;
import demo.utils.components.Label;
import demo.utils.components.Picture;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.text.TextField;
import flash.text.TextFormat;

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
//                throw new Error("shape without ");
            } else if (child is Bitmap) {
                var bitmap:Bitmap = child as Bitmap;
                var bitmapName:String = getQualifiedClassName(bitmap.bitmapData);
                trace(bitmap.bitmapData, bitmapName);
                newChild = new Picture(assetManager.getTexture(bitmapName));
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
                newChild.x = child.x;
                newChild.y = child.y;
                parent.addChild(newChild);
            }
        }

        return parent;
    }
}
}
