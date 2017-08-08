package scriptor.examples.weather.core.config {
	import robotlegs.bender.framework.api.IContext;

	import scriptor.additional.api.IConfig;
	import scriptor.examples.weather.model.WeatherConfig;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class Injections {
		[Inject]
		public var context : IContext;
		/**
		 * @private
		 */
		private var _config : IConfig;

		[PostConstruct]
		public function setup() : void {
			this.context.injector.map(IConfig).toValue(this.config);
		}

		[PreDestroy]
		public function dispose() : void {
		}

		public function get config() : IConfig {
			return this._config ||= new WeatherConfig();
		}
	}
}