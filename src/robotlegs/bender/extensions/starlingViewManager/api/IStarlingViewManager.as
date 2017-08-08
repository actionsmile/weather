package robotlegs.bender.extensions.starlingViewManager.api {
	import starling.display.DisplayObjectContainer;
	import starling.events.IEventDispatcher;

	[Event(name="containerAdd", type="robotlegs.bender.extensions.starlingViewManager.impl.StarlingViewManagerEvent")]
	[Event(name="containerRemove", type="robotlegs.bender.extensions.starlingViewManager.impl.StarlingViewManagerEvent")]
	[Event(name="handlerAdd", type="robotlegs.bender.extensions.starlingViewManager.impl.StarlingViewManagerEvent")]
	[Event(name="handlerRemove", type="robotlegs.bender.extensions.starlingViewManager.impl.StarlingViewManagerEvent")]
	
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IStarlingViewManager extends IEventDispatcher {
		function addContainer(container : DisplayObjectContainer) : void;

		function addViewHandler(handler : IStarlingViewHandler) : void;

		function get containers() : Vector.<DisplayObjectContainer>;

		function removeAllHandlers() : void;

		function removeContainer(container : DisplayObjectContainer) : void;

		function removeViewHandler(handler : IStarlingViewHandler) : void;
	}
}
