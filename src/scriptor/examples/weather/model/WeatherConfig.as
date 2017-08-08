package scriptor.examples.weather.model {
	import scriptor.additional.api.IConfig;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class WeatherConfig implements IConfig {
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

		public function initialize(source : Object) : void {
		}

		public function get ready() : ISignal {
			return this._ready ||= new Signal();
		}
	}
}