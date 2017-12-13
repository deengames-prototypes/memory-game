package memorymasjid.states;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import helix.core.HelixSprite;
import helix.core.HelixState;
import helix.core.HelixText;
import helix.data.Config;

class PlayState extends HelixState
{
	override public function create():Void
	{
		super.create();

		var sprite = new HelixSprite("assets/images/gem-red.png");
		sprite.x = 300;
		sprite.y = 100;
		this.createPattern(sprite, 3);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	private function createPattern(originalSprite:HelixSprite, numSprites:Int):Array<HelixSprite>
	{
		// Simple pattern: staggered three rows of three
		if (numSprites < 1 || numSprites > 9)
		{
			throw('numSprites must be between 2 and 9 inclusive (was: ${numSprites})');
		}

		var toReturn = new Array<HelixSprite>();
		toReturn.push(originalSprite);
		
		for (i in 1 ... numSprites)
		{
			toReturn.push(originalSprite.clone());
		}

		for (i in 1 ... toReturn.length)
		{
			var sprite = toReturn[i];
			sprite.x = originalSprite.x + ((i % 3) * 1.1 * sprite.width);
			sprite.y = originalSprite.y + ((i / 3) * 1.1 * sprite.height);
			add(sprite);
		}

		return toReturn;
	}
}
