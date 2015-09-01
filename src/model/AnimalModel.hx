package model;
import haxe.ds.Vector;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * ...
 * @author zelek
 */
class AnimalModel
{
	var _hatModels(get, null):Map<String, HatModel>;
	var _name:String;
	var _bitmapData:BitmapData;
	
	public function new(name:String) {
		_name = name;
		_hatModels = new Map<String, HatModel>();
	}
	
	public function addHat(model:model.HatModel) {
		_hatModels.set(model.get__name(), model);
	}
	
	public function getBitmapData():BitmapData {
		if (_bitmapData == null) {
			_bitmapData = Assets.getBitmapData(getAssetPath());
		}
		return _bitmapData;
	}
	
	public function getName():String {
		return _name;
	}
	
	public function getHat(name:String) {
		if (!_hatModels.exists(name)) {
			addHat(new HatModel(name));
			
		}
		
		return _hatModels.get(name);
	}
	
	public function toString():String {
		return "";
	}
	
	inline function getAssetPath():String {
		return "img/animals/" + _name + ".png";
	}
	
	public function get__hatModels():Map<String, HatModel> {
		return _hatModels;
	}
}