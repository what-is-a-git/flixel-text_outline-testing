package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(0, 0, MainState));
		addChild(new PerformanceStats(3, 3));
	}
}
