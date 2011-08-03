/*******************************************************************************
 * Copyright (c) 2009-2011 CWI
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:

 *   * Arnold Lankamp - Arnold.Lankamp@cwi.nl
*******************************************************************************/
package org.rascalmpl.parser.gtd.result.error;

import java.net.URI;

import org.rascalmpl.parser.gtd.result.AbstractContainerNode;
import org.rascalmpl.parser.gtd.result.CharNode;

public class ErrorSortContainerNode extends AbstractContainerNode{
	public final static int ID = 6;
	
	private CharNode[] unmatchedInput;
	
	public ErrorSortContainerNode(URI input, int offset, int endOffset, boolean isSeparator, boolean isLayout){
		super(input, offset, endOffset, false, isSeparator, isLayout);
		
		this.unmatchedInput = null;
	}
	
	public int getTypeIdentifier(){
		return ID;
	}
	
	public void setUnmatchedInput(CharNode[] unmatchedInput){
		this.unmatchedInput = unmatchedInput;
	}
	
	public CharNode[] getUnmatchedInput(){
		return unmatchedInput;
	}
}
