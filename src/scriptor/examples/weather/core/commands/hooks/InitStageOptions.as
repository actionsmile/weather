package scriptor.examples.weather.core.commands.hooks {
	import robotlegs.bender.framework.api.IHook;

	import scriptor.additional.api.IRootApplication;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class InitStageOptions implements IHook {
		[Inject]
		public var app : IRootApplication;

		public function hook() : void {
			this.app.view.stage.align = StageAlign.TOP_LEFT;
			this.app.view.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.app.view.stage.showDefaultContextMenu = false;
			this.app.view.stage.frameRate = 60;
		}
	}
}