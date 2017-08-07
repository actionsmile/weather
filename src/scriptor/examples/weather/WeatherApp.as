package scriptor.examples.weather {
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import scriptor.additional.api.IDisposable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class WeatherApp extends Sprite implements IDisposable {
		/**
		 * @private
		 */
		private var _onAddedToStage : ISignal;
		/**
		 * @private
		 */
		private var isCreated : Boolean;
		/**
		 * @private
		 */
		private var _context : IContext;

		public function WeatherApp() {
			this.stage ? this.create() : this.onAddedToStage.addOnce(this.onStageAppear);
		}

		public function get onAddedToStage() : ISignal {
			return this._onAddedToStage ||= new NativeSignal(this, Event.ADDED_TO_STAGE);
		}

		/**
		 * @inheritDoc
		 */
		public function create() : void {
			if (!this.isCreated) {
				this.initContext();
				this.isCreated = true;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function dispose() : void {
			if (this.isCreated) {
				this.isCreated = false;
			}
		}

		public function get context() : IContext {
			return this._context ||= new Context();
		}

		// Handles
		/**
		 * @eventType flash.events.Event.ADDED_TO_STAGE
		 * @return void
		 */
		private function onStageAppear(event : Event) : void {
		}

		// Private
		/**
		 * Init Robotlegs context with basic configs
		 * @return void
		 */
		private function initContext() : void {
		}
	}
}