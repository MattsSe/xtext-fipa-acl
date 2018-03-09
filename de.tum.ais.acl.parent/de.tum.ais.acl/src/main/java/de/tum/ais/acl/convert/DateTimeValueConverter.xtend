package de.tum.ais.acl.convert

import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.GregorianCalendar
import javax.xml.datatype.DatatypeFactory
import javax.xml.datatype.XMLGregorianCalendar
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.nodemodel.INode

class DateTimeValueConverter extends AbstractLexerBasedConverter<XMLGregorianCalendar> {

	static val ZULU = new SimpleDateFormat("yyyyMMdd'T'HHmmssSSSX");
	static val ISO8601 = new SimpleDateFormat("yyyyMMdd'T'HHmmssSSS");

	override toValue(String s, INode node) throws ValueConverterException {
		try {
			val calendar = new GregorianCalendar()
			val date = ISO8601.parse(s)
			calendar.setTime(date)
			return DatatypeFactory.newInstance().newXMLGregorianCalendar(calendar)
		} catch (ParseException e1) {
			try {
				val calendar = new GregorianCalendar()
				val date = ZULU.parse(s)
				calendar.setTime(date)
				return DatatypeFactory.newInstance().newXMLGregorianCalendar(calendar)
			} catch (ParseException e2) {
				throw new ValueConverterException('''Invalid value. '«s»' is not a valid datetime expression.''', node,
					null);
			}
		}
	}

	override toString(XMLGregorianCalendar value) {
		ISO8601.format(value)
	}
}
