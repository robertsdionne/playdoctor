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
        public static var _floor:Floor;

        override public function create():void{

            _player = new Player(200,200);
            this.add(_player);

            _linePoints = new FlxPoint(10,100);
            _linePoints2 = new FlxPoint (75,200);

            _line = new Lines(_linePoints, _linePoints2);
            this.add(_line);

            _floor = new Floor(50,400);
            this.add(_floor);

        }

        override public function update():void{
            super.update();
            borderCollide(_player);
            FlxG.collide(_player, _floor, collisionCallback);

        }

        public function collisionCallback(player:FlxObject, floor:Floor):void{

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