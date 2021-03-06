module bgui.controls.fancybutton;

import dsfml.graphics;

import dsfml.window : Mouse;

import bgui.control;
import bgui.events;
import bgui.point;
import bgui.space;
import bgui.paint;
import bgui.controls.image;
alias BImage = bgui.controls.image.Image;

/**
*	A fancy button control.
*/
class FancyButton : Control {
private:
	/**
	*	The normal image display.
	*/
	BImage m_normalImage;
	/**
	*	The click image display.
	*/
	BImage m_clickImage;
	/**
	*	The hover image display.
	*/
	BImage m_hoverImage;
	
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
	*		normalImage =	The normal image display.
	*		clickImage =	The click image display.
	*		hoverImage =	The hover image display.
	*/
	this(string name, BImage normalImage, BImage clickImage, BImage hoverImage) {
		super(name);
		
		m_normalImage = normalImage;
		m_clickImage = clickImage;
		m_hoverImage = hoverImage;
		m_size = new Point(m_normalImage.width, m_normalImage.height);
		
		mousePressed = new EventAction!(Mouse.Button)(&handleMousePressed);
		mouseReleased = new EventAction!(Mouse.Button)(&handleMouseReleased);
		mouseMoved = new EventAction!(Point)(&handleMouseMoved);
	}
	
	@property {
		/**
		*	Sets the position of the button.
		*/
		override void position(Point newPosition) {
			m_normalImage.position = newPosition;
			m_clickImage.position = newPosition;
			m_hoverImage.position = newPosition;
			m_position = newPosition;
		}
		
		override Point size() { return m_size; }
		
		override void size(Point newSize) {
			// Disallowed ...
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
		if (pressing && intersecting)
			m_clickImage.draw(window);
		else if (intersecting)
			m_hoverImage.draw(window);
		else
			m_normalImage.draw(window);
		
		if (borderSingle)
			borderSingle.draw(window);
	}
}