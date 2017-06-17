package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;

class PlayState extends FlxState
{
	private var _ball:Ball;
	private var _walls:FlxSpriteGroup;
	private var _paddles:FlxGroup;

	override public function create():Void
	{
		super.create();

		_paddles = new FlxGroup();
		_paddles.add(new Paddle({ UP: FlxKey.UP, DOWN: FlxKey.DOWN, ACTION:FlxKey.ENTER}, { x: 10, y: FlxG.height / 2 - 20}));
		_paddles.add(new Paddle({ UP: FlxKey.W, DOWN: FlxKey.S, ACTION:FlxKey.X}, {x: (FlxG.width - 20), y: (FlxG.height / 2 - 20) }));
		add(_paddles);

		_ball = new Ball();
		_ball.x = 10;
		_ball.y = 10;
		_ball.elasticity = 1;
		add(_ball);

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

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE)
		{
			_ball.start(new FlxVector(1, 1).normalize());
		}

		FlxG.collide(_ball, _walls);
		FlxG.collide(_ball, _paddles, function(ball:Ball, paddle:Paddle){
			
			var relativeIntersectY = paddle.y + paddle.height / 2 - ball.y;
			var normalizedIntersectY = relativeIntersectY / paddle.height / 2;
			var bounceAngle = normalizedIntersectY * 75;

			var velocity = new FlxVector(Math.cos(bounceAngle), -Math.sin(bounceAngle)).normalize();
			ball.velocity.x = velocity.x * ball.speed;
			ball.velocity.y = velocity.y * ball.speed;

		});

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.resetState();
		}

		trace(_ball.velocity);
	}
}
