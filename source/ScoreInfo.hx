package;

class ScoreInfo
{
	private var _scores:Array<Int> = [0, 0];

	public function new(){}

	public function addScore(player:Int):Void
	{
		_scores[player - 1]++;
	}

	public function getScore():Array<Int>
	{
		return _scores.copy();
	}
}