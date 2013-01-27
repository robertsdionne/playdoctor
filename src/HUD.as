﻿package{
	import org.flixel.*;
	
	public class HUD extends FlxGroup {
		
		[Embed(source="../assets/sprites/monitor_readout.png")] private var ImgBackDrop: Class;
		[Embed(source="../assets/sprites/heartImg.png")] private var ImgHeart: Class;
		
		public var beating: Boolean = false;
		public var backdrop: Boolean = false;
		public var _heart: FlxSprite = new FlxSprite;
		public var _backdrop: FlxSprite = new FlxSprite;
		public var _ekg: Ekg;
		public var vitality: Number = 99;
		public var _vDisplay: FlxText = new FlxText(485, 50, 150, vitality.toString());
		
		
		public function HUD(ekg: Ekg){
			super();
			
			_backdrop.loadGraphic(ImgBackDrop, true, true, 213, 474, true);
			_backdrop.x=420;
			_backdrop.y=3;
			this.add(_backdrop);
			
			_heart.loadGraphic(ImgHeart, true, true, 27, 21, true);
			_heart.x = 580;
			_heart.y = 15;
			this.add(_heart);

			_vDisplay.color = 0x00ff3c;
			_vDisplay.size = 72;
			this.add(_vDisplay);
			
			
			
			_ekg = ekg;
		}
		
		override public function update(): void{
			super.update();
			_vDisplay.text = vitality.toString();
		}
	}
}