package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Door extends FlxSprite
{
	var colorPuerta: String;


	public function new(X: Float, Y: Float, frame: Int) // le paso por parametro la ubicacion y tambien el frame que tiene que mostrar (color)
	{
		super(X, Y);
		loadGraphic("assets/images/door.png", true, 32, 48);
		
		animation.add("Puerta", [frame], 0);
        animation.play("Puerta");


        switch(frame)
        {
            case 0:
                colorPuerta = "amarillo";
            case 1:
                colorPuerta = "rojo";
            case 2:
                colorPuerta = "azul";
        }

	}

	public function getDoorColor(): String
	{
		return colorPuerta;
	}
}