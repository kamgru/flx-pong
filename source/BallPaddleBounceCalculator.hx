package;

import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.FlxAngle;

typedef BounceData = {paddleHeight:Float, ballRadius:Float, maxBounceAngle:Float};

class BallPaddleBounceCalculator
{
    private var _intersectOffset:Float;
    private var _maxBounceAngleRadians:Float;

    public function new(bounceData:BounceData) 
    {
        _intersectOffset = bounceData.paddleHeight / 2 - bounceData.ballRadius;
        _maxBounceAngleRadians = FlxAngle.asRadians(bounceData.maxBounceAngle);
    }

    public function calculateVelocity(ball:Ball, paddle:Paddle):FlxPoint
    {
        var xSign = ball.velocity.x >= 0 ? 1 : -1;

        var relativeIntersectY = paddle.y - ball.y + _intersectOffset;
        var normalizedIntersectY = relativeIntersectY / paddle.height;
        var bounceAngle = normalizedIntersectY * _maxBounceAngleRadians;

        var velocity = new FlxVector(Math.cos(bounceAngle), -Math.sin(bounceAngle)).normalize();
        return new FlxPoint(velocity.x * ball.speed * xSign, velocity.y * ball.speed);
    }
}