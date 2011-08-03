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

public class ErrorListContainerNode extends AbstractContainerNode{
	public final static int ID = 7;
	
	public ErrorListContainerNode(URI input, int offset, int endOffset, boolean isSeparator, boolean isLayout){
		super(input, offset, endOffset, false, isSeparator, isLayout);
	}
	
	public int getTypeIdentifier(){
		return ID;
	}
}
