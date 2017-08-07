package scriptor.additional.model {
	import scriptor.additional.api.ICanInitialize;
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class ObjectInitializer implements ICanInitialize {
		public function initialize(source : Object) : void {
			for (var prop : String in source) {
				if (prop in this) {
					this[prop] is ICanInitialize ? (this[prop] as ICanInitialize).initialize(source[prop]) : this.saveValue(prop, source[prop]);
				} else {
					this.uncategorizedSave(prop, source[prop]);
				}
			}
		}

		protected function uncategorizedSave(prop : String, source : *) : void {
		}

		protected function saveValue(prop : String, value : *) : void {
			this[prop] = value;
		}
	}
}