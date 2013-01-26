package {
  import org.flixel.*;
  import flash.display.Shape;

  public class Ekg extends FlxSprite {

    private static var BEATS_PER_MINUTE : Number = 70.0;
    private static var BPM_PER_HERTZ : Number = 60.0;
    private static var COLOR : uint = 0x00ff3c;
    private static var CURVE_THICKNESS : Number = 3;
    private static var FREQUENCY : Number = BEATS_PER_MINUTE / BPM_PER_HERTZ;
    private static var PERIOD : Number = 1.0 / FREQUENCY;
    private static var MEAN : Number =  PERIOD / 2.0;
    private static var MILLISECONDS_PER_SECOND : Number = 1000.0;
    private static var NEW_SAMPLES : int = 10;
    private static var NOISE_AMPLITUDE : Number = 20.0;
    private static var VARIANCE : Number = 1.0 / (100.0 * FREQUENCY * FREQUENCY);
    private static var WAVE_AMPLITUDE : Number = 100.0;
    private static var WAVE_FREQUENCY : Number = 8.0;

    private var curve : Array;
    private var lastTime : Number;

    public function Ekg(x : int = 0, y : int = 0) {
      super(x, y);
      curve = [];
      for (var i : int = 0; i < FlxG.width; ++i) {
        curve[i] = 0.0;
      }
      lastTime = getTime();
    }

    override public function draw() : void {
      super.draw();
      var newTime : Number = getTime();
      curve = curve.slice(NEW_SAMPLES);
      for (var t : Number = lastTime; t < newTime; t += (newTime - lastTime) / NEW_SAMPLES) {
        curve.push(f(t)*g(t));
      }
      drawCurve(curve, CURVE_THICKNESS, COLOR);
      lastTime = newTime;
    }

    private function f(t : Number) : Number {
      return WAVE_AMPLITUDE * Math.cos(2.0 * Math.PI * WAVE_FREQUENCY * t) + NOISE_AMPLITUDE * Math.random();
    }

    private function g(t : Number) : Number {
      var tMod : Number = t % PERIOD;
      return -1.0 * Math.exp(-1.0 / 2.0 * (tMod - MEAN) * (tMod - MEAN) / VARIANCE);
    }

    private function drawCurve(points : Array, thickness : Number = 1, color : uint = 0) : void {
      var curve : Shape = new Shape();
      curve.graphics.lineStyle(thickness, color);
      curve.graphics.moveTo(x, y + points[0]);
      for (var i : int = 1; i < points.length; ++i) {
        curve.graphics.lineTo(x + i, y + points[i]);
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
