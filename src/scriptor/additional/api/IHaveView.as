package scriptor.additional.api {
	import flash.display.DisplayObject;
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IHaveView {
		/**
		 * Returns visual representation of current object
		 */
		function get view() : DisplayObject;
	}
}