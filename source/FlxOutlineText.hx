package;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class FlxOutlineText extends FlxText {
	public var outlined(default, set):Bool = false;
	public var outlineColor:FlxColor = FlxColor.BLACK;
	public var outlineSize:Float = 1.0;

	private static var outlineShader:FlxOutlineShader = null;

	public override function draw():Void {
		@:privateAccess {
			colorTransform.redMultiplier = outlineColor.redFloat;
			colorTransform.greenMultiplier = outlineColor.greenFloat;
			colorTransform.blueMultiplier = outlineColor.blueFloat;
			colorTransform.alphaMultiplier = outlineColor.alphaFloat;
			colorTransform.redOffset = outlineSize * 255.0;
			colorTransform.blueOffset = colorTransform.greenOffset = colorTransform.alphaOffset = 0.0;
			super.draw();
		}
	}

	private function set_outlined(value:Bool):Bool {
		if (value) {
			if (outlineShader == null) {
				outlineShader = new FlxOutlineShader();
			}

			shader = outlineShader;
		}

		return outlined = value;
	}
}