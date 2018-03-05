package de.tum.ais.acl.tests

import com.google.inject.Guice
import com.google.inject.Injector
import com.google.inject.Key
import de.tum.ais.acl.AclStandaloneSetup
import de.tum.ais.acl.convert.FLOATValueConverter
import org.eclipse.xtext.GrammarUtil
import org.eclipse.xtext.IGrammarAccess
import org.eclipse.xtext.testing.GlobalRegistries
import org.eclipse.xtext.testing.GlobalRegistries.GlobalStateMemento
import org.junit.Before
import org.junit.BeforeClass

class AclValueConverterTest {

	private Injector injector
	private GlobalStateMemento globalStateMemento

	private FLOATValueConverter floatValueConverter

	@BeforeClass
	public def void staticSetup() {
		GlobalRegistries.initializeDefaults()
	}

	// https://github.com/eclipse/xtext-core/blob/master/org.eclipse.xtext.tests/src/org/eclipse/xtext/valueconverter/STRINGConverterTest.java
	// https://github.com/eclipse/xtext-core/blob/master/org.eclipse.xtext.tests/src/org/eclipse/xtext/tests/AbstractXtextTests.java
	@Before
	public def void setUp() throws Exception {
		globalStateMemento = GlobalRegistries.makeCopyOfGlobalState()
		val setup = new AclStandaloneSetup
		AclStandaloneSetup.doSetup

		floatValueConverter = get(FLOATValueConverter);
		floatValueConverter.setRule(GrammarUtil.findRuleForName(getGrammarAccess().getGrammar(), "FLOAT"));
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

}
