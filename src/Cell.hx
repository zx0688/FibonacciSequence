package;

import haxe.Timer;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author kutepov
 */
class Cell extends Sprite 
{

	public static inline var WIDTH:Int = 30;
	public static inline var HEIGHT:Int = 30;
	
	private var tfNumber:TextField;
	
	public var i:Int;
	public var j:Int;
	
	public var number(get, null):Int = 0;
	
	private var timer:Timer;
	
	public function new(i:Int, j:Int) 
	{
		super();
		
		this.i = i;
		this.j = j;
		
		this.graphics.beginFill(0xffffff, 1);
		this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
		this.graphics.endFill();
		
		this.tfNumber = new TextField();
		this.tfNumber.defaultTextFormat = new TextFormat(null, 20, 0, true, null, null, null, null, TextFormatAlign.CENTER);
		this.tfNumber.width = WIDTH;
		this.tfNumber.mouseEnabled = false;
		this.tfNumber.text = "";
		
		this.addChild(tfNumber);
	}
	
	public function increase():Void
	{
		this.number++;
		tfNumber.text = Std.string(this.number);
		
		flash(0xffff00);
	}
	
	public function clear():Void
	{
		if (this.number == 0)
			return;
		
		this.number = 0;
		tfNumber.text = "";
		
		flash(0x00ff00);
	}
	
	private function flash(color:UInt):Void
	{
		if (timer != null)
			timer.stop();
			
		this.graphics.beginFill(color, 1);
		this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
		this.graphics.endFill();	
			
		timer = Timer.delay(function():Void
		{
			this.graphics.beginFill(0xffffff, 1);
			this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			this.graphics.endFill();
			
		}, 300);
	}
	
	function get_number():Int 
	{
		return number;
	}

	
}