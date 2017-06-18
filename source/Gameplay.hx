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
	private var _paddles:FlxSpriteGroup;
	private var _bounceCalculator:BallPaddleBounceCalculator;

	public function new(ball:Ball, paddles:FlxSpriteGroup, walls:FlxSpriteGroup)
	{
		super();
		_ball = ball;
		_walls = walls;
		_paddles = paddles;
        _bounceCalculator = new BallPaddleBounceCalculator(
            {
                paddleHeight:_paddles.members[0].height, 
                ballRadius:ball.height / 2, 
                maxBounceAngle:75
            });
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