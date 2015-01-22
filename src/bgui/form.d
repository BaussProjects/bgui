module bgui.form;

import dsfml.graphics;
import dsfml.system;
import dsfml.window;

import bgui.point;
import bgui.space;
import bgui.screen;

/**
*	A window form class wrapper.
*/
class Form : Space {
private:
	/**
	*	The rendering window.
	*/
	RenderWindow m_window;
	/**
	*	The title.
	*/
	string m_title;
	/**
	*	The screens of the window.
	*/
	Screen[] m_screens;
public:
	/**
	*	Creates a new instance of Form.
	*	Params:
	*		size =		The size of the form.
	*		title =		The title of the form.
	*/
	this(Point size, string title) {
		ContextSettings context;
		context.antialiasingLevel = 8;
		
		m_window = new RenderWindow(VideoMode(cast(int)size.x, cast(int)size.y), title, Window.Style.None, context);
		m_size = size;
		m_title = title;
	}
	
	@property {
		/**
		*	Gets the cursor position.
		*/
		Point cursorPosition() {
			auto pos = Mouse.getPosition(m_window);
			return new Point(pos.x, pos.y);
		}
		
		/**
		*	Gets the position of the form.
		*/
		override void position(Point newPos) {
			m_position = newPos;
			m_window.position = Vector2i(cast(int)m_position.x, cast(int)m_position.y);
		}
		
		/**
		*	Gets the size of the form.
		*/
		override void size(Point newSize) {
			m_size = newSize;
			m_window.size = Vector2u(cast(uint)m_size.x, cast(uint)m_size.y);
		}
	}
	
	
	/**
	*	Adds a screen to the form.
	*/
	void addScreen(Screen screen) {
		m_screens ~= screen;
	}
	
	/**
	*	Opens the window, shows the form and handles the event messages.
	*/
	void show() {
		while (m_window.isOpen())
		{
			Event event;

			while(m_window.pollEvent(event))
			{
				switch (event.type) {
					case Event.EventType.Closed: {
						m_window.close();
						break;
					}
					
					case Event.EventType.KeyPressed: {
						foreach (screen; m_screens)
							screen.processKeyPressed(event.key.code);
						break;
					}
					
					case Event.EventType.KeyReleased: {
						foreach (screen; m_screens)
							screen.processKeyReleased(event.key.code);
						break;
					}
					
					case Event.EventType.MouseButtonPressed: {
						foreach (screen; m_screens)
							screen.processMousePressed(event.mouseButton.button);
						break;
					}
					
					case Event.EventType.MouseButtonReleased: {
						foreach (screen; m_screens)
							screen.processMouseReleased(event.mouseButton.button);
						break;
					}
					
					case Event.EventType.MouseMoved: {
						scope auto pos = new Point(cast(float)event.mouseMove.x, cast(float)event.mouseMove.y);
						foreach (screen; m_screens)
							screen.processMouseMoved(pos);
						break;
					}
				
					default: break;
				}
			}
			
			m_window.clear();
			
			foreach (s; m_screens)
				s.draw(m_window);
		
			m_window.display();
		}
	}
}