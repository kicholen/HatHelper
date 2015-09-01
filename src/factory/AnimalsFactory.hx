package factory;
import haxe.ds.Vector;
import model.AnimalModel;

/**
 * ...
 * @author zelek
 */
class AnimalsFactory
{
	var _animalsMap:Map<String, AnimalModel>;
	var _animalsArray:Array<AnimalModel>;
	
	public function new() {
		createAnimals();
	}
	
	inline public function getAnimals():Map<String, AnimalModel> {
		return _animalsMap;
	}
	
	inline public function getAnimalsArray():Array<AnimalModel> {
		return _animalsArray;
	}
	
	inline public function getAnimal(name:String):AnimalModel {
		return _animalsMap.get(name);
	}
	
	function createAnimals() {
		_animalsMap = new Map<String, AnimalModel>();
		_animalsArray = new Array();
		addAnimal("bee");
		addAnimal("cat");
		addAnimal("cow");
		addAnimal("crocodile");
		addAnimal("dingo");
		addAnimal("dog");
		addAnimal("dolphin");
		addAnimal("duck");
		addAnimal("elephant");
		addAnimal("fish_1");
		addAnimal("fox");
		addAnimal("girafee");
		addAnimal("gnu");
		addAnimal("goat");
		addAnimal("horse");
		addAnimal("kangaroo");
		addAnimal("kiwi");
		addAnimal("koala");
		addAnimal("leopard");
		addAnimal("lion");
		addAnimal("monkey_2");
		addAnimal("mouse");
		addAnimal("octopus");
		addAnimal("ostrich");
		addAnimal("owl");
		addAnimal("owl_winter");
		addAnimal("panda");
		addAnimal("parrot");
		addAnimal("parrot_2");
		addAnimal("peacock");
		addAnimal("penguin");
		addAnimal("polarbear");
		addAnimal("rhino");
		addAnimal("shark");
		addAnimal("sheep");
		addAnimal("snail");
		addAnimal("snake");
		addAnimal("squirell");
		addAnimal("tealplatypus");
		addAnimal("tiger");
		addAnimal("turtle");
		addAnimal("walrus");
		addAnimal("whale");
		addAnimal("wolf");
		addAnimal("yak");
		addAnimal("young_seal");
		addAnimal("zebra");
	}
	
	function addAnimal(name:String) {
		var model:AnimalModel = new AnimalModel(name);
		_animalsMap.set(name, model);
		_animalsArray.push(model);
	}
}