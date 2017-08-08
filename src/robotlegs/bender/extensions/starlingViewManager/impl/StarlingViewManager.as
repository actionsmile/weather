package robotlegs.bender.extensions.starlingViewManager.impl {
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewHandler;
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewManager;

	import starling.display.DisplayObjectContainer;
	import starling.events.EventDispatcher;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingViewManager extends EventDispatcher implements IStarlingViewManager {
		/**
		 * @private
		 */
		private var _containers : Vector.<DisplayObjectContainer>;
		/**
		 * @private
		 */
		private var _registry : ContainerRegistry;
		/**
		 * @private
		 */
		private var _handlers : Vector.<IStarlingViewHandler>;

		public function StarlingViewManager(containerRegistry : ContainerRegistry) {
			this._registry = containerRegistry;
		}

		public function get containers() : Vector.<DisplayObjectContainer> {
			return this._containers ||= new Vector.<DisplayObjectContainer>();
		}

		public function get registry() : ContainerRegistry {
			return this._registry;
		}

		public function get handlers() : Vector.<IStarlingViewHandler> {
			return this._handlers ||= new Vector.<IStarlingViewHandler>();
		}

		/**
		 * @inheritDoc
		 */
		public function addContainer(container : DisplayObjectContainer) : void {
			if (!this.validContainer(container))
				return;

			this.containers.push(container);

			for each (var handler : IStarlingViewHandler in this.handlers) {
				this.registry.addContainer(container).addHandler(handler);
			}
			this.dispatchEvent(new StarlingViewManagerEvent(StarlingViewManagerEvent.CONTAINER_ADD, container));
		}

		/**
		 * @inheritDoc
		 */
		public function removeContainer(container : DisplayObjectContainer) : void {
			const index : int = this.containers.indexOf(container);
			index > -1 && this.containers.splice(index, 1);

			const binding : ContainerBinding = this.registry.getBinding(container);
			for each (var handler : IStarlingViewHandler in this.handlers) {
				binding.removeHandler(handler);
			}
			this.dispatchEvent(new StarlingViewManagerEvent(StarlingViewManagerEvent.CONTAINER_REMOVE, container));
		}

		/**
		 * @inheritDoc
		 */
		public function addViewHandler(handler : IStarlingViewHandler) : void {
			if (this.handlers.indexOf(handler) != -1)
				return;

			this.handlers.push(handler);

			for each (var container : DisplayObjectContainer in this.containers) {
				this.registry.addContainer(container).addHandler(handler);
			}
			this.dispatchEvent(new StarlingViewManagerEvent(StarlingViewManagerEvent.HANDLER_ADD, null, handler));
		}

		/**
		 * @inheritDoc
		 */
		public function removeViewHandler(handler : IStarlingViewHandler) : void {
			const index : int = this.handlers.indexOf(handler);
			if (index == -1)
				return;

			this.handlers.splice(index, 1);

			for each (var container : DisplayObjectContainer in this.containers) {
				this.registry.getBinding(container).removeHandler(handler);
			}
			this.dispatchEvent(new StarlingViewManagerEvent(StarlingViewManagerEvent.HANDLER_REMOVE, null, handler));
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllHandlers() : void {
			for each (var container : DisplayObjectContainer in this.containers) {
				const binding : ContainerBinding = this.registry.getBinding(container);
				for each (var handler : IStarlingViewHandler in this.handlers) {
					binding.removeHandler(handler);
				}
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		private function validContainer(container : DisplayObjectContainer) : Boolean {
			for each (var registeredContainer : DisplayObjectContainer in this.containers) {
				if (container == registeredContainer)
					return false;

				if (registeredContainer.contains(container) || container.contains(registeredContainer))
					throw new Error("Containers can not be nested");
			}
			return true;
		}
	}
}
