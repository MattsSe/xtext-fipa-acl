package de.tum.ais.acl.convert

import com.google.inject.Inject
import org.eclipse.xtext.common.services.DefaultTerminalConverters
import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.conversion.ValueConverter

class AclValueConverter extends DefaultTerminalConverters {

	@Inject
	private INTEGERValueConverter integerValueConverter

	@ValueConverter(rule="INTEGER")
	public def IValueConverter<Integer> INTEGER() {
		integerValueConverter
	}

	@Inject
	private FloatMantissaValueConverter floatMantissaValueConverter

	@ValueConverter(rule="FLOATMANTISSA")
	public def IValueConverter<Double> FLOATMANTISSA() {
		floatMantissaValueConverter
	}
	
	@Inject
	private FLOATValueConverter floatValueConverter

	@ValueConverter(rule="FLOAT")
	public def IValueConverter<Double> FLOAT() {
		floatValueConverter
	}

}
