package checkstyle.checks.literal;

import checkstyle.utils.ExprUtils;
import haxe.macro.Expr;
import checkstyle.LintMessage.SeverityLevel;
import haxeparser.Data.Token;

@name("ERegLiteral", "ERegInstantiation")
@desc("Checks for usage of EReg literals (between ~/ and /) instead of new")
class ERegLiteralCheck extends Check {

	override function actualRun() {
		ExprUtils.walkFile(checker.ast, function(e:Expr) {
			if (isPosSuppressed(e.pos)) return;
			switch (e.expr){
				case ENew(
					{pack:[], name:"EReg"},
					[{expr:EConst(CString(re)), pos:_}, {expr:EConst(CString(opt)), pos:_}]
				):
					if (~/\$\{.+\}/.match(re)) return;
					logPos('Bad EReg instantiation, define expression between ~/ and /', e.pos, severity);
				default:
			}
		});
	}
}