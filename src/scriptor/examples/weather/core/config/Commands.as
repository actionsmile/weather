package scriptor.examples.weather.core.config {
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	import scriptor.events.ApplicationEvent;
	import scriptor.examples.weather.core.commands.InitStarling;
	import scriptor.examples.weather.core.commands.NullCommand;
	import scriptor.examples.weather.core.commands.hooks.GetConfig;
	import scriptor.examples.weather.core.commands.hooks.InitStageOptions;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class Commands {
		[Inject]
		public var commandMap : IEventCommandMap;

		[PostConstruct]
		public function setup() : void {
			this.commandMap.	map(ApplicationEvent.INITIALIZE).
								toCommand(NullCommand).
								withHooks(InitStageOptions, GetConfig).
								once();
			
			this.commandMap.	map(ApplicationEvent.CONFIG_PARSED).
								toCommand(InitStarling).
								once();
		}

		[PreDestroy]
		public function dispose() : void {
			this.commandMap.unmap(ApplicationEvent.INITIALIZE).fromAll();

			this.commandMap = null;
		}
	}
}