package de.tum.ais.acl.convert

import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.nodemodel.INode

class INTEGERValueConverter extends AbstractLexerBasedConverter<Integer> {

	override toValue(String s, INode node) throws ValueConverterException {
		if (s.contains("+")) {
			Integer.parseInt(s.replace("+", "").replace("-", ""))
		}
		if (s.contains("_")) {
			Integer.parseInt(s.replace("+", "").replace("-", "")) * -1
		}
		Integer.parseInt(s)
	}

}
