package robotlegs.bender.extensions.starlingViewManager.impl {
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewHandler;

	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingViewManagerEvent extends Event {
		public static const CONTAINER_ADD : String = 'containerAdd';
		public static const CONTAINER_REMOVE : String = 'containerRemove';
		public static const HANDLER_ADD : String = 'handlerAdd';
		public static const HANDLER_REMOVE : String = 'handlerRemove';
		/**
		 * @private
		 */
		private var _container : DisplayObjectContainer;
		/**
		 * @private
		 */
		private var _handler : IStarlingViewHandler;

		public function StarlingViewManagerEvent(type : String, container : DisplayObjectContainer = null, handler : IStarlingViewHandler = null) {
			super(type);
			this._container = container;
			this._handler = handler;
		}

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/
		/**
		 * The container associated with this event
		 */
		public function get container() : DisplayObjectContainer {
			return _container;
		}

		/**
		 * The view handler associated with this event
		 */
		public function get handler() : IStarlingViewHandler {
			return _handler;
		}
	}
}
