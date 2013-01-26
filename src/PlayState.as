package
{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.Shape;

    public class PlayState extends FlxState {

        public static var _player:Player;
        public static var t:FlxText;
        public static var _floor:Floor;
        public var sprite:FlxSprite;
        public var ekg:Ekg;

        override public function create():void{

            _player = new Player(200,200);
            this.add(_player);

            ekg = new Ekg(0, FlxG.height / 2.0);
            this.add(ekg);

            _floor = new Floor(50,400);
            this.add(_floor);
        }

        override public function update():void{
            super.update();
            borderCollide(_player);
            ekgCollide();
            FlxG.collide(_player,_floor,floorCollide);

        }

        public function ekgCollide():void{
            var suddenPush:int = ekg.getYCoordinateAt(_player.x + _player.width / 2.0);
            if(_player.y + _player.height > suddenPush){
                _player.y = suddenPush - _player.height - 1.0;
                _player.velocity.y = 0.0;
                _player.upPressLimit = 4;
            }
        }

        public function floorCollide(player:FlxObject, floor:Floor):void{
            _player.upPressLimit = 4;
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
