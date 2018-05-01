PImage img,convImg;

void setup(){
  img = loadImage("sample1.jpg");
  float[][] wave = new float[img.width][img.height];
  convImg = RGBtoY(img);

  size(img.width,img.height);
  wave = wavelet(convImg,wave,1);
//  wave = Iwavelet(convImg,wave,2);

  for(int x=0; x<img.width; x++){
    for(int y=0; y<img.height; y++){
      color c = color(wave[x][y],wave[x][y],wave[x][y]);
      convImg.set(x,y,c);//輝度値を取得してセット
    }
  }
  image(convImg,0,0);
  
}

float[][] copyFloat(float[][] wave, float[][] temp, int wide, int high){
  for(int x=0; x<wide; x++){
    for(int y=0; y<high; y++){
      wave[x][y] = temp[x][y];//輝度値を取得してセット
    }
  }
  return wave;
}

PImage RGBtoY(PImage OriginImg){//RGB値を輝度値に変換した画像を返す関数
  PImage img = OriginImg;
  
  for(int i=0; i<img.height; i++){
    for(int j=0; j<img.width; j++){
      double Y,Cb,Cr;
      color c = img.get(j,i);//(j,i)座標のピクセルのRGB値取得
      Y = 0.299 * red(c) + 0.587 * green(c) + 0.114 * blue(c);//RGBを輝度値に変換
      Cb = -0.1146 *red(c) + -0.3854 * green(c) + 0.5000 * blue(c);
      Cr = 0.5000 * red(c) + -0.4542 * green(c)+ -0.0458 * blue(c);
      
      c = color((int)(Y+0.5),(int)(Y+0.5),(int)(Y+0.5));//切り捨てされるので+0.5して四捨五入
      img.set(j,i,c);
    }
  }
  return img;
}

float[][] wavelet(PImage image, float[][] wave, int num){//原画像,色情報を保存するfloat配列, 変換する回数
  int high = image.height;
  int wide = image.width;
  float[][] temp = new float[image.width][image.height];
  for(int x=0; x<wide; x++){
    for(int y=0; y<high; y++){
      wave[x][y] = red(image.get(x,y));//輝度値を取得してセット
    }
  }
  
  for(int count=0; count<num; count++){//x方向の1次変換
    for(int y=0; y<high; y++){
      for(int x=0; x<wide/2; x++){
        float c1,c2;
        float cc;
        c1 = wave[2*x][y];
        c2 = wave[2*x+1][y];
        cc = (c1+c2)/2.0;
        temp[x][y] = cc;
        cc = c1 - c2;
        temp[wide/2+x][y] = cc;
      }
    }
    wave = copyFloat(wave, temp, wide, high);
    for(int y=0; y<high/2; y++){//y方向の1次変換
      for(int x=0; x<wide; x++){
        float c1,c2;
        float cc;
        c1 = wave[x][2*y];
        c2 = wave[x][2*y+1];
        cc = (c1+c2)/2.0;
        temp[x][y] = cc;
        cc = c1-c2; 
        temp[x][high/2+y] = cc;
      }
    }
    wave = copyFloat(wave, temp, wide, high);
  }
  return wave;
}

float[][] Iwavelet(PImage image, float[][] wave, int num){//原画像,色情報を保存するfloat配列, 変換する回数
  int high = image.height;
  int wide = image.width;
  float[][] temp = new float[image.width][image.height];

  for(int count=0; count<num; count++){
    for(int y=0; y<high; y++){
      for(int x=0; x<wide/2; x++){
        float c1,c2;
        float cc;
        c1 = wave[x][y];
        c2 = wave[x+wide/2][y];
        cc = (c1*2 + c2)/2.0;
        temp[2*x][y] = cc;
        cc = c1*2 - cc;
        temp[2*x+1][y] = cc;
      }
    }
    wave = copyFloat(wave, temp, wide, high);
    for(int y=0; y<high/2; y++){
      for(int x=0; x<wide; x++){
        float c1,c2;
        float cc;
        c1 = wave[x][y];
        c2 = wave[x][y+high/2];
        cc = (c1*2 + c2)/2.0;
        temp[x][2*y] = cc;
        cc = c1*2 - cc;
        temp[x][2*y+1] = cc;
      }
    }
    wave = copyFloat(wave, temp, wide, high);
  }
  return wave;
}
