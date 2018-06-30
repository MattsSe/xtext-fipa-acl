package org.xtext.fipa.acl.tests

import com.google.inject.Guice
import com.google.inject.Injector
import com.google.inject.Key
import org.xtext.fipa.acl.AclStandaloneSetup
import org.xtext.fipa.acl.convert.DateTimeValueConverter
import org.xtext.fipa.acl.convert.FLOATValueConverter
import org.xtext.fipa.acl.convert.UserdefinedParameterValueConverter
import java.text.SimpleDateFormat
import java.util.GregorianCalendar
import javax.xml.datatype.DatatypeFactory
import org.eclipse.xtext.GrammarUtil
import org.eclipse.xtext.IGrammarAccess
import org.eclipse.xtext.conversion.ValueConverterWithValueException
import org.eclipse.xtext.testing.GlobalRegistries
import org.eclipse.xtext.testing.GlobalRegistries.GlobalStateMemento
import org.junit.Assert
import org.junit.Before
import org.junit.BeforeClass
import org.junit.Test
import javax.xml.datatype.XMLGregorianCalendar

class AclValueConverterTest {

	private Injector injector
	private GlobalStateMemento globalStateMemento

	private FLOATValueConverter floatValueConverter
	private UserdefinedParameterValueConverter userdefinedParamValueConverter
	private DateTimeValueConverter dateTimeValueConverter

	@BeforeClass
	public static def void staticSetup() {
		GlobalRegistries.initializeDefaults()
	}

	// https://github.com/eclipse/xtext-core/blob/master/org.eclipse.xtext.tests/src/org/eclipse/xtext/valueconverter/STRINGConverterTest.java
	// https://github.com/eclipse/xtext-core/blob/master/org.eclipse.xtext.tests/src/org/eclipse/xtext/tests/AbstractXtextTests.java
	@Before
	public def void setUp() throws Exception {
		globalStateMemento = GlobalRegistries.makeCopyOfGlobalState()
		val setup = new AclStandaloneSetup
		setInjector(setup.createInjectorAndDoEMFRegistration)

		floatValueConverter = get(FLOATValueConverter)
		floatValueConverter.setRule(GrammarUtil.findRuleForName(getGrammarAccess().getGrammar(), "FLOAT"))
		userdefinedParamValueConverter = get(UserdefinedParameterValueConverter)
		userdefinedParamValueConverter.setRule(
			GrammarUtil.findRuleForName(getGrammarAccess().getGrammar(), "USERDEFINED_PARAMETER"))
		dateTimeValueConverter = get(DateTimeValueConverter)
		dateTimeValueConverter.setRule(GrammarUtil.findRuleForName(getGrammarAccess().getGrammar(), "DATE_TIME"))
	}

	@Test public def void userdefinedParamConvertToStringTest() {
		val input = "input-param"
		val toString = userdefinedParamValueConverter.toString(input)
		Assert.assertEquals(":x-" + input, toString)
	}

	@Test public def void userdefinedParamConvertToValueTest() {
		val input = ":x-input-param"
		try {
			userdefinedParamValueConverter.toValue(input, null);
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals("input-param", e.getValue());
		}
	}

	@Test public def void datetimeConvertToStringTest() {
		val sdf = new SimpleDateFormat("dd-M-yyyy hh:mm:ss")
		val s = "31-08-1982 10:20:56";
		val date = sdf.parse(s)
		val calendar = new GregorianCalendar()
		calendar.time = date
		val dt = DatatypeFactory.newInstance().newXMLGregorianCalendar(calendar)
		val toString = dateTimeValueConverter.toString(dt)
		Assert.assertEquals("19820831T102056000", toString)
	}

	@Test public def void datetimeConvertToValueTest_1() {
		val sdf = new SimpleDateFormat("dd-M-yyyy hh:mm:ss")
		val s = "31-08-1982 10:20:56";
		val date = sdf.parse(s)
		try {
			dateTimeValueConverter.toValue("19820831T102056000", null);
		} catch (ValueConverterWithValueException e) {
			val cal = e.getValue() as XMLGregorianCalendar
			Assert.assertEquals(date, cal.toGregorianCalendar.time);
		}
	}
	@Test public def void datetimeConvertToValueTest_2() {
		val sdf = new SimpleDateFormat("dd-M-yyyy hh:mm:ss")
		val s = "31-08-1982 10:20:56";
		val date = sdf.parse(s)
		try {
			dateTimeValueConverter.toValue("19820831T102056000Z", null);
		} catch (ValueConverterWithValueException e) {
			val cal = e.getValue() as XMLGregorianCalendar
			Assert.assertEquals(date, cal.toGregorianCalendar.time);
		}
	}

	@Test public def void floatExpressionToValueTest_1() {
		val input = "10.0"
		try {
			floatValueConverter.toValue(input, null)
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals(10.0, e.getValue())
		}
	}

	@Test public def void floatExpressionToValueTest_2() {
		val input = "-10.0"
		try {
			floatValueConverter.toValue(input, null)
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals(-10.0, e.getValue())
		}
	}

	@Test public def void floatExpressionToValueTest_3() {
		val input = "10.0e5"
		try {
			floatValueConverter.toValue(input, null)
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals(100000.0, e.getValue())
		}
	}

	@Test public def void floatExpressionToValueTest_4() {
		val input = "10.0E-5"
		try {
			floatValueConverter.toValue(input, null)
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals(0.00001, e.getValue())
		}
	}

	@Test public def void floatExpressionToValueTest_5() {
		val input = "-10.0E-5"
		try {
			floatValueConverter.toValue(input, null)
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals(-0.00001, e.getValue())
		}
	}

	@Test public def void floatExpressionToValueTest_6() {
		val input = "-.0E-5"
		try {
			floatValueConverter.toValue(input, null)
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals(0.0, e.getValue())
		}
	}

	@Test public def void floatExpressionToValueTest_7() {
		val input = "-0.E-5"
		try {
			floatValueConverter.toValue(input, null)
		} catch (ValueConverterWithValueException e) {
			Assert.assertEquals(0.0, e.getValue())
		}
	}

	public def <T> T get(Class<T> clazz) {
		if (injector === null)
			injector = Guice.createInjector()
		return injector.getInstance(clazz)
	}

	public def <T> T get(Key<T> key) {
		if (injector === null)
			injector = Guice.createInjector()
		return injector.getInstance(key)
	}

	protected def IGrammarAccess getGrammarAccess() {
		return getInjector().getInstance(IGrammarAccess)
	}

	public def final Injector getInjector() {
		if (injector === null)
			throw new IllegalStateException(
				"No injector set. Did you forget to call something like 'with(new YourStadaloneSetup())'?")
		return injector
	}

	protected def setInjector(Injector injector) {
		this.injector = injector
	}

}
