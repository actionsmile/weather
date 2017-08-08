package robotlegs.bender.extensions.starlingMediatorMap.impl {
	import robotlegs.bender.extensions.matching.ITypeFilter;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorConfigurator;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorUnmapper;
	import robotlegs.bender.extensions.mediatorMap.impl.MediatorMapping;
	import robotlegs.bender.framework.api.ILogger;

	import flash.utils.Dictionary;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingMediatorMapper implements IMediatorMapper, IMediatorUnmapper {
		/**
		 * @private
		 */
		private var _typeFilter : ITypeFilter;
		/**
		 * @private
		 */
		private var _handler : StarlingMediatorViewHandler;
		/**
		 * @private
		 */
		private var _logger : ILogger;
		/**
		 * @private
		 */
		private var _mappings : Dictionary;

		public function StarlingMediatorMapper(typeFilter : ITypeFilter, handler : StarlingMediatorViewHandler, logger : ILogger = null) {
			this._typeFilter = typeFilter;
			this._handler = handler;
			this._logger = logger;
		}

		public function toMediator(mediatorClass : Class) : IMediatorConfigurator {
			const mapping : IMediatorMapping = this.mappings[mediatorClass];
			return mapping ? this.overwriteMapping(mapping) : this.createMapping(mediatorClass);
		}

		public function fromMediator(mediatorClass : Class) : void {
			const mapping : IMediatorMapping = this.mappings[mediatorClass];
			mapping && this.deleteMapping(mapping);
		}

		public function fromAll() : void {
			for each (var mapping : IMediatorMapping in this.mappings) {
				this.deleteMapping(mapping);
			}
		}

		public function get mappings() : Dictionary {
			return this._mappings ||= new Dictionary();
		}
		
		public function get handler() : StarlingMediatorViewHandler {
			return this._handler;
		}
		
		public function get logger() : ILogger {
			return this._logger;
		}
		
		private function createMapping(mediatorClass:Class) : MediatorMapping {
			const mapping:MediatorMapping = new MediatorMapping(_typeFilter, mediatorClass);
			this.handler.addMapping(mapping);
			this.mappings[mediatorClass] = mapping;
			this.logger && this.logger.debug('{0} mapped to {1}', [_typeFilter, mapping.mediatorClass]);
			return mapping;
		}

		private function deleteMapping(mapping:IMediatorMapping) : void {
			this.handler.removeMapping(mapping);
			delete this.mappings[mapping.mediatorClass];
			this.logger && this.logger.debug('{0} unmapped from {1}', [_typeFilter, mapping]);
		}

		private function overwriteMapping(mapping : IMediatorMapping) : IMediatorConfigurator {
			this.logger && this.logger.warn(
				'{0} already mapped to {1}\n' +
				'If you have overridden this mapping intentionally you can use "unmap()" ' +
				'prior to your replacement mapping in order to avoid seeing this message.\n', [_typeFilter, mapping]);
			this.deleteMapping(mapping);
			return this.createMapping(mapping.mediatorClass);
		}
	}
}
