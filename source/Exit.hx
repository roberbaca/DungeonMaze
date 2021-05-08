package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Exit extends FlxSprite
{
	public function new(X: Float, Y: Float)
	{
		super(X, Y);
        loadGraphic("assets/images/exit.png", false, 48, 48);
		
		// AABB
		width = 32;
		height = 8;
		
		scale.set(2,2);
    }
}