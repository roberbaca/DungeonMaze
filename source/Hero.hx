package;

import haxe.display.Position;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.FlxSprite;
import flixel.FlxG; 
import Reg;

class Hero extends FlxSprite
{
    // banderas para guardar la direccion a la que debe mirar el personaje
	var izquierda:                          Bool = false;
	var derecha:                            Bool = false;
	var arriba:                             Bool = false;
    var abajo:                              Bool = true;
    
    var flaskCount:                         Int;
    var diamondCount:		                Int; 		    
    
    var isRedKey:                           Bool = false;
    var isYellowKey:                        Bool = false;
    var isBlueKey:                          Bool = false;

    var HERO_VEL_MAX:                       Float = 120;    // velocidad maxima
    static inline var HERO_ACC:             Float = 20;     // aceleracion del personaje
    

	public function new(X: Float, Y: Float)
	{
		super(X, Y);
        loadGraphic("assets/images/hero.png", true, 16, 17);
        
        animation.add("idle_down", [0, 1, 2, 3, 4, 5], 10);
        animation.add("idle_left", [6, 7, 8, 9, 10, 11], 10);
        animation.add("idle_right", [12, 13, 14, 15, 16, 17], 10);
        animation.add("idle_up", [18, 19, 20, 21, 22, 23], 10);
        animation.add("walking_down", [24, 25, 26, 27, 28, 29], 10);
        animation.add("walking_left", [30, 31, 32, 33, 34, 35], 10);
        animation.add("walking_right", [36, 37, 38, 39, 40, 41], 10);
        animation.add("walking_up", [42, 43, 44, 45, 46, 47], 10);
        animation.play("idle_down");
            
        flaskCount = 0;
        diamondCount = 0;
        
        //ajustamos box de colision del heroe
        width = 16;
        height = 28;
        offset.set(0,-2);
        scale.set(2,2);
      
    }

    public override function update(elapsed: Float)
    {
        super.update(elapsed);
             
        // la velocidad maxima del personaje depende de las pociones que agarremos
        HERO_VEL_MAX = 120 + 120 * 0.1 * (flaskCount); 

        // Limito la velocidad para que no se acelere de forma infinita

        if (velocity.x <= (-HERO_VEL_MAX))
        {
            velocity.x = -HERO_VEL_MAX;
        }

        if (velocity.x >= HERO_VEL_MAX)
        {
            velocity.x = HERO_VEL_MAX;
        }
        
        
        if (velocity.y <= (-HERO_VEL_MAX))
        {
            velocity.y = -HERO_VEL_MAX;
        }
    
        if (velocity.y >= HERO_VEL_MAX)
        {
            velocity.y = HERO_VEL_MAX;
        }

        // MOVIMIENTO

		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) // movimiento a la izquierda
        {
            velocity.x -= HERO_ACC; // MRUV
            velocity.y = 0;
                
            izquierda = true;
            derecha = false;
            arriba = false;
            abajo = false;
        }
        else if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) // movimiento a la derecha
        {
            velocity.x += HERO_ACC; // MRUV
            velocity.y = 0;
                                
            izquierda = false;
            derecha = true;
            arriba = false;
            abajo = false;
        }
        else if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP) // movimiento hacia arriba
        {
            velocity.y -= HERO_ACC; // MRUV
            velocity.x = 0;
                            
            izquierda = false;
            derecha = false;
            arriba = true;
            abajo = false;
        }
        else if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN) // movimiento hacia abajo
        {
            velocity.y += HERO_ACC; // MRUV
            velocity.x = 0;
                
            izquierda = false;
            derecha = false;
            arriba = false;
            abajo = true;
        }
        else
        {
            velocity.y = 0; 
            velocity.x = 0;
        }
                        
    
        // ANIMACIONES
    
        if ((velocity.x > 0) && (velocity.y == 0)) // derecha
        {
            animation.play("walking_right");
                
        }
        else if ((velocity.x < 0) && (velocity.y == 0)) // izquierda
        {
            animation.play("walking_left");
               
        }
            
        else if ((velocity.y < 0) && (velocity.x == 0)) // arriba
        {
            animation.play("walking_up");
        }
        else if ((velocity.y > 0) && (velocity.x == 0)) // abajo
        {
            animation.play("walking_down");
        }
        else if ((velocity.y == 0) && (velocity.x == 0)) // idle
        {
            if (arriba)
            {
                 animation.play("idle_up");
            }
            else if (abajo)
            {
                animation.play("idle_down");
            }
            else if (derecha)
            {
                animation.play("idle_right");
            }
            else if (izquierda)
            {
                animation.play("idle_left");
            }
        }
    }

    public function pickUpFlask(): Void
    {
        flaskCount++;
    }

    public function getFlaskCount(): Int
    {
        return flaskCount;
    }

    public function pickUpDiamond(): Void
    {
        diamondCount++;
        Reg.score += 1; // guardo la cantidad de diamantes para mostrarlo en el WinState
    }

    public function getDiamondCount(): Int
    {
        return diamondCount;
    }

    public function pickUpRedKey(): Void
    {
        isRedKey = true;
    }

    public function isRedKeyPicked(): Bool
    {
        return isRedKey;
    }
        
    public function pickUpYellowKey(): Void
    {
        isYellowKey = true;
    }
    
    public function isYellowKeyPicked(): Bool
    {
         return isYellowKey;
    }
        
    public function pickUpBlueKey(): Void
    {
        isBlueKey = true;
    }
    
    public function isBlueKeyPicked(): Bool
    {
        return isBlueKey;
    }
     
}