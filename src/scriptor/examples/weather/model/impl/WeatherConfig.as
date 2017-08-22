package scriptor.examples.weather.model.impl {
	import scriptor.additional.model.ObjectInitializer;
	import scriptor.examples.weather.model.api.IWeatherConfig;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class WeatherConfig extends ObjectInitializer implements IWeatherConfig {
		/**
		 * @private
		 */
		private var _ready : ISignal;
		/**
		 * @private
		 */
		private var isCreated : Boolean;

		public function create() : void {
			if (!this.isCreated) {
				this.isCreated = true;
			}
		}

		public function dispose() : void {
			if (this.isCreated) {
				this.ready.removeAll();
				this._ready = null;

				this.isCreated = false;
			}
		}

		override public function initialize(source : Object) : void {
			super.initialize(source);
			this.ready.dispatch();
		}

		public function get ready() : ISignal {
			return this._ready ||= new Signal();
		}

		public function configure() : void {
		}
	}
}