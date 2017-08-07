package scriptor.additional.api {
	import org.osflash.signals.ISignal;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IAppConfig extends ICanInitialize {
		/**
		 * Provides an instance of <code>ISignal</code>, which is dispatched, when config is ready
		 */
		function get ready() : ISignal;
	}
}