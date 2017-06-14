public class Human {
  private color c;
  public int id=0;
  public boolean notActioned = true;
  int x;
  int y;


  public ArrayList<Human> checkHumanInArea(ArrayList<ArrayList<Human>> board, int x, int y) {
    ArrayList<Human> ret = new ArrayList<Human>();
    int area[] = {
      -1, 0, 1
    };
    int x_max = board.get(0).size();
    int y_max = board.size();

    for (int i=0; i<area.length; i++) {
      for (int j=0; j<area.length; j++) {
        if ( !(i==0 &&j==0) &&  (0<=(x+area[j]) && (x+area[j])<x_max) && (0<=(y+area[i]) && (y+area[i])<y_max) ) {
          //行動可能範囲を取得
          ret.add(board.get(y+area[i]).get(x+area[j]));
        }
      }
    }
    return ret;
  }

  public ArrayList<Human> getNotFriend(ArrayList<Human> view) {
    ArrayList<Human> ret = new ArrayList<Human>();
    for (Human temp : view) {
      if (temp.id != this.id) {
        ret.add(temp);
      }
    }
    return ret;
  }

  public void death() {
    this.id=0;
  }

  public void move(int x, int y) {
    this.x = x;
    this.y = y;
  }


//乱数がよくない
  public void action(ArrayList<ArrayList<Human>> board, int targetId, float par) {
    ArrayList<Human> list = checkHumanInArea(board, this.x, this.y);
    ArrayList<Human> notFriendList = getNotFriend(list);

    ArrayList<Human> targetList = new ArrayList<Human>();
    ArrayList<Human> moveList = new ArrayList<Human>();
    for (Human temp : notFriendList) {
      if (temp.id == targetId && temp.notActioned)
        targetList.add(temp);
      else if (temp.id ==0)
        moveList.add(temp);
    }

    if (notFriendList.size()==0) {
      int rand = (int)(random(list.size()));
      list.get(rand).death();
    } 
    else if (targetList.size()!=0) {
      int rand = (int)(random(targetList.size()*1000));
      Human target = targetList.get(rand%targetList.size());
      if(random(1)<par)
        board.get(target.y).get(target.x).death();
      println("さつがい");
      board.get(this.y).get(this.x).notActioned = false;
    }
    else if (moveList.size()!=0) {
      int rand = (int)(random(moveList.size()*1000));
      rand = rand%moveList.size();
      Human temp = moveList.get(rand);
      int x = this.x;
      int y = this.y;
      board.get(temp.y).get(temp.x).id = this.id;
      board.get(this.y).get(this.x).id = 0;
      board.get(temp.y).get(temp.x).notActioned = false;
      board.get(this.y).get(this.x).notActioned = true;
      //      board.get(y).get(x).death();
      println("いどう");
    }
  }
}

