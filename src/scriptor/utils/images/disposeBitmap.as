package scriptor.utils.images {
	import flash.display.Bitmap;

	/**
	 * @author Aziz Zainutdin (aloha at scriptor.me)
	 */
	public function disposeBitmap(bitmap : Bitmap) : void {
		if (bitmap) {
			bitmap.parent && bitmap.parent.removeChild(bitmap);
			bitmap.bitmapData && bitmap.bitmapData.dispose();
			bitmap = null;
		}
	}
}
