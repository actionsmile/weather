package scriptor.examples.weather.core.commands {
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewManager;
	import robotlegs.bender.extensions.commandCenter.api.ICommand;

	import scriptor.additional.api.IRootApplication;
	import scriptor.examples.weather.model.api.IWeatherConfig;
	import scriptor.examples.weather.view.NullSprite;

	import starling.core.Starling;
	import starling.events.Event;

	import flash.geom.Rectangle;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class InitStarling implements ICommand {
		[Inject]
		public var config : IWeatherConfig;
		[Inject]
		public var app : IRootApplication;
		[Inject]
		public var starlingViewManager : IStarlingViewManager;
		[Inject]
		public var logger : ILogger;
		
		public function execute() : void {
			this.logger.debug("Initializing Starling");
			Starling.multitouchEnabled = true;
			
			var viewPort : Rectangle = new Rectangle(0, 0, this.app.view.stage.fullScreenWidth, this.app.view.stage.fullScreenHeight);
			var starling : Starling = new Starling(NullSprite, this.app.view.stage, viewPort);

			this.starlingViewManager.addContainer(starling.stage);
			starling.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated);

			CONFIG::DEBUG {
				starling.simulateMultitouch = true;
				starling.showStats = true;
			}

			viewPort = null;
			starling = null;

			this.starlingViewManager = null;
		}
		
		// Handlers
		private function onContextCreated(event : Event) : void {
			if (event.target is Starling) {
				this.logger.debug("Starling context created");
				var starling : Starling = event.target as Starling;
				starling.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated);
				starling.start();

				starling = null;
				this.dispose();
			}
		}

		private function dispose() : void {
			this.app = null;
			this.starlingViewManager = null;
			this.config = null;
			this.logger = null;
		}
	}
}