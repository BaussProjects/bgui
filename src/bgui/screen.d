module bgui.screen;

import std.algorithm : filter;
import std.array;

import dsfml.graphics;
import dsfml.system;

import bgui.point;
import bgui.space;
import bgui.events;
import bgui.control;

/**
*	Enumeration of layers in the screen.
*/
enum ScreenLayer {
	/**
	*	The background layer.
	*/
	background,
	/**
	*	The center layer.
	*/
	center,
	/**
	*	The foreground layer.
	*/
	foreground
}

/**
*	Enumeration for screen positions.
*/
enum ScreenPosition {
	/**
	*	Left position.
	*/
	left,
	/**
	*	Right position.
	*/
	right,
	/**
	*	Bottom position.
	*/
	bottom,
	/**
	*	Top position.
	*/
	top
}

/**
*	A screen panel wrapper.
*/
class Screen : Space {
private:
	/**
	*	The background controls.
	*/
	Control[] m_backgroundControls;
	/**
	*	The center controls.
	*/
	Control[] m_centerControls;
	/**
	*	The foreground controls.
	*/
	Control[] m_foregroundControls;
private:
	/**
	*	Removes a control from the screen.
	*	Params:
	*		c =		The control to remove.
	*		l =		The layer collection.
	*/
	void removeControl(Control c, Control[] l) {
		if (c.spos == 0)
			l = l[1 .. $];
		else if (c.spos == l.length - 1)
			l = l[0 .. $-1];
		else {
			auto before = l[0 .. c.spos];
			auto after = l[c.spos .. $];
			l = before ~ after;
		}
		foreach (i; 0 .. l.length) {
			auto oc = l[i];
			oc.spos = i;
		}
		
		c.parent = null;
	}
public:
	/**
	*	Creates a new instance of Screen.
	*	Params:
	*		position =	The position of the screen.
	*		size =		The size of the screen.
	*/
	this(Point position, Point size) {
		m_position = position;
		m_size = size;
	}
	
	@property {
		/**
		*	Sets the position of the screen.
		*/
		override void position(Point newPos) {
			m_position = newPos;
		}
		
		/**
		*	Sets the size of the screen.
		*/
		override void size(Point newSize) {
			m_size = newSize;
		}
	}
	
	/**
	*	Adds a control to the screen.
	*	Params:
	*		c =	The control to add.
	*		l =	The layer to add it to.
	*/
	void addControl(Control c, ScreenLayer l) {
		final switch (l) {
			case ScreenLayer.background:
				c.spos = m_backgroundControls.length;
				m_backgroundControls ~= c;
				c.parent = this;
				break;
			case ScreenLayer.center:
				c.spos = m_centerControls.length;
				m_centerControls ~= c;
				c.parent = this;
				break;
			case ScreenLayer.foreground:
				c.spos = m_foregroundControls.length;
				m_foregroundControls ~= c;
				c.parent = this;
				break;
		}
	}
	
	/**
	*	Removes a control from the screen.
	*	Params:
	*		name =	The name of the control to remove.
	*		l =		The layer to remove it from.
	*/
	void removeControl(string name, ScreenLayer l) {
		final switch (l) {
			case ScreenLayer.background:
				auto controls = filter!((e) => e.name == name)(m_backgroundControls).array;
				foreach (c; controls) {
					removeControl(c, m_backgroundControls);
				}
				break;
			case ScreenLayer.center:
				auto controls = filter!((e) => e.name == name)(m_centerControls).array;
				foreach (c; controls) {
					removeControl(c, m_centerControls);
				}
				break;
			case ScreenLayer.foreground:
				auto controls = filter!((e) => e.name == name)(m_foregroundControls).array;
				foreach (c; controls) {
					removeControl(c, m_foregroundControls);
				}
				break;
		}
	}
	
	/**
	*	Clears all controls of a specific layer.
	*	Params:
	*		l =	The layer to clear controls of.
	*/
	void clearControls(ScreenLayer l) {
		final switch (l) {
			case ScreenLayer.background:
				m_backgroundControls = null;
				break;
			case ScreenLayer.center:
				m_centerControls = null;
				break;
			case ScreenLayer.foreground:
				m_foregroundControls = null;
				break;
		}
	}
	
	/**
	*	Makes a control fit to the screen.
	*/
	void fitToScreen(Control c) {
		c.position = new Point(super.x + c.x, super.y + c.y);
	}
	
	/**
	*	Positionates a control to the screen.
	*/
	void positionate(Control c, ScreenPosition pos) {
		switch (pos) {
			case ScreenPosition.left:
				fitToScreen(c);
				c.position = new Point(super.x, c.y);
				break;
				
			case ScreenPosition.right:
				fitToScreen(c);
				c.position = new Point(
					(super.x + super.width) - c.width,
					c.y
				);
				break;
			
			case ScreenPosition.top:
				fitToScreen(c);
				c.position = new Point(c.x, super.y);
				break;

			case ScreenPosition.bottom:
				fitToScreen(c);
				c.position = new Point(c.x,
					(super.y + super.height) - c.height
				);
				break;
			
			default: break;
		}
	}
	
	/**
		Draws the screen to a sfml RenderWindow.
	*/
	void draw(RenderWindow w) {
		foreach (c; m_backgroundControls ~ m_centerControls ~ m_foregroundControls) {
			if (c.visible)
				c.draw(w);
		}
	}
	
	/**
		Processing key pressed for the controls.
	*/
	void processKeyPressed(Keyboard.Key key) {
		foreach (c; m_backgroundControls ~ m_centerControls ~ m_foregroundControls) {
			if (c.keyPressed && c.enabled)
				c.keyPressed.exec(key);
		}
	}
	
	/**
		Processing key release for the controls.
	*/
	void processKeyReleased(Keyboard.Key key) {
		foreach (c; m_backgroundControls ~ m_centerControls ~ m_foregroundControls) {
			if (c.keyReleased && c.enabled)
				c.keyReleased.exec(key);
		}
	}
	
	/**
		Processing mouse pressed for the controls.
	*/
	void processMousePressed(Mouse.Button button) {
		foreach (c; m_backgroundControls ~ m_centerControls ~ m_foregroundControls) {
			if (c.mousePressed && c.enabled)
				c.mousePressed.exec(button);
		}
	}
	
	/**
		Processing mouse released for the controls.
	*/
	void processMouseReleased(Mouse.Button button) {
		foreach (c; m_backgroundControls ~ m_centerControls ~ m_foregroundControls) {
			if (c.mouseReleased && c.enabled)
				c.mouseReleased.exec(button);
		}
	}
	
	/**
		Processing mouse moved for the controls.
	*/
	void processMouseMoved(Point position) {
		foreach (c; m_backgroundControls ~ m_centerControls ~ m_foregroundControls) {
			if (c.mouseMoved && c.enabled)
				c.mouseMoved.exec(position);
		}
	}
	
	/**
	*	Invokes an action thread-safely.
	*/
	void safeInvoke(Action action) {
		synchronized {
			action.exec();
		}
	}
}