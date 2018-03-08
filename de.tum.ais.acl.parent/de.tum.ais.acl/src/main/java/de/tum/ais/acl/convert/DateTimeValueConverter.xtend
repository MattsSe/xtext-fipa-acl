package de.tum.ais.acl.convert

import javax.xml.datatype.XMLGregorianCalendar
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.nodemodel.INode

class DateTimeValueConverter extends AbstractLexerBasedConverter<XMLGregorianCalendar> {

	override toValue(String s, INode node) throws ValueConverterException {
		
		// TODO: how to format XMLGregorianCalendar
		
		
		throw new UnsupportedOperationException("not yet implemented")
	}
	
	override toString(XMLGregorianCalendar value) {
		super.toString(value)
	}
	
}
