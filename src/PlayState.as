package
{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.Shape;

    public class PlayState extends FlxState {

        public static var _player:Player;
        public static var _line:Lines;
        public static var _linePoints:FlxPoint;
        public static var _linePoints2:FlxPoint;
        public static var t:FlxText;

        override public function create():void{

            _player = new Player(200,200);
            this.add(_player);

            _linePoints = new FlxPoint(10,100);
            _linePoints2 = new FlxPoint (75,200);

            _line = new Lines(_linePoints, _linePoints2);
            this.add(_line);

            var sprite : FlxSprite = new Ekg(0, FlxG.height / 2.0);
            this.add(sprite);
        }

        override public function update():void{
            super.update();
            borderCollide(_player);

            FlxG.collide(_line, _player, collisionCallback);
        }

        public function collisionCallback(line:Shape, player:Player):void{
            t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"click to play");
            t.alignment = "center";
            add(t);
        }

        public function borderCollide(wallSprite:FlxSprite):void{
            if(wallSprite.x >= FlxG.width - wallSprite.width)
                wallSprite.x = FlxG.width - wallSprite.width;
            if(wallSprite.x <= 0)
                wallSprite.x = 0;
            if(wallSprite.y >= FlxG.height - wallSprite.height)
                wallSprite.y = FlxG.height - wallSprite.height;
            if(wallSprite.y <= 0)
                wallSprite.y = 0;
        }
    }
}
