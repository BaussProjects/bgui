module bgui.controls.textbox;

import std.conv;
import std.array;
import std.algorithm;

import dsfml.graphics;
import dsfml.window : Keyboard, Mouse;

import bgui.control;
import bgui.events;
import bgui.point;

import bgui.controls.image;
alias BImage = bgui.controls.image.Image;
import bgui.controls.label;

class TextBox : Control {
private:
	/**
	*	The virtual string of the textbox.
	*/
	Label virtualString;
	/**
	*	The actual string of the textbox.
	*/
	string memoryString;
	
	/**
	*	Set to true whenever the cursor is intersecting with the textbox.
	*/
	bool intersecting = false;
	/**
	*	Set to true whenever the textbox is in focus.
	*/
	bool focused = false;
	
	/**
	*	Set to true whenver the shift key is hold.
	*/
	bool shift = false;
	
	/**
	*	Updates the virtual string.
	*/
	void updateVirtualString() {
		if (memoryString == "") {
			virtualString.text = "";
			return;
		}
		
		string viewString;
		foreach (c; memoryString) {
			if (isPassword)
				viewString ~= "*";
			else
				viewString ~= c;
			virtualString.text = viewString;
			if (virtualString.width >= (width - 3))
				break;
		}
	}
	
	/**
	*	Handles the key pressed event.
	*/
	void handleKeyPressed(Keyboard.Key key) {
		if (key == Keyboard.Key.LShift)
			shift = true;
	}
	
	/**
	*	Handles the key released event.
	*/
	void handleKeyReleased(Keyboard.Key key) {
		if (key == Keyboard.Key.LShift) {
			shift = false;
			return;
		}
		
		if (focused) {
			if (returnPressed) {
				if (key == Keyboard.Key.Return) {
					returnPressed.exec();
					return;
				}
			}
		
			if (key == Keyboard.Key.BackSpace ) {
				if (memoryString.length <= 1)
					memoryString = "";
				else
					memoryString.length -= 1;
			
				text = memoryString;
				return;
			}
		
			string s = to!string(key);
			if (s == "Space")
				s = " ";
			if (s == "Quote")
				s = "'";
			else if (s == "Comma")
				s = ",";
			else if (s == "Period")
				s = ".";
			else if (startsWith(s, "Num"))
				s = replace(s, "Num", "");
			else if (s.length != 1)
				return;
					
			char c = s[0];
			
			if (c == 32 || c == 39 || c >= 48 && c <= 57 || c >= 65 && c <= 90 || c == 44 || c == 46) {							
				if (c >= 65 && c <= 90) {
					if (!shift)
						c ^= 32;
				}
				text = text ~ c;
			}
		}
	}
	
	/**
	*	The handler for mouse releasing.
	*/
	void handleMouseReleased(Mouse.Button button) {
		focused = intersecting;
	}
	
	/**
	*	The handler for mouse movement.
	*/
	void handleMouseMoved(Point position){
		intersecting = intersect(position);
	}
public:
	/**
	*	Creates a new instance of TextBox.
	*/
	this(string name, string fontName, uint characterSize = 14) {
		import bgui.fonts;
		this(name, loadFont(fontName), characterSize);
	}
	
	/**
	*	Creates a new instance of TextBox.
	*/
	this(string name, Font font, uint characterSize = 14) {
		super(name);
		
		virtualString = new Label("lbl_" ~ name, "", font, characterSize);
		virtualString.position = new Point(0, 0);
		
		m_size = new Point(128, 32);
		
		keyPressed = new EventAction!(Keyboard.Key)(&handleKeyPressed);
		keyReleased = new EventAction!(Keyboard.Key)(&handleKeyReleased);
		mouseReleased = new EventAction!(Mouse.Button)(&handleMouseReleased);
		mouseMoved = new EventAction!(Point)(&handleMouseMoved);
	}

	/**
	*	The eventhandler for return press.
	*/
	Action returnPressed;
	
	/**
	*	If set to true character display is *
	*/
	bool isPassword = false;
	
	/**
	*	The maximum character amount.
	*/
	size_t maxCharacters = size_t.max;
	
	/**
	*	The background image of the textbox.
	*/
	BImage backgroundImage;
	/**
	*	The focusing image of the textbox.
	*/
	BImage focusedImage;
	
	@property {
		/**
		*	Gets the text.
		*/
		string text() {
			return memoryString;
		}
		
		/**
		*	Sets the text.
		*/
		void text(string value) {
			if (memoryString.length >= maxCharacters)
				return;
				
			memoryString = value;
			updateVirtualString();
		}
		
		/**
		*	Sets the size.
		*/
		override void size(Point newSize) {
			m_size = newSize;
			if (backgroundImage)
				backgroundImage.scaleImage(newSize);
			if (focusedImage)
				focusedImage.scaleImage(newSize);
			updateVirtualString();
		}
		
		/**
		*	Sets the position.
		*/
		override void position(Point newPosition) {
			auto p = newPosition;
			if (backgroundImage) {
				backgroundImage.position = p;
				if (focusedImage) {
					focusedImage.position = p;
				}
				p = new Point(newPosition.x + 3, newPosition.y + 3);
			}
			virtualString.position = p;
			m_position = newPosition;
		}
	}
	
	/**
	*	Draws the textbox to a sfml RenderWindow.
	*/
	override void draw(RenderWindow window) {
		if (backgroundImage && (!focused || !focusedImage))
			backgroundImage.draw(window);
		else if (focusedImage && backgroundImage && focused)
			focusedImage.draw(window);
		virtualString.draw(window);
	}
}