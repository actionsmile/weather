package scriptor.examples.weather {
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import scriptor.additional.api.IRootApplication;
	import scriptor.additional.bundles.DebugBundle;
	import scriptor.events.ApplicationEvent;
	import scriptor.examples.weather.core.config.Commands;
	import scriptor.examples.weather.core.config.Injections;
	import scriptor.examples.weather.core.config.Mediations;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class WeatherApp extends Sprite implements IRootApplication {
		/**
		 * @private
		 */
		private var _addedToStage : ISignal;
		/**
		 * @private
		 */
		private var _context : IContext;

		public function WeatherApp() {
			this.stage ? this.initialize() : this.addedToStage.addOnce(this.onStageAppear);
		}

		public function get addedToStage() : ISignal {
			return this._addedToStage ||= new NativeSignal(this, Event.ADDED_TO_STAGE);
		}

		public function get view() : DisplayObject {
			return this;
		}

		public function get context() : IContext {
			return this._context ||= new Context();
		}

		public function get contextDispatcher() : IEventDispatcher {
			return this.context.injector.getInstance(IEventDispatcher) as IEventDispatcher;
		}

		// Private
		/**
		 * @private App initialization
		 * @return void
		 */
		private function initialize() : void {

			this.context.
				install(DebugBundle).
				configure(Commands, Injections, Mediations).
				configure(this);

			this.context.initialized ? this.onContextReady() : this.context.initialize(this.onContextReady);
		}

		// Handles
		/**
		 * @eventType flash.events.Event.ADDED_TO_STAGE
		 * @return void
		 */
		private function onStageAppear(event : Event) : void {
			this.initialize();
		}

		/**
		 * @private <code>Context</code> initialized
		 * @return void
		 */
		private function onContextReady() : void {
			this.context.getLogger(this).info("Start app initialization");
			this.contextDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.INITIALIZE));
		}
	}
}