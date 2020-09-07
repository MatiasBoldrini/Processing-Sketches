//made by Boldrini and Andonegui
class TextBox {
	int x1, y1, rectWidth, rectHeight, borderRadius, textHeight;
	String word = "";
	boolean enableToType = false; // para detectar si le hizo click al textBox 
	color textColor = color(0), textBoxColor = color(255);
	boolean dotDetection = false;
	public TextBox(int x1, int y1, int rectWidth, int rectHeight, int textHeight, int borderRadius) {
		this.x1 = x1;
		this.y1 = y1;
		this.rectWidth = rectWidth;
		this.rectHeight = rectHeight;
		this.textHeight = textHeight;
		this.borderRadius = borderRadius;
	}
	void type(String tipoDeDato) { // aca el usuario especifica si quiere recibir solo enteros o cualquier cosa 
		textSize(textHeight);
		if (enableToType) { // si le hizo click al TextBox
			if (keyCode == BACKSPACE && word.length() > 0) {
				if (word.charAt(word.length() - 1) == '.') {
					dotDetection = false;
				}
				word = word.substring(0, word.length() - 1); //borrar un digito de la word
			} else if (tipoDeDato == "int" && (Character.isDigit(key) || key == '.') && textWidth(word) + textHeight < rectWidth) { // Detecta si el caracter es un entero o punto, si el rectWidth de texto es menor al rectWidth del texto
				if (key == '.') {
					if (!dotDetection) {
						dotDetection = true;
						word += key;
					}
				} else {
					word += key;
				}
			} else if (tipoDeDato == "str" && key != keyCode && textWidth(word) + textHeight < rectWidth) {
				word += key;
			}
		}
	}
	void drawTextBox() { // para dibujar la textBox como un boton
		rectMode(CORNER);
		if (estoySobreElBoton()) {
			fill(textBoxColor);
			rect(x1, y1, rectWidth, rectHeight, borderRadius);
			fill(textColor);
			if (mousePressed == true) {
				enableToType = true;
			}
		} else {
			if (mousePressed == true) {
				enableToType = false;
			}
			fill(textBoxColor);
			rect(x1, y1, rectWidth, rectHeight, borderRadius);
			fill(textColor);
		}
		textSize(textHeight);
		text(word, x1 + 5, y1 + rectHeight / 2 + textAscent() * 0.4);
	}
	boolean estoySobreElBoton() { // devuelve un valor booleano si presiono el texto
		if (mouseX > x1 && mouseX < x1 + rectWidth && mouseY > y1 && mouseY < y1 + rectHeight) {
			return true;
		}
		return false;
	}
	String getText() {
		return word;
	}
	void setText(String textToChange) {
		word = textToChange;
	}
	double getNumbers() {
		try {
			if (word.length() > 0) {
				return Double.parseDouble(word);
			}
		} catch (NumberFormatException e) {
			println("No todos los caracteres que has ingresado son numeros");
		}
		return 0.0;
	}
}
