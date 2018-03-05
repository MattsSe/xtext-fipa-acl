/*
 * generated by Xtext 2.13.0
 */
grammar InternalAcl;

options {
	superClass=AbstractInternalAntlrParser;
}

@lexer::header {
package de.tum.ais.acl.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;
}

@parser::header {
package de.tum.ais.acl.parser.antlr.internal;

import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import de.tum.ais.acl.services.AclGrammarAccess;

}

@parser::members {

 	private AclGrammarAccess grammarAccess;

    public InternalAclParser(TokenStream input, AclGrammarAccess grammarAccess) {
        this(input);
        this.grammarAccess = grammarAccess;
        registerRules(grammarAccess.getGrammar());
    }

    @Override
    protected String getFirstRuleName() {
    	return "AclMessage";
   	}

   	@Override
   	protected AclGrammarAccess getGrammarAccess() {
   		return grammarAccess;
   	}

}

@rulecatch {
    catch (RecognitionException re) {
        recover(input,re);
        appendSkippedTokens();
    }
}

// Entry rule entryRuleAclMessage
entryRuleAclMessage returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getAclMessageRule()); }
	iv_ruleAclMessage=ruleAclMessage
	{ $current=$iv_ruleAclMessage.current; }
	EOF;

// Rule AclMessage
ruleAclMessage returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		(
			lv_name_0_0=RULE_ID
			{
				newLeafNode(lv_name_0_0, grammarAccess.getAclMessageAccess().getNameIDTerminalRuleCall_0());
			}
			{
				if ($current==null) {
					$current = createModelElement(grammarAccess.getAclMessageRule());
				}
				setWithLastConsumed(
					$current,
					"name",
					lv_name_0_0,
					"de.tum.ais.acl.Acl.ID");
			}
		)
	)
;

// Entry rule entryRuleStringExpression
entryRuleStringExpression returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getStringExpressionRule()); }
	iv_ruleStringExpression=ruleStringExpression
	{ $current=$iv_ruleStringExpression.current; }
	EOF;

// Rule StringExpression
ruleStringExpression returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		(
			lv_value_0_0=RULE_STRING
			{
				newLeafNode(lv_value_0_0, grammarAccess.getStringExpressionAccess().getValueSTRINGTerminalRuleCall_0());
			}
			{
				if ($current==null) {
					$current = createModelElement(grammarAccess.getStringExpressionRule());
				}
				setWithLastConsumed(
					$current,
					"value",
					lv_value_0_0,
					"de.tum.ais.acl.Acl.STRING");
			}
		)
	)
;

RULE_INTEGER : RULE_SIGN? RULE_DIGIT+;

RULE_FLOAT : (RULE_SIGN? RULE_FLOATMANTISSA RULE_FLOATEXPONENT?|RULE_SIGN? RULE_DIGIT+ RULE_FLOATEXPONENT);

fragment RULE_FLOATMANTISSA : (RULE_DIGIT+ '.' RULE_DIGIT+|RULE_DIGIT+ '.'|'.' RULE_DIGIT+);

fragment RULE_DIGIT : '0'..'9';

fragment RULE_FLOATEXPONENT : RULE_EXPONENT RULE_SIGN? RULE_DIGIT+;

fragment RULE_EXPONENT : ('e'|'E');

fragment RULE_SIGN : ('+'|'-');

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'|'\'' ('\\' .|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;
