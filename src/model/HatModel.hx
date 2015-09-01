package model;

/**
 * ...
 * @author zelek
 */
class HatModel
{
	var _name(get, null):String;
	var _xPosition:Int;
	var _yPosition:Int;
	var _scale:Int;
	
	public function new(name:String) 
	{
		_name = name;
	}
	
	public function set(xPosition:Int, yPosition:Int, scale:Int) {
		_xPosition = xPosition;
		_scale = scale;
		_yPosition = yPosition;
	}
	
	public function get__name():String {
		return _name;
	}
	
	public function toString():String {
		return "<" + _name + " scale=\"" + Std.string(_scale) + "\" x=\"" + Std.string(_xPosition) + "\" y=\"" + Std.string(_yPosition) + "\"/>\n";
	}
	
}