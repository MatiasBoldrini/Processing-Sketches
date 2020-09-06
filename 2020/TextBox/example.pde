TextBox textBox,textBox1;
void setup() {
	size(800,800);
	textBox = new TextBox(100,100,300,50,25,255,125);
	textBox1 = new TextBox(100,300,150,50,15,255,125);
}
void draw() {
	background(0);
	textBox.drawTextBox();
	textBox1.drawTextBox();
	if (textBox.palabra.length() > 3 && textBox1.palabra.length() >3) { // Esto es para que no imprima valores infinitos
			println(textBox.getText());
			println(textBox1.getNumbers());
			textBox.setText("");
			textBox1.setText("");
	}
}
void keyPressed() {
	textBox1.detectData("int");
	textBox.detectData("str");
}
