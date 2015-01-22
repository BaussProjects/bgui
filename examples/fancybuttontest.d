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

	import bgui.controls.fancybutton;
	import bgui.controls.image;
	// Creates a newbutton with the text "Click"
	scope auto btn = new FancyButton("btn",
		new Image("", "login_btn.png"),
		new Image("", "login_btn_click.png"),
		new Image("", "login_btn_hover.png")
	);
	import bgui.events;
	// It writes "Hello World!" to a text file, when clicked.
	btn.onClick = new Action({
		import std.file;
		write("test.txt", "Hello World!");
	});
	// Positionated at the center x of the screen
	btn.position = new Point(
		(screenTest.width / 2) - (btn.width / 2),
		0
	);
	
	screenTest.addControl(btn, ScreenLayer.center);
	// Positionates the button at the top of the screen
	screenTest.positionate(btn, ScreenPosition.top);
	
	mainWindow.addScreen(screenTest);	
	mainWindow.show();
}