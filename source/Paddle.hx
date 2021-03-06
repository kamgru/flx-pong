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
	public var player(default, null):Int;

	private var _inputMap:InputMap;
	private var _onActionCallback:Void->Void;

	public function new(player:Int, inputMap:InputMap)
	{
		super();
		_inputMap = inputMap;
		makeGraphic(10, 40, FlxColor.WHITE);
		immovable = true;
		this.player = player;
	}

	public function onAction(callback:Void->Void):Void
	{
		_onActionCallback = callback;
	}

	override public function update(elapsed:Float):Void
	{
        super.update(elapsed);
		handleInput();
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
}