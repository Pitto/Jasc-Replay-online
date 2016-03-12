
// Global variables
float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 16;
PImage bmp_top_net;
PImage[] bmp_sprite = new Pimage[136];
int TOT_FRAMES = 60;
int Current_Frame = 0;

String Replay_Data[] = loadStrings("000.rep");
int Camera_Data[TOT_FRAMES][2];
int Ball_Data[TOT_FRAMES][4];
int Player_Data[TOT_FRAMES][22][3];
int Replay_Line = 0;


/*___________________PITCH VARIABLES_____________________*/
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
	
	int b;
	
	for (int a=0;a<136;a++){
		b = a +1
		bmp_sprite[a] = loadImage("img/_"+b+".png");
	}
	
	
	for (int frame=0; frame < TOT_FRAMES-1; frame++){
		/*store Camera Data*/
		int[] Camera_Data_Temp = int(split(Replay_Data[Replay_Line], ','));
		Camera_Data[frame][0] = Camera_Data_Temp[0];
		Camera_Data[frame][1] = Camera_Data_Temp[1];
		/*Store Players Data*/
		for (int c = 0; c < 22; c++ ) {
			Replay_Line++;
			int[] Player_Data_temp = int(split(Replay_Data[Replay_Line],','));
			Player_Data[frame][c][0] = Player_Data_temp[0];
			Player_Data[frame][c][1] = Player_Data_temp[1];
			Player_Data[frame][c][2] = Player_Data_temp[2];
		}
		/*Store Ball Data*/
		Replay_Line++;
		int[] Ball_Data_Temp = int(split(Replay_Data[Replay_Line],','));
		Ball_Data[frame][0] = Ball_Data_Temp[0];
		Ball_Data[frame][1] = Ball_Data_Temp[1];
		Ball_Data[frame][2] = Ball_Data_Temp[2];
		Ball_Data[frame][3] = Ball_Data_Temp[3];
		Replay_Line++;
	}
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

  //Draw background pitch
  draw_pitch_lines ( 	Pitch_x, Pitch_y, Pitch_w, Pitch_h, Xm, Ym, Paw, Pah,
						Pac, Padw, Padd, Gkw, Gkh, Cxo, Cyo);
  

	stroke (#005500);
	ellipse (X + int(cos(_abtp(mouseX,mouseY,X,Y))*10)+10,Y + int(-sin(_abtp(mouseX,mouseY,X,Y))*10)+20,7,2)
	fill(#FFFFFF);
	stroke (#FFFFFF);
	ellipse (X + int(cos(_abtp(mouseX,mouseY,X,Y))*10)+10,Y + int(-sin(_abtp(mouseX,mouseY,X,Y))*10)+15,7,7);
  for (int c = 0 ; c < 22; c++) {
	  image( bmp_sprite[Player_Data[0][2]], c*3, c*4);
  }
//   Camera_Data[0][0]=5;
  // println(Camera_Data[0][0]);
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


