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

class GridState extends HelixState
{
    override public function create():Void
    {
        trace("Hello, grid!!");
    }
}