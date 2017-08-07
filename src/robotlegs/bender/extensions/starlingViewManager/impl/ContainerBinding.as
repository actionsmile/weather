package robotlegs.bender.extensions.starlingViewManager.impl {
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewHandler;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.EventDispatcher;

	[Event(name="bindingEmpty", type="robotlegs.bender.extensions.starlingViewManager.impl.ContainerBindingEvent")]
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class ContainerBinding extends EventDispatcher {
		/**
		 * @private
		 */
		private var _parent : ContainerBinding;
		/**
		 * @private
		 */
		private var _container : DisplayObjectContainer;
		/**
		 * @private
		 */
		private var _handlers : Vector.<IStarlingViewHandler>;

		public function ContainerBinding(container : DisplayObjectContainer) {
			this._container = container;
		}

		public function get parent() : ContainerBinding {
			return this._parent;
		}

		public function set parent(value : ContainerBinding) : void {
			if (this._parent != value) this._parent = value;
		}

		public function get container() : DisplayObjectContainer {
			return this._container;
		}

		public function get handlers() : Vector.<IStarlingViewHandler> {
			return this._handlers ||= new Vector.<IStarlingViewHandler>();
		}

		public function addHandler(handler : IStarlingViewHandler) : void {
			this.handlers.indexOf(handler) == -1 && this.handlers.push(handler);
		}

		public function removeHandler(handler : IStarlingViewHandler) : void {
			const index : int = this.handlers.indexOf(handler);
			index > -1 && this.handlers.splice(index, 1);
			this.handlers.length == 0 && this.dispatchEvent(new ContainerBindingEvent(ContainerBindingEvent.BINDING_EMPTY));
		}

		public function handleView(view : DisplayObject, type : Class) : void {
			const length : uint = this.handlers.length;
			for (var i : int = 0; i < length; i++) {
				var handler : IStarlingViewHandler = this.handlers[i] as IStarlingViewHandler;
				handler.handleView(view, type);
			}
		}
	}
}
