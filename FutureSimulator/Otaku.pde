public class Otaku extends Human{
  
  public Otaku(int x, int y){
    super.id= 2;
    super.x = x;
    super.y = y;
  }
  
  void action(ArrayList<ArrayList<Human>> board){
    super.action(board,-1,0.0);
  }
  
   
}
