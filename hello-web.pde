
// Global variables
float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 16;
PImage bmp_top_net;
PImage[] bmp_sprite = new Pimage[136];

String lines[] = loadStrings("list.txt");

/*PITCH VARIABLES*/
int Pitch_x = 50;
int Pitch_y = 50; 
int Pitch_w = 832;
int Pitch_h	= 992;
int Pitch_middle_w = int(Pitch_w / 2) + Pitch_x;
int Pitch_middle_h = int(Pitch_h/2) + Pitch_y;
int Xm = int (Pitch_w / 2) + Pitch_x;
int Ym = int(Pitch_h / 2) + Pitch_y;
int Paw = int (Pitch_w / 3 );//half penalty area width
int Pah = int (Pitch_h / 6); //penalty area height
int Pac = int (Pitch_w / 10); //penalty area circle diameter
int Padw = 2; //penalty dish diameter
int Padd = int (Pah / 2);//penalty dish distance from net
int Gkw = int (Paw / 2); //half goalkeeper area width
int Gkh = int (Pah / 3); //goalkeeper area height
int Cxo = 0;
int Cyo = 0;


// Setup the Processing Canvas
void setup(){
	size( 640, 480 );
	strokeWeight( 10 );
	frameRate( 15 );
	X = width / 2;
	Y = width / 2;
	nX = X;
	nY = Y; 
	bmp_top_net = loadImage("net_top.png"); 
	int a;
	int b;
	for (a=0;a<136;a++){
		b = a +1
		bmp_sprite[a] = loadImage("img/_"+b+".png");
	}
	//
}

// Main draw loop
void draw(){
  
  // Track circle to new destination
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;
  
  Cxo -= -(nX-X)/10
  Cyo -= -(nY-Y)/10
  // Fill canvas green
  background( #00AA00 );
  
// println();


 /* line(50, 74, 590, 74);
  line(50, 74, 50, 400);
  line(590, 74, 590, 400);
  fill(#00AA00);
  rect(100, 74, 440, 150);
  rect(200, 74, 250, 50);
  ellipse( 320, 180, 3, 3 );  */
  
  


  //Draw background pitch
  draw_pitch_lines ( 	Pitch_x, Pitch_y, Pitch_w, Pitch_h, Xm, Ym, Paw, Pah,
						Pac, Padw, Padd, Gkw, Gkh, Cxo, Cyo);
  

	stroke (#005500);
	ellipse (X + int(cos(_abtp(mouseX,mouseY,X,Y))*10)+10,Y + int(-sin(_abtp(mouseX,mouseY,X,Y))*10)+20,7,2)
	fill(#FFFFFF);
	stroke (#FFFFFF);
	ellipse (X + int(cos(_abtp(mouseX,mouseY,X,Y))*10)+10,Y + int(-sin(_abtp(mouseX,mouseY,X,Y))*10)+15,7,7)
  image( bmp_sprite[start_frame(_abtp(mouseX,mouseY,X,Y))+frameCount%6], X, Y-5);
   
    println("Frame " + frameCount + "X" + int(X) + "; Y" + int(Y));       
}

// Set circle's next destination

void mouseMoved(){
  nX = mouseX;
  nY = mouseY;  
}

float _abtp(int x1, int y1, int x2, int y2) {
	return -atan2(y1-y2,x1-x2);
}

int start_frame (float radiants){
    int degree;
    //convert radiants to 360° degree
    degree = (180-int(radiants*180/PI));
    if (degree < 23) {
		return 68;
	} else if (degree < 68){
		return 51;
	} else if (degree < 113){
		return 34;
	} else if (degree < 158){
		return 17;
	} else if (degree < 203){
		return 0;
	} else if (degree < 248){
		return 119;
	} else if (degree < 293){
		return 102;
	} else if (degree < 338){
		return 85;
	} else if (degree < 361){
		return 68;
	}
}

void draw_pitch_lines ( int x, int y, int w, int h, int xm, int ym, int paw,
                        int pah /*penalty area height*/,
                        int pac /*penalty area circl diameter*/,
                        int padw /*'penalty dish diameter*/,
                        int padd /*penalty dish distance from net*/,
                        int gkw /*'half goalkeeper area*/,
                        int gkh, int cxo ,int cyo ) {
    strokeWeight(1);   // Default
	stroke (#FFFFFF);
    fill(#005500);
    //drawing the pitch's border lines
    rect (x - cxo, y - cyo,w , h );
    //middle pitch dish
    ellipse (xm - cxo, ym - cyo, pac, pac);
    //middle line, circle , dish
    line (x - cxo, ym - cyo,x + w - cxo, ym - cyo);
  
    //Top penalty area
    rect (xm - paw - cxo, y - cyo,paw*2, pah);
    //Top Gk area
    rect (xm - gkw - cxo, y - cyo,gkw*2,gkh);
    //Bottom penalty area
    rect (xm - paw - cxo, y + h - pah - cyo,paw*2, pah);
    //Bottom Gk area
    rect (xm - gkw - cxo, y + h - gkh - cyo,gkw*2, gkh);
      //top net
  image (bmp_top_net, Xm -50- Cxo, y-38-Cyo)
}


