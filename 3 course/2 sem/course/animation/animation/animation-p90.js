(function (cjs, an) {

var p; // shortcut to reference prototypes
var lib={};var ss={};var img={};
lib.ssMetadata = [
		{name:"animation_p90_atlas_1", frames: [[0,0,1920,1032],[0,1034,1280,720]]},
		{name:"animation_p90_atlas_2", frames: [[1783,215,153,489],[0,0,1567,567],[0,569,800,572],[802,780,480,360],[802,569,979,209],[1284,780,480,360],[802,1142,472,126],[1783,706,245,96],[1569,0,425,213],[1882,972,117,148],[1766,804,124,154],[1938,319,85,73],[1938,215,92,102],[1569,215,154,154],[1892,804,114,166],[1996,0,33,33],[1766,960,114,166],[1569,371,148,148]]}
];


(lib.AnMovieClip = function(){
	this.currentSoundStreamInMovieclip;
	this.actionFrames = [];
	this.soundStreamDuration = new Map();
	this.streamSoundSymbolsList = [];

	this.gotoAndPlayForStreamSoundSync = function(positionOrLabel){
		cjs.MovieClip.prototype.gotoAndPlay.call(this,positionOrLabel);
	}
	this.gotoAndPlay = function(positionOrLabel){
		this.clearAllSoundStreams();
		this.startStreamSoundsForTargetedFrame(positionOrLabel);
		cjs.MovieClip.prototype.gotoAndPlay.call(this,positionOrLabel);
	}
	this.play = function(){
		this.clearAllSoundStreams();
		this.startStreamSoundsForTargetedFrame(this.currentFrame);
		cjs.MovieClip.prototype.play.call(this);
	}
	this.gotoAndStop = function(positionOrLabel){
		cjs.MovieClip.prototype.gotoAndStop.call(this,positionOrLabel);
		this.clearAllSoundStreams();
	}
	this.stop = function(){
		cjs.MovieClip.prototype.stop.call(this);
		this.clearAllSoundStreams();
	}
	this.startStreamSoundsForTargetedFrame = function(targetFrame){
		for(var index=0; index<this.streamSoundSymbolsList.length; index++){
			if(index <= targetFrame && this.streamSoundSymbolsList[index] != undefined){
				for(var i=0; i<this.streamSoundSymbolsList[index].length; i++){
					var sound = this.streamSoundSymbolsList[index][i];
					if(sound.endFrame > targetFrame){
						var targetPosition = Math.abs((((targetFrame - sound.startFrame)/lib.properties.fps) * 1000));
						var instance = playSound(sound.id);
						var remainingLoop = 0;
						if(sound.offset){
							targetPosition = targetPosition + sound.offset;
						}
						else if(sound.loop > 1){
							var loop = targetPosition /instance.duration;
							remainingLoop = Math.floor(sound.loop - loop);
							if(targetPosition == 0){ remainingLoop -= 1; }
							targetPosition = targetPosition % instance.duration;
						}
						instance.loop = remainingLoop;
						instance.position = Math.round(targetPosition);
						this.InsertIntoSoundStreamData(instance, sound.startFrame, sound.endFrame, sound.loop , sound.offset);
					}
				}
			}
		}
	}
	this.InsertIntoSoundStreamData = function(soundInstance, startIndex, endIndex, loopValue, offsetValue){ 
 		this.soundStreamDuration.set({instance:soundInstance}, {start: startIndex, end:endIndex, loop:loopValue, offset:offsetValue});
	}
	this.clearAllSoundStreams = function(){
		var keys = this.soundStreamDuration.keys();
		for(var i = 0;i<this.soundStreamDuration.size; i++){
			var key = keys.next().value;
			key.instance.stop();
		}
 		this.soundStreamDuration.clear();
		this.currentSoundStreamInMovieclip = undefined;
	}
	this.stopSoundStreams = function(currentFrame){
		if(this.soundStreamDuration.size > 0){
			var keys = this.soundStreamDuration.keys();
			for(var i = 0; i< this.soundStreamDuration.size ; i++){
				var key = keys.next().value; 
				var value = this.soundStreamDuration.get(key);
				if((value.end) == currentFrame){
					key.instance.stop();
					if(this.currentSoundStreamInMovieclip == key) { this.currentSoundStreamInMovieclip = undefined; }
					this.soundStreamDuration.delete(key);
				}
			}
		}
	}

	this.computeCurrentSoundStreamInstance = function(currentFrame){
		if(this.currentSoundStreamInMovieclip == undefined){
			if(this.soundStreamDuration.size > 0){
				var keys = this.soundStreamDuration.keys();
				var maxDuration = 0;
				for(var i=0;i<this.soundStreamDuration.size;i++){
					var key = keys.next().value;
					var value = this.soundStreamDuration.get(key);
					if(value.end > maxDuration){
						maxDuration = value.end;
						this.currentSoundStreamInMovieclip = key;
					}
				}
			}
		}
	}
	this.getDesiredFrame = function(currentFrame, calculatedDesiredFrame){
		for(var frameIndex in this.actionFrames){
			if((frameIndex > currentFrame) && (frameIndex < calculatedDesiredFrame)){
				return frameIndex;
			}
		}
		return calculatedDesiredFrame;
	}

	this.syncStreamSounds = function(){
		this.stopSoundStreams(this.currentFrame);
		this.computeCurrentSoundStreamInstance(this.currentFrame);
		if(this.currentSoundStreamInMovieclip != undefined){
			var soundInstance = this.currentSoundStreamInMovieclip.instance;
			if(soundInstance.position != 0){
				var soundValue = this.soundStreamDuration.get(this.currentSoundStreamInMovieclip);
				var soundPosition = (soundValue.offset?(soundInstance.position - soundValue.offset): soundInstance.position);
				var calculatedDesiredFrame = (soundValue.start)+((soundPosition/1000) * lib.properties.fps);
				if(soundValue.loop > 1){
					calculatedDesiredFrame +=(((((soundValue.loop - soundInstance.loop -1)*soundInstance.duration)) / 1000) * lib.properties.fps);
				}
				calculatedDesiredFrame = Math.floor(calculatedDesiredFrame);
				var deltaFrame = calculatedDesiredFrame - this.currentFrame;
				if(deltaFrame >= 2){
					this.gotoAndPlayForStreamSoundSync(this.getDesiredFrame(this.currentFrame,calculatedDesiredFrame));
				}
			}
		}
	}
}).prototype = p = new cjs.MovieClip();
// symbols:



(lib.bodyback = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(0);
}).prototype = p = new cjs.Sprite();



(lib.body = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(1);
}).prototype = p = new cjs.Sprite();



