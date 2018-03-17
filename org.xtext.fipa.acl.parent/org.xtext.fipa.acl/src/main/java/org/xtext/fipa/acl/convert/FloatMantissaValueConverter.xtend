package org.xtext.fipa.acl.convert

import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.nodemodel.INode

class FloatMantissaValueConverter extends AbstractLexerBasedConverter<Double> {

	override toValue(String s, INode node) throws ValueConverterException {
		Double.parseDouble(s)
	}
}
