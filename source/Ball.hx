package;

import flixel.*;
import flixel.util.*;
import flixel.math.*;

class Ball extends FlxSprite
{
    private var _direction:FlxVector;
    public var speed(default, default):Float = 400;

    public function new()
    {
        super();
        makeGraphic(10, 10, FlxColor.WHITE);
        _direction = new FlxVector();
    }

    public function start(direction:FlxVector):Void
    {
        _direction = direction;
        velocity.x = direction.x * speed;
        velocity.y = direction.y * speed;
    }
}