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

// TODO: turn this into a substate!
class NBackState extends HelixState
{
	private static var FONT_SIZE:Int;

	private var previousPatterns = new Array<String>();
	private var numCorrect:Int = 0;
	private var numIncorrect:Int = 0;
	private var pattern:Pattern;
	private var currentLevelNumber:Int = 1;

	override public function create():Void
	{
		super.create();

		FONT_SIZE = Config.get("fontSize");

		pattern = new Pattern(currentLevelNumber);
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

	private function checkAndCyclePattern(isCorrect:Bool):Void
	{
		if (isCorrect)
		{
			numCorrect++;
			trace("RIGHT: " + numCorrect);
		}
		else
		{
			numIncorrect++;
			trace("WRONG: " + numIncorrect);
			// Change on wrong, but only if we answered at least three times
			if (numCorrect + numIncorrect >= Config.get("nback").minimumItemsToShow)
			{
				this.pattern.destroyCurrentPatternSprites();
				// 3 or the number right, whichever is larger.
				var numToShow = Std.int(Math.max(Config.get("nback").minimumItemsToShow, numCorrect));
				FlxG.switchState(new GridState(numToShow));
			}
		}

		if (numCorrect >= Config.get("nback").maximumItemsToShow)
		{
			trace("Perfect!");
			this.pattern.destroyCurrentPatternSprites();
			FlxG.switchState(new GridState(Config.get("nback").maximumItemsToShow));
		}

		// This doesn't make sense. But they appear on the new state even though
		// the switch (a few lines up) executes.
		if (HelixState.current == this)
		{
			this.previousPatterns.push(this.pattern.currentPattern);
			this.pattern.generatePattern();
		}
	}
}

enum GameState
{
	NBack;
	Grid;
}
