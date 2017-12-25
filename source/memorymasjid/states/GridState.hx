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
    private var numTargetGems:Int = 0;

    public function new(numTargetGems:Int)
    {
        super();
        this.numTargetGems = numTargetGems;
        trace('show ${this.numTargetGems} gems');
    }

    override public function create():Void
    {
        this.gridWidth = Config.get("grid").widthInTiles;
        this.gridHeight = Config.get("grid").heightInTiles;
        this.gridTiles =
            [for (x in 0...this.gridWidth)
                [for (y in 0...gridHeight)
                    createTile(x, y)]];

        var availableTileIndicies:Array<Int> = [for (i in 0...this.gridWidth * this.gridHeight) i].shuffle();
        var gemIndicies = availableTileIndicies.take(this.numTargetGems);
        
        while (gemIndicies.any())
        {
            var nextIndex:Int = gemIndicies.pop();
            var x:Int = nextIndex % this.gridWidth;
            var y:Int = Std.int(nextIndex / this.gridHeight);

            trace('Gem at ${x}, ${y}');
        }
    }

    private function createTile(x:Int, y:Int):HelixSprite
    {
        var sprite = new HelixSprite("assets/images/grid-tile.png");
        sprite.x = 200 + x * sprite.width;
        sprite.y = 50 + y * sprite.height;
        return sprite;
    }
}