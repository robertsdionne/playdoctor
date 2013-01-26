package {
  import org.flixel.*;
  import flash.display.Shape;
  import flash.geom.ColorTransform;

  public class Ekg extends FlxSprite {

    private static var BEATS_PER_MINUTE : Number = 70.0;
    private static var BPM_PER_HERTZ : Number = 60.0;
    private static var COLOR : uint = 0x00ff3c;
    private static var COLORGAP : uint = 0x000000;
    private static var CURVE_THICKNESS : Number = 3;
    private static var FREQUENCY : Number = BEATS_PER_MINUTE / BPM_PER_HERTZ;
    private static var PERIOD : Number = 1.0 / FREQUENCY;
    private static var MEAN : Number =  PERIOD / 2.0;
    private static var MILLISECONDS_PER_SECOND : Number = 1000.0;
    private static var NOISE_AMPLITUDE : Number = 50.0;
    private static var SAMPLES_PER_SECOND : int = 512;
    private static var VARIANCE : Number = 1.0 / (100.0 * FREQUENCY * FREQUENCY);
    private static var WAVE_AMPLITUDE : Number = 100.0;
    private static var WAVE_FREQUENCY : Number = 8.0;
    private var whichColor:uint;
    private var curve : Array;
    private var newArray:Array;
    private var lastTime : Number;

    public function Ekg(x : int = 0, y : int = 0) {
      super(x, y);
      makeGraphic(8, 8, 0x000000);
      curve = [];
      for (var i : int = 0; i < FlxG.width; ++i) {
        curve[i] = 0.0;
      }
      lastTime = getTime();
    }

    override public function draw() : void {
      super.draw();
      drawCurve(new FlxPoint(x, y), curve, CURVE_THICKNESS, COLOR);
    }

    override public function update() : void {
      super.update();
      var newTime : Number = getTime();
      var dt : Number = newTime - lastTime;
      if (dt > 0.0) {
        var newSamples : int = dt * SAMPLES_PER_SECOND;
        curve = curve.slice(newSamples);
        for (var t : Number = lastTime; t < newTime; t += 1.0 / SAMPLES_PER_SECOND) {
          curve.push(f(t) * g(t));
        }
        lastTime = newTime;
      }
      drawCurve(curve, CURVE_THICKNESS, COLOR);
      var c:uint = colorPicker();
      var r:Array = getRandomSlice(curve);
      drawCurve(r, CURVE_THICKNESS, c)
      lastTime = newTime;
    }

    public function colorPicker() : uint {
      whichColor = Math.random()*2;
      if(whichColor > 1){
        return 0x00ff3c;
      } else {
        return 0x000000;
      }
    }

    public function getRandomSlice(thisArray:Array):Array {
      var startIndex:int = Math.floor(Math.random()*(thisArray.length-20));
      var endIndex:int = startIndex + 20;
      var splitArray:Array = thisArray.slice(startIndex, endIndex)
      trace(splitArray);
      return splitArray;
    }

    /*override public function update():void{
      var curveSlice:Object = getRandomSlice(curve);
      var c:uint = colorPicker();
      curveSlice.color(c);
    }*/

    private function f(t : Number) : Number {
      return WAVE_AMPLITUDE * Math.cos(2.0 * Math.PI * WAVE_FREQUENCY * t) + NOISE_AMPLITUDE * Math.random();
    }

    private function g(t : Number) : Number {
      var tMod : Number = t % PERIOD;
      return -1.0 * Math.exp(-1.0 / 2.0 * (tMod - MEAN) * (tMod - MEAN) / VARIANCE);
    }

    private function drawCurve(start : FlxPoint, points : Array, thickness : Number = 1, color : uint = 0) : void {
      var curve : Shape = new Shape();
      curve.graphics.lineStyle(thickness, color);
      curve.graphics.moveTo(start.x, start.y + points[0]);
      for (var i : int = 1; i < points.length; ++i) {
        curve.graphics.lineTo(start.x + i, start.y + points[i]);
      }
      FlxG.camera.buffer.draw(curve);
    }

    private function getTime() : Number {
      return new Date().getTime() / MILLISECONDS_PER_SECOND;
    }

    public function getYCoordinateAt(xCoordinate : int) : Number {
      if (xCoordinate < 0 || xCoordinate >= FlxG.width) {
        return y;
      } else {
        return y + curve[xCoordinate];
      }
    }
  }
}
