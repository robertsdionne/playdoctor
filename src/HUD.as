
package{
	import org.flixel.*;

	public class HUD extends FlxGroup{

		[Embed(source="../assets/sprites/monitor_readout.png")] private var ImgBackDrop:Class;
		[Embed(source="../assets/sprites/heartImg.png")] private var ImgHeart:Class;
		[Embed(source="../assets/sprites/reflection.png")] private var ImgReflect:Class;
		[Embed(source="../assets/sprites/powerBar.png")] private var ImgPwrBar:Class;

		public var beating:Boolean = false;
		public var backdrop:Boolean = false;
		public var _heart:FlxSprite = new FlxSprite;
		public var _backdrop:FlxSprite = new FlxSprite;
		public var _ekg:Ekg;
		public var _vit:Array;
		public var _vDisplay:FlxText = new FlxText(465,50,200,"220");
		public var _heightDisplay:FlxText = new FlxText(40,FlxG.height - 40,100,"0");
		public var _levelDisplay:FlxText = new FlxText(465,210,150,"1");
		public var _ctrlsDisplay:FlxText = new FlxText(150,FlxG.height - 40,250,"KYBRD CTRLS: LFT RGHT SPCE")
		public var _timeDisplay:FlxText = new FlxText(530,165,100,"0")
		private var _elapsed:FlxText = new FlxText(530,165,100,"ELPSD:")
		private var _p:Player;
		public var _reflection:FlxSprite = new FlxSprite;
		private var _pwrBar:FlxSprite = new FlxSprite;
		private var _timer:Number = 0;

		public function HUD(ekg:Ekg, _player:Player, vit:Array){
			super();

			_backdrop.loadGraphic(ImgBackDrop,true,true,213,474,true);
			_backdrop.x=420;
			_backdrop.y=3;
			_backdrop.flicker(0);
			this.add(_backdrop);

			_pwrBar.loadGraphic(ImgPwrBar,true,true,48,136,true)
			_pwrBar.x = 575;
			_pwrBar.y = 330;
			_pwrBar.addAnimation("4",[0]);
			_pwrBar.addAnimation("3",[1]);
			_pwrBar.addAnimation("2",[2]);
			_pwrBar.addAnimation("1",[3]);
			this.add(_pwrBar);

			_heart.loadGraphic(ImgHeart,true,true,27,21,true);
			_heart.x = 580;
			_heart.y = 15;
			_heart.flicker(0);
			this.add(_heart);

			_vDisplay.color = 0x00ff3c;
			_vDisplay.size = 72;
			this.add(_vDisplay);

			_heightDisplay.color = 0xaeff00;
			_heightDisplay.size = 12;
			this.add(_heightDisplay);

			_levelDisplay.color = 0x17eaf3;
			_levelDisplay.size = 72;
			this.add(_levelDisplay);

			_elapsed.color = 0xaeff00;
			_elapsed.size = 12;
			this.add(_elapsed);

			_timeDisplay.color = 0xaeff00;
			_timeDisplay.size = 12;
			_timeDisplay.alignment = "right";
			this.add(_timeDisplay);

			_ctrlsDisplay.color = 0xaeff00;
			_ctrlsDisplay.size = 12;
			this.add(_ctrlsDisplay);

			_reflection.loadGraphic(ImgReflect,true,true,640,480,true)
			_reflection.alpha = .35;
			this.add(_reflection);

			_ekg = ekg;
			_p = _player;
			_vit = vit;
		}

		override public function update():void{
			super.update();
			_vDisplay.text = uint(_vit[_p.level-1]).toString();
			_heightDisplay.text = (int((_p.y * 4.234)*10000)/10000).toString();
			_timer += FlxG.elapsed;
			_timeDisplay.text = int(_timer).toString();
			_levelDisplay.text = _p.level.toString();

			if (_p.upPressLimit > 0){
				_pwrBar.visible = true;
				_pwrBar.play(_p.upPressLimit.toString());
			}
			else{
				_pwrBar.visible = false;
			}
		}
	}
}
