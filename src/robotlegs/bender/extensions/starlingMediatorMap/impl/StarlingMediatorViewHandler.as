package robotlegs.bender.extensions.starlingMediatorMap.impl {
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewHandler;

	import starling.display.DisplayObject;

	import flash.utils.Dictionary;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingMediatorViewHandler implements IStarlingViewHandler {
		/**
		 * @private
		 */
		private var _factory : StarlingMediatorFactory;
		/**
		 * @private
		 */
		private var _knownMappings : Dictionary;
		/**
		 * @private
		 */
		private var _mappings : Array;

		public function StarlingMediatorViewHandler(factory : StarlingMediatorFactory) {
			this._factory = factory;
		}

		public function get knownMappings() : Dictionary {
			return this._knownMappings ||= new Dictionary(true);
		}

		public function get mappings() : Array {
			return this._mappings ||= [];
		}

		public function get factory() : StarlingMediatorFactory {
			return this._factory;
		}

		/**
		 * @private
		 */
		public function addMapping(mapping : IMediatorMapping) : void {
			const index : int = this.mappings.indexOf(mapping);
			if (index > -1)
				return;
			this.mappings.push(mapping);
			flushCache();
		}

		/**
		 * @private
		 */
		public function removeMapping(mapping : IMediatorMapping) : void {
			const index : int = this.mappings.indexOf(mapping);
			if (index == -1)
				return;
			this.mappings.splice(index, 1);
			flushCache();
		}

		public function handleView(view : DisplayObject, type : Class) : void {
			const interestedMappings : Array = getInterestedMappingsFor(view, type);
			if (interestedMappings) {
				this.factory.createMediators(view, type, interestedMappings);
			}
		}

		/**
		 * @private
		 */
		public function handleItem(item : Object, type : Class) : void {
			const interestedMappings : Array = getInterestedMappingsFor(item, type);
			if (interestedMappings) {
				this.factory.createMediators(item, type, interestedMappings);
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		private function flushCache() : void {
			this._knownMappings = new Dictionary(true);
		}

		private function getInterestedMappingsFor(item : Object, type : Class) : Array {
			var mapping : IMediatorMapping;

			// we've seen this type before and nobody was interested
			if (this.knownMappings[type] === false)
				return null;

			// we haven't seen this type before
			if (this.knownMappings[type] == undefined) {
				this.knownMappings[type] = false;
				for each (mapping in this.mappings) {
					if (mapping.matcher.matches(item)) {
						var array : Array = this.knownMappings[type] ? this.knownMappings[type] : [];
						array.push(mapping);
						this.knownMappings[type] = array;
						array = null;
					}
				}
				// nobody cares, let's get out of here
				if (this.knownMappings[type] === false)
					return null;
			}

			// these mappings really do care
			return this.knownMappings[type] as Array;
		}
	}
}
