package org.xtext.fipa.acl.convert

import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.nodemodel.INode

class INTEGERValueConverter extends AbstractLexerBasedConverter<Integer> {

	override toValue(String s, INode node) throws ValueConverterException {
		if (s.startsWith("+")) {
			Integer.parseInt(s.replaceFirst("\\+|-", ""))
		}
		if (s.startsWith("_")) {
			Integer.parseInt(s.replaceFirst("\\+|-", "")) * -1
		}
		Integer.parseInt(s)
	}

}
