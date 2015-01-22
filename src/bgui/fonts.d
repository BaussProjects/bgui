module bgui.fonts;

import dsfml.graphics.font;

/**
*	Collection of loaded fonts.
*/
private shared Font[string] loadedFonts;

/**
*	Loads a font and if the font is already loaded, retrieves it from the font collection.
*	Params:
*		fontFile =	The font file.
*	Returns: The loaded font.
*/
Font loadFont(string fontFile) {
	synchronized {
		auto fonts = cast(Font[string])loadedFonts;
		auto f = fonts.get(fontFile, null);
		if (!f) {
			f = new Font();
			f.loadFromFile(fontFile);
			fonts[fontFile] = f;
			loadedFonts = cast(shared(Font[string]))fonts;
			return f;
		}
		else
			return f;
	}
}