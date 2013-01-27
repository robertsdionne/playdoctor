package
{
    import org.flixel.*;

    public class GapBox extends FlxSprite{

        public static var gravity:int = -430;
        public var level:int = 1;

        public function GapBox(x:int,y:int,level:int){

            makeGraphic(40,20,0xff000000);
            this.x = x;
            this.y = y;
            this.level = level;
            this.visible = false;
        }
    }
}
