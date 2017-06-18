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
	public var ball:Ball;
	public var walls:FlxSpriteGroup;
	public var paddles:FlxSpriteGroup;
	public var servingPaddle:Paddle;

	private var _fsm:FlxFSM<PlayState>;

	override public function create():Void
	{
		super.create();

		addPaddles();
		addBall();
		addWalls();

		servingPaddle = cast(paddles.members[0], Paddle);

		_fsm = new FlxFSM<PlayState>(this, new Serve());
		_fsm.transitions.add(Serve, Gameplay, Serve.served);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.resetState();
		}

		_fsm.update(elapsed);
	}

	private function addPaddles():Void
	{
		paddles = new FlxSpriteGroup();
		paddles.add(new Paddle({ UP: FlxKey.UP, DOWN: FlxKey.DOWN, ACTION:FlxKey.ENTER}, { x: 10, y: FlxG.height / 2 - 20}));
		paddles.add(new Paddle({ UP: FlxKey.W, DOWN: FlxKey.S, ACTION:FlxKey.X}, {x: (FlxG.width - 20), y: (FlxG.height / 2 - 20) }));
		add(paddles);
	}

	private function addBall():Void
	{
		ball = new Ball();
		ball.x = 10;
		ball.y = 10;
		add(ball);
	}

	private function addWalls():Void
	{
		walls = new FlxSpriteGroup();
		walls.add(new FlxSprite().makeGraphic(FlxG.width, 1, FlxColor.WHITE));
		walls.add(new FlxSprite(0, FlxG.height - 1).makeGraphic(FlxG.width, 1, FlxColor.WHITE));
		walls.add(new FlxSprite(0, 0).makeGraphic(1, FlxG.height, FlxColor.WHITE));
		walls.add(new FlxSprite(FlxG.width - 1, 0).makeGraphic(1, FlxG.height, FlxColor.WHITE));
		for (wall in walls)
		{
			wall.immovable = true;
			wall.solid = true;
		}
		add(walls);
	}
}
