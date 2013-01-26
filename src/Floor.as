package
{
    import org.flixel.*;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.Shape;

    public class Floor extends FlxSprite
    {
        public function Floor(x:int,y:int):void{
            this.makeGraphic(640,1,0xffCC0000);
            this.x = x;
            this.y = y;
            immovable = true;
        }
    }
}