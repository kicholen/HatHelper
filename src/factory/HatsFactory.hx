package factory;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * ...
 * @author zelek
 */
class HatsFactory
{
	var _hatsMap:Map<String, BitmapData>;
	var _hatsArray:Array<BitmapData>;
	
	public function new() {
		createHats();
	}
	
	inline public function getHats():Map<String, BitmapData> {
		return _hatsMap;
	}
	
	inline public function getHat(name:String):BitmapData {
		return _hatsMap[name];
	}
	
	function createHats() {
		_hatsMap = new Map<String, BitmapData>();
		_hatsArray = new Array();
		
		addHat("chef_hat");
		addHat("detective_hat");
		addHat("easter_ears");
		addHat("farmer_hat");
		addHat("fedora_hat");
		addHat("garden_hat");
		addHat("gentelman_hat");
		addHat("girl_hat");
		addHat("medieval_hat");
		addHat("okulary");
		addHat("oriental_hat");
		addHat("painter_hat");
		addHat("party_hat");
		addHat("pirate_hat");
		addHat("sailor_hat");
		addHat("santa_hat");
		addHat("top_hat");
		addHat("wizard_hat");
	}
	
	function addHat(name:String) {
		var bitmapData:BitmapData = Assets.getBitmapData(getAssetPath(name));
		_hatsMap.set(name, bitmapData);
		_hatsArray.push(bitmapData);
	}
	
	inline function getAssetPath(name:String):String {
		return "img/hats/" + name + ".png";
	}
}