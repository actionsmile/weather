package robotlegs.bender.extensions.starlingViewManager.impl {
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingStageObserver {
		/**
		 * @private
		 */
		private var containerRegistry : ContainerRegistry;

		public function StarlingStageObserver(registry : ContainerRegistry) {
			this.containerRegistry = registry;
			this.containerRegistry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, this.onRootContainerAdd);
			this.containerRegistry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, this.onRootContainerRemove);
			// We might have arrived late on the scene
			for each (var binding : ContainerBinding in this.containerRegistry.rootBindings) {
				this.addRootListener(binding.container);
			}
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/
		/**
		 * @private
		 */
		public function dispose() : void {
			this.containerRegistry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, this.onRootContainerAdd);
			this.containerRegistry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, this.onRootContainerRemove);
			for each (var binding : ContainerBinding in this.containerRegistry.rootBindings) {
				this.removeRootListener(binding.container);
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		private function onRootContainerAdd(event : ContainerRegistryEvent) : void {
			this.addRootListener(event.container);
		}

		private function onRootContainerRemove(event : ContainerRegistryEvent) : void {
			this.removeRootListener(event.container);
		}

		private function addRootListener(container : DisplayObjectContainer) : void {
			container.addEventListener(Event.ADDED, this.onViewAddedToStage);
		}

		private function removeRootListener(container : DisplayObjectContainer) : void {
			container.removeEventListener(Event.ADDED, this.onViewAddedToStage);
		}

		private function onViewAddedToStage(event : Event) : void {
			const view : DisplayObject = event.target as DisplayObject;
			// Question: would it be worth caching QCNs by view in a weak dictionary,
			// to avoid getQualifiedClassName() cost?
			const type : Class = view['constructor'] as Class;
			// Walk upwards from the nearest binding
			var binding : ContainerBinding = this.containerRegistry.findParentBinding(view);
			while (binding) {
				binding.handleView(view, type);
				binding = binding.parent;
			}
		}
	}
}