(lib.oleksandrholub02 = function() {
	this.initialize(ss["animation_p90_atlas_1"]);
	this.gotoAndStop(0);
}).prototype = p = new cjs.Sprite();



(lib.scope = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(2);
}).prototype = p = new cjs.Sprite();



(lib.soldierwithgun = function() {
	this.initialize(ss["animation_p90_atlas_1"]);
	this.gotoAndStop(1);
}).prototype = p = new cjs.Sprite();



(lib.scope2 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(3);
}).prototype = p = new cjs.Sprite();



(lib.magazine = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(4);
}).prototype = p = new cjs.Sprite();



(lib.target = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(5);
}).prototype = p = new cjs.Sprite();



(lib.shutter = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(6);
}).prototype = p = new cjs.Sprite();



(lib.magazinedetail = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(7);
}).prototype = p = new cjs.Sprite();



(lib.bodydetail = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(8);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_6 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(9);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_8 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(10);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_2 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(11);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_3 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(12);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_9 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(13);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_5 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(14);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_1 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(15);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_4 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(16);
}).prototype = p = new cjs.Sprite();



(lib.CachedBmp_7 = function() {
	this.initialize(ss["animation_p90_atlas_2"]);
	this.gotoAndStop(17);
}).prototype = p = new cjs.Sprite();



(lib.BStop = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{bstop:2});

	// Слой_1
	this.instance = new lib.CachedBmp_8();
	this.instance.setTransform(220.5,-203.95,0.4935,0.4935);

	this.instance_1 = new lib.CachedBmp_9();
	this.instance_1.setTransform(225.5,-203.95,0.4935,0.4935);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance}]}).to({state:[{t:this.instance_1}]},2).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(220.5,-203.9,81,76);


(lib.BPlay = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.CachedBmp_6();
	this.instance.setTransform(-31,-40.95,0.5,0.5);

	this.instance_1 = new lib.CachedBmp_7();
	this.instance_1.setTransform(-31,-40.95,0.5,0.5);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance}]}).to({state:[{t:this.instance_1}]},2).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-31,-40.9,74,74);


(lib.BPause = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.CachedBmp_4();
	this.instance.setTransform(-30,-47.95,0.5,0.5);

	this.instance_1 = new lib.CachedBmp_5();
	this.instance_1.setTransform(-30,-47.95,0.5,0.5);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance}]}).to({state:[{t:this.instance_1}]},2).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-30,-47.9,57,83);


(lib.Анимация53 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodyback();
	this.instance.setTransform(-38.15,-122.05,0.4992,0.4992);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-38.1,-122,76.30000000000001,244.1);


(lib.Анимация52 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodyback();
	this.instance.setTransform(-38.15,-122.05,0.4992,0.4992);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-38.1,-122,76.30000000000001,244.1);


(lib.Анимация51 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.scope();
	this.instance.setTransform(-201.3,-143.9,0.5033,0.5033);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-201.3,-143.9,402.6,287.9);


