package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import Reg;

class WinState extends FlxState
{
   	override public function create():Void
	{
        super.create();
       
        var text = new FlxText(0, 64, FlxG.width);
        text.size = 16;
        text.alignment = "center";        
        text.text = "CONGRATULATIONS!\n\n You have found the exit to the dungeon.\n\n Diamonds: " + Reg.score + " / " + Reg.diamondsTotal;
        add(text);
    }
}