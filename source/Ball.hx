package;

import flixel.*;
import flixel.util.*;
import flixel.math.*;

class Ball extends FlxSprite
{
    public var speed(default, default):Float = 400;

    public function new()
    {
        super();
        makeGraphic(10, 10, FlxColor.WHITE);
        elasticity = 1;
    }

    public function start(direction:FlxVector):Void
    {
        velocity.x = direction.x * speed;
        velocity.y = direction.y * speed;
    }
}