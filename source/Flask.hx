package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Flask extends FlxSprite
{
	public function new(X: Float, Y: Float)
	{
		super(X, Y);
        loadGraphic("assets/images/flask.png", true, 12, 17);
		
		width = 16;
        height = 20;
		offset.set(-2,0);
		
		scale.set(1.5,1.5);
    }
}