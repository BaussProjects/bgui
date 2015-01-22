module bgui.control;

import dsfml.graphics;
import dsfml.system;
import dsfml.window;

import bgui.point;
import bgui.space;
import bgui.screen;
import bgui.events;

/**
*	Exception thrown when there's a draw error.
*/
class ControlDrawException : Throwable {
	/**
	*	Creates a new instance of ControlDrawException.
	*	Params:
	*		msg =	The error message.
	*/
	public this(string msg) {
		super(msg);
	}
}

/**
*	The base control wrapper.
*/
class Control : Space {
private:
	/**
	*	The name of the control.
	*/
	string m_name;
	/**
	*	The parent of the control.
	*/
	Screen m_parent;
	
	/**
	*	Boolean determining whether the control is visible or not.
	*/
	bool m_visible = true;
	
	/**
	*	Boolean determining whether the control is enabled or not.
	*/
	bool m_enabled = true;
protected:
	/**
	*	Creates a new instance of Control.
	*	Params:
	*		name =	The name of the control.
	*/
	this(string name) {
		m_name = name;
	}
public:
	/**
	*	The screen position. (DO NOT MODIFY!!!!!)
	*/
	size_t spos;
	
	@property {
		/**
		*	Sets the position of the control.
		*/
		override void position(Point newPos) {
			m_position = newPos;
		}
		
		/**
		*	Sets the size of the control.
		*/
		override void size(Point newSize) {
			m_size = newSize;
		}
		
		/**
		*	Gets the parent of the control.
		*/
		Screen parent() { return m_parent; }
		
		/**
		*	Sets the parent of the control.
		*/
		void parent(Screen newParent) {
			m_parent = newParent;
		}
		
		/**
		*	Gets the name of the control.
		*/
		string name() { return m_name; }
		
		/**
		*	Gets the visibility of the control.
		*/
		bool visible() { return m_visible; }
		
		/**
		*	Sets the visibility of the control.
		*/
		void visible(bool newVisibility) {
			m_visible = newVisibility;
		}
		
		/**
		*	Gets the enable state of the control.
		*/
		bool enabled() { return m_enabled; }
		
		/**
		*	Sets the enable state of the control.
		*/
		void enabled(bool newEnableState) {
			m_enabled = newEnableState;
		}
	}
	
	/**
	*	Checks whether the control intersects with a point.
	*	Params:
	*		p =	The point to check.
	*	Returns: True if the control intersects with the point.
	*/
	bool intersect(Point p) {
		return (p.x > super.x &&
			p.x < (super.x + super.width) &&
			p.y > super.y &&
			p.y < (super.y + super.height));
	}
	
	/**
	*	OVERRIDE THIS!!
	*/
	void draw(RenderWindow window) {
		throw new ControlDrawException("override draw(RenderWindow).");
	}
	
	/**
	*	Event handler for keyboard pressed.
	*/
	EventAction!(Keyboard.Key) keyPressed;

	/**
	*	Event handler for keyboard released.
	*/
	EventAction!(Keyboard.Key) keyReleased;

	/**
	*	Event handler for mouse pressed.
	*/
	EventAction!(Mouse.Button) mousePressed;

	/**
	*	Event handler for mouse released.
	*/
	EventAction!(Mouse.Button) mouseReleased;

	/**
	*	Event handler for mouse moved.
	*/
	EventAction!(Point) mouseMoved;
}