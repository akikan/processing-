//Boardクラス
  //Humanクラスのリストの管理をする
//Humanクラス
  //自分の座標（x,y）とその１近傍に誰がいるのかをリストにして返す

Board board = new Board(100,100);
int day=1; 
boolean flag=false;
void setup(){
  ellipseMode(CENTER);
  size(1000,1000);
  board.myBoard = board.popProffesor(board.myBoard,10);
  board.myBoard = board.popWei(board.myBoard,50);
  board.myBoard = board.popOtaku(board.myBoard,500);
  frameRate = 1;
  
}

void draw(){
  background(255);
  if(day%180 == 0){
    board.test();
  }
  else if(day == 365){
    board.myBoard = board.popWei(board.myBoard,50);
    board.myBoard = board.popOtaku(board.myBoard,500);
    day = 1;
  }
  else{
    board.turn(3);
    board.turn(1);
    board.turn(2);
  }
  board.drawBoard();
  day += 1;
}

void mouseClicked()
{ 
  //println(board.myBoard.get(0).size());
  

}
