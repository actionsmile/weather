package scriptor.utils {
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public function expandObject(object : Object, tabCount : uint = 0) : void {
		if(object) {
			var tab : String = "";
			trace("Expanding object", object);
			for (var i : int = 0; i < tabCount; i++) tab += "\t"; 
			for (var property : String in object) {
				typeof object[property] != "object" ? trace(tab + property + ": " + object[property]) : expandObject(object[property], tabCount++);
			}
		}
	}
}
