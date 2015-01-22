module main;

import bgui.point;
import bgui.form;

void main() {
	// Initializes a window of the size 800x600 with the text "bgui test"
	scope auto mainWindow = new Form(new Point(800, 600), "bgui test");
	
	import bgui.events;
	import bgui.screen;
	import bgui.controls.imagebutton;
	import bgui.controls.label;
	
	// Creates a new screen positionated at (0,0) with the size 800x600
	auto screenTest = new Screen(
		new Point(0, 0),
		new Point(800, 600)
	);
	
	// Creates a new image button that writes "Hello World!" to a text file.
	auto imgTest = new ImageButton("imgTest", "logo.png");
	imgTest.position = new Point(0, 0);
	imgTest.onClick = new Action({
		import std.file;
		write("test.txt", "Hello World!");
	});
	screenTest.addControl(imgTest, ScreenLayer.center);
	// Makes the image button fit to the screen position.
	screenTest.fitToScreen(imgTest);
	
	// Creates a new label with the text "Hello World!" using "Verdana" as the font.
	auto lblTest = new Label("lblTest", "Hello World!", "fonts\\Verdana.ttf");
	lblTest.position = new Point(33, 300);
	screenTest.addControl(lblTest, ScreenLayer.foreground);
	// Positionates the label to be docked at right.
	screenTest.positionate(lblTest, ScreenPosition.right);
	
	mainWindow.addScreen(screenTest);
	
	mainWindow.show();
}