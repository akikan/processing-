class Crista{
  int num;
  float rad;
  Crista(int num){
    this.num = num;
    rad = 360/(float)num;
    for(int i=0; i<num; i++){
      //arc( width/2, height/2, width, height, radians(i*rad), radians((i+1)*rad));
     // line(width/2, height/2, width/2*cos(radians(i*rad)) + width/2, height/2*sin(radians(i*rad))+height/2);
      //line(width/2, height/2, width/2*cos(radians((i+1)*rad))+ width/2, height/2*sin(radians((i+1)*rad))+height/2);
    }
    for(int i=0; i<num/2; i++){
      line( width*cos(radians( i   *rad))+250,height*sin(radians(i*rad))+250,
                width*cos(radians((i+num/2)*rad))+250,height*sin(radians((i+num/2)*rad))+250);
    }
    println(tan(radians(0)));
    
    println(rad);
  }
  
  void check(){
    float dis = sqrt(abs((mouseX-250)*(mouseX-250) + (mouseY-250)*(mouseY-250)));
    for(int i=0; i<num; i+=2){
      //if(( tan(radians(i*rad))*(mouseX-250) < mouseY-250 &&  mouseY-250 < tan(radians((i+1)*rad))*(mouseX-250))||
      //   ( tan(radians(i*rad))*(mouseX-250) > mouseY-250 &&  mouseY-250 > tan(radians((i+1)*rad))*(mouseX-250))){
           println(i);
          
        if( (abs(pmouseX-mouseX) >= 1) || (abs(pmouseY-mouseY) >= 1)){
          line(width/2+(mouseX-250)*cos(radians(i*rad))-(mouseY-250)*sin(radians(i*rad)),
               height/2+(mouseX-250)*sin(radians(i*rad))+(mouseY-250)*cos(radians(i*rad)),
               width/2+(pmouseX-250)*cos(radians(i*rad))-(pmouseY-250)*sin(radians(i*rad)),
               height/2+(pmouseX-250)*sin(radians(i*rad))+(pmouseY-250)*cos(radians(i*rad)));
           line(width/2-(mouseX-250)*cos(radians((i+2)*rad))+(mouseY-250)*sin(radians((i+2)*rad)),
               height/2+(mouseX-250)*sin(radians((i+2)*rad))+(mouseY-250)*cos(radians((i+2)*rad)),
               width/2-(pmouseX-250)*cos(radians((i+2)*rad))+(pmouseY-250)*sin(radians((i+2)*rad)),
               height/2+(pmouseX-250)*sin(radians((i+2)*rad))+(pmouseY-250)*cos(radians((i+2)*rad)));
        }
        else{
          point(width/2+(mouseX-250)*cos(radians(i*rad+1))-(mouseY-250)*sin(radians(i*rad+1)),
               height/2+(mouseX-250)*sin(radians(i*rad+1))+(mouseY-250)*cos(radians(i*rad+1)));
          point(width/2-(mouseX-250)*cos(radians((i+1)*rad))+(mouseY-250)*sin(radians((i+1)*rad)),
               height/2+(mouseX-250)*sin(radians((i+2)*rad))+(mouseY-250)*cos(radians((i+2)*rad)));//*/
        }
     // }
     // else{}
      
      
    }
    
  }
  
  
}



boolean mouseMoveFlag=false;
Crista cri;

void setup(){
  size(500,500);
  background(255);
  cri  = new Crista(12);//必ず偶数
}


void draw(){


}


void mouseClicked(){
  mouseMoveFlag = !mouseMoveFlag;
}

void mouseMoved(){
  if(mouseMoveFlag){
    cri.check();   
  }
  
}
