/* @pjs transparent=true; */

// Comp
// LIGHTWOMB INTERACTIVE
// By Jared Boria

// ----------------------------------------------------------------------
// Javascript 
// ----------------------------------------------------------------------
JavaScript tojplaya;

interface JavaScript {
  // Player functions
  void click(int bn); 
  void stop();
  void pause();
  void playhead();
  void volume();
  void getCurrentTIME();
  // Sizing
  void start_size();
  // Misc
  void showXYCoordinates();
  // Display
  void showTransport();
}

// random relative window global variables
float deadcenterX;
float deadcenterY;

void bindtojplaya(JavaScript jaavs) { // name of function has to match function in '.js' file
  tojplaya = jaavs;
} // end of void

void sizing(float w_, float h_) {
  private float w = w_;
	private float h = h_;
	
	private float sketch_w = w;
	private float sketch_h = h;
	
  size(sketch_w, sketch_h);	// * RESIZE *
  
  deadcenterX = w/2;
  deadcenterY = h/2; 
  redraw();
}	// end of void

void loop_sketch() {
	loop();
}	// end of void

void noLoop_sketch() {
	noLoop();
}	// end of void


// -----------------------------------------------------------------------
// GLOBAL VARIABLES
// -----------------------------------------------------------------------
int counter = 0;
color undercolor = color(250); 
int fr = 30;
/*
  Composite Objects
  An object can include several other objects. Creating such composite objects 
  is a good way to use the principles of modularity and build higher levels of 
  abstraction within a program.
 */
boolean alreadyon = false; 

boolean vis = true;

Pattern pat;
Transport tranny;

class Nodo {
  float x, y;
  float d = 10.0;
  float num;
  float data;
  boolean over; 

  Nodo(float _x, float _y, float _num, float _data) {
    x = _x;
    y = _y;
    num = _num;
    data = _data;
    over = false;
    
  } // end of constructor (Nodo)

  void checkOver() {
   if (!alreadyon) {
      float dis = dist(mouseX, mouseY, x, y);
      if (dis <= d/2) {
        over = true;
      }
      else {
        over = false;
      }
    }
  } // end of void

  void draw_nodo() { // called from render
    int data_int = int(data);
    int num_int = int(num);
    pushStyle();
    if (over) {
      textSize(12);
      fill(255);
      text(data_int, x-12, y-10);
      textSize(10);
      fill(150);
      text(num_int, x, y-10);
      // ellipse style
      noStroke();
      fill(255);
    }
    else {      
      textSize(10);
      fill(100);
      text(data_int, x-12, y-10);
      textSize(8);
      fill(150);
      text(num_int, x, y-10);
      // ellipse style
      noStroke();
      ellipseMode(CENTER);
      fill(200,190,190, 100);
    }  
    ellipse(x, y, d, d);
    popStyle();
  } // end of void

  void render() {
    if (vis) {
    checkOver();
    draw_nodo();
   	}
  } // end of void

} // end of class

class Pattern {
	float xTrans, yTrans;

  // NODE NODE NODE NODE
  int numDataFilesSTART = 6; 
  int num_dataFILES_current = numDataFilesSTART; // number of used strings that you start with

  String[][] txtStrings = new String[100][];
  float[] numLinesOF = new float[100];

  int numDataFilesTOTAL;
  float[] numLinesTOTAL = new float[100];

  boolean vis = false;
  color bgColor = color(50);

  int ts_dataFILE = 2;

  Nodo[][] nodos;

  Pattern(int x, int y, int w, int h) {
    for (int i=0; i < num_dataFILES_current; i++) {
      txtStrings[i] = loadStrings("data/data" + i + ".txt");
      numLinesOF[i] = txtStrings[i].length; // creation of array
    }    

    nodos = new Nodo[txtStrings.length][numLinesOF.length];

    numDataFilesTOTAL = num_dataFILES_current;

    for (int dataFile = 0; dataFile < numDataFilesTOTAL; dataFile++) {
      numLinesTOTAL[dataFile] = numLinesOF[dataFile]; // numLinesTOTALis being updated each time through for loop   
      for (int lineNumber = 0; lineNumber < numLinesTOTAL[dataFile]; lineNumber++) {  
        float[] values = float(split(txtStrings[dataFile][lineNumber], ","));
        //dataDisplay(dataFile, lineNumber, values);
        nodos[dataFile][lineNumber] = new Nodo(values[0], values[1], values[2], values[3]);
      }
    }
  } // end of constructor

