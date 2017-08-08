package scriptor.examples.weather.core.commands.hooks {
	import robotlegs.bender.framework.api.IHook;
	import robotlegs.bender.framework.api.ILogger;

	import scriptor.additional.api.IConfig;
	import scriptor.additional.enums.FolderNames;
	import scriptor.events.ApplicationEvent;

	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class GetConfig implements IHook {
		[Inject]
		public var logger : ILogger;

		[Inject]
		public var dispatcher : IEventDispatcher;

		[Inject]
		public var config : IConfig;
		/**
		 * @private
		 */
		private var _stream : FileStream;
		/**
		 * @private
		 */
		private var _source : Object;

		public function hook() : void {
			var configFolder : File = File.applicationDirectory.resolvePath(FolderNames.CONFIG);
			this.logger.debug("Searching for config in '{0}' folder", [configFolder.nativePath]);
			configFolder.exists && configFolder.isDirectory && configFolder.getDirectoryListing().forEach(this.parseFile);

			configFolder = null;
			this._stream = null;

			this.config.ready.addOnce(this.onConfigReady);
			this.config.initialize(this._source);
		}

		private function onConfigReady() : void {
			this.dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.CONFIG_PARSED));
			this.dispatcher = null;
			this.logger = null;
			this.config = null;
			this._source = null;
		}

		private function parseFile(file : File, ...rest) : void {
			if (!file.isDirectory) {
				var configString : String;
				var current : Object;
				this._stream ||= new FileStream();
				this._source ||= {};
				this._stream.open(file, FileMode.READ);
				configString = this._stream.readUTFBytes(this._stream.bytesAvailable);
				this._stream.close();

				current = JSON.parse(configString);
				configString = file.name.split(".")[0];
				this.logger.debug("Config '{0}' parsed and saved to model as '{1}'", [file.name, configString]);
				this._source[configString] = current;
			} else {
				file.getDirectoryListing().forEach(this.parseFile);
			}
			current = null;
			configString = null;
		}
	}
}