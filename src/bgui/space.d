module bgui.space;

import dsfml.graphics;

import bgui.point;

/**
*	A spacing wrapper.
*/
class Space {
protected:
	/**
	*	The position of the space.
	*/
	Point m_position;
	/**
	*	The size of the space.
	*/
	Point m_size;
public:
	/**
	*	Creates a new space of a default size (0,0) and position (0,0).
	*/
	this() {
		m_position = new Point(0, 0);
		m_size = new Point(0, 0);
	}
	
	@property {
		/**
		*	Gets the position of the space.
		*/
		Point position() { return m_position; }
		/**
		*	Sets the position of the space.
		*/
		void position(Point newPos) {
			m_position = newPos;
		}
		
		/**
		*	Gets the x axis of the space.
		*/
		float x() { return m_position.x; }
		
		/**
		*	Gets the y axis of the space.
		*/
		float y() { return m_position.y; }
		
		/**
		*	Gets the size of the space.
		*/
		Point size() { return m_size; }
		
		/**
		*	Sets the size of the space.
		*/
		void size(Point newSize) {
			m_size = newSize;
		}
		
		/**
		*	Gets the width of the space.
		*/
		float width() { return m_size.x; }
		
		/**
		*	Gets the height of the space.
		*/
		float height() { return m_size.y; }
	}
}