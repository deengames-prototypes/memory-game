package memorymasjid.states;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
using haxesharp.collections.Linq;
import helix.core.HelixSprite;
import helix.core.HelixState;
import helix.core.HelixText;
import helix.data.Config;
import memorymasjid.view.Pattern;

class PlayState extends HelixState
{
	private static inline var FONT_SIZE:Int = 32;
	private var previousPatterns = new Array<String>();
	private var numCorrect:Int = 0;
	private var numIncorrect:Int = 0;
	private var pattern = new Pattern();

	override public function create():Void
	{
		super.create();
		pattern.generatePattern();

		new HelixText(316, 16, "Seen this before?", FONT_SIZE);
		
		var  yesButton = new HelixText(316, 75, "Yes", FONT_SIZE);
		yesButton.onClick(function()
		{
			var isCorrect:Bool = this.previousPatterns.contains(this.pattern.currentPattern);
			this.checkAndCyclePattern(isCorrect);
		});

		var  noButton = new HelixText(450, 75, "No", FONT_SIZE);
		noButton.onClick(function()
		{
			var isCorrect:Bool = !this.previousPatterns.contains(this.pattern.currentPattern);
			this.checkAndCyclePattern(isCorrect);
		});
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
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
		
		this.pattern.generatePattern();
	}
}
