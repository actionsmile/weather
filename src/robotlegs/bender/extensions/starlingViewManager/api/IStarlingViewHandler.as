package robotlegs.bender.extensions.starlingViewManager.api {
	import starling.display.DisplayObject;
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IStarlingViewHandler {
		function handleView(view : DisplayObject, type : Class) : void;
	}
}
