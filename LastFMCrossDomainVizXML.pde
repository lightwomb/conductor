Preloader preloader;
Boolean xmlLoading;
XMLElement xml;
Artist [] artists;
int numArtistsDisplayed;
static int count;
int mappedWidth;
color bgCol;

void setup()
{
  println("Last.fm Data Visualization with cross-domain xml");
  //println("Test php proxy with: http://autumn8.co.za/processing-js/getXML.php?file=http://ws.audioscrobbler.com/2.0/user/loBoobOscill8r/topartists.xml?period=3month");
  xmlLoading = true;
  bgCol = #FFFFFF; //#E8F1F2;
  preloader = new Preloader();
  numArtistsDisplayed = 20;
  count = 0;
  size(600,420);
  background(bgCol);
  artists = new Artist[numArtistsDisplayed]; 
  textAlign(CENTER, CENTER);
  fill(0);
  text("Loading", width/2, height/2);         
}

void draw()
{
  if (xmlLoading) 
  {
    preloader.animate();
  }
}

void parseXML(String xml)
{
  xmlLoading = false;
  background(bgCol);
  XMLElement data = new XMLElement(xml); 
 
  for (int i = 0; i< numArtistsDisplayed; i++)
  {
    XMLElement artist = data.getChild(i); 
    String name = artist.getChild(0).getContent();
    int playCount = int(artist.getChild(1).getContent());
    artists[i] = new Artist(name, playCount);
  }
}

class Artist 
{
  PFont font;
  String artist;
  int playCount;
  int bgWidth = 400;
  int playMaxWidth = 300;
  int bgHeight = 20;
  float mappedCount;
  color col;
  String leadingSpace;

  
  Artist(String _artist, int _playCount)
  {
    artist = _artist;
    playCount = _playCount;
    noStroke();
    textAlign(BASELINE);
    drawBackground();
    drawPlayCount();
    writePlayCount();
    writeArtistName();
    translate(0, bgHeight+1);  
    count++;    
  }
  
 void drawBackground()
  {
    color col = (count %2==0) ? #E5E5E5 : #FFFFFF;
    fill(col);
    rect(0, 0, bgWidth, bgHeight);    
  }
  
  void drawPlayCount()
  { 
    if (count==0) 
    {
      mappedWidth = playCount;
    }
    fill(#95DDEA);
    mappedCount = map(playCount, 0, mappedWidth, 0, playMaxWidth);
    rect(bgWidth, 0, mappedCount, bgHeight);        
 }
 
 void writePlayCount()
 {
   fill(0);
   text(playCount, bgWidth + 6, 11);
 }

  void writeArtistName()
  {    
    fill(0);    
    leadingSpace = count<9 ? "  " : "";
    text(leadingSpace + (count+1) + "      "  + artist, 5, 11);    
  }  
}

class Preloader
{
  int numSpokes = 8;  
  float rot = 360/numSpokes;
  float totalRot = 0;
  int interval = 15;
  int counter = 0;

  Preloader()
  {
    noStroke();
  }

  void animate()
  { 
    if (interval==counter)
    {
      counter=0;
      totalRot+=360/numSpokes;
    }
    else
    {
      counter++;
    }    
    background(bgCol);
    translate(width/2, height/2);
    pushMatrix();
      rotate(radians(totalRot));
      for (int i = 0 ; i<numSpokes;  i++)
      {
        rotate(radians(360/numSpokes));
        fill(0,0,0, 10*i + 20);
        ellipse(-2,10, 5,5);
        //rect(-2, 7, 4, 10);
      }
    popMatrix();    
  }

}