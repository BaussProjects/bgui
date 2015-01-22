module bgui.controls.imagebutton;

import dsfml.graphics : RenderWindow;
import dsfml.window : Mouse;

import bgui.control;
import bgui.events;
import bgui.point;

import bgui.image;

/**
*	An image button control.
*/
class ImageButton : Image {
private:
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
	*	Creates a new instance of ImageButton.
	*	Params:
	*		name =		The name of the image button.
	*		imgFile =	The image file of the button.
	*/
	this(string name, string imgFile) {
		super(name, imgFile);
		
		mousePressed = new EventAction!(Mouse.Button)(&handleMousePressed);
		mouseReleased = new EventAction!(Mouse.Button)(&handleMouseReleased);
		mouseMoved = new EventAction!(Point)(&handleMouseMoved);
	}
	
	/**
	*	The event to trigger when the image button is clicked.
	*/
	Action onClick;
}