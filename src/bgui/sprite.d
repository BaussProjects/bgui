module bgui.sprite;

import dsfml.graphics;
alias SFMLSprite = dsfml.graphics.Sprite;

import dsfml.system;

import bgui.point;

/**
	The sprite class which inherits the sfml sprite class, the sprite class lacks proper position wrapping.
*/
class Sprite : SFMLSprite {
private:
	/**
	*	The position.
	*/
	Point m_position;
public:
	/**
	*	Creates a new instance of Sprite.
	*	Params:
	*		texture =	The texture of the sprite.
	*/
	this(Texture texture) {
		super(texture);
	}
	
	@property {
		/**
		*	Gets the position.
		*/
		Point position() {
			return m_position;
		}
		
		/**
		*	Sets the position.
		*/
		void position(Point value) {
			m_position = value;
			super.position = Vector2f(value.x, value.y);
		}
	}
}