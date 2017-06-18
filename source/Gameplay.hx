package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;
import flixel.addons.util.FlxFSM;

class Gameplay extends FlxFSMState<FlxState>
{
	private var _ball:Ball;
	private var _walls:FlxSpriteGroup;
	private var _paddles:FlxGroup;
	private var _bounceCalculator:BallPaddleBounceCalculator = new BallPaddleBounceCalculator();

	public function new(ball:Ball, paddles:FlxGroup, walls:FlxSpriteGroup)
	{
		super();
		_ball = ball;
		_walls = walls;
		_paddles = paddles;
	}

	override public function update(elapsed:Float, owner:FlxState, fsm:FlxFSM<FlxState>):Void
	{
		processCollisions();
	}

	private function processCollisions():Void
	{
		FlxG.collide(_ball, _walls);
		FlxG.collide(_ball, _paddles, function(ball:Ball, paddle:Paddle)
		{
			var velocity = _bounceCalculator.calculateVelocity(ball, paddle);
			ball.velocity.set(velocity.x, velocity.y);
		});
	}
}