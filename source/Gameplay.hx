package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;
import flixel.addons.util.FlxFSM;
import flixel.group.FlxGroup;

class Gameplay extends FlxFSMState<PlayState>
{
	private var _ball:Ball;
	private var _walls:FlxSpriteGroup;
	private var _paddles:FlxSpriteGroup;
    private var _goals:FlxTypedGroup<GoalTrigger>;
	private var _bounceCalculator:BallPaddleBounceCalculator;
    private var _owner:PlayState;

    private static var _shouldTransition:Bool;

    override public function enter(owner:PlayState, fsm:FlxFSM<PlayState>):Void
    {
        _owner = owner;
        _ball = owner.ball;
		_walls = owner.stage.walls;
        _goals = owner.stage.goals;
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

    override public function exit(owner:PlayState):Void
    {
        _shouldTransition = false;
    }

	override public function update(elapsed:Float, owner:PlayState, fsm:FlxFSM<PlayState>):Void
	{
		FlxG.collide(_ball, _walls);
        FlxG.collide(_ball, _paddles, processBallPaddleCollision);        
        FlxG.collide(_ball, _goals, processBallGoalCollision);
	}

    public static function shouldTransition(owner:PlayState):Bool
    {
        return _shouldTransition;
    }

    private function processBallPaddleCollision(ball:Ball, paddle:Paddle):Void
    {
        var velocity = _bounceCalculator.calculateVelocity(ball, paddle);
		ball.velocity.set(velocity.x, velocity.y);
    }

    private function processBallGoalCollision(ball:Ball, goal:GoalTrigger):Void
    {
        ball.velocity.set(0, 0);
        _owner.goalInfo = {player: goal.player};
        _shouldTransition = true;
    }
}