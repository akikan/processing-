public class Wei extends Human{
  
  public Wei(int x, int y){
    this.id= 1;
    this.x = x;
    this.y = y;
  }
  
  void action(ArrayList<ArrayList<Human>> board){
    super.action(board,2,1);
  }
  
  
  
 
}
