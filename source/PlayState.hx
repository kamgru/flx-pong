package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;
import flixel.addons.util.FlxFSM;

class PlayState extends FlxState
{
	private var _ball:Ball;
	private var _walls:FlxSpriteGroup;
	private var _paddles:FlxSpriteGroup;

	private var _fsm:FlxFSM<FlxState>;

	override public function create():Void
	{
		super.create();

		addPaddles();
		addBall();
		addWalls();

		_fsm = new FlxFSM<FlxState>(this, new Gameplay(_ball, _paddles, _walls));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE)
		{
			_ball.start(new FlxVector(1, 1).normalize());
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.resetState();
		}

		_fsm.update(elapsed);
	}

	private function addPaddles():Void
	{
		_paddles = new FlxSpriteGroup();
		_paddles.add(new Paddle({ UP: FlxKey.UP, DOWN: FlxKey.DOWN, ACTION:FlxKey.ENTER}, { x: 10, y: FlxG.height / 2 - 20}));
		_paddles.add(new Paddle({ UP: FlxKey.W, DOWN: FlxKey.S, ACTION:FlxKey.X}, {x: (FlxG.width - 20), y: (FlxG.height / 2 - 20) }));
		add(_paddles);
	}

	private function addBall():Void
	{
		_ball = new Ball();
		_ball.x = 10;
		_ball.y = 10;
		add(_ball);
	}

	private function addWalls():Void
	{
		_walls = new FlxSpriteGroup();
		_walls.add(new FlxSprite().makeGraphic(FlxG.width, 1, FlxColor.WHITE));
		_walls.add(new FlxSprite(0, FlxG.height - 1).makeGraphic(FlxG.width, 1, FlxColor.WHITE));
		_walls.add(new FlxSprite(0, 0).makeGraphic(1, FlxG.height, FlxColor.WHITE));
		_walls.add(new FlxSprite(FlxG.width - 1, 0).makeGraphic(1, FlxG.height, FlxColor.WHITE));
		for (wall in _walls)
		{
			wall.immovable = true;
			wall.solid = true;
		}
		add(_walls);
	}
}
