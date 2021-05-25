//CurveGrowth by DeweshAgrawal


ArrayList<Agent> a=new ArrayList<Agent>();
int count=0;

void setup(){
  size(800,800);
  frameRate(40);
  background(255);
  ini();
}

void draw(){
  translate(width/2,height/2);
  rectMode(CENTER);
  blendMode(NORMAL);
  noStroke();
  ten();
  sep();
  update();
  rend();
  check();
  count++;
  //saveFrame();
}


//Update agent state
void update(){
  for(Agent aa:a){
    aa.upd();
  }
}


//Check for point addition in the curve
void check(){
  float dis;
  PVector mid;
  for(int i=a.size()-1;i>0;i--){
    dis=PVector.dist(a.get(i).p,a.get(i-1).p);
    if(dis>25 && count<500){
      mid=PVector.add(a.get(i).p,a.get(i-1).p);
      mid.mult(0.5);
      a.add(i,new Agent(mid.x,mid.y));
    }
  }
}


//Curve render function
void rend(){
  noFill();
  strokeWeight(map(count,0,200,0.1,0.1));
  stroke(map(count,0,200,255,120));
  curveTightness(-0.5);
  //blendMode(MULTIPLY);
  beginShape();
  for(Agent aa:a){
    curveVertex(aa.p.x,aa.p.y);
    //ellipse(aa.p.x,aa.p.y,bl,bl);
  }
  curveVertex(a.get(0).p.x,a.get(0).p.y);
  curveVertex(a.get(1).p.x,a.get(1).p.y);
  curveVertex(a.get(2).p.x,a.get(2).p.y);
  endShape();
}



int num=100;
float r=150;


//Initialization function
void ini(){
  float t;
  float ra=random(r*0.5,r*0.8);
  for(float i=0;i<num;i++){
    t=map(i,0,float(num),0,2*PI);
    a.add(new Agent(ra*cos(t),ra*sin(t)));
  }
}

  float bl=1.5*2*PI*r/num;
  float k=10;
  
  
//Maintaining tension in the curve  
void ten(){
  PVector f1,f2;
  int b,f;
  for(int i=0;i<a.size();i++){
    if(i==0){
      b=a.size()-1;
      f=i+1;
    }
    else if(i==a.size()-1){
      b=i-1;
      f=0;
    }
    else{
      b=i-1;
      f=i+1;
    }
    f1=PVector.sub(a.get(f).p,a.get(i).p);
    f1.setMag(k*(f1.mag()-bl));
    f2=PVector.sub(a.get(b).p,a.get(i).p);
    f2.setMag(k*(f2.mag()-bl));
    a.get(i).force(PVector.add(f1,f2));
    //a.get(f).force(f1.mult(-1));
    //a.get(b).force(f2.mult(-1));
  }
}

float sd=20;
float sk=500;


//Function to prevent overlapping 
void sep(){
  PVector f1;
  float dis;
  
  for(Agent aa:a){
    for(Agent bb:a){
      dis=PVector.dist(aa.p,bb.p);
      if(dis>0 && dis<bl*2.6){
        f1=PVector.sub(aa.p,bb.p);
        f1.setMag(sk/(dis));
        aa.force(f1);
        bb.force(f1.mult(-1));
      }
    }
  }
}
 
      
//Triggering rerun on mouse click      
void mousePressed(){
  a=new ArrayList<Agent>();
  ini();
  background(255);
  count=0;
}
      
      
  

    
