package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Enemy extends FlxSprite
{
	public function new(X: Float = 0, Y: Float = 0 )
	{
		super(X, Y);
        loadGraphic("assets/images/imp.png", true, 16, 15);
        
        animation.add("walking", [0, 1, 2, 3, 4, 5, 6, 7], 10);
        animation.add("idle", [8, 9, 10, 11, 12, 13, 14], 10);
        animation.play("idle");
        
        // AABB
        width = 22;
        height = 22;
      
        offset.set(-1, 0);

        scale.set(2,2);

        var timer = new FlxTimer();
        onRestartTimer(timer);
    }

    public override function update(elapsed: Float)
    {
        super.update(elapsed);
    }

    
    private function onTimerOff(theTimer: FlxTimer)
    {
        switch(FlxG.random.int(0, 3))
        {
            case 0:
                velocity.y = ENEMY_VEL;
                velocity.x = 0;
                animation.play("walking");
            case 1:
                velocity.y = -ENEMY_VEL;
                velocity.x = 0;
                animation.play("walking");
            case 2:
                velocity.y = 0;
                velocity.x = ENEMY_VEL;
                animation.play("walking");
                flipX = false;
            case 3:
                velocity.y = 0;
                velocity.x = -ENEMY_VEL;
                animation.play("walking");
                flipX = true;
            
        }
        theTimer.start(FlxG.random.int(1, 3), onRestartTimer);
    }

    private function onRestartTimer(theTimer: FlxTimer)
    {
        velocity.x = velocity.y = 0;
        animation.play("idle");
        theTimer.start(FlxG.random.int(0, 8), onTimerOff);
    }

    static inline var ENEMY_VEL: Float = 80;
}