package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.animation.FlxAnimationController;

class Spikes extends FlxSprite
{
    var spikesON: Bool = false;
    
    public function new(X: Float, Y: Float)
	{
		super(X, Y);
        loadGraphic("assets/images/peaks.png", true, 16, 16);
        
        animation.add("moving_up", [0, 1, 2, 3], 8, false);
        animation.add("moving_down", [3, 2, 1, 0], 8, false);
        animation.add("idle", [0], 3);
        animation.add("up", [3], 3);
        animation.play("moving_up");
        
        scale.set(2,2);
        var timer = new FlxTimer();
        onRestartTimer(timer);

    }

    private function onTimerOff(theTimer: FlxTimer)
    {
        spikesON = true;
        animation.play("moving_up");
        theTimer.start(1, onRestartTimer);        
    }
      
    private function onRestartTimer(theTimer: FlxTimer)
    {
        spikesON = false;
        animation.play("moving_down");
        theTimer.start(3, onTimerOff);    
    }

    public function getSpikesState() : Bool
    {
        return spikesON;
    }
}