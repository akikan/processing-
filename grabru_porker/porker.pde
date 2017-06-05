import processing.video.*;
import gab.opencv.*;
import org.opencv.core.Mat;
import org.opencv.core.CvType;
import org.opencv.imgproc.Imgproc;
import org.opencv.highgui.Highgui;
import org.opencv.core.Core.MinMaxLocResult;
import org.opencv.core.Core;

import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.imageio.ImageIO;

int[][] trump = new int[4][13];
String[][] templeteList = {{"./card/2_dia.png","./card/3_dia.png","./card/4_dia.png","./card/5_dia.png","./card/6_dia.png","./card/7_dia.png","./card/8_dia.png","./card/9_dia.png","./card/10_dia.png","./card/J_dia.png","./card/Q_dia.png","./card/K_dia.png","./card/A_dia.png"},
{"./card/2_hart.png","./card/3_hart.png","./card/4_hart.png","./card/5_hart.png","./card/6_hart.png","./card/7_hart.png","./card/8_hart.png","./card/9_hart.png","./card/10_hart.png","./card/J_hart.png","./card/Q_hart.png","./card/K_hart.png","./card/A_hart.png"},
{"./card/2_spade.png","./card/3_spade.png","./card/4_spade.png","./card/5_spade.png","./card/6_spade.png","./card/7_spade.png","./card/8_spade.png","./card/9_spade.png","./card/10_spade.png","./card/J_spade.png","./card/Q_spade.png","./card/K_spade.png","./card/A_spade.png"},
{"./card/2_club.png","./card/3_club.png","./card/4_club.png","./card/5_club.png","./card/6_club.png","./card/7_club.png","./card/8_club.png","./card/9_club.png","./card/10_club.png","./card/J_club.png","./card/Q_club.png","./card/K_club.png","./card/A_club.png"}};
PImage[][] templateImage = new PImage[4][13];
String filename = "test.png";
int  cardNum;
float highRate=0, lowRate=0;
int count;

void setup() {
  size(400,150);
  
  //trumpを初期化
  init(trump);
  initLoadTemplete();
  
  GetDisplayImage(filename);//画像取得
//  PickupBoard(filename);
  count = matching(filename);
  println(count);
  if(count==1)
    calc();
  text(highRate,100,100);
  text(lowRate,300,100);
}

void draw(){
  background(0);
  GetDisplayImage(filename);//画像取得
//  PickupBoard(filename);
  count = matching(filename);
  if(count==1)
    calc();
  text(highRate,100,100);
  text(lowRate,300,100);
}



// 関数名:GetDisplayImage
// 返り値:正常終了時に1をそれ以外は-1を返す
// 処理：ディスプレイを画像として保存する、ファイル名は引数としてstringで与える
int GetDisplayImage(String filename){
  int returnStatus = 1;
  try{
    BufferedImage image = new Robot().createScreenCapture(new Rectangle(Toolkit.getDefaultToolkit().getScreenSize()));
   // BufferedImage thumb = new BufferedImage(width/2, height/2, image.getType());
    ImageIO.write(image, "png", new File(filename));
  }
  catch(Exception e){
    returnStatus = -1;
  }
  
  return returnStatus;
}

/*
void PickupBoard(String filename){
  OpenCV inputCV = new OpenCV(this, filename);
  Mat inputMat = OpenCV.imitate(inputCV.getGray());
  OpenCV templateCV = new OpenCV(this, "temp.jpg");
  Mat templateMat = OpenCV.imitate(templateCV.getGray());
      
  // 結果格納用の行列の準備
  int resultCols = inputMat.cols() - templateMat.cols() + 1;
  int resultRows = inputMat.rows() - templateMat.rows() + 1;
  Mat resultMat = new Mat(resultRows, resultCols, CvType.CV_32FC1);
      
  // テンプレートマッチングを実行
  Imgproc.matchTemplate(inputCV.getColor(), templateCV.getColor(), resultMat, Imgproc.TM_CCOEFF_NORMED);
  Highgui.imwrite("board.jpg",resultMat);
}
*/

// 関数名:init
// 返り値:返すものなど無いわ！
// 処理：トランプを初期化
void init(int[][] trump){
  for(int i=0; i<4; i++){
    for(int j=0; j<4; j++){
      trump[i][j]=0;
    }
  }
}


// 関数名:initLoadTemplete
// 返り値:返すものなど無いわ！
// 処理：テンプレート画像を読み込み
void initLoadTemplete(){
  for(int i=0; i<4; i++){
      for(int j=0; j<13; j++){
        // テンプレート画像の準備
        templateImage[i][j] = loadImage(templeteList[i][j]);
      }
  }
}


// 関数名:matching
// 返り値:トランプが何枚画像内にあったかを返す
// 処理：引数で与えられたfilenameの画像内にあるトランプの枚数をカウント
int matching(String filename){
  PImage inputImage = loadImage(filename);
  OpenCV inputCV = new OpenCV(this, inputImage);
  Mat inputMat = OpenCV.imitate(inputCV.getGray());
  int count=0;
  
  for(int i=0; i<4; i++){
    for(int j=0; j<13; j++){
      // テンプレート画像の準備
      OpenCV templateCV = new OpenCV(this, templateImage[i][j]);
      Mat templateMat = OpenCV.imitate(templateCV.getGray());
      
      // 結果格納用の行列の準備
      int resultCols = inputMat.cols() - templateMat.cols() + 1;
      int resultRows = inputMat.rows() - templateMat.rows() + 1;
      Mat resultMat = new Mat(resultRows, resultCols, CvType.CV_32FC1);
      // テンプレートマッチングを実行
      Imgproc.matchTemplate(inputCV.getColor(), templateCV.getColor(), resultMat, Imgproc.TM_CCOEFF_NORMED);
      
      // 結果を処理  
      MinMaxLocResult mmlr = Core.minMaxLoc(resultMat);
      println(mmlr.maxVal);
      //パターンとの一致率が9割より上なら実行する
      if (mmlr.maxVal > 0.95) {
        trump[i][j]=1;
        count++;
        //mmlr.maxLoc.xでx座標取得
        if(count==1){
          cardNum = j;
        }
      }
    }
  }
  if(count>=3){
    init(trump);
    cardNum=0;
  }
  
  return count;
}


// 関数名:calc
// 返り値:勝率を返す
// 処理：highを押した時の勝率とlowを押したときの勝率を出力する
void calc(){
  int high=0,low=0, sum=0;
  for(int i=0; i<13; i++){
    for(int j=0; j<4; j++){
      if(trump[j][i]==0)
        sum++;
    }
  }
  
  for(int i=cardNum+1; i<13; i++){
    for(int j=0; j<4; j++){
      if(trump[j][i]==0)
        high++;
    }
  }
  
  for(int i=cardNum-1; i>0; i--){
    for(int j=0; j<4; j++){
      if(trump[j][i]==0)
        low++;
    }
  }
  
 highRate = high/((float)sum);
 lowRate = low/((float)sum);
}
