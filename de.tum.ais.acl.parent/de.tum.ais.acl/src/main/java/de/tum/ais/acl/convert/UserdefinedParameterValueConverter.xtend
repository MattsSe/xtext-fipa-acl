package de.tum.ais.acl.convert

import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.nodemodel.INode

class UserdefinedParameterValueConverter extends AbstractLexerBasedConverter<String> {

	override toValue(String s, INode node) throws ValueConverterException {
		s.replaceFirst(":x-", "")
	}

	override toString(String s) {
		assertValidValue(s)
		val value = s.trim
		if (value.startsWith(":x-")) {
			value
		} else {
			":x-" + value
		}
	}

}
