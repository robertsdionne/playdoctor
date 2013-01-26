package {
  import org.flixel.*;
  import flash.display.Shape;

  public class Ekg extends FlxSprite {

    private static var POINT_COUNT : int = 640;

    private var curve : Array;

    public function Ekg(x : int = 0, y : int = 0) {
      super(x, y);
      makeGraphic(1000, 200, 0x000000);
      curve = [];
      for (var i : int = 0; i < POINT_COUNT; ++i) {
        curve[i] = 0.0;
      }
    }

    override public function draw() : void {
      super.draw();
      var t : Number = new Date().getTime() / 1000.0;
      curve = curve.slice(1);
      curve.push(100.0 * Math.cos(t * 6.0) + 15.0 * Math.random());
      var shape : Shape = new Shape();
      shape.graphics.lineStyle(3, 0xffffff);
      var startValue : Number = curve[0];
      shape.graphics.moveTo(x, y + startValue);
      for (var i : int = 1; i < POINT_COUNT; ++i) {
        var value : Number = curve[i];
        shape.graphics.lineTo(x + i, y + value);
      }
      FlxG.camera.buffer.draw(shape);
    }
  }
}
