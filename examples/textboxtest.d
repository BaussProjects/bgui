module main;

import bgui.point;
import bgui.form;

void main() {
	// Initializes a window of the size 800x600 with the text "bgui test"
	scope auto mainWindow = new Form(new Point(800, 600), "bgui test");
	
	import bgui.screen;
	// Creates a new screen positionated at (0, 0) with the size 400x300
	scope auto screenTest = new Screen(
		new Point(0, 0),
		new Point(400, 300)
	);
	import bgui.controls.image;
	auto bgImg = new Image("bgImg", "login_bg.png");
	bgImg.scaleImage(new Point(400, 300));
	screenTest.addControl(bgImg, ScreenLayer.background);
	
	import bgui.controls.textbox;
	auto txt = new TextBox("txt", "fonts\\Verdana.ttf");
	txt.position = new Point(125, 125);
	txt.maxCharacters = 16;
	//txt.isPassword = true;
	txt.backgroundImage = new Image("", "login_txt.png");
	txt.focusedImage = new Image("", "login_txt_focus.png");
	txt.size = new Point(200, 62);
	
	screenTest.addControl(txt, ScreenLayer.center);
	screenTest.fitToScreen(txt);
	
	mainWindow.addScreen(screenTest);
	mainWindow.show();
}