    // line 
	void display(int x_, int y_, float scale_) {
		xTrans = x_;
    	yTrans = y_;
    	float scaled = scale_;
    
		int dataFILE = ts_dataFILE; 
		for (int line_num = 0; line_num < numLinesTOTAL[dataFILE]; line_num++) {  
			nodos[dataFILE][line_num].render();
		}    
		
		pushMatrix();
		translate(xTrans, yTrans);
		pushMatrix();
		scale(scaled);

		// Line Style
		stroke(250, 200);
		strokeWeight(1);
		noFill();   		
		
		// shape 
		beginShape(); 
		vertex(nodos[dataFILE][0].x, nodos[dataFILE][0].y);     
		for (int i = 1; i < (numLinesTOTAL[dataFILE] - 2); i+=3) {				
			bezierVertex(
			nodos[dataFILE][i].x, 
			nodos[dataFILE][i].y, 
			nodos[dataFILE][i+1].x, 
			nodos[dataFILE][i+1].y, 
			nodos[dataFILE][i+2].x, 
			nodos[dataFILE][i+2].y
				);
			float x = bezierPoint(
			nodos[dataFILE][i-1].x, 
			nodos[dataFILE][i].x, 
			nodos[dataFILE][i+1].x, 
			nodos[dataFILE][i+2].x, 
			tranny.pulse
				);
			float y = bezierPoint(
			nodos[dataFILE][i-1].y, 
			nodos[dataFILE][i].y, 
			nodos[dataFILE][i+1].y, 
			nodos[dataFILE][i+2].y, 
			tranny.pulse
			
				);
			// Draw Circle at Beat Location
			pushStyle();
			noStroke();			
			if(nodos[dataFILE][i].data == tranny.beat_num){
				fill(255);
				ellipse(x, y, 20, 20);
			}
			popStyle();
		}
		endShape();
		popMatrix();
		popMatrix();
	} // end of void
	void released() {
		for (int k=0; k< numDataFilesTOTAL; k++) {
			for (int i = 0; i < numLinesTOTAL[k]; i++) {
				pat.nodos[k][i].over = false;
			}
		}
	} // end of void
	void dragged() {
		boolean overconnect = false;
		int second_last;
		int last;
		for (int numTXT=0; numTXT< numDataFilesTOTAL; numTXT++) {   
			for (int i = 0; i < numLinesTOTAL[numTXT]; i++) {
				int second_last = int(numLinesTOTAL[numTXT]-2);
				int last = int(numLinesTOTAL[numTXT]-1);
				if (nodos[numTXT][i].over == true) {
					// 1st node
					if (i==0) {
						if (nodos[numTXT][i].x > nodos[numTXT][i+1].x) {
							nodos[numTXT][i+1].x = mouseX - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i+1].x, mouseY));
						}
						if (nodos[numTXT][i].x < nodos[numTXT][i+1].x) {
							nodos[numTXT][i+1].x = mouseX + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i+1].x, mouseY));
						}
						if (nodos[numTXT][i].y > nodos[numTXT][i+1].y) {
							nodos[numTXT][i+1].y = mouseY - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i+1].y));
						}
						if (nodos[numTXT][i].y < nodos[numTXT][i+1].y) {
							nodos[numTXT][i+1].y = mouseY + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i+1].y));
						}
						// end of string of nodos
						if (nodos[numTXT][last].x > nodos[numTXT][second_last].x ) {
							nodos[numTXT][second_last].x = mouseX - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][second_last].x, mouseY));
						}
						if (nodos[numTXT][last].x < nodos[numTXT][second_last].x ) {
							nodos[numTXT][second_last].x = mouseX + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][second_last].x, mouseY));
						}
						if (nodos[numTXT][last].y > nodos[numTXT][second_last].y) {
							nodos[numTXT][second_last].y = mouseY - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][second_last].y));
						}
						if (nodos[numTXT][last].y < nodos[numTXT][second_last].y) {
							nodos[numTXT][second_last].y = mouseY + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][second_last].y));
						}
						nodos[numTXT][i].x = mouseX;
						nodos[numTXT][i].y = mouseY;
						overconnect = true;
					}
					// all middle anchor nodes
					int num = int(i/3); // esto es para ver si i es múltiplo de tres
					if ((i/3) == num) {       
						if (i>0 && i<last) {
							if (nodos[numTXT][i].x > nodos[numTXT][i+1].x) {
								nodos[numTXT][i+1].x = mouseX - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i+1].x, mouseY));
							}
							if (nodos[numTXT][i].x < nodos[numTXT][i+1].x) {
								nodos[numTXT][i+1].x = mouseX + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i+1].x, mouseY));
							}
							if (nodos[numTXT][i].y > nodos[numTXT][i+1].y) {
								nodos[numTXT][i+1].y = mouseY - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i+1].y));
							}
							if (nodos[numTXT][i].y < nodos[numTXT][i+1].y) {
								nodos[numTXT][i+1].y = mouseY + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i+1].y));
							}
							if (nodos[numTXT][i].x > nodos[numTXT][i-1].x ) {
								nodos[numTXT][i-1].x = mouseX - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i-1].x, mouseY));
							}
							if (nodos[numTXT][i].x < nodos[numTXT][i-1].x ) {
								nodos[numTXT][i-1].x = mouseX + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i-1].x, mouseY));
							}
							if (nodos[numTXT][i].y > nodos[numTXT][i-1].y) {
								nodos[numTXT][i-1].y = mouseY - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i-1].y));
							}
							if (nodos[numTXT][i].y < nodos[numTXT][i-1].y) {
								nodos[numTXT][i-1].y = mouseY + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i-1].y));
							}
						}
						nodos[numTXT][i].x = mouseX;
						nodos[numTXT][i].y = mouseY;
					}    
	
					for (int j = 0; j < numLinesTOTAL[numTXT]; j++) {
						if (j != i) {
							nodos[numTXT][j].over = false;
						}
					}
					if (overconnect) {			
						nodos[numTXT][0].x = mouseX;
						nodos[numTXT][0].y = mouseY;
						nodos[numTXT][last].x = mouseX;
						nodos[numTXT][last].y = mouseY;
					}
				} // end of if(nodos[numTXT][i].over == true) {...}
			}
		}
	} // end of void
	void dragged2() {	
		for (int numTXT=0; numTXT< numDataFilesTOTAL; numTXT++) { 
			for (int i = 0; i < numLinesTOTAL[numTXT]; i++) {	
				int second_last = int(numLinesTOTAL[numTXT]-2);
				int last = int(numLinesTOTAL[numTXT]-1);
	
				if (nodos[numTXT][i].over == true) { 		
					// if not an anchor node 
					int num = int(i/3);
					if ((i/3) != num) {       	
						nodos[numTXT][i].x = mouseX;
						nodos[numTXT][i].y = mouseY;
					}			
	
					// 2nd node
					if (i==1) {			
						if (nodos[numTXT][i].x > nodos[numTXT][second_last].x) {
							nodos[numTXT][second_last].x = nodos[numTXT][0].x - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][0].x, mouseY));
						}
						if (nodos[numTXT][i].x < nodos[numTXT][second_last].x) {
							nodos[numTXT][second_last].x = nodos[numTXT][0].x + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][0].x, mouseY));
						}
						if (nodos[numTXT][i].y > nodos[numTXT][second_last].y && nodos[numTXT][i].y > nodos[numTXT][0].y) {
							nodos[numTXT][second_last].y = nodos[numTXT][0].y - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][0].y));
						}
						if (nodos[numTXT][i].y > nodos[numTXT][second_last].y && nodos[numTXT][i].y < nodos[numTXT][0].y) {
							nodos[numTXT][second_last].y = nodos[numTXT][0].y + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][0].y));
						}
						if (nodos[numTXT][i].y < nodos[numTXT][second_last].y) {
							nodos[numTXT][second_last].y = nodos[numTXT][0].y + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][0].y));
						}
					}	
					// baton nodos
					if (i>1 && nodos[numTXT][i].num == 1) {
						if (nodos[numTXT][i].x > nodos[numTXT][i-2].x ) {
							nodos[numTXT][i-2].x = nodos[numTXT][i-1].x - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i-1].x, mouseY));
						}
						if (nodos[numTXT][i].x < nodos[numTXT][i-2].x ) {
							nodos[numTXT][i-2].x = nodos[numTXT][i-1].x + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i-1].x, mouseY));
						}
						if (nodos[numTXT][i].y > nodos[numTXT][i-2].y) {
							nodos[numTXT][i-2].y = nodos[numTXT][i-1].y - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i-1].y));
						}
						if (nodos[numTXT][i].y < nodos[numTXT][i-2].y) {
							nodos[numTXT][i-2].y = nodos[numTXT][i-1].y + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i-1].y));
						}
					}
					// baton nodos that are not 2nd to last
					if (i>1 && i < numLinesTOTAL[numTXT]-2 && nodos[numTXT][i].num == 2) {
						if (nodos[numTXT][i].x > nodos[numTXT][i+2].x ) {
							nodos[numTXT][i+2].x = nodos[numTXT][i+1].x - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i+1].x, mouseY));
						}
						if (nodos[numTXT][i].x < nodos[numTXT][i+2].x ) {
							nodos[numTXT][i+2].x = nodos[numTXT][i+1].x + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][i+1].x, mouseY));
						}
						if (nodos[numTXT][i].y > nodos[numTXT][i+2].y) {
							nodos[numTXT][i+2].y = nodos[numTXT][i+1].y - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i+1].y));
						}
						if (nodos[numTXT][i].y < nodos[numTXT][i+2].y) {
							nodos[numTXT][i+2].y = nodos[numTXT][i+1].y + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][i+1].y));
						}
					}
					//2nd to last node
					if (i>0 && i==(numLinesTOTAL[numTXT]-2)) {
						if (nodos[numTXT][i].x > nodos[numTXT][1].x ) {
							nodos[numTXT][1].x = nodos[numTXT][0].x - abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][0].x, mouseY));
						}
						if (nodos[numTXT][i].x < nodos[numTXT][1].x ) {
							nodos[numTXT][1].x = nodos[numTXT][0].x + abs(dist(nodos[numTXT][i].x, mouseY, nodos[numTXT][0].x, mouseY));
						}
						if (nodos[numTXT][i].y > nodos[numTXT][1].y) {
							nodos[numTXT][1].y = nodos[numTXT][0].y - abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][0].y));
						}
						if (nodos[numTXT][i].y < nodos[numTXT][1].y) {
							nodos[numTXT][1].y = nodos[numTXT][0].y + abs(dist(mouseX, nodos[numTXT][i].y, mouseX, nodos[numTXT][0].y));
						}
					}
	
					for (int j = 0; j < numLinesTOTAL[numTXT]; j++) {
						if (j != i) {
							nodos[numTXT][j].over = false;
						}
					}
				}
			}
		}
	} // end of void 
} // end of class


