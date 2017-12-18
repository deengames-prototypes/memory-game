package memorymasjid.view;

import helix.core.HelixSprite;
import flixel.math.FlxRandom;

class Pattern
{
    private static var VALID_COLOURS:Array<String> = ["red", "blue", "green", "purple"];

	public var currentPattern(default, null):String = "";

	private var patternSprites:Array<HelixSprite> =  new Array<HelixSprite>();
	private var random:FlxRandom = new FlxRandom();

    public function new() { }

	public function generatePattern():Void
    {
		var gem:String = random.getObject(VALID_COLOURS);
		var sprite:HelixSprite = new HelixSprite('assets/images/gem-${gem}.png');
		sprite.x = 350;
		sprite.y = 200;
		
		var number = random.int(1, 9);
		this.currentPattern = '${gem}-${number}';
		return this.createPatternSprites(sprite, number);
	}

    private function createPatternSprites(originalSprite:HelixSprite, numSprites:Int):Void
	{
        var toReturn = new Array<HelixSprite>();

		while (this.patternSprites.length > 0)
		{
			this.patternSprites.pop().destroy();
		}

		// Simple pattern: staggered three rows of three
		if (numSprites < 1 || numSprites > 9)
		{
			throw('numSprites must be between 2 and 9 inclusive (was: ${numSprites})');
		}

		this.patternSprites.push(originalSprite);
		
		for (i in 1 ... numSprites)
		{
			this.patternSprites.push(originalSprite.clone());
		}

		for (i in 1 ... this.patternSprites.length)
		{
			var sprite = this.patternSprites[i];
			sprite.x = originalSprite.x + ((i % 3) * 1.1 * sprite.width);
			sprite.y = originalSprite.y + ((i / 3) * 1.1 * sprite.height);
		}
	}
}