package scriptor.additional.api {
	import starling.display.DisplayObject;
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IHaveStarlingView {
		/**
		 * Returns visual representation of current object
		 */
		function get view() : DisplayObject;

		function get width() : Number;

		function get height() : Number;
	}
}