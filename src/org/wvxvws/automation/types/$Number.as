package org.wvxvws.automation.types
{
	import org.wvxvws.automation.language.Atom;
	
	public class $Number extends Atom
	{
		public function $Number(parseFrom:String)
		{
			super(name, $Number, NaN);
		}
		
		public override function toString():String
		{
			return String(this._value);
		}
	}
}