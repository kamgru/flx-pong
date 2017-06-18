package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;

typedef InputMap = { UP:FlxKey, DOWN:FlxKey, ACTION:FlxKey }
typedef SpawnPoint = { x:Float, y:Float }

class Paddle extends FlxSprite
{
	public var speed(default, default):Float = 300;

	private var _inputMap:InputMap;
	private var _onActionCallback:Void->Void;

	public function new(inputMap:InputMap, ?spawnPoint:SpawnPoint)
	{
		super();
		_inputMap = inputMap;
		makeGraphic(10, 40, FlxColor.WHITE);
		immovable = true;

		if (spawnPoint != null)
		{
			x = spawnPoint.x;
			y = spawnPoint.y;	
		}
	}

	public function onAction(callback:Void->Void):Void
	{
		_onActionCallback = callback;
	}

	override public function update(elapsed:Float):Void
	{
        super.update(elapsed);
		handleInput();
		checkBounds();
	}

	private function handleInput():Void
	{
		var up = FlxG.keys.checkStatus(_inputMap.UP, FlxInputState.PRESSED);
        var down = FlxG.keys.checkStatus(_inputMap.DOWN, FlxInputState.PRESSED);

        if (up == down) 
        {
            velocity.y = 0;
        }

		if (up)
		{
			velocity.y = -speed;
		}

		if (down)
		{
			velocity.y = speed;
		}

		if (FlxG.keys.checkStatus(_inputMap.ACTION, FlxInputState.JUST_PRESSED))
		{
			if (_onActionCallback != null)
			{
				_onActionCallback();
			}
		}
	}

	private function checkBounds():Void
	{
		if (this.y < 0) 
		{
			this.y = 0;
		}

		if (this.y > FlxG.height - this.height)
		{
			this.y = FlxG.height - this.height;
		}
	}
}