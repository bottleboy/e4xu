﻿package org.wvxvws.data 
{
	//{ imports
		
	//}
	
	/**
	 * DataBinTree class.
	 * @author wvxvw
	 * @langVersion 3.0
	 * @playerVersion 10.0.32
	 */
	public class DataBinTree implements Iterable
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		public var rule:Function;
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		protected var _type:Class;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function DataBinTree(type:Class, rule:Function = null) 
		{
			super();
			this._type = type;
		}
		
		/* INTERFACE org.wvxvws.data.Iterable */
		
		public function getIterator():IIterator
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
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