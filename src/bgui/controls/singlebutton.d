module bgui.controls.singlebutton;

import dsfml.graphics;
import dsfml.window : Mouse;

import bgui.control;
import bgui.events;
import bgui.point;
import bgui.paint;
import bgui.controls.label;

/**
*	A single border button control.
*/
class SingleButton : Control {
private:
	/**
	*	The button text.
	*/
	Label m_text;
	
	/**
	*	The paint of the button.
	*/
	Paint m_paint;
	
	/**
	*	The color rectangle of the button.
	*/
	RectangleShape m_rect;
	
	/**
	*	Boolean determining whether the button is pressed or not.
	*/
	bool pressing = false;
	/**
	*	Boolean determining whether the button has an intersection with a point.
	*/
	bool intersecting = false;
	
	/**
	*	The handler for mouse pressing.
	*	Params:
	*		button =	The mouse button.
	*/
	void handleMousePressed(Mouse.Button button) {
		pressing = true;
	}
	
	/**
	*	The handler for mouse releasing.
	*	Params:
	*		button =	The mouse button.
	*/
	void handleMouseReleased(Mouse.Button button) {
		if (button == Mouse.Button.Left) {
			if (intersecting) {
				if (onClick)
					onClick.exec();
			}
		}
		pressing = false;
	}
	
	/**
	*	The handler for mouse movement.
	*	Params:
	*		position =	The position of the mouse.
	*/
	void handleMouseMoved(Point position){
		intersecting = intersect(position);
	}
public:
	/**
	*	Creates a new instance of Button.
	*	Params:
	*		name =			The name of the button.
	*		text =			The text of the button.
	*		fontName =		The font name of the text.
	*		characterSize =	The character size of the text.
	*/
	this(string name, string text, string fontName, uint characterSize = 14) {
		import bgui.fonts;
		this(name, text, loadFont(fontName), characterSize);
	}
	
	/**
	*	Creates a new instance of Button.
	*	Params:
	*		name =			The name of the button.
	*		text =			The text of the button.
	*		font =			The font of the text.
	*		characterSize =	The character size of the text.
	*/
	this(string name, string text, Font font, uint characterSize = 14) {
		super(name);
		
		m_text = new Label("m_text", text, font, characterSize);
		m_text.position = new Point(0,0);
		//size = new Point(m_text.width + 4, m_text.height + 4);
		
		mousePressed = new EventAction!(Mouse.Button)(&handleMousePressed);
		mouseReleased = new EventAction!(Mouse.Button)(&handleMouseReleased);
		mouseMoved = new EventAction!(Point)(&handleMouseMoved);
	}
	
	@property {
		/**
		*	Sets the position of the button.
		*/
		override void position(Point newPosition) {
			m_text.position = new Point(
				(super.width / 2) - (m_text.width / 2),
				(super.height / 2) - (m_text.height / 2)
			);
			m_rect.position = Vector2f(m_position.x, m_position.y);
			m_position = newPosition;
		}
		
		override void size(Point newSize) {
			m_size = newSize;
			m_rect = new RectangleShape(Vector2f(newSize.x + 1, newSize.y + 1));
			m_rect.fillColor = m_paint.toSfmlColor();
			position = m_position;
		}
		
		Paint paint() { return m_paint; }
		void paint(Paint newPaint) {
			m_paint = newPaint;
		}
	}
	
	/**
	*	The event to trigger when the image button is clicked.
	*/
	Action onClick;
	
	/**
		Drawing the image to a sfml RenderWindow.
	*/
	override void draw(RenderWindow window) {
		window.draw(m_rect);
		m_text.draw(window);
		if (borderSingle)
			borderSingle.draw(window);
	}
}