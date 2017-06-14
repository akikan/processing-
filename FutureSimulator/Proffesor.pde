public class Proffesor extends Human{
  
  public Proffesor(int x, int y){
    this.id= 3;
    this.x = x;
    this.y = y;
  }
  
  void action(ArrayList<ArrayList<Human>> board){
    super.action(board,1,0.4);
  }
  
  
  
 
}
