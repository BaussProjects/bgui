module bgui.point;

/**
*	A 2d point class.
*/
class Point {
private:
	/**
	*	The x axis.
	*/
	float m_x;
	/**
	*	The y axis.
	*/
	float m_y;
public:
	/**
	*	Creates a new instance of Point.
	*	Params:
	*		x =		The x axis.
	*		y =		The y axis.
	*/
	this(float x, float y) {
		m_x = x;
		m_y = y;
	}
	
	@property {
		/**
		*	Gets the x axis.
		*/
		float x() { return m_x; }
		/**
		*	Gets the y axis.
		*/
		float y() { return m_y; }
	}
}