package{
    import org.flixel.*;

    public class Player extends FlxSprite{

        public function Player(x:int, y:int){
            super(x,y);

            this.makeGraphic(20,20,0x4E0B1FFF)

            drag.x = runSpeed*80;
            drag.y = runSpeed*80;
        }

        override public function update():void{
            super.update();

            velocity.x = 500;
            velocity.y = fallSpeed;
            _jumppower = 230;
            acceleration.x = 0;
            acceleration.y = 400;

            if(FlxG.keys.LEFT) {
                acceleration.x -= drag.x;
            } else if(FlxG.keys.RIGHT){
                acceleration.x += drag.x;

            if(FlxG.keys.justPressed("UP")){
                velocity.y = -_jumppower;
            }
        }
    }
    }
}

