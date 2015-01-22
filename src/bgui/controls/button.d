module bgui.controls.button;

import dsfml.graphics : RenderWindow;
import dsfml.window : Mouse;

import bgui.control;
import bgui.events;
import bgui.point;

/**
*	Unfinished ... DO NOT USE!!!
*/
class Button : Control {
private:
	bool pressing = false;
	bool intersecting = false;
	/**
	*	The handler for mouse pressing.
	*/
	void handleMousePressed(Mouse.Button button) {
		pressing = true;
	}
	
	/**
	*	The handler for mouse releasing.
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
	*/
	void handleMouseMoved(Point position){
		intersecting = intersect(position);
	}
	
public:
	this(string name) {
		super(name);
		
		mousePressed = new EventAction!(Mouse.Button)(&handleMousePressed);
		mouseReleased = new EventAction!(Mouse.Button)(&handleMouseReleased);
		mouseMoved = new EventAction!(Point)(&handleMouseMoved);
	}
	
	Action onClick;
	
	/**
	*	Drawing the image to a sfml RenderWindow.
	*/
	override void draw(RenderWindow window) {
	}
}