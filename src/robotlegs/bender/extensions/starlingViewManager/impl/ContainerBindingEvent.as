package robotlegs.bender.extensions.starlingViewManager.impl {
	import starling.events.Event;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class ContainerBindingEvent extends Event {
		public static const BINDING_EMPTY : String = 'bindingEmpty';

		public function ContainerBindingEvent(type : String) {
			super(type);
		}
	}
}
