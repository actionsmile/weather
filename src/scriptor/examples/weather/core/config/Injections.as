package scriptor.examples.weather.core.config {
	import robotlegs.bender.framework.api.IContext;

	import scriptor.examples.weather.model.api.IWeatherConfig;
	import scriptor.examples.weather.model.impl.WeatherConfig;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class Injections {
		[Inject]
		public var context : IContext;
		/**
		 * @private
		 */
		private var _config : IWeatherConfig;

		[PostConstruct]
		public function setup() : void {
			this.context.injector.map(IWeatherConfig).toValue(this.config);
		}

		[PreDestroy]
		public function dispose() : void {
			this.context.injector.unmap(IWeatherConfig);
			
			this.config.dispose();
			this._config = null;
		}

		public function get config() : IWeatherConfig {
			return this._config ||= new WeatherConfig();
		}
	}
}