package;

import openfl.text.TextField;
import openfl.text.TextFormat;

class PerformanceStats extends TextField {
	public var framerate:Int = 0;

	private var lastTime:Float = 0.0;
	private var countedFrames:Int = 0;

	public function new(x:Float = 0.0, y:Float = 0.0) {
		super();

		this.x = x;
		this.y = y;
		autoSize = LEFT;
		selectable = false;
		mouseEnabled = false;

		defaultTextFormat = new TextFormat('_sans', 12, 0xFFFFFFFF);

		display();
	}

	private override function __enterFrame(delta:Float):Void {
		var currentTime:Float = Sys.time();
		++countedFrames;

		if (currentTime > lastTime + 1.0) {
			lastTime = currentTime;
			framerate = countedFrames;
			countedFrames = 0;
			display();
		}
	}

	private function display():Void {
		text = 'FPS: $framerate\nRAM: ${truncateDecimal(bytesToMegabytes(getMemoryUsage()), 2)} MiB';
	}

	private inline function truncateDecimal(input:Float, decimals:Int):Float {
		return Math.floor(input * (10 ^ decimals)) / (10 ^ decimals);
	}

	private inline function bytesToMegabytes(bytes:Float):Float {
		return bytes / 1024.0 / 1024.0;
	}

	public inline function getMemoryUsage():Float {
		#if cpp
		return cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
		#else
		return openfl.system.System.totalMemory;
		#end
	}
}