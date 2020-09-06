class TextBox  {
	int x1,y1,ancho,alto,tamanoDetexto;
	color colorDelBoton, colorDelBotonSinFoco,colorDelTexto;
	String palabra = ""; // palabra del textBox
	boolean enabledToType=false; // para detectar si le hizo click al textBox
	String tipoDeDato;	// Para detectar que tipo de dato quiere recibir 
	int points =0;	// para que no de eerror la conversion de Float a Strings por muchos puntos
	boolean hasBeenExecuted = false; //para detectar si esta usando correctamente el programa
	float textHeight;
	public TextBox (int x1, int y1, int ancho, int alto, int tamanoDetexto, color colorDelBoton,color colorDelBotonSinFoco,color colorDelTexto) {
		this.x1=x1;
		this.y1=y1;
		this.ancho=ancho;
		this.alto=alto;
		this.tamanoDetexto=tamanoDetexto;
		this.colorDelBoton=colorDelBoton;
		this.colorDelBotonSinFoco=colorDelBoton;
		this.colorDelTexto=colorDelTexto;
	}
	void detectData(String tipoDeDato) { // aca el usuario especifica si quiere recibir solo enteros o cualquier cosa 
		this.tipoDeDato=tipoDeDato;
		hasBeenExecuted = true;
		textSize(tamanoDetexto);
		if (enabledToType) { // si le hizo click al TextBox
			if (keyCode == BACKSPACE && palabra.length() > 0) {
				palabra=palabra.substring(0,palabra.length()-1); //borrar un digito de la palabra
			}else if(tipoDeDato == "int" && (Character.isDigit(key) || key == '.') && textWidth(palabra)+tamanoDetexto < ancho){ // Detecta si el caracter es un entero o punto, si el ancho de texto es menor al ancho del texto
				palabra+=key;
			}else if (tipoDeDato == "str" && textWidth(palabra)+tamanoDetexto < ancho) {
				palabra+=key;
				println("ancho: "+ancho);
				println("textWidth(palabra): "+textWidth(palabra));
			}
		}
	}
	void drawTextBox(){ // para dibujar la textBox como un boton
		
		if (estoySobreElBoton()) {
			fill(colorDelBoton);
			if(mousePressed == true){
				enabledToType=true;
			}
		}else {
			if(mousePressed == true){
				enabledToType=false;
			}
			fill(colorDelBotonSinFoco);
		}
		rect(x1, y1, ancho, alto);
		fill(colorDelTexto);
		textSize(tamanoDetexto);
		text(palabra, x1+5, (y1+alto)-(alto-textAscent() * 0.8) / 2);
	}
	boolean estoySobreElBoton(){ // devuelve un valor booleano si presiono el texto
		if (mouseX > x1 && mouseX < x1+ancho && mouseY > y1 && mouseY < y1+alto) {
			return true;
		}
		return false;
	}
	String getText(){ 
		return palabra;
	}
	void setText(String textToChange){
		palabra=textToChange;
	}
	float getNumbers(){
		if (tipoDeDato == "int" && palabra.length() > 0) {
			for (int i = 0; i < palabra.length(); ++i) { // para contar cuantos puntos tiene la palabra
				if (palabra.charAt(i) == '.') {
					points++;
				}
			}
			if (points <= 1){ // si solo hay un punto en el numero
				points=0;
				colorDelTexto=color (colorDelTexto);
				return Float.parseFloat(palabra);
			}else {
				println("Has puesto "+ points+" puntos en el TextBox");
				colorDelTexto=color (255,0,0);
				points=0;
				return 0.0;
			}
			
		}
		points=0;
		if (hasBeenExecuted) { // para detectar si el usuario uso el metodo detectData()
			println("Has especificado solo recibir Strings -> detectData(str), cambia ese parametro para recibir enteros -> detectData(int)");
		}else{
			println("Debes incluir la funcion detectData(int) o detectData(str) en keyPressed()");
		}
		return 0.0;
	}
}
