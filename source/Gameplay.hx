package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;
import flixel.addons.util.FlxFSM;

class Gameplay extends FlxFSMState<PlayState>
{
	private var _ball:Ball;
	private var _walls:FlxSpriteGroup;
	private var _paddles:FlxSpriteGroup;
	private var _bounceCalculator:BallPaddleBounceCalculator;

    override public function enter(owner:PlayState, fsm:FlxFSM<PlayState>):Void
    {
        _ball = owner.ball;
		_walls = owner.walls;
		_paddles = owner.paddles;
        if (_bounceCalculator == null)
        {
            _bounceCalculator = new BallPaddleBounceCalculator(
            {
                paddleHeight:_paddles.members[0].height, 
                ballRadius:_ball.height / 2, 
                maxBounceAngle:75
            });    
        }
    }

	override public function update(elapsed:Float, owner:PlayState, fsm:FlxFSM<PlayState>):Void
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