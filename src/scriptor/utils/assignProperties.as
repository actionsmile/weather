package scriptor.utils {
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public function assignProperties(object : Object, injection : Object) : void {
		for (var property : String in injection) {
			if (property in object) {
				if (typeof object[property] == "object" && !(object[property] is Array)) {
					assignProperties(object[property], injection[property]);
				} else {
					object[property] = injection[property];
				}
			}
		}
	}
}
