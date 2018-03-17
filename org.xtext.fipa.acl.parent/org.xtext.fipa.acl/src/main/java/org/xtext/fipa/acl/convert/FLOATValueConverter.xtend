package org.xtext.fipa.acl.convert

import java.util.regex.Pattern
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.nodemodel.INode

class FLOATValueConverter extends AbstractLexerBasedConverter<Double> {

	public static val REGEX = Pattern.compile("(\\+|-)?(\\d*\\.\\d*)([eE](\\+|-)?(\\d+))?")

	override toValue(String s, INode node) throws ValueConverterException {
		val matcher = REGEX.matcher(s)

		while (matcher.find()) {
			var value = Double.parseDouble(matcher.group(2))
			if ("-".equals(matcher.group(1))) {
				value *= -1
			}
			val exponent = matcher.group(5)
			if (exponent !== null) {
				var power = Integer.parseInt(exponent)
				if ("-".equals(matcher.group(4))) {
					power *= -1
				}
				value = Math.pow(value, power)
			}
			return value
		}
		throw new ValueConverterException('''Invalid value. '«s»' is not a valid float expression. ''', node, null)
	}
}
