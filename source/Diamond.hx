package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Diamond extends FlxSprite
{
	public function new(X: Float, Y: Float)
	{
		super(X, Y);
        loadGraphic("assets/images/diamond.png", true, 11, 9);
        
        animation.add("shine", [0, 1, 2, 3, 4, 5], 8);
        animation.play("shine");
        
        // AABB
        width = 22;
        height = 18;
        offset.set(-4, -2);
        
        scale.set(2,2);

    }
}