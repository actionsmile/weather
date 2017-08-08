package robotlegs.bender.extensions.starlingMediatorMap.impl {
	import robotlegs.bender.extensions.matching.ITypeMatcher;
	import robotlegs.bender.extensions.matching.TypeMatcher;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorUnmapper;
	import robotlegs.bender.extensions.mediatorMap.impl.NullMediatorUnmapper;
	import robotlegs.bender.extensions.starlingViewManager.api.IStarlingViewHandler;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogger;

	import starling.display.DisplayObject;

	import flash.utils.Dictionary;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class StarlingMediatorMap implements IMediatorMap, IStarlingViewHandler {
		/**
		 * @private
		 */
		private var _logger : ILogger;
		/**
		 * @private
		 */
		private var _mappers : Dictionary;
		/**
		 * @private
		 */
		private var _factory : StarlingMediatorFactory;
		/**
		 * @private
		 */
		private var _starlingViewHandler : StarlingMediatorViewHandler;
		/**
		 * @private
		 */
		private const NULL_UNMAPPER:IMediatorUnmapper = new NullMediatorUnmapper();

		public function StarlingMediatorMap(context : IContext) {
			this._logger = context.getLogger(this);
			this._factory = new StarlingMediatorFactory(context.injector);
		}

		public function unmediateAll() : void {
			this.factory.removeAllMediators();
		}

		public function handleView(view : DisplayObject, type : Class) : void {
			this.starlingViewHandler.handleView(view, type);
		}

		public function map(type : Class) : IMediatorMapper {
			return this.mapMatcher(new TypeMatcher().allOf(type));
		}

		public function mapMatcher(matcher : ITypeMatcher) : IMediatorMapper {
			return this.mappers[matcher.createTypeFilter().descriptor] ||= this.createMapper(matcher);
		}

		public function mediate(item : Object) : void {
			this.starlingViewHandler.handleItem(item, item['constructor'] as Class);
		}

		public function unmap(type : Class) : IMediatorUnmapper {
			return this.unmapMatcher(new TypeMatcher().allOf(type));
		}

		public function unmapMatcher(matcher : ITypeMatcher) : IMediatorUnmapper {
			return this.mappers[matcher.createTypeFilter().descriptor] || NULL_UNMAPPER;
		}

		public function unmediate(item : Object) : void {
			this.factory.removeMediators(item);
		}

		public function get logger() : ILogger {
			return this._logger;
		}

		public function get mappers() : Dictionary {
			return this._mappers ||= new Dictionary();
		}

		public function get factory() : StarlingMediatorFactory {
			return this._factory;
		}

		public function get starlingViewHandler() : StarlingMediatorViewHandler {
			return this._starlingViewHandler ||= new StarlingMediatorViewHandler(this.factory);
		}
		
		private function createMapper(matcher : ITypeMatcher) : IMediatorMapper {
			return new StarlingMediatorMapper(matcher.createTypeFilter(), this.starlingViewHandler, this.logger);
		}
	}
}
