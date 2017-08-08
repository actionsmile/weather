package robotlegs.bender.extensions.starlingMediatorMap {
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.starlingMediatorMap.impl.StarlingMediatorMap;
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewManager;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.IInjector;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingMediatorMapExtension implements IExtension {
		/**
		 * @private
		 */
		private var _injector : IInjector;
		/**
		 * @private
		 */
		private var _starlingMediatorMap : StarlingMediatorMap;
		/**
		 * @private
		 */
		private var _starlingViewManager : IStarlingViewManager;

		public function extend(context : IContext) : void {
			context.
				beforeInitializing(this.beforeInitializing).
				beforeDestroying(this.beforeDestroying).
				whenDestroying(this.whenDestroying);

			this._injector = context.injector;
			this._injector.map(IMediatorMap).toSingleton(StarlingMediatorMap);
			
			context = null;
		}

		// Handlers
		private function beforeInitializing() : void {
			this._starlingMediatorMap = this._injector.getInstance(IMediatorMap) as StarlingMediatorMap;
			if(this._injector.satisfiesDirectly(IStarlingViewManager)) {
				this._starlingViewManager = this._injector.getInstance(IStarlingViewManager) as IStarlingViewManager;
				this._starlingViewManager.addViewHandler(this._starlingMediatorMap);
			}
		}

		private function beforeDestroying() : void {
			this._starlingMediatorMap.unmediateAll();
			if (_injector.satisfiesDirectly(IStarlingViewManager))
			{
				this._starlingViewManager = _injector.getInstance(IStarlingViewManager);
				this._starlingViewManager.removeViewHandler(this._starlingMediatorMap);
			}
		}

		private function whenDestroying() : void {
			this._injector.satisfiesDirectly(IMediatorMap) && this._injector.unmap(IMediatorMap);
			
			this._starlingMediatorMap = null;
			this._starlingViewManager = null;
			this._injector = null;
		}
	}
}
