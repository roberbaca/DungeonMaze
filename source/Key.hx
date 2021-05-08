package;

import lime.net.oauth.OAuthToken.RequestToken;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Key extends FlxSprite
{

    var colorLlave: String;

	public function new(X: Float, Y: Float, frame: Int) // le paso por parametro la ubicacion y tambien el frame que tiene que mostrar (color)
	{
		super(X, Y);
        loadGraphic("assets/images/llave.png", true, 11, 8);
                
        animation.add("Llave", [frame], 0);
        animation.play("Llave");


        switch(frame)
        {
            case 0:
                colorLlave = "amarillo";
            case 1:
                colorLlave = "rojo";
            case 2:
                colorLlave = "azul";
        }
        
         scale.set(2,2);
    }

    public function getKeyColor(): String
    {
        return colorLlave;
    }
}