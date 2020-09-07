TextBox textBox, textBox1;
void setup() {
	size(800, 800);
	textBox = new TextBox(100, 100, 300, 50, 25, 100);
	textBox1 = new TextBox(100, 300, 300, 50, 15, 20);
}
void draw() {
	background(125);
	textBox.drawTextBox();
	textBox1.drawTextBox();
}
void keyPressed() {
	textBox.type("str");
	println(textBox.getNumbers());
	textBox1.type("int");
	println(textBox1.getNumbers());
}
