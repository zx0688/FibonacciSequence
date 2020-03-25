package;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;

/**
 * ...
 * @author kutepov
 */
class Main extends Sprite 
{
	private static inline var SIZE:Int = 20;
	private static inline var SEQUENCE_LENGTH:Int = 5;
	
	private var map:Array<Array<Cell>>;

	public function new() 
	{
		super();
		
		map = [];
		
		for (i in 0...SIZE)
		{
			map.push([]);
			for (j in 0...SIZE)
			{
				var c:Cell = new Cell(i, j);
				
				c.x = i * (Cell.WIDTH + 1);
				c.y = j * (Cell.HEIGHT + 1);
				
				map[i].push(c);
		
				c.addEventListener(MouseEvent.CLICK, onClick);
				
				this.addChild(c);
			}
		}
		
	}
	
	function onClick(e:MouseEvent):Void 
	{
		var target:Cell = e.currentTarget;
		var sequence:Array<Cell> = [];
		
		//increase value
		target.increase();
		for (i in 0...SIZE)
		{
			if (i != target.j)
			{
				map[target.i][i].increase();
			}
			
			if (i != target.i)
			{
				map[i][target.j].increase();
			}	
		}
		
		//search Fibonacci sequence
		var line:Array<Cell> = [];
		for (i in 0...SIZE)
		{
			//vertical
			sequence = sequence.concat(searchSequence(map[i]));
			
			line = map[i].copy();
			line.reverse();
			sequence = sequence.concat(searchSequence(line));
	
			line = [];
			for (j in 0...SIZE)
			{
				
				line.push(map[j][i]);
			}

			//horizontal
			sequence = sequence.concat(searchSequence(line));
			line.reverse();
			sequence = sequence.concat(searchSequence(line));
			
		}
		
		for (cell in sequence)
		{
			cell.clear();
		}
		
	}
	
	function searchSequence(line:Array<Cell>):Array<Cell>
	{
		var result:Array<Cell> = [];
	
		for (index in 0...line.length)
		{
			if (isItFibonacciNumber(line, index) && belongsToFibonacciSequence(line, index, SEQUENCE_LENGTH - 2))
			{
				for (d in 0...SEQUENCE_LENGTH)
				{
					if (index - d >= 0)
					{
						result.push(line[index - d]);
					}
				}
			}
		}
		
		return result;
	}
	
	function belongsToFibonacciSequence(array:Array<Cell>, index:Int, depth:Int):Bool
	{
		if (depth == 0)
		{
			return true; 
		}
			
		if (index > 1 && array[index].number > 0 && array[index].number == array[index - 1].number + array[index - 2].number)
		{
			return belongsToFibonacciSequence(array, index - 1, depth - 1);
		}
			
		return false;
	}
	
	function isItFibonacciNumber(array:Array<Cell>, index:Int):Bool
	{
		return Math.sqrt(5 * Math.pow(array[index].number, 2) - 4) % 1 == 0 || Math.sqrt(5 * Math.pow(array[index].number, 2) + 4) % 1 == 0;
	}
	

}
