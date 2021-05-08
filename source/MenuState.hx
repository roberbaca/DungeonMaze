package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	override public function create():Void
	{
		var t:FlxText;
		t = new FlxText(0, FlxG.height / 2 - 40, FlxG.width, "Dungeon Maze");
		t.setFormat(null, 32, FlxColor.BLACK, CENTER, OUTLINE, FlxColor.WHITE);
		add(t);

		t = new FlxText(0, FlxG.height - 80, FlxG.width, "Press space to play");
		t.setFormat(null, 16, FlxColor.WHITE, CENTER, OUTLINE);
		add(t);


		t = new FlxText(0, FlxG.height - 30, FlxG.width, "Roberto Baca v1.0 - 2020");
		t.setFormat(null, 8, FlxColor.WHITE, CENTER, OUTLINE);
		add(t);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justReleased.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
	}
}