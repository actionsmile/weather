package robotlegs.bender.extensions.starlingMediatorMap.impl {
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;

	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingMediatorManager {
		/**
		 * @private
		 */
		private static const CREATION_COMPLETE : String = "creationComplete";
		/**
		 * @private
		 */
		private var _factory : StarlingMediatorFactory;
		private const initialization : Array = ["preInitialize", "initialize", "postInitialize"];
		private const disposing : Array = ["preDestroy", "destroy", "postDestroy"];
		

		public function StarlingMediatorManager(factory : StarlingMediatorFactory) {
			this._factory = factory;
		}

		public function addMediator(mediator : Object, item : Object, mapping : IMediatorMapping) : void {
			const displayObject : DisplayObject = item as DisplayObject;

			// Watch Display Object for removal
			if (displayObject && mapping.autoRemoveEnabled)
				displayObject.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);

			// Synchronize with item life-cycle
			if (this.itemInitialized(item)) {
				this.initializeMediator(mediator);
			} else {
				displayObject.addEventListener(CREATION_COMPLETE, function(e : Event) : void {
					displayObject.removeEventListener(CREATION_COMPLETE, arguments["callee"]);
					// Ensure that we haven't been removed in the meantime
					if (_factory.getMediator(item, mapping) == mediator)
						initializeMediator(mediator);
				});
			}
		}

		public function removeMediator(mediator : Object, item : Object) : void {
			if (item is DisplayObject)
				DisplayObject(item).removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);

			if (itemInitialized(item))
				destroyMediator(mediator);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		private function onRemovedFromStage(event : Event) : void {
			this._factory.removeMediators(event.target);
		}

		private function itemInitialized(item : Object) : Boolean {
			if ("initialized" in item && !item['initialized'])
				return false;
			return true;
		}

		private function initializeMediator(mediator : Object) : void {
			this.rollSteps(mediator, this.initialization);
		}

		private function destroyMediator(mediator : Object) : void {
			this.rollSteps(mediator, this.disposing);
		}

		private function rollSteps(mediator : Object, steps : Array) : void {
			var func : Function;
			for each(var step : String in steps) {
				if (step in mediator) {
					func = mediator[step] as Function;
					func();
				}
			}
		}
	}
}