(lib.Анимация50 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.scope();
	this.instance.setTransform(-201.3,-143.9,0.5033,0.5033);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-201.3,-143.9,402.6,287.9);


(lib.Анимация47 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.scope2();
	this.instance.setTransform(-728.75,-546.55,3.0366,3.0366);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-728.7,-546.5,1457.5,1093.1);


(lib.Анимация46 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.scope2();
	this.instance.setTransform(-728.75,-546.55,3.0366,3.0366);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-728.7,-546.5,1457.5,1093.1);


(lib.Анимация30 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.body();
	this.instance.setTransform(-393,-142.2,0.5016,0.5016);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-393,-142.2,786.1,284.5);


(lib.Анимация27 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.shutter();
	this.instance.setTransform(-128.5,-35.55,0.5446,0.5646);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-128.5,-35.5,257.1,71.1);


(lib.Анимация26 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.shutter();
	this.instance.setTransform(-128.5,-35.55,0.5446,0.5646);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-128.5,-35.5,257.1,71.1);


(lib.Анимация25 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.shutter();
	this.instance.setTransform(-128.5,-35.55,0.5446,0.5646);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-128.5,-35.5,257.1,71.1);


(lib.Анимация24 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.scope();
	this.instance.setTransform(-185,-151,0.4336,0.4336);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-185,-151,346.9,248);


(lib.Анимация19 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.magazinedetail();
	this.instance.setTransform(-83.2,-32.6,0.6794,0.6794);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-83.2,-32.6,166.5,65.2);


(lib.Анимация18 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.magazinedetail();
	this.instance.setTransform(-83.2,-32.6,0.6794,0.6794);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-83.2,-32.6,166.5,65.2);


(lib.Анимация17 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.magazinedetail();
	this.instance.setTransform(-83.2,-32.6,0.6794,0.6794);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-83.2,-32.6,166.5,65.2);


(lib.Анимация16 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodyback();
	this.instance.setTransform(-36,-123.6,0.4707,0.5055);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-36,-123.6,72,247.2);


(lib.Анимация15 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodyback();
	this.instance.setTransform(-36,-123.6,0.4707,0.5055);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-36,-123.6,72,247.2);


(lib.Анимация14 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodyback();
	this.instance.setTransform(-36,-123.6,0.4707,0.5055);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-36,-123.6,72,247.2);


(lib.Анимация13 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodydetail();
	this.instance.setTransform(-116.9,-58.6,0.5502,0.5502);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-116.9,-58.6,233.9,117.2);


(lib.Анимация12 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodydetail();
	this.instance.setTransform(-116.9,-58.6,0.5502,0.5502);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-116.9,-58.6,233.9,117.2);


(lib.Анимация11 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodydetail();
	this.instance.setTransform(-116.9,-58.6,0.5502,0.5502);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-116.9,-58.6,233.9,117.2);


(lib.Анимация10 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodydetail();
	this.instance.setTransform(-116.9,-58.6,0.5502,0.5502);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-116.9,-58.6,233.9,117.2);


(lib.Анимация9 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.bodydetail();
	this.instance.setTransform(-116.9,-58.6,0.5502,0.5502);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-116.9,-58.6,233.9,117.2);


(lib.Анимация8 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.magazine();
	this.instance.setTransform(-254.75,-51.95,0.5205,0.4972);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-254.7,-51.9,509.5,103.9);


(lib.Анимация7 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.magazine();
	this.instance.setTransform(-254.75,-51.95,0.5205,0.4972);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-254.7,-51.9,509.5,103.9);


(lib.Анимация5 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Слой_1
	this.instance = new lib.magazine();
	this.instance.setTransform(-254.75,-51.95,0.5205,0.4972);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	this._renderFirstFrame();

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-254.7,-51.9,509.5,103.9);


