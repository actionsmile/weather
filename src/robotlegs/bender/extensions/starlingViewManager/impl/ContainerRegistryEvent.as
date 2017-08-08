package robotlegs.bender.extensions.starlingViewManager.impl {
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class ContainerRegistryEvent extends Event {
		public static const CONTAINER_ADD : String = 'containerAdd';
		public static const CONTAINER_REMOVE : String = 'containerRemove';
		public static const ROOT_CONTAINER_ADD : String = 'rootContainerAdd';
		public static const ROOT_CONTAINER_REMOVE : String = 'rootContainerRemove';
		/**
		 * @private
		 */
		private var _container : DisplayObjectContainer;

		public function ContainerRegistryEvent(type : String, container : DisplayObjectContainer) {
			super(type);
			this._container = container;
		}

		public function get container() : DisplayObjectContainer {
			return this._container;
		}
	}
}
