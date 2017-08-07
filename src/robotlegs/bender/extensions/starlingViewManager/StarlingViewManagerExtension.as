package robotlegs.bender.extensions.starlingViewManager {
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewManager;
	import robotlegs.bender.extensions.starlingViewManager.impl.ContainerRegistry;
	import robotlegs.bender.extensions.starlingViewManager.impl.StarlingViewManager;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.IInjector;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingViewManagerExtension implements IExtension {
		/**
		 * @private
		 */
		private var _injector : IInjector;
		/**
		 * @private
		 */
		private var _containerRegistry : ContainerRegistry;
		/**
		 * @private
		 */
		private var _starlingViewManager : IStarlingViewManager;

		public function extend(context : IContext) : void {
			context.whenInitializing(whenInitializing);
			context.whenDestroying(whenDestroying);

			this._injector = context.injector;

			// Just one Container Registry

			this._injector.map(ContainerRegistry).toValue(this.containerRegistry);

			// But you get your own View Manager
			this._injector.map(IStarlingViewManager).toSingleton(StarlingViewManager);
		}

		public function get containerRegistry() : ContainerRegistry {
			return this._containerRegistry ||= new ContainerRegistry();
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		private function whenInitializing() : void {
			this._starlingViewManager = _injector.getInstance(IStarlingViewManager) as IStarlingViewManager;
		}

		private function whenDestroying() : void {
			this._starlingViewManager.removeAllHandlers();
			this._injector.unmap(IStarlingViewManager);
			this._injector.unmap(ContainerRegistry);
		}
	}
}