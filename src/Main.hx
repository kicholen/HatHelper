package;

import factory.AnimalsFactory;
import factory.HatsFactory;
import model.AnimalModel;
import model.HatModel;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
#if cpp
import sys.io.File;
import sys.io.FileOutput;
#else
import js.html.File;
#end

/**
 * ...
 * @author zelek
 */
class Main extends Sprite 
{
	var _animalsFactory:AnimalsFactory;
	var _hatsFactory:HatsFactory;
	var _lastY:Float;
	var _currentBitmap:Bitmap;
	var _hatsArray:Array<Sprite>;
	var _currentHatSprite:Sprite;
	
	var _saveButton:SimpleButton;
	var _scaleUpButton:SimpleButton;
	var _scaleDownButton:SimpleButton;
	var _saveToFileButton:SimpleButton;
	var _scaleUpButtonBig:SimpleButton;
	var _scaleDownButtonBig:SimpleButton;
	
	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	function onAddedToStage(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		init();
	}
	
	function init():Void {
		_animalsFactory = new AnimalsFactory();
		_hatsFactory = new HatsFactory();
		createBackground();
		displayAnimals();
		createButtons();
	}
	
	function createBackground() {
		var bg:Bitmap = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x0000FF));
		addChild(bg);
	}
	
	function createButtons():Void {
		_saveButton = createButton("save");
		_saveButton.addEventListener(TouchEvent.TOUCH_TAP, onSave);
		_saveButton.addEventListener(MouseEvent.CLICK, onSave);
		_saveButton.y = _lastY + 10;
		addChild(_saveButton);
		
		_scaleUpButton = createButton("scale + 5");
		_scaleUpButton.addEventListener(TouchEvent.TOUCH_TAP, onScalePlusHat);
		_scaleUpButton.addEventListener(MouseEvent.CLICK, onScalePlusHat);
		_scaleUpButton.y = _saveButton.y + _saveButton.height + 10;
		addChild(_scaleUpButton);
		
		_scaleUpButtonBig = createButton("scale + 20");
		_scaleUpButtonBig.addEventListener(TouchEvent.TOUCH_TAP, onScalePlusBigHat);
		_scaleUpButtonBig.addEventListener(MouseEvent.CLICK, onScalePlusBigHat);
		_scaleUpButtonBig.y = _scaleUpButton.y;
		_scaleUpButtonBig.x = _scaleUpButton.x + _scaleUpButton.width + 10;
		addChild(_scaleUpButtonBig);
		
		_scaleDownButton = createButton("scale - 5");
		_scaleDownButton.addEventListener(TouchEvent.TOUCH_TAP, onScaleMinusHat);
		_scaleDownButton.addEventListener(MouseEvent.CLICK, onScaleMinusHat);
		_scaleDownButton.y = _scaleUpButton.y + _scaleUpButton.height + 10;
		addChild(_scaleDownButton);
		
		_scaleDownButtonBig = createButton("scale - 20");
		_scaleDownButtonBig.addEventListener(TouchEvent.TOUCH_TAP, onScaleMinusBigHat);
		_scaleDownButtonBig.addEventListener(MouseEvent.CLICK, onScaleMinusBigHat);
		_scaleDownButtonBig.y = _scaleDownButton.y;
		_scaleDownButtonBig.x = _scaleDownButton.x + _scaleDownButton.width + 10;
		addChild(_scaleDownButtonBig);
		
		#if cpp
		_saveToFileButton = createButton("save to file");
		_saveToFileButton.addEventListener(TouchEvent.TOUCH_TAP, onSaveToFile);
		_saveToFileButton.addEventListener(MouseEvent.CLICK, onSaveToFile);
		_saveToFileButton.y = _scaleDownButton.y + _scaleDownButton.height + 10;
		addChild(_saveToFileButton);
		#end
		setButtonsVisibility(false);
	}
	
	function displayAnimals():Void {
		var offset:Float = 10.0;
		var currentY:Float = 0.0;
		var currentX:Float = 0.0;
		var bitmapWidth:Float = 0.0;
		var bitmapHeight:Float = 0.0;
		var size:Int = 50;
		var animals:Array<AnimalModel> = _animalsFactory.getAnimalsArray();
		
		for (i in 0...animals.length) {
			var sprite:Sprite = new Sprite();
			sprite.addChild(new Bitmap(animals[i].getBitmapData()));
			sprite.name = animals[i].getName();
			sprite.x = currentX;
			sprite.y = currentY;
			scaleToSize(sprite, size);
			addChild(sprite);
			sprite.addEventListener(TouchEvent.TOUCH_TAP, onSpriteTapped);
			sprite.addEventListener(MouseEvent.CLICK, onSpriteTapped);
			if (currentX + sprite.width * 2 + offset > stage.stageWidth) {
				currentY += size + offset;
				currentX = 0.0;
			}
			else {
				currentX += sprite.width + offset;
			}
		}
		_lastY = currentY + size + offset;
	}
	
	function onSpriteTapped(e:MouseEvent):Void {
		var sprite:Sprite = e.target;
		if (_currentBitmap == null) {
			_currentBitmap = new Bitmap();
			_currentBitmap.y = _lastY;
			addChild(_currentBitmap);
		}
		_currentBitmap.bitmapData = _animalsFactory.getAnimal(sprite.name).getBitmapData();
		_currentBitmap.x = (stage.stageWidth - _currentBitmap.width) / 2.0;
		_currentBitmap.name = sprite.name;
		
		resetHats();
	}
	
	function resetHats() {
		if (_hatsArray == null) {
			_hatsArray = new Array();
			var hats:Map<String, BitmapData> = _hatsFactory.getHats();
			
			for (key in hats.keys()) {
				_hatsArray.push(createHatSprite(key, hats.get(key)));
			}
		}
		var xPosition:Float = stage.stageWidth - 50;
		var yPosition:Float = _lastY;
		
		for (i in 0..._hatsArray.length) {
			_hatsArray[i].scaleX = _hatsArray[i].scaleY = 1.0;
			_hatsArray[i].x = xPosition;
			_hatsArray[i].y = yPosition;
			yPosition += _hatsArray[i].height + 10;
			if (yPosition + _hatsArray[i].height * 2 + 10 > stage.stageHeight) {
				yPosition = _lastY;
				xPosition -= 50;
			}
		}
		setButtonsVisibility(false);
	}
	
	function createHatSprite(name:String, bitmapData:BitmapData):Sprite {
		var sprite:Sprite = new Sprite();
		sprite.addChild(new Bitmap(bitmapData));
		sprite.name = name;
		sprite.addEventListener(MouseEvent.MOUSE_DOWN, onHatDown);
		addChild(sprite);
		
		return sprite;
	}
	
	function onHatDown(e:MouseEvent):Void {
		if (_currentHatSprite != e.target) {
			resetHats();
		}
		
		setButtonsVisibility(true);
		_currentHatSprite = e.target;
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMove);
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageUp);
	}
	
	function onStageMove(e:MouseEvent):Void {
		_currentHatSprite.x = e.stageX - _currentHatSprite.width / 2.0;
		_currentHatSprite.y = e.stageY - _currentHatSprite.height / 2.0;
	}

	function onStageUp(e:MouseEvent):Void {
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMove);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageUp);
	}
	
	function onScalePlusHat(e:MouseEvent) {
		if (_currentHatSprite != null) {
			_currentHatSprite.scaleX = _currentHatSprite.scaleY = _currentHatSprite.scaleX + 0.05;
		}
	}
	
	function onScalePlusBigHat(e:MouseEvent) {
		if (_currentHatSprite != null) {
			_currentHatSprite.scaleX = _currentHatSprite.scaleY = _currentHatSprite.scaleX + 0.20;
		}
	}
	
	function onScaleMinusHat(e:MouseEvent) {
		if (_currentHatSprite != null) {
			_currentHatSprite.scaleX = _currentHatSprite.scaleY = _currentHatSprite.scaleX - 0.05;
		}
	}
	
	function onScaleMinusBigHat(e:MouseEvent) {
		if (_currentHatSprite != null) {
			_currentHatSprite.scaleX = _currentHatSprite.scaleY = _currentHatSprite.scaleX - 0.20;
		}
	}
	
	function onSave(e:MouseEvent) {
		var hatModel:HatModel = _animalsFactory.getAnimal(_currentBitmap.name).getHat(_currentHatSprite.name);
		var xPosition:Float = (_currentHatSprite.x + _currentHatSprite.width - _currentBitmap.x) / _currentBitmap.width * 100.0;
		var yPosition:Float = (_currentHatSprite.y + _currentHatSprite.height - _currentBitmap.y) / _currentBitmap.height * 100.0;
		var scale:Float = (_currentHatSprite.scaleX - 1.0) * 100.0;
		
		hatModel.set(Std.int(xPosition), Std.int(yPosition), Std.int(scale));
	}
	
	
	function onSaveToFile(e:MouseEvent) {
		var output:String = "out_";
		var suffix:String = ".xml";
		
		#if cpp
		var file:FileOutput = File.write(output + "positions" + suffix);
		var animals:Array<AnimalModel> = _animalsFactory.getAnimalsArray();
		for (i in 0...animals.length) {
			file.writeString("<" + animals[i].getName() + ">\n");
			var hatModels:Map<String, HatModel> = animals[i].get__hatModels();
			for (hatModel in hatModels.iterator()) {
				file.writeString(hatModel.toString());
			}
			file.writeString("</" + animals[i].getName() + ">\n");
		}
		file.close();
		#end
	}
	
	function createButton(name:String):SimpleButton {
		var container:DisplayObjectContainer = new DisplayObjectContainer();
		container.addChild(new Bitmap(Assets.getBitmapData("img/button_blue.png")));
		var format:TextFormat = new TextFormat(Assets.getFont("img/Raleway-Bold.ttf").fontName, 60);
		var textfield:TextField = new TextField();
		textfield.defaultTextFormat = format;
		textfield.selectable = false;
		textfield.text = name;
		container.addChild(textfield);
		
		var button:SimpleButton = new SimpleButton(container, container, container);
		var scale = stage.stageWidth * 10 / 100 / button.width;
		button.scaleX = scale;
		button.scaleY = scale;
		
		return button;
	}
	
	function setButtonsVisibility(visible:Bool) {
		_scaleUpButton.visible = visible;
		_scaleUpButtonBig.visible = visible;
		_scaleDownButton.visible = visible;
		_scaleDownButtonBig.visible = visible;
		_saveButton.visible = visible;
		#if cpp
		_saveToFileButton.visible = visible;
		#end
	}
	
	function scaleToSize(object:DisplayObject, size:Int) {
		var scale:Float = size / object.width;
		if (object.height * scale <= size) {
			object.scaleX = object.scaleY = scale;
		}
		else {
			object.scaleX = object.scaleY = size / object.height;
		}
	}

}