// stage content:
(lib.animationp90 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	this.actionFrames = [0,421,472,1008,1044,1088,1139];
	this.streamSoundSymbolsList[0] = [{id:"тест2onlineaudioconvertercom",startFrame:0,endFrame:486,loop:1,offset:0}];
	this.streamSoundSymbolsList[421] = [{id:"p902",startFrame:421,endFrame:463,loop:1,offset:0}];
	this.streamSoundSymbolsList[472] = [{id:"тест4",startFrame:472,endFrame:1411,loop:1,offset:0}];
	this.streamSoundSymbolsList[1008] = [{id:"p90shoot",startFrame:1008,endFrame:1412,loop:1,offset:0}];
	this.streamSoundSymbolsList[1044] = [{id:"тест5",startFrame:1044,endFrame:1412,loop:1,offset:0}];
	this.streamSoundSymbolsList[1088] = [{id:"тест2onlineaudioconvertercom",startFrame:1088,endFrame:1089,loop:1,offset:0}];
	this.streamSoundSymbolsList[1139] = [{id:"тест3onlineaudioconvertercom",startFrame:1139,endFrame:1472,loop:1,offset:0}];
	// timeline functions:
	this.frame_0 = function() {
		this.clearAllSoundStreams();
		 
		var soundInstance = playSound("тест2onlineaudioconvertercom",0);
		this.InsertIntoSoundStreamData(soundInstance,0,486,1);
		this.stop();
		this.bstop.addEventListener("click",()=>this.gotoAndStop(0));
		this.bpause.addEventListener("click",()=>this.stop());
		this.bplay.addEventListener("click",()=>this.play());
	}
	this.frame_421 = function() {
		var soundInstance = playSound("p902",0);
		this.InsertIntoSoundStreamData(soundInstance,421,463,1);
	}
	this.frame_472 = function() {
		var soundInstance = playSound("тест4",0);
		this.InsertIntoSoundStreamData(soundInstance,472,1411,1);
	}
	this.frame_1008 = function() {
		var soundInstance = playSound("p90shoot",0);
		this.InsertIntoSoundStreamData(soundInstance,1008,1412,1);
	}
	this.frame_1044 = function() {
		var soundInstance = playSound("тест5",0);
		this.InsertIntoSoundStreamData(soundInstance,1044,1412,1);
	}
	this.frame_1088 = function() {
		var soundInstance = playSound("тест2onlineaudioconvertercom",0);
		this.InsertIntoSoundStreamData(soundInstance,1088,1089,1);
	}
	this.frame_1139 = function() {
		var soundInstance = playSound("тест3onlineaudioconvertercom",0);
		this.InsertIntoSoundStreamData(soundInstance,1139,1472,1);
	}

	// actions tween:
	this.timeline.addTween(cjs.Tween.get(this).call(this.frame_0).wait(421).call(this.frame_421).wait(51).call(this.frame_472).wait(536).call(this.frame_1008).wait(36).call(this.frame_1044).wait(44).call(this.frame_1088).wait(51).call(this.frame_1139).wait(384));

	// кнопки
	this.bstop = new lib.BStop();
	this.bstop.name = "bstop";
	this.bstop.setTransform(-198.8,814.4,1.0132,1);
	new cjs.ButtonHelper(this.bstop, 0, 1, 2);

	this.bpause = new lib.BPause();
	this.bpause.name = "bpause";
	this.bpause.setTransform(152.55,656.25);
	new cjs.ButtonHelper(this.bpause, 0, 1, 2);

	this.bplay = new lib.BPlay();
	this.bplay.name = "bplay";
	this.bplay.setTransform(245,653.35);
	new cjs.ButtonHelper(this.bplay, 0, 1, 2);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.bplay},{t:this.bpause},{t:this.bstop,p:{scaleX:1.0132,x:-198.8}}]}).to({state:[{t:this.bplay},{t:this.bpause},{t:this.bstop,p:{scaleX:1.0132,x:-198.8}}]},179).to({state:[{t:this.bplay},{t:this.bpause},{t:this.bstop,p:{scaleX:1.0132,x:-198.8}}]},122).to({state:[{t:this.bplay},{t:this.bpause},{t:this.bstop,p:{scaleX:1.0132,x:-198.8}}]},601).to({state:[{t:this.bplay},{t:this.bpause},{t:this.bstop,p:{scaleX:1,x:-195.5}}]},1).to({state:[{t:this.bplay},{t:this.bpause},{t:this.bstop,p:{scaleX:1,x:-195.5}}]},619).wait(1));

	// прицел_мишень
	this.instance = new lib.scope2();
	this.instance.setTransform(-111,-127,3.0366,3.0366);

	this.instance_1 = new lib.Анимация46("synched",0);
	this.instance_1.setTransform(617.75,419.55);
	this.instance_1._off = true;

	this.instance_2 = new lib.Анимация47("synched",0);
	this.instance_2.setTransform(579.35,486.7,1.6476,1.6476);
	this.instance_2._off = true;

	this.timeline.addTween(cjs.Tween.get({}).to({state:[]}).to({state:[{t:this.instance}]},675).to({state:[{t:this.instance_1}]},1).to({state:[{t:this.instance_2}]},66).to({state:[{t:this.instance_2}]},270).to({state:[{t:this.instance_2}]},5).to({state:[{t:this.instance_2}]},4).to({state:[{t:this.instance_2}]},4).to({state:[{t:this.instance_2}]},3).to({state:[{t:this.instance_2}]},4).to({state:[{t:this.instance_2}]},6).to({state:[]},112).to({state:[]},260).wait(113));
	this.timeline.addTween(cjs.Tween.get(this.instance_1).wait(676).to({_off:false},0).to({_off:true,scaleX:1.6476,scaleY:1.6476,x:579.35,y:486.7},66).wait(781));
	this.timeline.addTween(cjs.Tween.get(this.instance_2).wait(676).to({_off:false},66).to({startPosition:0},270).to({y:369.65},5).to({y:486.7},4).to({y:369.65},4).to({y:486.7},3).to({y:369.65},4).to({y:486.7},6).to({_off:true},112).wait(373));

	// попадания
	this.instance_3 = new lib.CachedBmp_1();
	this.instance_3.setTransform(676.35,332.05,0.5,0.5);

	this.instance_4 = new lib.CachedBmp_2();
	this.instance_4.setTransform(676.35,311.9,0.5,0.5);

	this.instance_5 = new lib.CachedBmp_3();
	this.instance_5.setTransform(676.35,311.9,0.5,0.5);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[]}).to({state:[{t:this.instance_3}]},1013).to({state:[{t:this.instance_4}]},10).to({state:[{t:this.instance_5}]},6).to({state:[]},121).to({state:[]},262).wait(111));

	// мишень
	this.instance_6 = new lib.target();
	this.instance_6.setTransform(457,160);
	this.instance_6._off = true;

	this.timeline.addTween(cjs.Tween.get(this.instance_6).wait(676).to({_off:false},0).to({_off:true},474).wait(373));

	// солдат
	this.instance_7 = new lib.soldierwithgun();
	this.instance_7._off = true;

	this.timeline.addTween(cjs.Tween.get(this.instance_7).wait(456).to({_off:false},0).to({_off:true},219).wait(848));

	// затвор
	this.instance_8 = new lib.shutter();
	this.instance_8.setTransform(729,317,0.5446,0.5646);

	this.instance_9 = new lib.Анимация25("synched",0);
	this.instance_9.setTransform(857.5,352.55);
	this.instance_9._off = true;

	this.instance_10 = new lib.Анимация26("synched",0);
	this.instance_10.setTransform(798.5,352.55);
	this.instance_10._off = true;

	this.instance_11 = new lib.Анимация27("synched",0);
	this.instance_11.setTransform(857.5,352.55);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_8}]}).to({state:[{t:this.instance_8}]},301).to({state:[{t:this.instance_9}]},120).to({state:[{t:this.instance_10}]},13).to({state:[{t:this.instance_11}]},14).to({state:[]},8).to({state:[]},1066).wait(1));
	this.timeline.addTween(cjs.Tween.get(this.instance_9).wait(421).to({_off:false},0).to({_off:true,x:798.5},13).wait(1089));
	this.timeline.addTween(cjs.Tween.get(this.instance_10).wait(421).to({_off:false},13).to({_off:true,x:857.5},14).wait(1075));

	// затвор___копия
	this.instance_12 = new lib.shutter();
	this.instance_12.setTransform(729,317,0.5446,0.5646);

	this.instance_13 = new lib.Анимация25("synched",0);
	this.instance_13.setTransform(857.5,352.55);

	this.instance_14 = new lib.Анимация27("synched",0);
	this.instance_14.setTransform(857.5,352.55);

	this.instance_15 = new lib.Анимация30("synched",0);
	this.instance_15.setTransform(672.9,403.2,0.9767,0.9767);
	this.instance_15._off = true;

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_12}]}).to({state:[{t:this.instance_12}]},301).to({state:[{t:this.instance_13}]},120).to({state:[{t:this.instance_13}]},13).to({state:[{t:this.instance_14}]},14).to({state:[]},8).to({state:[{t:this.instance_15}]},694).to({state:[{t:this.instance_15}]},40).to({state:[{t:this.instance_15}]},331).to({state:[]},1).wait(1));
	this.timeline.addTween(cjs.Tween.get(this.instance_15).wait(1150).to({_off:false},0).to({startPosition:0},40).wait(331).to({startPosition:0},0).to({_off:true},1).wait(1));

	// задняя_база
	this.instance_16 = new lib.Анимация14("synched",0);
	this.instance_16.setTransform(276,157.6);

	this.instance_17 = new lib.Анимация15("synched",0);
	this.instance_17.setTransform(276,157.6);
	this.instance_17._off = true;

	this.instance_18 = new lib.Анимация16("synched",0);
	this.instance_18.setTransform(276,384.6);
	this.instance_18._off = true;

	this.instance_19 = new lib.Анимация13("synched",0);
	this.instance_19.setTransform(404.6,430.6);
	this.instance_19._off = true;

	this.timeline.addTween(cjs.Tween.get(this.instance_16).to({_off:true},96).wait(1427));
	this.timeline.addTween(cjs.Tween.get(this.instance_17).to({_off:false},96).to({_off:true,y:384.6},13).wait(1414));
	this.timeline.addTween(cjs.Tween.get(this.instance_18).wait(96).to({_off:false},13).to({startPosition:0},70).to({startPosition:0},122).to({_off:true},155).wait(1067));
	this.timeline.addTween(cjs.Tween.get(this.instance_19).wait(1150).to({_off:false},0).to({startPosition:0},21).to({startPosition:0},113).to({startPosition:0},141).to({x:161},47).to({startPosition:0},49).to({_off:true},1).wait(1));

	// прицел
	this.instance_20 = new lib.Анимация24("synched",0);
	this.instance_20.setTransform(957.9,176.2,1.167,1.167);

	this.instance_21 = new lib.scope();
	this.instance_21.setTransform(693,103,0.5033,0.5033);

	this.instance_22 = new lib.Анимация50("synched",0);
	this.instance_22.setTransform(894.3,246.9);
	this.instance_22._off = true;

	this.instance_23 = new lib.Анимация51("synched",0);
	this.instance_23.setTransform(1025.3,169.9);
	this.instance_23._off = true;

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_20}]}).to({state:[{t:this.instance_20}]},210).to({state:[{t:this.instance_20}]},21).to({state:[{t:this.instance_20}]},70).to({state:[]},155).to({state:[{t:this.instance_21}]},694).to({state:[{t:this.instance_22}]},68).to({state:[{t:this.instance_23}]},55).to({state:[{t:this.instance_23}]},248).to({state:[]},1).wait(1));
	this.timeline.addTween(cjs.Tween.get(this.instance_20).to({startPosition:0},210).to({x:886.6,y:277.6},21).to({startPosition:0},70).to({_off:true},155).wait(1067));
	this.timeline.addTween(cjs.Tween.get(this.instance_22).wait(1218).to({_off:false},0).to({_off:true,x:1025.3,y:169.9},55).wait(250));
	this.timeline.addTween(cjs.Tween.get(this.instance_23).wait(1218).to({_off:false},55).to({startPosition:0},248).to({_off:true},1).wait(1));

	// магазин
	this.instance_24 = new lib.Анимация5("synched",0);
	this.instance_24.setTransform(534.35,79.95);

	this.instance_25 = new lib.Анимация7("synched",0);
	this.instance_25.setTransform(754.95,209.05);
	this.instance_25._off = true;

	this.instance_26 = new lib.Анимация8("synched",0);
	this.instance_26.setTransform(727.75,311.95);
	this.instance_26._off = true;

	this.instance_27 = new lib.oleksandrholub02();
	this.instance_27.setTransform(-306,0);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_24}]}).to({state:[{t:this.instance_24}]},315).to({state:[{t:this.instance_25}]},28).to({state:[{t:this.instance_25}]},29).to({state:[{t:this.instance_26}]},7).to({state:[]},77).to({state:[{t:this.instance_27}]},633).to({state:[{t:this.instance_26}]},61).to({state:[{t:this.instance_26}]},40).to({state:[{t:this.instance_26}]},190).to({state:[{t:this.instance_26}]},62).to({state:[{t:this.instance_26}]},79).to({state:[]},1).wait(1));
	this.timeline.addTween(cjs.Tween.get(this.instance_24).to({startPosition:0},315).to({_off:true,x:754.95,y:209.05},28).wait(1180));
	this.timeline.addTween(cjs.Tween.get(this.instance_25).wait(315).to({_off:false},28).to({x:727.75,y:311.8},29).to({_off:true,y:311.95},7).wait(1144));
	this.timeline.addTween(cjs.Tween.get(this.instance_26).wait(372).to({_off:false},7).to({_off:true},77).wait(694).to({_off:false,x:759.45},0).to({x:660,y:113.05},40).to({startPosition:0},190).to({startPosition:0},62).to({startPosition:0},79).to({_off:true},1).wait(1));

	// база
	this.instance_28 = new lib.body();
	this.instance_28.setTransform(253,261,0.5016,0.5016);

	this.instance_29 = new lib.shutter();
	this.instance_29.setTransform(741,316,0.5722,0.5722);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_28}]}).to({state:[{t:this.instance_28}]},179).to({state:[{t:this.instance_28}]},122).to({state:[]},155).to({state:[{t:this.instance_29}]},694).to({state:[]},371).to({state:[]},1).wait(1));

	// база_деталь
	this.instance_30 = new lib.Анимация9("synched",0);
	this.instance_30.setTransform(372.9,585.6);

	this.instance_31 = new lib.Анимация10("synched",0);
	this.instance_31.setTransform(372.9,585.6);
	this.instance_31._off = true;

	this.instance_32 = new lib.Анимация11("synched",0);
	this.instance_32.setTransform(108.3,528.2);
	this.instance_32._off = true;

	this.instance_33 = new lib.Анимация12("synched",0);
	this.instance_33.setTransform(372.9,430.6);
	this.instance_33._off = true;

	this.instance_34 = new lib.Анимация13("synched",0);
	this.instance_34.setTransform(372.9,430.6);
	this.instance_34._off = true;

	this.instance_35 = new lib.bodyback();
	this.instance_35.setTransform(276,262,0.4992,0.4992);

	this.instance_36 = new lib.Анимация52("synched",0);
	this.instance_36.setTransform(314.15,384.05);
	this.instance_36._off = true;

	this.instance_37 = new lib.Анимация53("synched",0);
	this.instance_37.setTransform(314.15,142.05);
	this.instance_37._off = true;

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_30}]}).to({state:[{t:this.instance_31}]},19).to({state:[{t:this.instance_32}]},16).to({state:[{t:this.instance_32}]},8).to({state:[{t:this.instance_33}]},17).to({state:[{t:this.instance_34}]},119).to({state:[{t:this.instance_34}]},122).to({state:[]},155).to({state:[{t:this.instance_35}]},694).to({state:[{t:this.instance_36}]},218).to({state:[{t:this.instance_37}]},34).to({state:[{t:this.instance_37}]},41).to({state:[{t:this.instance_37}]},78).to({state:[]},1).wait(1));
	this.timeline.addTween(cjs.Tween.get(this.instance_30).to({_off:true},19).wait(1504));
	this.timeline.addTween(cjs.Tween.get(this.instance_31).to({_off:false},19).to({_off:true,x:108.3,y:528.2},16).wait(1488));
	this.timeline.addTween(cjs.Tween.get(this.instance_32).wait(19).to({_off:false},16).to({y:440.2},8).to({_off:true,x:372.9,y:430.6},17).wait(1463));
	this.timeline.addTween(cjs.Tween.get(this.instance_33).wait(43).to({_off:false},17).to({_off:true},119).wait(1344));
	this.timeline.addTween(cjs.Tween.get(this.instance_34).wait(60).to({_off:false},119).to({startPosition:0},122).to({_off:true},155).wait(1067));
	this.timeline.addTween(cjs.Tween.get(this.instance_36).wait(1368).to({_off:false},0).to({_off:true,y:142.05},34).wait(121));
	this.timeline.addTween(cjs.Tween.get(this.instance_37).wait(1368).to({_off:false},34).to({startPosition:0},41).to({startPosition:0},78).to({_off:true},1).wait(1));

	// магазин_деталь
	this.instance_38 = new lib.magazinedetail();
	this.instance_38.setTransform(515,167,0.6794,0.6794);

	this.instance_39 = new lib.Анимация17("synched",0);
	this.instance_39.setTransform(598.2,199.6);
	this.instance_39._off = true;

	this.instance_40 = new lib.Анимация18("synched",0);
	this.instance_40.setTransform(598.2,302.6);
	this.instance_40._off = true;

	this.instance_41 = new lib.Анимация19("synched",0);
	this.instance_41.setTransform(432.2,302.6);
	this.instance_41._off = true;

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_38}]}).to({state:[{t:this.instance_39}]},143).to({state:[{t:this.instance_40}]},19).to({state:[{t:this.instance_41}]},32).to({state:[{t:this.instance_41}]},107).to({state:[]},155).to({state:[{t:this.instance_41}]},694).to({state:[{t:this.instance_41}]},134).to({state:[{t:this.instance_41}]},22).to({state:[{t:this.instance_41}]},25).to({state:[{t:this.instance_41}]},50).to({state:[{t:this.instance_41}]},62).to({state:[{t:this.instance_41}]},78).to({state:[]},1).wait(1));
	this.timeline.addTween(cjs.Tween.get(this.instance_39).wait(143).to({_off:false},0).to({_off:true,y:302.6},19).wait(1361));
	this.timeline.addTween(cjs.Tween.get(this.instance_40).wait(143).to({_off:false},19).to({_off:true,x:432.2},32).wait(1329));
	this.timeline.addTween(cjs.Tween.get(this.instance_41).wait(162).to({_off:false},32).to({startPosition:0},107).to({_off:true},155).wait(694).to({_off:false,x:463.9},0).to({startPosition:0},134).to({x:635.55},22).to({y:230.4},25).to({startPosition:0},50).to({startPosition:0},62).to({startPosition:0},78).to({_off:true},1).wait(1));

	// Слой_1
	this.instance_42 = new lib.oleksandrholub02();
	this.instance_42.setTransform(-306,0);

	this.timeline.addTween(cjs.Tween.get(this.instance_42).wait(1521).to({_off:true},1).wait(1));

	this._renderFirstFrame();

}).prototype = p = new lib.AnMovieClip();
p.nominalBounds = new cjs.Rectangle(18.6,-170.8,1761.6000000000001,1558.2);
// library properties:
lib.properties = {
	id: 'EA1C3BE305CA50479A6D6DCF19A2BCFA',
	width: 1280,
	height: 720,
	fps: 30,
	color: "#FFFFFF",
	opacity: 1.00,
	manifest: [
		{src:"images/animation_p90_atlas_1.png?1710394111840", id:"animation_p90_atlas_1"},
		{src:"images/animation_p90_atlas_2.png?1710394111841", id:"animation_p90_atlas_2"},
		{src:"sounds/тест3onlineaudioconvertercom.mp3?1710394111897", id:"тест3onlineaudioconvertercom"},
		{src:"sounds/тест2onlineaudioconvertercom.mp3?1710394111897", id:"тест2onlineaudioconvertercom"},
		{src:"sounds/тест5.mp3?1710394111897", id:"тест5"},
		{src:"sounds/тест4.mp3?1710394111897", id:"тест4"},
		{src:"sounds/p90shoot.mp3?1710394111897", id:"p90shoot"},
		{src:"sounds/p902.mp3?1710394111897", id:"p902"}
	],
	preloads: []
};



