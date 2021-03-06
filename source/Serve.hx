package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;
import flixel.addons.util.FlxFSM;

class Serve extends FlxFSMState<PlayState>
{
    private static var _served:Bool;

    private var _ball:Ball;
    private var _servingPaddle:Paddle;
    private var _stage:Stage;

    override public function enter(owner:PlayState, fsm:FlxFSM<PlayState>):Void
    {
        _ball = owner.ball;
        _stage= owner.stage;
        _servingPaddle = owner.servingPaddle;
        _servingPaddle.onAction(onServe);
        _ball.x = calculateBallX();
        _ball.visible = true;
    }

    override public function exit(owner:PlayState):Void
    {
        _served = false;
    }

    override public function update(elapsed:Float, owner:PlayState, fsm:FlxFSM<PlayState>):Void
	{
        _ball.y = _servingPaddle.y + _servingPaddle.height / 2 - _ball.height / 2;
	}

    public static function served(state:PlayState):Bool
    {
        return _served;
    }

    private function onServe():Void
    {
        var direction = new FlxVector(_ball.x > _servingPaddle.x ? 1 : -1, _ball.y > _stage.height / 2 ? 1 : -1).normalize();
        _ball.start(direction);
        _served = true;
    }

    private function calculateBallX()
    {
        if (_servingPaddle.player == 1)
        {
            return _servingPaddle.x + _servingPaddle.width + 1;
        }
        return _servingPaddle.x - _servingPaddle.width - 1;
    }
}