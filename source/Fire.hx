package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.animation.FlxAnimationController;

class Fire extends FlxSprite
{

    var fireIsON: Bool = false;
    
    public function new(X: Float, Y: Float)
	{
		super(X, Y);
        loadGraphic("assets/images/fire.png", true, 16, 48);
        
        animation.add("fire_on", [0, 1, 2, 3, 4, 5], 10, true);
        animation.add("fire_off", [5], 10, false);
   
        // AABB
        width = 32;
        height = 64;
        offset.set(-8, 16);
        
        scale.set(2,2);
        var timer = new FlxTimer();
        onRestartTimer(timer);
    }

    private function onTimerOff(theTimer: FlxTimer)
    {
        animation.play("fire_on");
        theTimer.start(1, onRestartTimer);        
    }
      
    private function onRestartTimer(theTimer: FlxTimer)
    {
        animation.play("fire_off");
        theTimer.start(3, onTimerOff);       
    }

    public override function update(elapsed: Float)
    {
        super.update(elapsed);
        if  (animation.name == "fire_on")
        {
            fireIsON = true;        
        }
        else if  (animation.name == "fire_off")
        {
            fireIsON = false; 
        }
    }
    

    public function getFireState() : Bool
    {
        return fireIsON;
    }
}