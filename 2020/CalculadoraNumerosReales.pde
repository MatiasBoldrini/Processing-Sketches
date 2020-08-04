int numeros=1;
int separacion=3;
int largo=50;
int ancho=75;
int rectx=150;
int recty=150;
int posicion_numeros_calculadora=0;
String texto_calculadora="";
boolean habilitado = true;
boolean calculado = true;
String[] signos = {"*","/","+","-"};
String operacion = "";
String primerNumero = "";
String segundoNumero = "";
void setup() {
    size(500, 500);    
    background(26,169,3);
    noFill();
    rect(142, 10, 325, 355);
}
void draw() {
    //background(26,169,3);
    dibujarBotones();
    if (habilitado){
        dibujarNumeros();
        habilitado=false;
    }
}
void dibujarBotones(){
    for (int i = 0; i < 4; ++i) { //vertical
        for (int j = 0; j < 4; j++) { // horizontal
            fill(actualizar(rectx,recty));
            rect(rectx, recty, ancho, largo);
            rectx+=separacion+ancho;
        }
        rectx=150;
        recty+=separacion+largo;
    }
    recty=150;
}
color actualizar(int hola1, int hola2){
    habilitado=true;
    numeros=1;
    for (int i = 0; i < 4; i++) {
        int limitex=hola1+ancho;
        int limitey=hola2+largo;
        for (int j = 0; j < 4;j++) {
            if (mouseX > hola1 && limitex > mouseX && mouseY > hola2 && mouseY < limitey) {
                return color(200);
            }
        }
    }
    return color(115,115,115,30);
}
void dibujarNumeros(){
    fill(0);
    textSize(15);
    // --> SIGNOS <--
    text("del", 150+ancho/2-5,150+largo/2+5+(largo+separacion)*3);
    text("0", 150+ancho/2-5+ancho+separacion,150+largo/2+5+(largo+separacion)*3);
    text("=", 150+ancho/2-5+(ancho+separacion)*2,150+largo/2+5+(largo+separacion)*3);
    text("*", 150+ancho/2-5+(ancho+separacion)*3,150+largo/2+5+(largo+separacion)*0);
    text("/", 150+ancho/2-5+(ancho+separacion)*3,150+largo/2+5+(largo+separacion)*1);
    text("+", 150+ancho/2-5+(ancho+separacion)*3,150+largo/2+5+(largo+separacion)*2);
    text("-", 150+ancho/2-5+(ancho+separacion)*3,150+largo/2+5+(largo+separacion)*3);    
    for (int j = 0; j < 3; ++j) {
        for (int k = 0; k < 3; ++k) {
            fill(0);
            textSize(15);
            if(numeros<10){
                text(numeros,rectx+ancho/2+(ancho+separacion)*k-5,recty+largo/2+(largo+separacion)*j+5);
                 numeros++;
            }
        }
    }
}
void mouseClicked(){
    String digitoPulsado=queBotonAprete();
    if(digitoPulsado != "=" && digitoPulsado != "" && digitoPulsado != "del"){
        if (calculado) {
            calculado=false;
            texto_calculadora="";
        }
        texto_calculadora+=digitoPulsado;
        noStroke();
        fill(26,169,3);
        rect(150,115,400,30);
        textSize(30);
        fill(0, 0, 0);
        text(texto_calculadora,425-posicion_numeros_calculadora,140);
        posicion_numeros_calculadora+=18;
    }else if (digitoPulsado.equals("del") && texto_calculadora.length() > 0) {
        println(texto_calculadora.substring(texto_calculadora.length()-1));
        println("texto_calculadora: "+texto_calculadora);
        texto_calculadora=texto_calculadora.substring(0,texto_calculadora.length()-1);
        println("texto_calculadora1: "+texto_calculadora);
        noStroke();
        fill(26,169,3);
        rect(150,115,400,30);
        textSize(30);
        fill(0, 0, 0);
        text(texto_calculadora,425-posicion_numeros_calculadora,140);
        posicion_numeros_calculadora-=18;
    }
    else {
        texto_calculadora=str(calcular(texto_calculadora));
        noStroke();
        fill(26,169,3);
        rect(150,115,400,30);
        textSize(30);
        fill(0, 0, 0);
        posicion_numeros_calculadora=texto_calculadora.length()*18;
        text(texto_calculadora,425-posicion_numeros_calculadora,140);
        calculado=true;
    }
}
int calcular(String operaciones){
    for (int i = 0; i < 4; ++i) {
        if(operaciones.indexOf(signos[ i ])   > 0){
            primerNumero = operaciones.substring(0,operaciones.indexOf(signos[i]));
            operacion = operaciones.substring(operaciones.indexOf(signos[i]),operaciones.indexOf(signos[i])+1);
            segundoNumero = operaciones.substring(operaciones.indexOf(signos[i])+1);
            break;
        }   
    }
    if (operacion.equals("*")) {
        println("El resultado es: ",int(primerNumero)*int(segundoNumero));
        return int(primerNumero)*int(segundoNumero);
    }else if (operacion.equals("/")) {
        if (int(segundoNumero) != 0) {
            return int(primerNumero)/int(segundoNumero);
        }else{
            return 0;
        }
    }
    else if (operacion.equals("+")) {
        return int(primerNumero)+int(segundoNumero);
    }
    else if (operacion.equals("-")) {
        return int(primerNumero)-int(segundoNumero);
    }

    return 0;
}
String queBotonAprete(){
    if (mouseX > 150 && mouseX < 150+ancho) { //Columna 1 = 1,4,7,punto "."
        if (mouseY > 150 && mouseY < 150 + largo) { //1
            return "1";
        }
        if (mouseY > 150+largo+separacion && mouseY < 150 + largo*2+separacion) { //4
            return "4";
        }
        if (mouseY > 150+(largo+separacion)*2 && mouseY < 150 + largo*3+2*separacion) { //7
            return "7";
        }
        if (mouseY > 150+(largo+separacion)*3 && mouseY < 150 + largo*4+3*separacion) { //. (punto)
            return "del";
        }
    }
    if (mouseX > 150+ancho+separacion && mouseX < 150+ancho*2+separacion) { //Columna2 = 2,5,8,0
        if (mouseY > 150 && mouseY < 150 + largo) { //1
            return "2";
        }
        if (mouseY > 150+largo+separacion && mouseY < 150 + largo*2+separacion) { //4
            return "5";
        }
        if (mouseY > 150+(largo+separacion)*2 && mouseY < 150 + largo*3+2*separacion) { //7
            return "8";
        }
        if (mouseY > 150+(largo+separacion)*3 && mouseY < 150 + largo*4+3*separacion) { //. (punto)
            return "0";
        }
    }
    if (mouseX > 150+(ancho+separacion)*2 && mouseX < 150+ancho*3+2*separacion) { //Columna 3 = 3,6,9,=
        if (mouseY > 150 && mouseY < 150 + largo) { //1
            return "3";
        }
        if (mouseY > 150+largo+separacion && mouseY < 150 + largo*2+separacion) { //4
            return "6";
        }
        if (mouseY > 150+(largo+separacion)*2 && mouseY < 150 + largo*3+2*separacion) { //7
            return "9";
        }
        if (mouseY > 150+(largo+separacion)*3 && mouseY < 150 + largo*4+3*separacion) { //. (punto)
            return "=";
        }
    }
    if (mouseX > 150+(ancho+separacion)*3 && mouseX < 150+ancho*4+3*separacion) { //Columna 4 = *,/,+,-
        if (mouseY > 150 && mouseY < 150 + largo) { //1
            return "*";
        }
        if (mouseY > 150+largo+separacion && mouseY < 150 + largo*2+separacion) { //4
            return "/";
        }
        if (mouseY > 150+(largo+separacion)*2 && mouseY < 150 + largo*3+2*separacion) { //7
            return "+";
        }
        if (mouseY > 150+(largo+separacion)*3 && mouseY < 150 + largo*4+3*separacion) { //. (punto)
            return "-";
        }
    }
    return "";
}