module bgui.borders;

import dsfml.graphics;

import bgui.space;
import bgui.point;
import bgui.paint;

class BorderSingle : Space {
private:
	RectangleShape m_top;
	RectangleShape m_bottom;
	RectangleShape m_left;
	RectangleShape m_right;
	
	Paint m_topPaint;
	Paint m_bottomPaint;
	Paint m_leftPaint;
	Paint m_rightPaint;
public:
	this() {
		m_position = new Point(0,0);
		size = new Point(0,0);
	}
	
	@property {
		override void position(Point newPosition) {
			m_top.position = Vector2f(newPosition.x, newPosition.y);
			m_bottom.position = Vector2f(newPosition.x, newPosition.y + height);
			m_left.position = Vector2f(newPosition.x, newPosition.y);
			m_right.position = Vector2f(newPosition.x + width, newPosition.y);
			m_position = newPosition;
		}
		
		override void size(Point newSize) {
			m_top = new RectangleShape(Vector2f(newSize.x, 1));
			m_top.fillColor = m_topPaint.toSfmlColor();
			m_bottom = new RectangleShape(Vector2f(newSize.x, 1));
			m_bottom.fillColor = m_bottomPaint.toSfmlColor();
			m_left = new RectangleShape(Vector2f(1, newSize.y));
			m_left.fillColor = m_leftPaint.toSfmlColor();
			m_right = new RectangleShape(Vector2f(1, newSize.y));
			m_right.fillColor = m_rightPaint.toSfmlColor();
			m_size = newSize;
			position = m_position;
		}
		
		Paint topPaint() { return m_topPaint; }
		void topPaint(Paint newPaint) {
			m_top.fillColor = newPaint.toSfmlColor();
			m_topPaint = newPaint;
		}
		
		Paint bottomPaint() { return m_bottomPaint; }
		void bottomPaint(Paint newPaint) {
			m_bottom.fillColor = newPaint.toSfmlColor();
			m_bottomPaint = newPaint;
		}
		
		Paint leftPaint() { return m_leftPaint; }
		void leftPaint(Paint newPaint) {
			m_left.fillColor = newPaint.toSfmlColor();
			m_leftPaint = newPaint;
		}
		
		Paint rightPaint() { return m_rightPaint; }
		void rightPaint(Paint newPaint) {
			m_right.fillColor = newPaint.toSfmlColor();
			m_rightPaint = newPaint;
		}
	}
	
	void draw(RenderWindow window) {
		window.draw(m_left);
		window.draw(m_right);
		window.draw(m_top);
		window.draw(m_bottom);
	}
}