// bootstrap callback support:

(lib.Stage = function(canvas) {
	createjs.Stage.call(this, canvas);
}).prototype = p = new createjs.Stage();

p.setAutoPlay = function(autoPlay) {
	this.tickEnabled = autoPlay;
}
p.play = function() { this.tickEnabled = true; this.getChildAt(0).gotoAndPlay(this.getTimelinePosition()) }
p.stop = function(ms) { if(ms) this.seek(ms); this.tickEnabled = false; }
p.seek = function(ms) { this.tickEnabled = true; this.getChildAt(0).gotoAndStop(lib.properties.fps * ms / 1000); }
p.getDuration = function() { return this.getChildAt(0).totalFrames / lib.properties.fps * 1000; }

p.getTimelinePosition = function() { return this.getChildAt(0).currentFrame / lib.properties.fps * 1000; }

an.bootcompsLoaded = an.bootcompsLoaded || [];
if(!an.bootstrapListeners) {
	an.bootstrapListeners=[];
}

an.bootstrapCallback=function(fnCallback) {
	an.bootstrapListeners.push(fnCallback);
	if(an.bootcompsLoaded.length > 0) {
		for(var i=0; i<an.bootcompsLoaded.length; ++i) {
			fnCallback(an.bootcompsLoaded[i]);
		}
	}
};

