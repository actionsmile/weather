package scriptor.additional.api {
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IDisposable {
		function create() : void;

		function dispose() : void;
	}
}