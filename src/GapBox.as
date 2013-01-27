package
{
    import org.flixel.*;

    public class GapBox extends FlxSprite{

        public static var gravity:int = -430;

        public function GapBox(x:int,y:int){
            //velocity.y -= gravity;
            makeGraphic(20,20,0xffCC0000);
            this.x = x;
            this.y = y;
            //immovable = true;
        }
    }
}
