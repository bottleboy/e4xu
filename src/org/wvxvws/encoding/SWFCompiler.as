﻿package org.wvxvws.encoding 
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import org.wvxvws.encoding.tags.DefineSceneAndFrameLabelData;
	import org.wvxvws.encoding.tags.DefineSound;
	import org.wvxvws.encoding.tags.DefineVideoStream;
	import org.wvxvws.encoding.tags.DoABC;
	import org.wvxvws.encoding.tags.FileAttributes;
	import org.wvxvws.encoding.tags.FrameLabel;
	import org.wvxvws.encoding.tags.PlaceObject2;
	import org.wvxvws.encoding.tags.ScriptLimits;
	import org.wvxvws.encoding.tags.SetBackgroundColor;
	import org.wvxvws.encoding.tags.ShowFrame;
	import org.wvxvws.encoding.tags.SoundStreamHead2;
	import org.wvxvws.encoding.tags.SymbolClass;
	import org.wvxvws.encoding.tags.VideoFrame;
	
	//{imports
	
	//}
	/**
	* SWFCompiler class.
	* @author wvxvw
	* @langVersion 3.0
	* @playerVersion 10.0.12.36
	*/
	public class SWFCompiler 
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		public static const MP3:int = 2;
		public static const WAVE:int = 0;
		
		public static var signature:String = "\x46\x57\x53";
		public static var version:uint = 0x9;
		public static var fileLength:uint = 0;
		public static var frameRect:String = "\x78\x00\x06\x40\x00\x00\x12\xc0\x00";
		//"\x78\x00\x07\xD0\x00\x00\x17\x70\x00";
		public static var frameRate:uint = 0x1900;
		public static var frameCount:uint = 0x1;
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static var defineSound:DefineSound;
		private static var defineSceneAndFrameLabelData:DefineSceneAndFrameLabelData = 
							new DefineSceneAndFrameLabelData();
		private static var doABC:DoABC = new DoABC();
		private static var fileAttributes:FileAttributes = new FileAttributes();
		private static var frameLabel:FrameLabel = new FrameLabel();
		private static var scriptLimits:ScriptLimits = new ScriptLimits();
		private static var setBackgroundColor:SetBackgroundColor = new SetBackgroundColor();
		private static var symbolClass:SymbolClass = new SymbolClass();
		private static var soundStreamHead2:SoundStreamHead2 = new SoundStreamHead2();
		private static var _generator:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function SWFCompiler() { super(); }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		public static function compileEmbeddedVideo(input:ByteArray, toFile:String):ByteArray
		{
			var videoStream:DefineVideoStream = new DefineVideoStream();
			var placeObject:PlaceObject2 = new PlaceObject2();
			var videoFrame:VideoFrame = new VideoFrame();
			var showFrame:ShowFrame = new ShowFrame();
			var frames:Array = FLVTranscoder.read(input);
			var swf:ByteArray = new ByteArray();
			swf.endian = Endian.LITTLE_ENDIAN;
			writeHeader(swf, toFile);
			return null;
		}
		
		private static function vriteVideoFrame():void
		{
			
		}
		
		public static function compileMP3SWF(input:ByteArray, toFile:String):ByteArray
		{
			var swf:ByteArray = new ByteArray();
			swf.endian = Endian.LITTLE_ENDIAN;
			writeHeader(swf, toFile);
			defineSound = MP3Transcoder.transcode(input);
			
			soundStreamHead2.playBackSoundRate = defineSound.soundRate;
			soundStreamHead2.playBackSoundSize = defineSound.soundSize;
			soundStreamHead2.playBackSoundType = defineSound.soundType;
			
			//soundStreamHead2.streamSoundCompression = defineSound.soundFormat;
			trace("defineSound.sampleCount", defineSound.sampleCount);
			//soundStreamHead2.streamSoundSampleCount = defineSound.sampleCount;
			//soundStreamHead2.streamSoundRate = defineSound.soundRate;
			//soundStreamHead2.streamSoundSize = defineSound.soundSize;
			//soundStreamHead2.streamSoundType = defineSound.soundType;
			
			doABC.embeddedSoundName = generateMP3Name();
			swf.writeBytes(doABC.compile());
			swf.writeBytes(defineSound.data);
			symbolClass.classNames = [doABC.embeddedSoundName];
			symbolClass.tagIDs = [1];
			symbolClass.numSymbols = 1;
			swf.writeBytes(symbolClass.compile());
			swf.writeBytes(soundStreamHead2.compile());
			
			writeEnd(swf);
			swf.position = 4;
			swf.writeUnsignedInt(swf.length);
			swf.position = 0;
			return swf;
		}
		
		public static function compileSoundSWF(input:ByteArray, toFile:String, soundType:int):ByteArray
		{
			var swf:ByteArray = new ByteArray();
			swf.endian = Endian.LITTLE_ENDIAN;
			writeHeader(swf, toFile);
			switch (soundType)
			{
				case MP3:
					defineSound = MP3Transcoder.transcode(input);
					break;
				case WAVE:
					defineSound = WAVETranscoder.transcode(input);
					break;
				default:
					throw new Error("Wrong sound type");
					return;
			}
			
			soundStreamHead2.playBackSoundRate = defineSound.soundRate;
			soundStreamHead2.playBackSoundSize = defineSound.soundSize;
			soundStreamHead2.playBackSoundType = defineSound.soundType;
			
			doABC.embeddedSoundName = generateMP3Name();
			swf.writeBytes(doABC.compile());
			swf.writeBytes(defineSound.data);
			symbolClass.classNames = [doABC.embeddedSoundName];
			symbolClass.tagIDs = [1];
			symbolClass.numSymbols = 1;
			swf.writeBytes(symbolClass.compile());
			swf.writeBytes(soundStreamHead2.compile());
			
			writeEnd(swf);
			swf.position = 4;
			swf.writeUnsignedInt(swf.length);
			swf.position = 0;
			return swf;
		}
		
		private static function generateMP3Name():String
		{
			var id:String = (++_generator).toString(36).toUpperCase();
			while (id.length < 3) id = "0" + id;
			return "Sound" + id;
		}
		
		public static function writeHeader(input:ByteArray, 
											frameClassName:String):void
		{
			input.endian = Endian.LITTLE_ENDIAN;
			writeFromString(signature, input);
			input.writeByte(version);
			input.writeUnsignedInt(fileLength);
			writeFromString(frameRect, input);
			input.writeShort(frameRate);
			input.writeShort(frameCount);
			
			fileAttributes.useNetwork = 0;
			input.writeBytes(fileAttributes.compile());
			//input.writeBytes(scriptLimits.compile());
			input.writeBytes(setBackgroundColor.compile());
			frameLabel.label = "Scene 1"; // frameClassName;
			//input.writeBytes(frameLabel.compile());
			input.writeBytes(defineSceneAndFrameLabelData.compile());
		}
		
		public static function writeEnd(input:ByteArray):void
		{
			input.writeByte(0x40);
			input.writeByte(0);
			input.writeByte(0);
			input.writeByte(0);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private static function writeFromString(input:String, data:ByteArray):void
		{
			var i:int = -1;
			var il:int = input.length - 1;
			while (i++ < il) data.writeByte(input.charCodeAt(i));
		}
	}
	
}