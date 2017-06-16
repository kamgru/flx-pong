package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();

		add(new Paddle({ UP: FlxKey.UP, DOWN: FlxKey.DOWN}, { x: 10, y: FlxG.height / 2 - 20}));
		add(new Paddle({ UP: FlxKey.W, DOWN: FlxKey.S}, {x: (FlxG.width - 20), y: (FlxG.height / 2 - 20) }));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

	}
}