class Transport {// TEMPO CONTROL  
  float BPM = 100; 
  // Time Signature
  int ts_top=4;
  int ts_bottom=4;
  //	Calculations
  float MsPB = 60000 / BPM;  
  float beatStart = millis();  
  float nextBeat = beatStart + MsPB;   
  float pulseWidth = 1 / MsPB; // time in ms to next beat (fraction)  
  float pulseClock;  
  float pulse = 0; // for sin() function in rendering
  boolean switched = false;
  String beatinfo;

  // Counted Display for User
  int beat = 0;
  int measure = 0;
  float beat_num = 0;
  
  void doitall(){	
  	MsPB = 60000 / BPM;
		pulser();
		beat_calculation(6);
		calculate_measure();
  }

  void pulser() {  
    pulseClock = (1 / MsPB) * (beatStart - millis());      	
    pulse = abs(pulseClock);
    // beat shit
    if (millis() >= nextBeat) {    
      beatStart = millis();  
      nextBeat = beatStart + MsPB;
    }
  } // end of void
  
  void beat_calculation(float b) { 
    float beat_division = b;

    if (beat_division == 6) {
      if (pulse < 1/beat_division && !switched) {    
        beatinfo = "(1)";
        beat++;
        if (beat_num < ts_top) {
          beat_num++;
          tojplaya.click(beat_num);
        } 
        else {
          beat_num = 1;
          tojplaya.click(beat_num);
        }
        switched = true;
      }
      if (pulse > 1/beat_division) {    
        beatinfo = "(2)";
      }
      if (pulse > (2/beat_division)) {    
        beatinfo = "(3)";
      }
      if (pulse > 3/beat_division) {    
        beatinfo = "(4)";
      }
      if (pulse > (4/beat_division)) {    
        beatinfo = "(5)";
      }
      if (pulse > (5/beat_division)) {    
        beatinfo = "(6)";
        switched = false;
      }
    }
    if (beat_division == 4) {
      if (pulse < 1/beat_division && !switched) {    
        beatinfo = "(1)";
        beat++;
        if (beat_num < ts_top) {
          beat_num++;
        } 
        else {
          beat_num = 1;
        }
        switched = true;
      }
      if (pulse > 1/beat_division) {    
        beatinfo = "(2) ee";
      }
      if (pulse > (2/beat_division)) {    
        beatinfo = "(3) and";
      }
      if (pulse > (3/beat_division)) {    
        beatinfo = "(4) ah";
        switched = false;
      }
    }
    if (beat_division == 3) {
      if (pulse < 1/beat_division && !switched) {    
        beatinfo = "(1)";
        beat++;
        if (beat_num < ts_top) {
          beat_num++;
        } 
        else {
          beat_num = 1;
        }
        switched = true;
      }
      if (pulse > 1/beat_division) {    
        beatinfo = "(2)";
      }
      if (pulse > (2/beat_division)) {    
        beatinfo = "(3)";
        switched = false;
      }
    }   
    if (beat_division == 2) {
      if (pulse < 1/beat_division && !switched) {    
        beatinfo = "(1)";
        beat++;
        if (beat_num < ts_top) {
          beat_num++;
        } 
        else {
          beat_num = 1;
        }
        switched = true;
      }
      if (pulse > 1/beat_division) {    
        beatinfo = "(2)";
        switched = false;
      }
    }
  } // end of void
  
