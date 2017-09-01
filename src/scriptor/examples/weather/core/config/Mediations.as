package scriptor.examples.weather.core.config {
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

	import scriptor.additional.view.starling.NullSprite;
	import scriptor.examples.weather.core.mediators.NullSpriteMediator;
	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public class Mediations {
		[Inject]
		public var mediatorMap : IMediatorMap;
		
		[PostConstruct]
		public function setup() : void {
			this.mediatorMap.	map(NullSprite).
								toMediator(NullSpriteMediator).
								autoRemove();
		}
		
		[PreDestroy]
		public function dispose() : void {
		}
	}
}