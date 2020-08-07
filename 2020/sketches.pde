int posicionInicialX;
int posicionInicialY;
int posicionFinalY;
int posicionFinalX;
boolean enabled = true;
class Pelotas {
    float speedy;
    float speedx;
    float radio;
    float x=width/2;
    float y;
    color colores=color(random(0,255),random(0,255),random(0,255),200);;
    int angle = round(random(0,180));
    public Pelotas(float speed,float radio) {
        speedx=speed;
        speedy=speed;
        this.radio=radio;
        y=height-radio;
    }
    void rebotarHaciaArribaOAbajo(){
        speedy=speedy*-1;
    }
    void rebotarHaciaDerechaOIzquierda(){
        speedx=speedx*-1;
    }
    void lanzarPelota(float angulo){
        y-=sin(angulo)*speedy;
        x+=cos(angulo)*speedx;
    }
}
int cantidadDePelotas=10;
Pelotas pelota[] = new Pelotas[cantidadDePelotas];
void setup() {
    size(1920, 1000);
    for (int i = 0; i < pelota.length; ++i) {
        pelota[i]= new Pelotas(random(1,100),round(random(1,179)));
    }
}
void draw() {
    background(0);
    for (int i = 0; i < pelota.length; ++i) {
        pelota[i].lanzarPelota(radians(90));
        if (pelota[i].x >= width-pelota[i].radio/2 || pelota[i].x-pelota[i].radio/2 <= 1 ) {
            pelota[i].rebotarHaciaDerechaOIzquierda();
            }
        else if(pelota[i].y > height-pelota[i].radio/2 || pelota[i].y-pelota[i].radio/2 <= 1){
                pelota[i].rebotarHaciaArribaOAbajo();
            }
        fill(pelota[i].colores);
        ellipse(pelota[i].x, pelota[i].y, pelota[i].radio, pelota[i].radio);
    }
}
void mousePressed() {
    rect(posicionInicialX, posicionInicialY, dist(posicionInicialX, posicionInicialY, mouseX, mouseY), 80);
}
void mouseDragged(){
    if (enabled) {
    posicionInicialX=mouseX;
    posicionInicialY=mouseY;
    enabled=false;
    }
    fill(255);
    rect(posicionInicialX, posicionInicialY, dist(posicionInicialX, posicionInicialY, mouseX, mouseY), 80);
}
void mouseReleased() {
    posicionFinalX=mouseX;
    posicionFinalY=mouseY;
    enabled=true;
    for (int i = 0; i < pelota.length; ++i) {
        pelota[i].speedx=dist(posicionInicialX, posicionInicialY, posicionFinalX, posicionFinalY)/10;
        pelota[i].speedy=dist(posicionInicialX, posicionInicialY, posicionFinalX, posicionFinalY)/10;
    }
}