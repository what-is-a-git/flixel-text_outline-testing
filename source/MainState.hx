package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MainState extends FlxState {
	public var baselineText:FlxText;
	public var normalTextField:FlxTextField;
	public var outlinedText:FlxOutlineText;

	override public function create() {
		FlxG.cameras.bgColor = 0xFF666666;
		FlxG.stage.frameRate = 1000;
		FlxG.updateFramerate = 1000;
		FlxG.drawFramerate = 1000;
		FlxG.autoPause = false;

		super.create();

		baselineText = new FlxText(16.0, FlxG.height - 16.0, 0.0, 'This is some normal FlxText!', 16);
		baselineText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.5);
		baselineText.y -= baselineText.height;
		add(baselineText);

		normalTextField = new FlxTextField(0.0, 16.0, 'This is a FlxTextField (unused in terms of FlxOutlineText but I was trying).', FlxG.width, '_sans', 12,
			CENTER);
		add(normalTextField);

		outlinedText = new FlxOutlineText(-16.0, baselineText.y, FlxG.width, 'This is some ok FlxOutlineText!', 16);
		outlinedText.alignment = RIGHT;
		outlinedText.outlined = true;
		outlinedText.outlineSize = 2.0;
		add(outlinedText);

		var cumTtexx = new FlxOutlineText(16.0, baselineText.y - baselineText.height - 16.0, FlxG.width,
			'This is some less ok FlxOutlineText...\nDecimal outlines don\'t work that well...', 16);
		cumTtexx.alignment = LEFT;
		cumTtexx.outlined = true;
		cumTtexx.outlineColor = FlxColor.BLACK;
		cumTtexx.outlineSize = 1.5;
		add(cumTtexx);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
