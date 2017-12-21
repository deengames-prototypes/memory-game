package memorymasjid.view;

import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.tweens.FlxTween;
using haxesharp.collections.Linq;
import helix.core.HelixSprite;

/**
 *  A pattern class. Represents a pattern (a colour and number, eg. red-6), and
 *  encapsulates the sprites that make up that pattern. Call generatePattern to
 *  generate a new pattern (destroys the old pattern's sprites -- stateful).
 */
class Pattern
{
	public var currentPattern(default, null):String = "";

	// 3 + (level/4) => 3, 3, 3, 3, 4, 4, 4, 4, ...
    private var validColours:Array<String> = ["red", "blue", "green", "purple"];
	private var currentPatternSprites:Array<HelixSprite> =  new Array<HelixSprite>();
	private var random:FlxRandom = new FlxRandom();

	// 3 + (level/2) => 3, 3, 4, 4, 5, 5, ...
	private var maxPatternNumber:Int = 9;

    public function new(levelNumber:Int)
	{
		random.shuffle(this.validColours);
		this.maxPatternNumber = 3 + Std.int((levelNumber / 2));

		var numColours = Std.int(Math.min(validColours.length, levelNumber + 2));
		if (numColours != validColours.length)
		{
			validColours = validColours.take(numColours);
		}
	}

	public function generatePattern():Void
    {
		var gem:String = random.getObject(validColours);
		var sprite:HelixSprite = new HelixSprite('assets/images/gem-${gem}.png');
		sprite.x = 350;
		sprite.y = 200;
		
		var number = random.int(1, maxPatternNumber);
		this.currentPattern = '${gem}-${number}';
		return this.createPatternSprites(sprite, number);
	}


	public function destroyCurrentPatternSprites():Void
	{
		while (this.currentPatternSprites.any())
		{
			var sprite = this.currentPatternSprites.pop();
			var tween = FlxTween.tween(sprite, { alpha: 0, x: FlxG.width }, 0.5);
			tween.onComplete = (t) =>
			{
				sprite.destroy();
			}
		}
	}
	
	/**
	 *  Creates sprites in a simple pattern: staggered three rows of three.
	 *  Destroys existing sprites (if present) first.
	 */
    private function createPatternSprites(originalSprite:HelixSprite, numSprites:Int):Void
	{
		if (numSprites < 1 || numSprites > 9)
		{
			throw('numSprites must be between 1 and 9 inclusive (was: ${numSprites})');
		}

        var toReturn = new Array<HelixSprite>();

		this.destroyCurrentPatternSprites();
		
		this.currentPatternSprites.push(originalSprite);
		
		for (i in 1 ... numSprites)
		{
			this.currentPatternSprites.push(originalSprite.clone());
		}

		for (i in 1 ... this.currentPatternSprites.length)
		{
			var sprite = this.currentPatternSprites[i];
			sprite.x = originalSprite.x + ((i % 3) * 1.1 * sprite.width);
			sprite.y = originalSprite.y + ((i / 3) * 1.1 * sprite.height);
		}
	}
}