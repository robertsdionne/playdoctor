package{
    import org.flixel.*;

    public class GameOver extends FlxState {
        [Embed(source="../assets/GameOver.png")] public var gameOver:Class;
        [Embed(source="../assets/HUD.png")] public var endHUD:Class;

        override public function create(): void{

            var game_over:FlxSprite;
            var over_hud:FlxSprite;
            var _names:FlxText;
            var _playagain:FlxText;

            game_over = new FlxSprite();
            over_hud = new FlxSprite();

            _names = new FlxText(30,370,300,"CRTD BY : nina freeman, diego garcia, rob dionne, franziska zeiner");
            _names.color = 0x00ff3c;
            _names.size = 13;

            _playagain = new FlxText(30,415,300,"click to play again");
            _playagain.color = 0x00ff3c;
            _playagain.size = 9;

            over_hud.loadGraphic(endHUD,false,false,630,480);
            game_over.loadGraphic(gameOver,false,false,420,400);

            add(over_hud);
            add(game_over);
            add(_names);
            add(_playagain);

            FlxG.mouse.show();

        }

            override public function update(): void{
                super.update();

                if(FlxG.mouse.justPressed()) {
                    FlxG.mouse.hide();
                    FlxG.switchState(new PlayState());
            }
        }
    }
}