package robotlegs.bender.extensions.starlingViewManager {
	import robotlegs.bender.extensions.starlingViewManager.impl.ContainerRegistry;
	import robotlegs.bender.extensions.starlingViewManager.impl.StarlingStageObserver;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.LifecycleEvent;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingStageObserverExtension implements IExtension {
		/**
		 * @private
		 */
		private static var installs : uint;
		/**
		 * @private
		 */
		private var stageObserver : StarlingStageObserver;
		/**
		 * @private
		 */
		private var context : IContext;

		public function extend(extendableContext : IContext) : void {
			this.context = extendableContext;
			this.context.addEventListener(LifecycleEvent.INITIALIZE, this.onContextInit);
			this.context.addEventListener(LifecycleEvent.DESTROY, this.onContextDestroy);
			installs++;

		}

		private function onContextInit(event : LifecycleEvent) : void {
			if (!this.stageObserver) {
				var containerRegistry : ContainerRegistry = this.context.injector.getInstance(ContainerRegistry) as ContainerRegistry;
				this.context.getLogger(this).debug("Creating StarlingStageObserver");
				this.stageObserver = new StarlingStageObserver(containerRegistry);
				containerRegistry = null;
			}
		}

		private function onContextDestroy(event : LifecycleEvent) : void {
			installs--;
			if (installs == 0) {
				this.stageObserver.dispose();
				this.context.getLogger(this).debug("Disposing StarlingStageObserver");
				this.stageObserver = null;
				this.context.removeEventListener(LifecycleEvent.INITIALIZE, this.onContextInit);
				this.context.removeEventListener(LifecycleEvent.DESTROY, this.onContextDestroy);
				
				this.context = null;
			}
		}
	}
}
