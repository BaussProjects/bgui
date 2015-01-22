module bgui.controls.label;

import std.conv : to;

import dsfml.system;
import dsfml.window;
import dsfml.graphics;

import bgui.control;
import bgui.space;
import bgui.point;
import bgui.events;
import bgui.paint;

/**
*	A simple wrapper around the text class from dsfml.
*	This simplifies around text management, drawing, size and position.
*/
class Label : Control {
private:
	/**
	*	The text.
	*/
	Text m_text;
	
	/**
	*	The font.
	*/
	Font m_font;
	/**
	*	The character size.
	*/
	uint m_characterSize;
	/**
	*	The color.
	*/
	Paint m_paint;
	
public:
	/**
	*	Creates a new instance of Label.
	*	Params:
	*		name =			The name of the label.
	*		msg =			The text of the label.
	*		font =			The font of the label.
	*		characterSize =	The character size of the label.
	*/
	this(string name, string msg, Font font, uint characterSize = 14) {
		super(name);
		
		m_characterSize = characterSize;
		m_font = font;
		m_paint = white;
		text = msg;
	}
	
	/**
	*	Creates a new instance of Label.
	*	Params:
	*		name =			The name of the label.
	*		msg =			The text of the label.
	*		fontName =		The name of the font of the label.
	*		characterSize =	The character size of the label.
	*/
	this(string name, string msg, string fontName, uint characterSize = 14) {
		import bgui.fonts;
		this(name, msg, loadFont(fontName), characterSize);
	}
	
	@property {
		/**
		*	Gets the text.
		*/
		string text() {
			return to!string(m_text.getString());
		}
		
		/**
		*	Sets the text.
		*/
		void text(string value) {
			//if (!text || text == value) {
				m_text = new Text(to!dstring(value), m_font, m_characterSize);
				if (m_position)
					m_text.position = Vector2f(m_position.x, m_position.y);
				m_text.setColor(m_paint.toSfmlColor());
				auto size = m_text.getLocalBounds();
				m_size = new Point(cast(uint)size.width, cast(uint)size.height);
			//}
		}
		
		/**
		*	Sets the position.
		*/
		override void position(Point newPos) {
			m_position = newPos;
			m_text.position = Vector2f(newPos.x, newPos.y);
		}
		
		/**
		*	Gets the paint.
		*/
		Paint paint() {
			return m_paint;
		}
		
		/**
		*	Sets the paint.
		*/
		void paint(Paint newPaint) {
			m_paint = newPaint;
			m_text.setColor(m_paint.toSfmlColor());
		}
	}
	
	/**
	*	Draws the label to a sfml RenderWindow.
	*/
	override void draw(RenderWindow window) {
		window.draw(m_text);
	}
}