class Agent{
  
  PVector p,v,a;
  PVector fo=new PVector(0,0);

  Agent(float x, float y){
    p=new PVector(x,y);
    v=new PVector(0,0);
    a=new PVector(0,0);
  }
  
  void force(PVector f){
   fo.add(f);
  }
  
  float maxf=1;
  float vlim=1;
  
  void upd(){
    fo.setMag(maxf);
    PVector st=PVector.sub(fo,v);
    st.normalize().mult(maxf);
    a.add(st);
    v.add(a);
    v.limit(vlim);
    p.add(v);
    a.mult(0);
    fo.mult(0);
  }
    
  
}
