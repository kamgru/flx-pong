package;

import flixel.*;
import flixel.util.*;
import flixel.input.keyboard.*;
import flixel.input.*;
import flixel.input.FlxInput;
import flixel.math.*;
import flixel.group.*;
import flixel.group.FlxGroup;
import flixel.addons.util.FlxFSM;

class GoalTrigger extends FlxSprite
{
    public var player(default, null):Int;

    public function new(player:Int, x:Float, y:Float, width:Int, height:Int)
    {
        super(x, y);
        this.player = player;
        immovable = true;
        solid = true;
        makeGraphic(width, height, FlxColor.WHITE);
    }
}