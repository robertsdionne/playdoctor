package {
  import org.flixel.*;
  import flash.display.Shape;

  public class Ekg extends FlxSprite {

    private static var FREQUENCY : Number = 2.0;
    private static var MILLISECONDS_PER_SECOND : Number = 1000.0;
    private static var NOISE_AMPLITUDE : Number = 15.0;
    private static var WAVE_AMPLITUDE : Number = 100.0;

    private var curve : Array;

    public function Ekg(x : int = 0, y : int = 0) {
      super(x, y);
      makeGraphic(1000, 200, 0x000000);
      curve = [];
      for (var i : int = 0; i < FlxG.width; ++i) {
        curve[i] = 0.0;
      }
    }

    override public function draw() : void {
      super.draw();
      var t : Number = new Date().getTime() / MILLISECONDS_PER_SECOND;
      curve = curve.slice(1);
      curve.push(WAVE_AMPLITUDE * Math.cos(2.0 * Math.PI * FREQUENCY * t) + NOISE_AMPLITUDE * Math.random());
      var shape : Shape = new Shape();
      shape.graphics.lineStyle(3, 0xffffff);
      var startValue : Number = curve[0];
      shape.graphics.moveTo(x, y + startValue);
      for (var i : int = 1; i < FlxG.width; ++i) {
        var value : Number = curve[i];
        shape.graphics.lineTo(x + i, y + value);
      }
      FlxG.camera.buffer.draw(shape);
    }
  }
}
