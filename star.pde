class Star{
  float sx,x, sy, y,r,rate,ac;
  float bai,opt=0;
  Star(float x, float y, float ac, float r,float rate ){
    this.bai= cos(radians(ac));
    this.x = x;//原点のx座標
    this.sx=bai * r * cos(radians(rate) + (ac-90))+x;; //点のx座標
    this.y = y;//原点のy座標
    this.sy= r * sin(radians(ac))+y;//点のy座標
    this.r = r;//半径
    this.ac=ac;//設定θ
    this.rate = rate;//増分角度
    stroke(255);
    strokeWeight(2);
    point(sx,sy);
  }
  
  public void moveX(){
    rate += 1;
//    if(rate%(2*ac) > ac){
      sx = bai * r * cos(radians(rate) + (ac-90))+x;
//    }else{
//      sx = bai * r * cos(radians(rate%(2*ac))+(ac-90))+x;
//    }
    
    stroke(255);
    strokeWeight(2);
    point(sx,sy);
  }
}
int flag=1;
int pointNum = 1000;
Star[] a = new Star[pointNum];
void setup(){
  int i;
  size(300,300);
  background(0);
  for(i=0; i<pointNum; i++){
    a[i] = new Star(150,150,200+i*2,100,i+1);
  }
}

void draw(){
  int i;
  if(flag==-1){
      background(0);
    for(i=0; i<pointNum; i++){
       a[i].moveX();
    }
  }
}

void mouseClicked(){
  flag *= -1;
}
