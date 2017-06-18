package;

import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.util.FlxAxes;

class Gui extends FlxGroup
{
	private var _scoreText:FlxText;

	public function new(stage:Stage)
	{
		super();

		var p1Text = new FlxText(0,0,0, "P1", 10);
		p1Text.setPosition(stage.x, stage.y - p1Text.height - 2);
		add(p1Text);

		var p2Text = new FlxText(0, 0, 0, "P2", 10);
		p2Text.setPosition(stage.x + stage.width - p2Text.width, p1Text.y);
		add(p2Text);

		_scoreText = new FlxText(0, p1Text.y - 10, 0, "0:0", 20);
		_scoreText.screenCenter(FlxAxes.X);
		add(_scoreText);
	}

	public function updateScore(p1Score:Int, p2Score:Int):Void
	{
		_scoreText.text = p1Score + ":" + p2Score;
	}
}