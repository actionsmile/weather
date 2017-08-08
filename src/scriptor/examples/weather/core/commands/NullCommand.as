package scriptor.examples.weather.core.commands {
	import robotlegs.bender.extensions.commandCenter.api.ICommand;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class NullCommand implements ICommand {
		public function execute() : void {
		}
	}
}