public class Board{
  long seed = 123456789;
  ArrayList<ArrayList<Human>> myBoard = new ArrayList<ArrayList<Human>>();
  Board(int x, int y){
    for(int i=0; i<y; i++){
      ArrayList<Human> temp = new ArrayList<Human>();
      for(int j=0; j<x; j++){
        Human instant = new Human();
        instant.x = j;
        instant.y = i;
        temp.add(instant);
      }
      myBoard.add(temp);
    }
  }
  
  public void turn(int canMoveId){
    for(int i=0, i_max= myBoard.size(); i<i_max; i++ ){
        for(int j=0, j_max= myBoard.get(i).size(); j<j_max; j++ ){
          Human temp = myBoard.get(i).get(j);
          if( (0 < temp.id) && (temp.id < 4) && temp.notActioned && canMoveId == temp.id){
            if(temp.id==1){
              Wei wei = new Wei(temp.x, temp.y);
              wei.action(myBoard); 
            }
            else if(temp.id == 2){
              Otaku otaku = new Otaku(temp.x, temp.y);
              otaku.action(myBoard); 
            }
            else if(temp.id == 3){
              Proffesor kyouju = new Proffesor(temp.x, temp.y);
              kyouju.action(myBoard);
            }
          }
        }
        
    }
  }
  
  
  public void drawBoard(){
    String text="";
    for(int i=0, i_max= myBoard.size(); i<i_max; i++ ){
      for(int j=0, j_max= myBoard.get(i).size(); j<j_max; j++ ){
        myBoard.get(i).get(j).notActioned = true;
        Human temp = myBoard.get(i).get(j);
        if( (0 < temp.id) && (temp.id < 4)){
          if(temp.id==1){
            fill(255,0,0);
            text = "ウェイ";
          }
          else if(temp.id == 2){
            fill(0,255,0);
            text = "オタク";
          }
          else if(temp.id == 3){
            fill(0,0,255);
            text = "教授";
          }
          ellipse(10*(j+1),10*(i+1),10,10);
          
          
          fill(0);
       //   text(text,25*(j+1)-7,25*(i+1)+3);
          fill(255,255,255);
        }
      }
    }
    println("turn");
  }



  public ArrayList<ArrayList<Human>> popOtaku(ArrayList<ArrayList<Human>> board, int popCount){
    int index=0;
    int y = board.size();
    int x = board.get(0).size();
    while(index < popCount){
      int popX = (int)(random(x));
      int popY = (int)(random(y));
      if(board.get(popY).get(popX).id == 0){
        index++;
        board.get(popY).set(popX,new Otaku(popX,popY));
      }
    }
    
    return board;
  
  }
  
 public ArrayList<ArrayList<Human>> popWei(ArrayList<ArrayList<Human>> board, int popCount){
    int index=0;
    int y = board.size();
    int x = board.get(0).size();
    while(index < popCount){
      int popX = (int)(random(x));
      int popY = (int)(random(y));
      if(board.get(popY).get(popX).id == 0){
        index++;
        board.get(popY).set(popX, new Wei(popX,popY));
        println("wei");
      }
    }
    
    return board;
  
  }
  
  public ArrayList<ArrayList<Human>> popProffesor(ArrayList<ArrayList<Human>> board, int popCount){
    int index=0;
    int y = board.size();
    int x = board.get(0).size();
    while(index < popCount){
      int popX = (int)(random(x));
      int popY = (int)(random(y));
      if(board.get(popY).get(popX).id == 0){
        index++;
        board.get(popY).set(popX, new Proffesor(popX,popY));
      }
    }
    
    return board;
  
  }
  
  //オタクは6割生き残り、ウェイは3割生き残る
  public void test(){
    for(int i=0, i_max= myBoard.size(); i<i_max; i++ ){
      for(int j=0, j_max= myBoard.get(i).size(); j<j_max; j++ ){
        Human temp = myBoard.get(i).get(j);
        if( 1 == temp.id ){
          if(random(1)>0.3)
            myBoard.get(i).get(j).death();
        }
        if( 2 == temp.id ){
          if(random(1)>0.6)
            myBoard.get(i).get(j).death();
        }
      }
    }
  }
}
