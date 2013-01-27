package{
    import org.flixel.*;

    public class MenuState extends FlxState {
        [Embed(source="../assets/StartScreen.png")] private var Start:Class;
        [Embed(source="../assets/HUD.png")] private var HUD:Class;

        override public function create(): void{
            var t: FlxSprite;
            var b: FlxSprite;
            var _play: FlxText;

            t = new FlxSprite();
            b = new FlxSprite();

            _play = new FlxText(160,415,300,"click to play");
            _play.color = 0x00ff3c;
            _play.size = 12;

            t.loadGraphic(Start,false,false,420,400);
            b.loadGraphic(HUD,false,false,640,480);

            add(b);
            add(t);
            add(_play);

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
