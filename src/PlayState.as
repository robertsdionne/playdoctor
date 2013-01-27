package
{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.display.Shape;

    public class PlayState extends FlxState {

        [Embed(source="../assets/sounds/beep.mp3")] private var beepSound:Class;
        //[Embed(source="../assets/sounds/click.mp3")] private var clickSound:Class;

        public static var _player: Player;
        public static var _hud: HUD;
        public static var t: FlxText;
        public var ekgs: Array;
        public var gaps: Array;
        public var masks: Array;
        public var _colArray:Array;
        public var currentColor:int;
        public var suddenGapX: int;
        public var suddenGapY: int;
        public var gapTime: int;
        public var vit:Array;
        public var _gapDisplayGrp:FlxGroup = new FlxGroup;

        override public function create(): void {
            _player = new Player(200,200);

            _colArray = [];
            _colArray.push(0x00ff3c);
            _colArray.push(0x17eaf3);
            _colArray.push(0xff7800);
            _colArray.push(0xaeff00);
            _colArray.push(0xd235ff);
            currentColor = 0;

            ekgs = [];
            for (var i: int = 0; i < 2; ++i) {
                var item: Ekg = new Ekg(0, 2.0 * FlxG.height / 3.0 - 200.0 * i,
                    70.0 + 150.0 * i, makeColor(), 3.0 - 2.0 * i, 50.0, 100 + 20 * i, 420, 100.0, 8.0 + 8.0 * i);
                ekgs.push(item);

                this.add(item);
            }

            gapForEachEKG();

            vit = [];
            for (var j: int = 0; j < 10; ++j) {
                var vitPoints: Number = 220 - (10*_player.level);
                vit.push(vitPoints);
            }


            this.add(_gapDisplayGrp)
            this.add(_player);

            _hud = new HUD(ekgs[0], _player, vit);
            this.add(_hud);

            FlxG.playMusic(beepSound);
        }

        private function makeColor(): uint {
            return _colArray[currentColor++ % 5];
        }

        override public function update(): void{
            super.update();
            borderCollide(_player);
            ekgCollide();
            hitLevelAbove();

            vit[_player.level-1]-=0.1;

            for (var i: int = 0; i < gaps.length; ++i) {
                var gap: GapBox = gaps[i];
                if (ekgs[gap.level - 1]) {
                    suddenGapX = (ekgs[gap.level - 1].ekgGap()) - gap.width*0.5;
                    suddenGapY = (ekgs[gap.level - 1].getYCoordinateAt(suddenGapX)) - gap.width*0.5;
                    gap.x = suddenGapX;
                    gap.y = suddenGapY;
                }

                masks[i].x = gap.x;
                masks[i].y = (ekgs[gap.level-1].y) - 100;

                FlxG.overlap(_player, gap, gapOverlap);
            }

            if (FlxG.keys.justPressed("Q") && _player.level < 100) {
                _player.level += 1;
            }
            if (FlxG.keys.justPressed("Z") && _player.level > 0) {
                _player.level -= 1;
            }

            if(_player.y >= FlxG.height - _player.height){
                _player.kill();
            }
        }

        public function gapForEachEKG(): void{
            gaps = [];
            masks = [];
            for (var i: int = 0; i < ekgs.length; ++i){
                var gap: GapBox = new GapBox(300 + 30 * i, 200, i + 1);
                gaps.push(gap);
                _gapDisplayGrp.add(gap);

                var mask: GapMask = new GapMask();
                masks.push(mask);
                _gapDisplayGrp.add(mask);
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
            }
        }

        public function floorCollide(player: FlxObject, floor: Floor): void {
            _player.upPressLimit = 4;
        }

        public function gapOverlap(player: FlxObject, gap: GapBox): void {
            if(gap.level == _player.level){
                _player.level -= 1;
            } else {
                _player.level += 1;
            }
        }

        public function hitLevelAbove():void{
            if (ekgs[_player.level]) {
                var suddenPush: int = ekgs[_player.level].getYCoordinateAt(_player.x + _player.width / 2.0);
                if (_player.y < suddenPush) {
                    _player.y = suddenPush;
                    _player.velocity.y = 0.0;
                }
            }
        }

        public function borderCollide(wallSprite: FlxSprite): void{
            if (wallSprite.x >= 420 - wallSprite.width) {
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

