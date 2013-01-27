package
{
    import org.flixel.*;

    public class GapBox extends FlxSprite {

        private static var COLLIDE_DELAY : Number = 1.0;
        private static var MILLISECONDS_PER_SECOND: Number = 1000.0;

        public static var gravity: int = -430;
        public var level: int = 1;
        private var nextCollideTime: Number;

        public function GapBox(x:int,y:int,level:int){
            makeGraphic(20,20,0xffCC0000);
            this.x = x;
            this.y = y;
            this.level = level;
            this.nextCollideTime = getTime();
        }

        public function mayCollide(): Boolean {
            return nextCollideTime < getTime();
        }

        public function collide(): void {
            nextCollideTime = getTime() + COLLIDE_DELAY;
        }

        private function getTime(): Number {
          return new Date().getTime() / MILLISECONDS_PER_SECOND;
        }
    }
}
