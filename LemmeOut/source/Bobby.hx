 package;

 import flixel.FlxSprite;
 import flixel.system.FlxAssets.FlxGraphicAsset;
 import flixel.util.FlxColor;
 import flixel.FlxG;
 import flixel.math.FlxPoint;
 import flixel.FlxObject;

 class Player extends FlxSprite
 {
	 var speed:Float = 200;
	 var _rot: Float = 0;
	 // helper variables to be able to tell which keys are pressed
	 var _up:Bool = false;
	 var _down:Bool = false;
	 var _left:Bool = false;
	 var _right:Bool = false;
     public function new(?X:Float=0, ?Y:Float=0)
     {
         super(X, Y);
		 //makeGraphic(16,16, FlxColor.GREEN);
		 loadGraphic("assets/images/bobby.png", true, 100, 100);
		 // setFacingFlip(direction, flipx, flipy)
		 setFacingFlip(FlxObject.LEFT, true, false);
		 setFacingFlip(FlxObject.RIGHT, false, false);
		 animation.add("walkDown", [0,1], 5, true);
		 animation.add("walkUp", [4, 5], 5, true);
		 animation.add("walkSide", [6, 7], 5, true);
		 animation.add("idle", [0,0,1,1,0,2,1,3], 5, true);
		 drag.x = drag.y = 1600;
     }
	 
	 override public function update(elapsed:Float):Void
	 {
		 movement();
		 super.update(elapsed);
	 }
	 
	 function movement():Void
	 {
		 _up = FlxG.keys.anyPressed([UP, W]);
		 _down = FlxG.keys.anyPressed([DOWN, S]);
		 _left = FlxG.keys.anyPressed([LEFT, A]);
		 _right = FlxG.keys.anyPressed([RIGHT, D]);
		 
		 // cancel out opposing directions
		 if (_up && _down){
		 	_up = _down = false;
		 }
		 if (_left && _right){
		 	_left = _right = false;
		 }
		 
		 if (_up || _down || _left || _right){
			 if (_left)
			 {
				 _rot = 180;
				 facing = FlxObject.RIGHT;
			 }
			 else if (_right)
			 {
				 _rot = 0;
				 facing = FlxObject.LEFT;
			 }
			 else if(_up){
			 	_rot = 270;
			 }
			 else if(_down){
			 	_rot = 90;
			 }
			 
		 	velocity.set(speed,0);
			velocity.rotate(new FlxPoint(0,0), _rot);
		 }
		 if (velocity.x != 0 || velocity.y != 0){
		 	if(_down){
		 		animation.play("walkDown");
		 	}
		 	if(_up){
		 		animation.play("walkUp");
		 	}
		 	if(_left || _right){
		 		animation.play("walkSide");
		 	}
		 }
		 else animation.play("idle");
	 }
 }
