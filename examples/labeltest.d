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

	import bgui.controls.label;
	// Creates a new label with the text "Hello World!"
	scope auto lbl = new Label("lblTest", "Hello World!", "fonts\\Verdana.ttf");
	// Positionated at (0,0)
	lbl.position = new Point(0, 0);
	screenTest.addControl(lbl, ScreenLayer.center);
	// Makes the label fit to the boundaries of "screenTest" -- (screenTest.x + lbl.x, screenTest.y + lbl.y)
	screenTest.fitToScreen(lbl);
	
	mainWindow.addScreen(screenTest);	
	mainWindow.show();
}