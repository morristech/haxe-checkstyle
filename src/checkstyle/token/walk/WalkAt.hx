package checkstyle.token.walk;

import checkstyle.token.TokenStream;
import checkstyle.token.TokenTree;

class WalkAt {
	/**
	 * At
	 *  |- DblDot
	 *      |- Const(CIdent)
	 *          |- POpen
	 *              |- expression
	 *              |- PClose
	 *
	 * At
	 *  |- DblDot
	 *      |- Const(CIdent)
	 *
	 * At
	 *  |- Const(CIdent)
	 *      |- POpen
	 *          |- expression
	 *          |- PClose
	 *
	 * At
	 *  |- Const(CIdent)
	 *
	 */
	public static function walkAt(stream:TokenStream):TokenTree {
		var atTok:TokenTree = stream.consumeTokenDef(At);
		var parent:TokenTree = atTok;
		if (stream.is(DblDot)) {
			var dblDot:TokenTree = stream.consumeTokenDef(DblDot);
			atTok.addChild(dblDot);
			parent = dblDot;
		}
		var name:TokenTree;
		switch (stream.token()) {
			case Const(_):
				name = stream.consumeConstIdent();
			default:
				name = stream.consumeToken();
		}
		parent.addChild(name);
		if (stream.is(POpen)) WalkPOpen.walkPOpen(stream, name);
		return atTok;
	}
}