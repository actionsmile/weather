package scriptor.additional.api {
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IDisposable {
		/**
		 * Creates object, if not created yet
		 * @return void
		 * @see #dispose
		 */
		function create() : void;
		
		/**
		 * Prepare object to remove from memory, if it already created
		 * @return void
		 * @see #create()
		 */
		function dispose() : void;
	}
}