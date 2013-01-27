package
{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.display.Shape;

    public class PlayState extends FlxState {

        public static var _player: Player;
        public static var _hud: HUD;
        public static var t: FlxText;
        public var ekg: Ekg;
        public var _gap: GapBox;
        public var suddenGapX: int;
        public var suddenGapY: int;
        public var gapTime: int;

        override public function create(): void {
            _player = new Player(200,200);
            this.add(_player);

            ekg = new Ekg(0, FlxG.height / 2.0,
                70.0, 0x00ff3c, 3.0, 50.0, 512, 420, 100.0, 8.0);
            this.add(ekg);

            _hud = new HUD(ekg,_player);
            this.add(_hud);

            _gap = new GapBox(suddenGapX,suddenGapY);
            this.add(_gap);
        }

        override public function update(): void{
            super.update();
            borderCollide(_player);
            ekgCollide();

            suddenGapX = Math.random()*640;
            suddenGapY = ekg.getYCoordinateAt(suddenGapX);
        }

        public function ekgCollide(): void {
            var suddenPush: int = ekg.getYCoordinateAt(_player.x + _player.width / 2.0);
            if (_player.y + _player.height > suddenPush) {
                _player.y = suddenPush - _player.height;
                _player.velocity.y = 0.0;
                _player.jumping = false;
                _player.upPressLimit = 3;
            } else {
                _player.jumping = true;
            }

            var suddenPushGap : int = ekg.getYCoordinateAt(_gap.x + _gap.width);
            if(_gap.y + _gap.height > suddenPushGap){
                _gap.y = suddenPushGap - 0.5;
                _gap.velocity.y =+ 430;
                _gap.x++;
            }
        }

        public function floorCollide(player: FlxObject, floor: Floor): void {
            _player.upPressLimit = 4;
        }

        public function borderCollide(wallSprite: FlxSprite): void{
            if (wallSprite.x >= FlxG.width - wallSprite.width) {
                wallSprite.x = FlxG.width - wallSprite.width;
            }
            if (wallSprite.x <= 0) {
                wallSprite.x = 0;
            }
            if (wallSprite.y >= FlxG.height - wallSprite.height) {
                wallSprite.y = FlxG.height - wallSprite.height;
            }
            if (wallSprite.y <= 0) {
                wallSprite.y = 0;
            }
        }
    }
}
