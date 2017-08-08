package scriptor.additional.bundles {
	import robotlegs.bender.extensions.enhancedLogging.InjectableLoggerExtension;
	import robotlegs.bender.extensions.enhancedLogging.TraceLoggingExtension;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtension;
	import robotlegs.bender.extensions.eventDispatcher.EventDispatcherExtension;
	import robotlegs.bender.extensions.matching.instanceOfType;
	import robotlegs.bender.extensions.starlingMediatorMap.StarlingMediatorMapExtension;
	import robotlegs.bender.extensions.starlingViewManager.StarlingStageObserverExtension;
	import robotlegs.bender.extensions.starlingViewManager.StarlingViewManagerExtension;
	import robotlegs.bender.extensions.vigilance.VigilanceExtension;
	import robotlegs.bender.framework.api.IBundle;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;

	import scriptor.additional.api.IRootApplication;
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class DebugBundle implements IBundle {
		public function extend(context : IContext) : void {
			context.logLevel = LogLevel.DEBUG;

			context.install(
			// log tools
			TraceLoggingExtension, InjectableLoggerExtension,
			
			// Mediator map 
			StarlingViewManagerExtension, StarlingMediatorMapExtension, StarlingStageObserverExtension,
			
			// Errors
			VigilanceExtension,
				
			// Command map & modularity section 
			EventDispatcherExtension, EventCommandMapExtension);

			context.addConfigHandler(instanceOfType(IRootApplication), this.handleRootApp);
		}

		/**
		 * @private handles, when <code>Context</code> configures with stage
		 * @param value link to <code>Stage</code> object of application
		 */
		private function handleRootApp(app : IRootApplication) : void {
			app.context.getLogger(this).info("Mapping {0} as application root", [app]);
			app.context.injector.map(IRootApplication).toValue(app);
		}
	}
}