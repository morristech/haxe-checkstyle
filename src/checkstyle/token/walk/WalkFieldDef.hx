package checkstyle.token.walk;

import checkstyle.token.TokenStream;
import checkstyle.token.TokenStreamProgress;
import checkstyle.token.TokenTree;

class WalkFieldDef {

	public static function walkFieldDef(stream:TokenStream, parent:TokenTree) {
		var tempStore:Array<TokenTree> = [];
		var progress:TokenStreamProgress = new TokenStreamProgress(stream);
		while (progress.streamHasChanged()) {
			switch (stream.token()) {
				case Kwd(KwdVar), Kwd(KwdFunction):
					var tok:TokenTree = stream.consumeToken();
					parent.addChild(tok);
					parent = tok;
				case At:
					tempStore.push(WalkAt.walkAt(stream));
				default:
					break;
			}
		}

		var name:TokenTree = WalkTypeNameDef.walkTypeNameDef(stream, parent);
		for (tok in tempStore) {
			name.addChild(tok);
		}

		if (stream.is(DblDot)) {
			var dblDot:TokenTree = stream.consumeTokenDef(DblDot);
			name.addChild(dblDot);
			WalkTypedefBody.walkTypedefBody(stream, dblDot);
		}
		if (stream.is(Binop(OpAssign))) {
			WalkStatement.walkStatement(stream, name);
		}
		switch (stream.token()) {
			case Comma:
				name.addChild(stream.consumeTokenDef(Comma));
			case Semicolon:
				name.addChild(stream.consumeTokenDef(Semicolon));
			default:
		}
	}
}