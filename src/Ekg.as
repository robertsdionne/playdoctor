package {
  import org.flixel.*;
  import flash.display.Shape;

  public class Ekg extends FlxSprite {

    /**
     * Constants.
     */
    private static var BPM_PER_HERTZ: Number = 60.0;
    private static var MILLISECONDS_PER_SECOND: Number = 1000.0;

    /**
     * Private member variables.
     */
    private var beatsPerMinute: Number;
    private var curve: Array;
    private var curveColor: uint;
    private var curveThickness: Number;
    private var frequency: Number;
    private var lastTime: Number;
    private var mean: Number;
    private var noiseAmplitude: Number;
    private var offsetIndex: int;
    private var period: Number;
    private var samplesPerSecond: Number;
    private var screenWidth: int;
    private var variance: Number;
    private var waveAmplitude: Number;
    private var waveFrequency: Number;

    public function Ekg(
        x: int = 0,
        y: int = 0,
        beatsPerMinute: Number = 70.0,
        curveColor: int = 0x00ff3c,
        curveThickness: Number = 3.0,
        noiseAmplitude: Number = 50.0,
        samplesPerSecond: int = 512,
        screenWidth: int = 640,
        waveAmplitude: Number = 100.0,
        waveFrequency: Number = 8.0) {
      super(x, y);
      makeGraphic(8, 8, 0x000000);
      this.beatsPerMinute = beatsPerMinute;
      this.curveColor = curveColor;
      this.curveThickness = curveThickness;
      this.noiseAmplitude = noiseAmplitude;
      this.samplesPerSecond = samplesPerSecond;
      this.screenWidth = screenWidth;
      this.waveAmplitude = waveAmplitude;
      this.waveFrequency = waveFrequency;
      this.frequency = this.beatsPerMinute / BPM_PER_HERTZ;
      this.period = 1.0 / this.frequency;
      this.mean = this.period / 2.0;
      this.variance = 1.0 / (100.0 * this.frequency * this.frequency);
      this.curve = [];
      for (var i: int = 0; i < screenWidth; ++i) {
        this.curve[i] = 0.0;
      }
      this.offsetIndex = 0;
      this.lastTime = getTime();
    }

    override public function draw(): void {
      super.draw();
      drawCurve(new FlxPoint(x, y), curve, curveThickness, curveColor);
    }

    override public function update(): void {
      super.update();
      var newTime: Number = getTime();
      var dt: Number = newTime - lastTime;
      if (dt > 0.0) {
        var newSamples: int = dt * samplesPerSecond;
        for (var t: Number = lastTime; t < newTime; t += 1.0 / samplesPerSecond) {
          curve[offsetIndex++ % curve.length] = f(t) * g(t);
        }
        lastTime = newTime;
      }
    }

    private function f(t: Number): Number {
      return waveAmplitude * Math.cos(2.0 * Math.PI * waveFrequency * t) + noiseAmplitude * Math.random();
    }

    private function g(t: Number): Number {
      var tMod: Number = t % period;
      return -1.0 * Math.exp(-1.0 / 2.0 * (tMod - mean) * (tMod - mean) / variance);
    }

    private function drawCurve(start: FlxPoint, points: Array, thickness: Number = 1, color: uint = 0): void {
      var curve: Shape = new Shape();
      curve.graphics.lineStyle(thickness, color);
      curve.graphics.moveTo(start.x, start.y + points[0]);
      for (var i: int = 1; i < points.length; ++i) {
        curve.graphics.lineTo(start.x + i, start.y + points[i]);
      }
      FlxG.camera.buffer.draw(curve);
    }

    private function getTime(): Number {
      return new Date().getTime() / MILLISECONDS_PER_SECOND;
    }

    public function getYCoordinateAt(xCoordinate: int): Number {
      if (xCoordinate < 0 || xCoordinate >= screenWidth) {
        return y;
      } else {
        return y + curve[xCoordinate - x];
      }
    }
  }
}
