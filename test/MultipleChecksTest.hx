package ;

class MultipleChecksTest {

	var _arr1:Array;
	var _arr2:Array;

	var _clr:Int;

	var _regExp:EReg;

	// variable instantiation check
	var _a:Int = 2;

	// variable naming check
	var b:Int;

	// public variable naming check
	public var _c:Int;

	public function new() {
		_arr1 = new Array();
		_arr2 = [];

		_clr = 0xffffff;

		_regExp = ~/[a-z]/;
		_regExp = new EReg("haxe", "i");
	}

	function _emptyLines() {
		trace("TEST");


		trace("TEST");
	}

	// override check
	public override function execute() {
		trace("TEST");
	}

	// Void check
	function _test():Void {
		trace("TEST");
	}
}