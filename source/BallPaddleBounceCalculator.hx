package;

import flixel.math.FlxPoint;
import flixel.math.FlxVector;

class BallPaddleBounceCalculator
{
    public function new() {}

    public function calculateVelocity(ball:Ball, paddle:Paddle):FlxPoint
    {
        var relativeIntersectY = paddle.y - paddle.height / 2 + ball.y;
        var normalizedIntersectY = relativeIntersectY / paddle.height / 2;
        var bounceAngle = normalizedIntersectY * 75;

        var velocity = new FlxVector(Math.cos(bounceAngle), -Math.sin(bounceAngle)).normalize();
        return new FlxPoint(velocity.x * ball.speed, velocity.y * ball.speed);
    }
}