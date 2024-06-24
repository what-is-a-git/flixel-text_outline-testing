package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Int64;
import openfl.display.BitmapData;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

class FlxTextField extends FlxSprite {
	private static var fieldCounts:Int64 = 0;

	private var field:TextField;
	private var bitmapData:BitmapData;

	public var text(default, set):String;
	public var textWidth(default, set):Float;
	public var font(default, set):String;
	public var size(default, set):Int;
	public var alignment(default, set):TextFormatAlign;

	public function new(x:Float = 0.0, y:Float = 0.0, text:String, width:Float = 100.0, font:String = '_sans', size:Int = 12,
			alignment:TextFormatAlign = LEFT) {
		super(x, y);

		++fieldCounts;
		makeGraphic(1024, 1024, FlxColor.TRANSPARENT, false, 'flxTextField_$fieldCounts');
		bitmapData = graphic.bitmap;

		field = new TextField();
		field.height = 100000.0;
		this.textWidth = width;

		@:bypassAccessor { // since this changes with the next line these would be unneccesary to do
			this.font = font;
			this.size = size;
		}
		this.alignment = alignment;
		this.text = text;
	}

	public override function draw():Void {
		super.draw();
	}

	private function set_text(value:String):String {
		if (field == null) {
			return text = value;
		}

		field.text = text = value;
		bitmapData.fillRect(bitmapData.rect, 0x00000000);
		bitmapData.draw(field);
		return value;
	}

	private function set_textWidth(value:Float):Float {
		if (field == null) {
			return textWidth = value;
		}

		return field.width = textWidth = value;
	}

	private function set_font(value:String):String {
		if (field == null) {
			return font = value;
		}

		field.defaultTextFormat = new TextFormat(value, size, 0xFFFFFFFF, null, null, null, null, null, alignment);
		return font = value;
	}

	private function set_size(value:Int):Int {
		if (field == null) {
			return size = value;
		}

		field.defaultTextFormat = new TextFormat(font, value, 0xFFFFFFFF, null, null, null, null, null, alignment);
		return size = value;
	}

	private function set_alignment(value:TextFormatAlign):TextFormatAlign {
		if (field == null) {
			return alignment = value;
		}

		field.defaultTextFormat = new TextFormat(font, size, 0xFFFFFFFF, null, null, null, null, null, value);
		return alignment = value;
	}
}