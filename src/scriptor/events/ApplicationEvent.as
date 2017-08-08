package scriptor.events {
	import flash.events.Event;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class ApplicationEvent extends Event {
		public static const INITIALIZE : String = "application-initialize";
		public static const CONFIG_PARSED : String = "config-parsed";

		public function ApplicationEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}