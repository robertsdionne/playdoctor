package
{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.display.Shape;

    public class PlayState extends FlxState {

        public static var _player: Player;
        public static var _hud: HUD;
        public static var t: FlxText;
        public var ekgs: Array;
        public var _gap: GapBox;
        public var suddenGapX: int;
        public var suddenGapY: int;
        public var gapTime: int;

        override public function create(): void {
            _player = new Player(200,200);
            this.add(_player);

            ekgs = [];
            for (var i: int = 0; i < 2; ++i) {
                var item: Ekg = new Ekg(0, 2.0 * FlxG.height / 3.0 - 200.0 * i,
                    70.0 + 150.0 * i, makeColor(Math.random(), Math.random(), Math.random()), 3.0 - 2.0 * i, 50.0, 100, 420, 100.0, 8.0 + 8.0 * i);
                ekgs.push(item);

                this.add(item);
            }

            _hud = new HUD(ekgs[0], _player);
            this.add(_hud);

            _gap = new GapBox(suddenGapX,suddenGapY);
            this.add(_gap);
        }

        private function makeColor(red: Number, green: Number, blue: Number): uint {
            var r : uint = uint(red * 255);
            var g : uint = uint(green * 255);
            var b : uint = uint(blue * 255);
            return ((r << 16) | (g << 8) | b);
        }

        override public function update(): void{
            super.update();
            borderCollide(_player);
            ekgCollide();

            if (ekgs[_player.level - 1]) {
                suddenGapX = (ekgs[_player.level - 1].ekgGap()) - _gap.width*0.5;
                suddenGapY = (ekgs[_player.level - 1].getYCoordinateAt(suddenGapX)) - _gap.width*0.5;
                _gap.x = suddenGapX;
                _gap.y = suddenGapY;
            }

            FlxG.overlap(_player, _gap, gapOverlap);

            if (FlxG.keys.justPressed("Q") && _player.level < 100) {
                _player.level += 1;
            }
            if (FlxG.keys.justPressed("Z") && _player.level > 0) {
                _player.level -= 1;
            }
        }

        public function ekgCollide(): void {
            if (ekgs[_player.level - 1]) {
                var suddenPush: int = ekgs[_player.level - 1].getYCoordinateAt(_player.x + _player.width / 2.0);
                if (_player.y + _player.height > suddenPush) {
                    _player.y = suddenPush - _player.height;
                    _player.velocity.y = 0.0;
                    _player.jumping = false;
                    _player.upPressLimit = 3;
                } else {
                    _player.jumping = true;
                }

                var suddenPushGap : int = ekgs[_player.level - 1].getYCoordinateAt(_gap.x + _gap.width);
                if(_gap.y + _gap.height > suddenPushGap){
                    _gap.y = suddenPushGap - 0.5;
                    _gap.velocity.y =+ 430;
                    _gap.x++;
                }
            }
        }

        public function floorCollide(player: FlxObject, floor: Floor): void {
            _player.upPressLimit = 4;
        }

        public function gapOverlap(player: FlxObject, gap:GapBox): void {
            _player.velocity.y =+ 430;
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

