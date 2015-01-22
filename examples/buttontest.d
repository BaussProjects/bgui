module main;

import bgui.point;
import bgui.form;

void main() {
	// Initializes a window of the size 800x600 with the text "bgui test"
	scope auto mainWindow = new Form(new Point(800, 600), "bgui test");
	
	import bgui.screen;
	// Creates a new screen positionated at (100, 100) with the size 400x300
	scope auto screenTest = new Screen(
		new Point(100, 100),
		new Point(400, 300)
	);

	import bgui.controls.singlebutton;
	// Creates a new button with the text "Click"
	scope auto btn = new SingleButton("btn", "Click", "fonts\\Verdana.ttf");
	import bgui.paint;
	// With a blue color
	btn.paint = blue;
	// Sized (128x48)
	btn.size = new Point(128, 48);
	// Positionated at (0,0)
	btn.position = new Point(0, 0);
	import bgui.borders;
	// Creates a single border for the button.
	auto btnBorder = new BorderSingle();
	btnBorder.topPaint = white;
	btnBorder.bottomPaint = white;
	btnBorder.leftPaint = white;
	btnBorder.rightPaint = white;
	btn.borderSingle = btnBorder;
	screenTest.addControl(btn, ScreenLayer.center);
	// Makes the label fit to the boundaries of "screenTest" -- (screenTest.x + lbl.x, screenTest.y + lbl.y)
	screenTest.fitToScreen(btn);
	
	mainWindow.addScreen(screenTest);	
	mainWindow.show();
}