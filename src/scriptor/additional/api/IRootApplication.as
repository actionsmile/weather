package scriptor.additional.api {
	import robotlegs.bender.framework.api.IContext;

	import org.osflash.signals.ISignal;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public interface IRootApplication extends IHaveView {
		function get addedToStage() : ISignal;

		function get context() : IContext;
	}
}