package
{
    import org.flixel.*;

    public class GapMask extends FlxSprite{

        [Embed(source = "../assets/sprites/blackGap2.png")] private var ImgGap:Class;

        public function GapMask(){

            this.loadGraphic(ImgGap,false,false,30,200);
        
        }
    }
}