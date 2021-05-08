package;

import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledObject;
import flixel.FlxCamera;
import Reg;

class PlayState extends FlxState
{
	
	var hero: 				Hero;
	var salida:				Exit;
	
	var tiledMap:			TiledMap;
	var solidMap:			FlxTilemap;
	var shadowMap:			FlxTilemap;
	var floorMap:			FlxTilemap;
	
	var flaskGroup:			FlxGroup;	// grupo para las pociones
	var enemiesGroup: 		FlxGroup;	// grupo para los enemigos
	var doorGroup:			FlxGroup;	// grupo para las puertas
	var diamondGroup:		FlxGroup;	// grupo para los diamantes
	var keyGroup:			FlxGroup;	// grupo para las llaves
	var trapsGroup: 		FlxGroup;	// grupo para las trampas

	var heroCollideables: 	FlxGroup;	// grupo para todos los objetos con los que puede colisionar el heroe
		
	override public function create():Void
	{
		super.create();
		
		Reg.score = 0;			 // reseteo el puntaje
		Reg.diamondsTotal = 0; 	 // contro del total de diamantes

		//FlxG.debugger.visible = true; // para debug visible por codigo

		tiledMap = new TiledMap("assets/data/Dungeons.tmx");
		
		flaskGroup = new FlxGroup();
		enemiesGroup = new FlxGroup();
		doorGroup = new FlxGroup();
		diamondGroup = new FlxGroup();
		keyGroup = new FlxGroup();
		trapsGroup = new FlxGroup();
		heroCollideables = new FlxGroup();
		salida = new Exit(472, 48);

		hero = new Hero(32, 160);

		var solidLayer = cast(tiledMap.getLayer("solid"), TiledTileLayer); 		// capa de solidos
		var shadowLayer = cast(tiledMap.getLayer("shadows"), TiledTileLayer);	// capa de las sombras
		var floorLayer = cast(tiledMap.getLayer("floor"), TiledTileLayer);		// capa del piso
		var objectLayer = cast(tiledMap.getLayer("objects"), TiledObjectLayer);	// capa de los objetos

		for (i in 0...objectLayer.objects.length)
		{
			loadObject(objectLayer.objects[i]);
		} 

		
		// ----- Layer Solid --------
		solidMap = new FlxTilemap();
		solidMap.loadMapFromArray(solidLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/dungeon.png", tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF,1);
		
		
		// ----- Layer Shadows --------
		shadowMap = new FlxTilemap();
		shadowMap.loadMapFromArray(shadowLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/dungeon.png", tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF,1);

		// ----- Layer Floor --------
		floorMap = new FlxTilemap();
		floorMap.loadMapFromArray(floorLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/dungeon.png", tiledMap.tileWidth, tiledMap.tileHeight, FlxTilemapAutoTiling.OFF,1);
	
		
		// objetos con los que puede colisiones el heroe.
		heroCollideables.add(solidMap);
		heroCollideables.add(keyGroup);
		heroCollideables.add(enemiesGroup);
		heroCollideables.add(flaskGroup);
		heroCollideables.add(diamondGroup);
		heroCollideables.add(doorGroup);
		heroCollideables.add(trapsGroup);
		heroCollideables.add(salida);

		add(floorMap);
		add(shadowMap);
		add(solidMap);
		add(flaskGroup);
		add(doorGroup);
		add(diamondGroup);
		add(keyGroup);
		add(salida);
		add(trapsGroup);
		add(enemiesGroup);
		add(hero);
		

		FlxG.camera.follow(hero, TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0,0, tiledMap.fullWidth, tiledMap.fullHeight, true);
			
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// comprobar colisiones:
		FlxG.collide(solidMap, enemiesGroup);
		FlxG.collide(doorGroup, enemiesGroup);
		FlxG.overlap(heroCollideables, hero, onHeroCollision); 
	
	}

	function loadObject(obj: TiledObject) 
	{
		// crea los objetos
		var type = obj.type;
			
		switch(type)
		{
			case "Flask":
			{
				var flask = new Flask(obj.x + 8, obj.y - 24);
				flaskGroup.add(flask);
			}
			
			case "Enemy":
			{
				var enemy = new Enemy(obj.x, obj.y);
				enemiesGroup.add(enemy);
			}

			case "Trap":
			{
				var spikes = new Spikes(obj.x + 8, obj.y -24 );
				trapsGroup.add(spikes);
			}

			case "Fire":
			{
				var fire = new Fire(obj.x + 0, obj.y-48);
				trapsGroup.add(fire);
			}
						
			case "Door":
			{
				var colorPuerta = obj.properties.get("numColor");
				var door = new Door(obj.x, obj.y - 48, Std.parseInt(colorPuerta));
				doorGroup.add(door);
				door.immovable = true;
			}
			
			case "Diamond":
			{
				var diamond = new Diamond(obj.x + 8, obj.y -24);
				diamondGroup.add(diamond);
				Reg.diamondsTotal++;
			}
			
			case "Key":
			{
				var colorLlave = obj.properties.get("numColor");
				var llave = new Key(obj.x + 12 , obj.y - 20, Std.parseInt(colorLlave));
							
				keyGroup.add(llave);
			}
			
			case "Player":
			{
				hero.x = obj.x;
				hero.y = obj.y - 32;
			}

			default:
			{
				trace("ERROR: tipo desconocido" + obj.type);
			}
		}
	
			
	}
	
	function onHeroCollision(object: FlxObject, hero:Hero)
	{
		// manejo todas las colisiones del Heroe con una unica funcion
		
		switch (Type.getClass(object))
		{
			case FlxTilemap:
			{
				FlxObject.separate(object, hero);
			}
			
			case Enemy:
			{
				FlxG.resetState(); // se reinicia el nivel
			}
			
			case Spikes:
			{
				var estaca: Spikes = cast(object, Spikes);
				if (estaca.getSpikesState())
				{
					FlxG.resetState(); // se reinicia el nivel
				}
				else
				{
					// se puede cruzar a salvo
				}
			}

			case Fire:
			{
				var fuego: Fire = cast(object, Fire);

				if (fuego.getFireState())
				{
					FlxG.resetState(); // se reinicia el nivel
				}
				else
				{
					// se puede cruzar a salvo
				}
			}
			
			case Diamond:
			{
				var diamond: Diamond = cast(object, Diamond);
				hero.pickUpDiamond(); // sumo ++;
				diamond.kill(); // desaparece
				
			}
			
			case Flask:
			{
				var pocion: Flask = cast(object, Flask);
				hero.pickUpFlask(); // permite correr un 10 % mas rapido
				pocion.kill(); // desaparece
			}

			case Exit:
			{
				// condicion de victoria. Si se obtuvieron las 3 llaves, se puede salir del dungeon
				if (hero.isYellowKeyPicked() && hero.isRedKeyPicked() && hero.isBlueKeyPicked())
				{
					FlxG.switchState(new WinState()); 
				}
			}

			case Door:
			{
				
				var door: Door = cast(object, Door);

				// Detecto el color que tiene la puerta. 
				//Si se tiene la llave correcta, se abre la puerta
				if (door.getDoorColor() == "amarillo" && hero.isYellowKeyPicked())
				{
					door.kill();
				}
				else if (door.getDoorColor() == "rojo" && hero.isRedKeyPicked())
				{
					door.kill();
				}
				else if (door.getDoorColor() == "azul" && hero.isBlueKeyPicked())
				{
					door.kill();	
				}
				else
				{
					FlxObject.separate(object, hero);
				}

			}

			case Key:
			{
				var key: Key = cast(object, Key);
				
				// Detecto el color que tiene la llave
				if (key.getKeyColor() == "amarillo")
				{
					hero.pickUpYellowKey();
				}
				else if (key.getKeyColor() == "rojo")
				{
					hero.pickUpRedKey();
				}
				else if (key.getKeyColor() == "azul")
				{
					hero.pickUpBlueKey();	
				}
								
				key.kill(); // desaparece
								
			}

		}
	
	}
	
}
