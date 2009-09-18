﻿package org.wvxvws.utils 
{
	import flash.system.Capabilities;
	
	//{imports
	
	//}
	/**
	* KeyUtils class.
	* @author wvxvw
	* @langVersion 3.0
	* @playerVersion 10.0.12.36
	*/
	public class KeyUtils 
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
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
		
		private static const _keyNamesWinUSqwerty:Object =
		{
			"192" : "`",
			"49" : "1",
			"50" : "2",
			"51" : "3",
			"52" : "4",
			"53" : "5",
			"54" : "6",
			"55" : "7",
			"56" : "8",
			"57" : "9",
			"48" : "0",
			"189" : "-",
			"187" : "=",
			"8" : "Backspace",
			"9" : "Tab",
			"81" : "Q",
			"87" : "W",
			"69" : "E",
			"82" : "R",
			"84" : "T",
			"89" : "Y",
			"85" : "U",
			"73" : "I",
			"79" : "O",
			"80" : "P",
			"219" : "[",
			"221" : "]",
			"13" : "Enter",
			"20" : "Caps Lock",
			"65" : "A",
			"83" : "S",
			"68" : "D",
			"70" : "F",
			"71" : "G",
			"72" : "H",
			"74" : "J",
			"75" : "K",
			"76" : "L",
			"186" : ";",
			"222" : "'",
			"220" : "\\",
			"16" : "Shift",
			"90" : "Z",
			"88" : "X",
			"67" : "C",
			"86" : "V",
			"66" : "B",
			"78" : "N",
			"77" : "M",
			"188" : ",",
			"190" : ".",
			"191" : "/",
			"17" : "Ctrl",
			"91" : "Start",
			"32" : "Space",

			// Ins - Pgd
			"45" : "Ins",
			"36" : "Home",
			"33" : "PgUp",
			"46" : "Del",
			"35" : "End",
			"34" : "PgDn",

			// ESC + Fn
			"27" : "ESC",
			"112" : "F1",
			"113" : "F2",
			"114" : "F3",
			"115" : "F4",
			"116" : "F5",
			"116" : "F6",
			"117" : "F7",
			"118" : "F8",
			"119" : "F9",
			"120" : "F10",

			// arrows
			"38" : "Up",
			"37" : "Left",
			"40" : "Down",
			"39" : "Right",

			// numlock
			"144" : "Num Lock",
			"111" : "Num /",
			"106" : "Num *",
			"109" : "Num -",
			"107" : "Num +",
			"12" : "Num 5"
		};
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function KeyUtils() { super(); }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		public static function keyToString(key:int):String
		{
			// TODO: figure out what other layouts look like.
			if (Capabilities.os.indexOf("Win") > -1)
			{
				return _keyNamesWinUSqwerty[key];
			}
			return "";
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
	}
	
}