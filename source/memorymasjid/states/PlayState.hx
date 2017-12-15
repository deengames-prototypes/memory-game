package memorymasjid.states;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
using haxesharp.collections.Linq;
import helix.core.HelixSprite;
import helix.core.HelixState;
import helix.core.HelixText;
import helix.data.Config;

class PlayState extends HelixState
{
	private static inline var FONT_SIZE:Int = 32;
	private var random:FlxRandom = new FlxRandom();
	private var currentPattern:String = "";
	private var previousPatterns = new Array<String>();
	private var numCorrect:Int = 0;
	private var numIncorrect:Int = 0;
	private var patternSprites = new Array<HelixSprite>();

	override public function create():Void
	{
		super.create();
		this.createRandomPattern();

		new HelixText(316, 16, "Seen this before?", FONT_SIZE);
		
		var  yesButton = new HelixText(316, 75, "Yes", FONT_SIZE);
		yesButton.onClick(function()
		{
			var isCorrect:Bool = this.previousPatterns.contains(currentPattern);
			this.checkAndCyclePattern(isCorrect);
		});

		var  noButton = new HelixText(450, 75, "No", FONT_SIZE);
		noButton.onClick(function()
		{
			var isCorrect:Bool = !this.previousPatterns.contains(currentPattern);
			this.checkAndCyclePattern(isCorrect);
		});
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	private function createRandomPattern():Void
	{
		var gem:String = random.getObject(["red", "blue", "green", "purple"]);
		var sprite:HelixSprite = new HelixSprite('assets/images/gem-${gem}.png');
		sprite.x = 350;
		sprite.y = 200;
		
		var number = random.int(1, 9);
		this.currentPattern = '${gem}-${number}';
		this.createPattern(sprite, number);
	}

	private function checkAndCyclePattern(isCorrect:Bool):Void
	{
		if (isCorrect)
		{
			numCorrect++;
			trace('RIGHT! (${numCorrect})');
		}
		else
		{
			numIncorrect++;
			trace('WRONG! (${numIncorrect})');
		}

		for (sprite in this.patternSprites)
		{
			sprite.destroy();
			remove(sprite);
		}

		this.createRandomPattern();
	}

	private function createPattern(originalSprite:HelixSprite, numSprites:Int):Void
	{
		while (this.patternSprites.length > 0)
		{
			this.patternSprites.pop();
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
