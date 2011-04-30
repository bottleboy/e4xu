package org.wvxvws.parsers.as3
{
	public class SinksBase
	{
		protected const _stack:SinksStack = new SinksStack();
		
		public function SinksBase() { super(); }
		
		protected function readInternal():void
		{
			this.buildDictionary();
			this.loopSinks();
		}
		
		protected function buildDictionary(stack:SinksStack = null):SinksStack
		{
			return this._stack.clear(stack);
		}
		
		private function loopSinks():void
		{
			var nextSink:ISink;
			while (nextSink = this._stack.next())
			{
				if (nextSink.isSinkStart(this as ISinks) && 
					nextSink.read(this as ISinks))
					this._stack.reset();
			}
		}
	}
}