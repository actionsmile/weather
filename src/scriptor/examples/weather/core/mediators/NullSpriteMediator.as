package scriptor.examples.weather.core.mediators {
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.extensions.mediatorMap.api.IMediator;

	import scriptor.additional.view.starling.NullSprite;
	import scriptor.events.ApplicationEvent;

	import flash.events.IEventDispatcher;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class NullSpriteMediator implements IMediator {
		[Inject]
		public var sprite : NullSprite;

		[Inject]
		public var dispatcher : IEventDispatcher;
		
		[Inject]
		public var logger : ILogger;

		public function initialize() : void {
			this.dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.STARLING_INITED));
			this.logger.debug("Starling completly inited");

			this.destroy();
		}

		public function destroy() : void {
			this.sprite = null;
			this.dispatcher = null;
			this.logger = null;
		}
	}
}