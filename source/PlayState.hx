package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;
import flixel.group.FlxGroup;
import flixel.addons.util.FlxFSM;

typedef GoalInfo = { player:Int };

class PlayState extends FlxState
{
	public var ball:Ball;
	public var paddles:FlxSpriteGroup;
	public var servingPaddle:Paddle;
	public var stage:Stage;

	public var goalInfo:GoalInfo;

	private var _fsm:FlxFSM<PlayState>;
	
	override public function create():Void
	{
		super.create();

		stage = new Stage(600, 400, (FlxG.width - 600) / 2, (FlxG.height - 400) / 2);
		add(stage.walls);
		add(stage.goals);

		addPaddles(stage);
		addBall();

		servingPaddle = cast(paddles.members[0], Paddle);

		_fsm = new FlxFSM<PlayState>(this, new Serve());
		_fsm.transitions.add(Serve, Gameplay, Serve.served);
		_fsm.transitions.add(Gameplay, Serve, Gameplay.shouldTransition);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.resetState();
		}

		_fsm.update(elapsed);
		checkPaddleBounds();
	}

	private function checkPaddleBounds():Void
	{
		for (paddle in paddles)
		{
			if (paddle.y < stage.y + 1) 
			{
				paddle.y = stage.y + 1;
			}

			if (paddle.y > stage.y + stage.height - paddle.height)
			{
				paddle.y = stage.y + stage.height - paddle.height;
			}
		}
	}

	private function addPaddles(stage:Stage):Void
	{
		var startingSpots = stage.getPaddleStartingSpots(10, 40);

		paddles = new FlxSpriteGroup();

		var leftPaddle = new Paddle(1, { UP: FlxKey.UP, DOWN: FlxKey.DOWN, ACTION:FlxKey.ENTER});
		leftPaddle.setPosition(startingSpots[0].x, startingSpots[0].y);

		var rightPaddle = new Paddle(2, { UP: FlxKey.W, DOWN: FlxKey.S, ACTION:FlxKey.X});
		rightPaddle.setPosition(startingSpots[1].x, startingSpots[1].y);

		paddles.add(leftPaddle);
		paddles.add(rightPaddle);

		add(paddles);
	}

	private function addBall():Void
	{
		ball = new Ball();
		ball.x = 10;
		ball.y = 10;
		add(ball);
	}
}
