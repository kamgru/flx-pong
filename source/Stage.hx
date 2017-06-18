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

class Stage
{
	public var width:Int;
	public var height:Int;
    public var x:Float;
    public var y:Float;
    public var walls:FlxSpriteGroup;
	
	public function new(width:Int, height:Int, x:Float, y:Float)
	{
		this.width = width;
		this.height = height;
        this.x = x;
        this.y = y;
		walls = createWalls();
	}

	public function getStageSize():FlxPoint
	{
		return new FlxPoint(width, height);
	}

	public function getPaddleStartingSpots(paddleWidth:Int, paddleHeight:Int):Array<FlxPoint>
	{
		var leftSpot = new FlxPoint(x + 10, y + height / 2 - paddleHeight / 2);
		var rightSpot = new FlxPoint(x + width - 20,  y + height / 2 - paddleHeight / 2);
		return [leftSpot, rightSpot];
	}

	private function createWalls():FlxSpriteGroup
	{
        var walls = new FlxSpriteGroup();
		walls.add(createWall(x, y, width, 1));
		walls.add(createWall(x, y + height - 1, width, 1));
		walls.add(createWall(x, y, 1, height));
		walls.add(createWall(x + width - 1, y, 1, height));
        return walls;
	}

	private function createWall(x:Float, y:Float, width:Int, height:Int):FlxSprite
	{
		var wall = new FlxSprite(x, y).makeGraphic(width, height, FlxColor.WHITE);
		wall.solid = true;
		wall.immovable = true;
		return wall;
	}
}