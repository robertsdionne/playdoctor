package{
    import org.flixel.*;

    public class Player extends FlxSprite{

        public function Player(x:int,y:int){
            super(x,y);

            makeGraphic(20,20,0xffCC0000);

            var runSpeed:uint = 10;
            drag.x = runSpeed*80;
            drag.y = runSpeed*80;

        }

        override public function update():void{
            super.update();

            acceleration.x = 0;
            acceleration.y = 0;

            if(FlxG.keys.LEFT) {
                acceleration.x -= drag.x;
            } else if(FlxG.keys.RIGHT){
                acceleration.x += drag.x;
            } else if(FlxG.keys.UP){
                acceleration.y -= drag.y;
            } else if(FlxG.keys.DOWN){
                acceleration.y += drag.y;
            }
        }
    }
}
