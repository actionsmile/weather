package scriptor.additional.api {
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface ICanInitialize {
		/**
		 * Initializes current object with provided source
		 * @param source often is JSON-object which represents 
		 */
		function initialize(source : Object) : void;
	}
}