  void calculate_measure() {
    measure =  1 + (beat-1)/ts_top;
  } // end of void
  
} // end of class

int timesTHRUsetup = 0;
void setup() {
	background(0, 0, 0, 0); 
  //size(800, 800);
  smooth();
  pat = new Pattern(100, 100, 100, 300);
  tranny = new Transport();
  timesTHRUsetup++;
} // end of setup()

void draw() {
  if (tojplaya != null) {
    counter++; // start counter if javascript is ready
    if (counter==1) {
      tojplaya.start_size();
      noLoop();
    }  
    //tojplaya.showXYCoordinates(mouseX, mouseY); 
  }
  if (counter > 1) {
		background(70,70,150,10);
		showTranny(); 
		pat.display(0,0,1); 
		fill(200);
		//text("timesTHRUsetup ~ " + timesTHRUsetup, 20, 20);
  } // end of if 

  if(counter>3){
  		tranny.doitall();  
	}
		    

} // end of draw()


void tempo_increase() {
	tranny.BPM += 1;
	tranny.doitall();
}	// end of void
void tempo_decrease() {
	tranny.BPM -= 1;
	tranny.doitall();
}	// end of void


void mousePressed() {
  alreadyon = true;
} // end of mousePressed
void mouseReleased() {
  alreadyon = false;
  pat.released();
} // end of mouseReleased
void mouseDragged() {
  pat.dragged();
  pat.dragged2();
} // end of mouseDragged
void mouseClicked() {
  //  setup();
  //  redraw(); 
  //tojplaya.setTextSize(browser_width*.9, browser_height*.4);
} // end of mouseClicked

void showTranny() {
	tojplaya.showTransport(
    "Total", tranny.beat, 
    "Beat", tranny.beat_num, 
    "BPM", tranny.BPM, 
    "Meter", tranny.ts_top, tranny.ts_bottom, 
    "Bar", int(tranny.measure)
      );
      }