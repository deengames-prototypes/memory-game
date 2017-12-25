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
    // TODO: refactor into Grid class?
    private var gridTiles = new Array<Array<HelixSprite>>();
    private var gridWidth:Int = 0;
    private var gridHeight:Int = 0;

    override public function create():Void
    {
        this.gridWidth = Config.get("grid").widthInTiles;
        this.gridHeight = Config.get("grid").heightInTiles;
        this.gridTiles = [for (x in 0...this.gridWidth) [for (y in 0...gridHeight) createTile(x, y)]];
    }

    private function createTile(x:Int, y:Int):HelixSprite
    {
        var sprite = new HelixSprite("assets/images/grid-tile.png");
        sprite.x = 200 + x * sprite.width;
        sprite.y = 50 + y * sprite.height;
        return sprite;
    }
}