/*
 * generated by Xtext 2.13.0
 */
package org.xtext.fipa.acl

import org.xtext.fipa.acl.convert.AclValueConverter

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class AclRuntimeModule extends AbstractAclRuntimeModule {

	override def bindIValueConverterService() {
		AclValueConverter
	}
}