an.compositions = an.compositions || {};
an.compositions['EA1C3BE305CA50479A6D6DCF19A2BCFA'] = {
	getStage: function() { return exportRoot.stage; },
	getLibrary: function() { return lib; },
	getSpriteSheet: function() { return ss; },
	getImages: function() { return img; }
};

an.compositionLoaded = function(id) {
	an.bootcompsLoaded.push(id);
	for(var j=0; j<an.bootstrapListeners.length; j++) {
		an.bootstrapListeners[j](id);
	}
}

an.getComposition = function(id) {
	return an.compositions[id];
}


an.makeResponsive = function(isResp, respDim, isScale, scaleType, domContainers) {		
	var lastW, lastH, lastS=1;		
	window.addEventListener('resize', resizeCanvas);		
	resizeCanvas();		
	function resizeCanvas() {			
		var w = lib.properties.width, h = lib.properties.height;			
		var iw = window.innerWidth, ih=window.innerHeight;			
		var pRatio = window.devicePixelRatio || 1, xRatio=iw/w, yRatio=ih/h, sRatio=1;			
		if(isResp) {                
			if((respDim=='width'&&lastW==iw) || (respDim=='height'&&lastH==ih)) {                    
				sRatio = lastS;                
			}				
			else if(!isScale) {					
				if(iw<w || ih<h)						
					sRatio = Math.min(xRatio, yRatio);				
			}				
			else if(scaleType==1) {					
				sRatio = Math.min(xRatio, yRatio);				
			}				
			else if(scaleType==2) {					
				sRatio = Math.max(xRatio, yRatio);				
			}			
		}			
		domContainers[0].width = w * pRatio * sRatio;			
		domContainers[0].height = h * pRatio * sRatio;			
		domContainers.forEach(function(container) {				
			container.style.width = w * sRatio + 'px';				
			container.style.height = h * sRatio + 'px';			
		});			
		stage.scaleX = pRatio*sRatio;			
		stage.scaleY = pRatio*sRatio;			
		lastW = iw; lastH = ih; lastS = sRatio;            
		stage.tickOnUpdate = false;            
		stage.update();            
		stage.tickOnUpdate = true;		
	}
}
an.handleSoundStreamOnTick = function(event) {
	if(!event.paused){
		var stageChild = stage.getChildAt(0);
		if(!stageChild.paused){
			stageChild.syncStreamSounds();
		}
	}
}


})(createjs = createjs||{}, AdobeAn = AdobeAn||{});
var createjs, AdobeAn;