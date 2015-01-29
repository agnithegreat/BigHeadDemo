/**
 * Created by kirillvirich on 29.01.15.
 */
package demo.utils {
import avmplus.getQualifiedClassName;

import demo.utils.view.AbstractView;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.text.TextField;
import flash.text.TextFormat;

import starling.display.Button;
import starling.display.Image;
import starling.text.TextField;
import starling.utils.AssetManager;

public class GUIFactory {

    private static var assetManager: AssetManager;

    public static function init(inAssetManager: AssetManager):void {
        assetManager = inAssetManager;
    }

    public static function createView(parent: AbstractView, inView: DisplayObjectContainer):AbstractView {
        for (var i:int = 0; i < inView.numChildren; i++) {
            var child: DisplayObject = inView.getChildAt(i);
            trace(child, child.name);

            var newChild: starling.display.DisplayObject;
            if (child is Shape) {
                var shape: Shape = child as Shape;
//                throw new Error("shape without ");
            } else if (child is Bitmap) {
                var bitmap:Bitmap = child as Bitmap;
                var bitmapName:String = getQualifiedClassName(bitmap.bitmapData);
                trace(bitmapName);
                newChild = new Image(assetManager.getTexture(bitmapName));
            } else if (child is flash.text.TextField) {
                var textField: flash.text.TextField = child as flash.text.TextField;
                var textFormat: TextFormat = textField.getTextFormat();
                newChild = new starling.text.TextField(textField.width, textField.height, textField.text, textFormat.font, int(textFormat.size), int(textFormat.color), textFormat.bold);
            } else if (child is DisplayObjectContainer) {
                newChild = new AbstractView();
                createView(newChild as AbstractView, child as DisplayObjectContainer);
            }
            if (newChild) {
                newChild.x = child.x;
                newChild.y = child.y;
                parent.addChild(newChild);
            }
        }

        return parent;
    }

    public static function createButton(btn: DisplayObjectContainer):Button {
        var text: String = btn["text"].text;

        var button: Button = new Button(null, text);
        return button;
    }
}
}
