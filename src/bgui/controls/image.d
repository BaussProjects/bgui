module bgui.controls.image;

import dsfml.graphics;
import dsfml.system;
alias SFMLImage = dsfml.graphics.Image;

import bgui.control;
import bgui.point;
import bgui.space;
import bgui.sprite;

/**
*	Aliasing to avoid name conflicts.
*/
alias BSprite = bgui.sprite.Sprite;

/**
	Simple image wrapper class.
*/
class Image : Control {
private:
	/**
		The sprite.
	*/
	BSprite m_sprite;
public:
	/**
		Creates a new instance of Image.
	*/
	this(string name, string imageFile) {
		auto img = new SFMLImage();
		img.loadFromFile(imageFile);
		this(name, img);
	}
	/**
		Creates a new instance of Image.
	*/
	this(string name, SFMLImage img) {
		super(name);
		
		auto texture = new Texture();
		texture.loadFromImage(img);
		texture.setSmooth(true);
		
		m_sprite = new BSprite(texture);
		position = new Point(0, 0);
		auto imgSize = img.getSize();
		m_size = new Point(imgSize.x, imgSize.y);
	}
	
	/**
	*	Scales the image to fit a specific size.
	*	Note: This needs to set properties etc. too, which it currently doesn't...
	*/
	void scaleImage(Point size) {
		m_sprite.scale(Vector2f(size.x / m_size.x, size.y / m_size.y));
	}
	
	@property {
		/**
			Sets the position.
		*/
		override void position(Point newPosition) {
			m_position = newPosition;
			m_sprite.position = newPosition;
		}
	}
	
	/**
		Drawing the image to a sfml RenderWindow.
	*/
	override void draw(RenderWindow window) {
		window.draw(m_sprite);
		if (borderSingle)
			borderSingle.draw(window);
	}
}