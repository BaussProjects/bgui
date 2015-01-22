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

	import bgui.controls.image;
	// Creates a image
	scope auto img = new Image("img", "logo.png");
	// Positionated at the center x of the screen
	img.position = new Point(
		(screenTest.width / 2) - (img.width / 2),
		0
	);
	
	screenTest.addControl(img, ScreenLayer.center);
	// Positionates the image at the bottom of the screen
	screenTest.positionate(img, ScreenPosition.bottom);
	
	mainWindow.addScreen(screenTest);	
	mainWindow.show();
}