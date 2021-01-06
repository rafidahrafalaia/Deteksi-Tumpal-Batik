
float[][] kernel = {{ -1, -1, -1}, 
                    { -1,  9, -1}, 
                    { -1, -1, -1}};

float[][] kernel2 = {{ -1, -1, -1}, 
                    { -1,  9, -1}, 
                    { -1, -1, -1}};
import controlP5.*;

ControlP5 cp5;
PImage img, img2;
  
PrintWriter output;
PrintWriter hasil;

void setup() {
  size(900,680);
  cp5 = new ControlP5(this);
  //cp5.addTextfield("a").setPosition(400, 400).setSize(100, 50).setAutoClear(false);
PImage imgs = loadImage("1.jpg");
imgs.resize(150,150);
imgs.save("R16.jpg");
PImage imgs2 = loadImage("2.jpg");
imgs2.resize(150,150);
imgs2.save("R7.jpg");
PImage imgs3 = loadImage("3.jpg");
imgs3.resize(150,150);
imgs3.save("R11.jpg");
PImage imgs4 = loadImage("4.jpg");
imgs4.resize(150,150);
imgs4.save("R12.jpg");
PImage imgs5 = loadImage("5.jpg");
imgs5.resize(150,150);
imgs5.save("R20.jpg");
PImage imgs6 = loadImage("6.jpg");
imgs6.resize(150,150);
imgs6.save("R14.jpg");
PImage imgs7 = loadImage("7.jpg");
imgs7.resize(150,150);
imgs7.save("R22.jpg");
PImage imgs8 = loadImage("8.jpg");
imgs8.resize(150,150);
imgs8.save("R24.jpg");
cp5.addButton("batik1").setImage(loadImage("R16.jpg")).updateSize().setPosition(550,20);
cp5.addButton("batik2").setImage(loadImage("R7.jpg")).updateSize().setPosition(720,20);
cp5.addButton("batik3").setImage(loadImage("R11.jpg")).updateSize().setPosition(550,180);
cp5.addButton("batik4").setImage(loadImage("R12.jpg")).updateSize().setPosition(720,180);
cp5.addButton("batik5").setImage(loadImage("R20.jpg")).updateSize().setPosition(550,340);
cp5.addButton("batik6").setImage(loadImage("R14.jpg")).updateSize().setPosition(720,340);
cp5.addButton("batik7").setImage(loadImage("R22.jpg")).updateSize().setPosition(550,500);
cp5.addButton("batik8").setImage(loadImage("R24.jpg")).updateSize().setPosition(720,500);
}
void draw() {
  //background(0,0);
  //PImage dataset=loadImage("14.jpg");
  //image(dataset,0,0);
}
void batik1(){
PImage dataset=loadImage("1.jpg");
process(dataset);
}
void batik2(){
PImage dataset=loadImage("2.jpg");
process(dataset);
}
void batik3(){
PImage dataset=loadImage("3.jpg");
process(dataset);
}
void batik4(){
PImage dataset=loadImage("4.jpg");
process(dataset);
}
void batik5(){
PImage dataset=loadImage("5.jpg");
process(dataset);
}
void batik6(){
PImage dataset=loadImage("6.jpg");
process(dataset);
}
void batik7(){
PImage dataset=loadImage("7.jpg");
process(dataset);
}
void batik8(){
PImage dataset=loadImage("8.jpg");
process(dataset);
}
void process(PImage dataset){
int size=10;  
int treshold1=13400;
int treshold2=13900;
int k=-1;
  // Images must be in the "data" directory to load correctly
  for(int i=1;i<=8;i++){
   PImage img = loadImage(i+".jpg");
   img.resize(500,400);
   img.loadPixels();
   PImage edgeImg = createImage(img.width, img.height, RGB);
   // Loop through every pixel in the image.
   for (int y = 1; y < img.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) {  // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      edgeImg.pixels[y*img.width + x] = color(sum, sum, sum);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();
  edgeImg.save("gray.jpg");
  PImage gray=loadImage("gray.jpg");
    int z=1;
    k=k+2;
    for (int n = 0; n < (20*size); n=n+size) {
      PImage myImage = gray.get(n, 0, size, size);
      myImage.save(k+"/" + z +".jpg");
      z=z+1;
    }
    z=0;
    for (int n = 0; n < (20*size); n=n+size) {
      PImage myImage = gray.get(n, 400-size, size, size);
      myImage.save((k+1)+"/" + z +".jpg");
      z=z+1;
    }
  }
    lbp(dataset,size);    
}

void lbp(PImage dataset,int size){
  dataset.resize(500,400);
  dataset.save("dataset.jpg");
  double batas=999999999;
  int pola=0;
  int Hreal=dataset.height;
  int Wreal=dataset.width;
  int img_lbp[][]=new int[size][size];
  int img_lbp2[][]=new int[size][size];
  for (int j = 0; j < Wreal; j=j+size) {
    for (int i = 0; i < Hreal; i=i+size) {
      PImage myImage = dataset.get(j, i, size, size); 
      for (int r = 0; r < size; r++) {
        for (int s = 0; s < size; s++) {
          img_lbp[r][s]= lbp_calculated_pixel(myImage, r, s);        
          output.println(img_lbp[r][s]); // Write the coordinate to the file
        } 
      } 

      for(int m=1;m<=16;m++){
        for(int n=1;n<=20;n++){
          PImage train=loadImage(m+"/"+n+".jpg");
          for (int r = 0; r < size; r++) {
            for (int s = 0; s < size; s++) {
              img_lbp2[r][s]= lbp_calculated_pixel(train, r, s);        
              hasil.println(img_lbp[r][s]); // Write the coordinate to the file
            } 
          } 

        double Sum = 0.0;
        for (int r=0;r<size;r++){
          for (int s=0;s<size;s++) {
            Sum = Sum+Math.pow((img_lbp[r][s]-img_lbp2[r][s]),2.0);
          }
        }
        double dst=Math.sqrt(Sum);
        if(dst<batas){
          pola=m;
          batas=dst;
        }
        
        }
      }
    
    klasifikasi(j,i,pola,size);  
    }
  } 
}


void klasifikasi(int lebar,int tinggi,int pola,int size){
  PImage image=loadImage("dataset.jpg");
  PImage gambar=image.get(lebar,tinggi,size,size);
  switch(pola){
   case 1:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 2:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 3:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 4:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 5:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 6:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 7:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 8:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 9:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 10:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 11:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 12:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 13:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 14:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 15:
    gambar.filter(THRESHOLD, 0.7);
    break;
   case 16:
    gambar.filter(THRESHOLD, 0.7);
    break;
  }
  image(image,25,125);
  image(gambar,lebar+25,tinggi+125);
}
//void histoED(int box[], int matrix[][][],int loop,int treshold1,int treshold2) {

//  int nb[]=new int[loop];
//  int k;
//  double tres=0.0;
//  hasil = createWriter("result.txt"); 
//  output = createWriter("feature.txt"); 
// // BufferedImage image, image2;
//  int numPixels=0, numPixels2=0;
//  int[][] ref=new int[loop][box[loop-1]];
//  int[] ArRef=new int[loop];
//  for(int x=0;x<loop;x++){
//    nb[x]=0;
//    ref[x][0]=1;
//    ArRef[x]=1;
//  }
//  for(int tot=1;tot<loop+1;tot++){
//    double temp=0.0;
//    double rata=0.0;    
//  for (k=1; k<box[tot-1]+1; k++) {
//    PImage image = loadImage("temp-"+tot+"/IMG-" + k +".png");
//    //image = ImageIO.read(input);
//    int W = image.width;
//    int H = image.height;
//    int img_lbp[][][]=new int[loop][H][W];
//    for (int i = 0; i < H; i++) {
//      for (int j = 0; j < W; j++) {
//        img_lbp[tot-1][i][j]= lbp_calculated_pixel(image, i, j);        
//  output.println(img_lbp[tot-1][i][j]); // Write the coordinate to the file
// //       color c1 = image.get(0,0);
//   //     int r=int c1.red();
//        //numPixels++;
//      } 
//    } 
  
//      output.println("--------------------------------"); // Write the coordinate to the file
////pakai simpan untuk mengambil dst yg plng mendekati 0
//       double simpan=10700;
//    for (int i = 0; i < nb[tot-1]+1; i++) {
//      PImage image2 = loadImage("temp-"+tot+"/IMG-" + ref[tot-1][i] +".png");
//      int W2 = image2.width;
//      int H2 = image2.height;
//      int img_lbp2[][][]=new int[loop][H2][W2];
//      for (int m = 0; m < H; m++) {
//        for (int n = 0; n < W; n++) {
//          img_lbp2[tot-1][m][n]= lbp_calculated_pixel(image2, m, n);
//        }
//      }
      
//      double Sum = 0.0;
 
//      for (int p=0;p<H;p++){
//      for (int j=0;j<W;j++) {
//        Sum = Sum+Math.pow((img_lbp[tot-1][p][j]-img_lbp2[tot-1][p][j]),2.0);
//        }
//      }
//      double dst=Math.sqrt(Sum);
//    if(tot==1){
//      tres=treshold1;
//  }
//    else if(tot==2){
//      tres=treshold2;
//    }
//   println(dst);
//   rata=rata+dst;
//      if(dst<tres){
//        //if(dst<simpan){
//          matrix[tot-1][k-1][4]=matrix[tot-1][ref[tot-1][i]-1][4];
//          //simpan=dst;
//          //println("simpan:"+simpan);
//        //}
//        //else{
//        //;}//pake break berarti lngsng mskin klo cocok
//          // g pake break berarti cek ke semua image referensi
//          //break;
          
//      }
//      else{
//        matrix[tot-1][k-1][4]=matrix[tot-1][ref[tot-1][i]-1][4]+1;
//          if(matrix[tot-1][k-1][4]>nb[tot-1]){
//            ref[tot-1][ArRef[tot-1]]=k;
//            ArRef[tot-1]=ArRef[tot-1]+1;
//            nb[tot-1]+=1;

//        }
//      }
      
//    }
//   println("IMG-"+k+"= (NB="+matrix[tot-1][k-1][4]+")");
//  }
//   double ratax=rata/box[tot-1];
//   //println("rata="+ratax);
//  }
//  tumpal(box,matrix,nb,loop);
//}

//void tumpal(int box[],int matrix[][][],int nb[],int loop){
//  int new_width  = 500;
//  int new_height = 100;
//  int jarak=0;
//  int s=1;
//  int[][] a=new int[loop][box[loop-1]];
//  PImage cross=loadImage("cross.png");
//  PImage batik=loadImage("N22.jpg");
//  int[] temp=new int[loop];
//  int[] x=new int[loop];
//  int[] sign={0,0};
//  int[] simpan={0,0};
//  int tumpuk=0;
//  image(batik,25,125);
//  for(int jml=1;jml<loop+1;jml++){
//    cross.resize(new_width/jml,new_height/jml);
//    cross.save("Ncross"+jml+".png");
//    temp[jml-1]=0;
//    x[jml-1]=0;
    
//    for(int i=0;i<nb[jml-1]+1;i++){
//    a[jml-1][i]=0;
//    }

//   // println(matrix[jml-1][4][4]);
//  for(int i=0;i<nb[jml-1]+1;i++){
//    for(int k=1;k<box[jml-1]+1;k++){
//      if(matrix[jml-1][k-1][4]==i){
//        a[jml-1][i]+=1;
//      }
//    }
//    if(a[jml-1][i]>temp[jml-1] && a[jml-1][i]>0){
//      x[jml-1]=i;
//      temp[jml-1]=a[jml-1][i];
//    }
//        //println(a[jml-1][i]);
//  }
// // println(x[jml-1]);
//  //}
// // println(x[jml-1]+" "+a[jml-1][x[jml-1]]);
//  //println("Lokasi Tumpal:");
//  //for(int w=1;w<3;w++){
//  for(int k=1;k<box[jml-1]+1;k++){
//         //print(matrix[jml-1][k-1][5]);
// // println(k+" "+matrix[jml-1][k-1][4]);
//   // println("lol");
//    if(matrix[jml-1][k-1][4]!=x[jml-1]){
//      sign[jml-1]=1;
//      if(jml>1){
//        for(int i=1;i<box[jml-2]+1;i++){ 
//         matrix[jml-1][k-1][5]=1;
//          if(matrix[jml-2][i-1][5]==1 && ((matrix[jml-1][k-1][0]>matrix[jml-2][i-1][0] && matrix[jml-1][k-1][0]<matrix[jml-2][i-1][2]) || (matrix[jml-1][k-1][2]>matrix[jml-2][i-1][0] && matrix[jml-1][k-1][2]<matrix[jml-2][i-1][2])) && ((matrix[jml-1][k-1][1]>matrix[jml-2][i-1][1] && matrix[jml-1][k-1][1]<matrix[jml-2][i-1][3]) || (matrix[jml-1][k-1][3]>matrix[jml-2][i-1][1] && matrix[jml-1][k-1][3]<matrix[jml-2][i-1][3]))){
//           tumpuk=1;
//          }   
//        //    image(Ncross,matrix[jml-1][k-1][0],matrix[jml-1][k-1][1]);
//          //s=k;
//          }
//         // println(""+matrix[jml-1][k-1][0]+" "+matrix[jml-1][k-1][1]+" "+matrix[jml-1][k-1][2]+" "+matrix[jml-1][k-1][3]);
//         //println("jmlh="+jml+" k="+k+" (("+matrix[jml-1][k-1][0]+">="+matrix[0][s-1][0]+" && "+matrix[jml-1][k-1][0]+"<="+matrix[0][s-1][2]+")||("+matrix[jml-1][k-1][2]+">="+matrix[0][s-1][0]+" && "+matrix[jml-1][k-1][2]+"<="+matrix[0][s-1][2]+")) && (("+matrix[jml-1][k-1][1]+">="+matrix[0][s-1][1]+" && "+matrix[jml-1][k-1][1]+"<="+matrix[0][s-1][3]+")||("+matrix[jml-1][k-1][3]+">="+matrix[0][s-1][1]+" && "+matrix[jml-1][k-1][3]+"<="+matrix[0][s-1][3]+"))");
//       }    
//        //continue;
//  //    }
//      else{    
//        matrix[jml-1][k-1][5]=1;
//        //s=k;
//       // matrix[jml-1][k-1][5]=1;
//        //image(Ncross,matrix[jml-1][k-1][0],matrix[jml-1][k-1][1]);
//        //println(""+matrix[jml-1][k-1][0]+" "+matrix[jml-1][k-1][1]+" "+matrix[jml-1][k-1][2]+" "+matrix[jml-1][k-1][3]);
//      }
//          println("IMG-"+k+"= (cross="+matrix[jml-1][k-1][5]+")");
//    }
//  }
//  }
////  for(int jml=1;jml<loop+1;jml++){
////    for(int k=1;k<box[jml-1]+1;k++){
////        print(matrix[jml-1][k-1][5]);
////  } 
////}
//  for(int j=1;j<loop;j++){
//    if(sign[j-1]==1){
//      if(tumpuk==1){
//      for(int i=1;i<box[j-1]+1;i++){ 
//      for(int k=1;k<box[j]+1;k++){
//           if(matrix[j-1][i-1][5]==1 && matrix[j][k-1][5]==1 && ((matrix[j][k-1][0]>matrix[j-1][i-1][0] && matrix[j][k-1][0]<matrix[j-1][i-1][2]) || (matrix[j][k-1][2]>matrix[j-1][i-1][0] && matrix[j][k-1][2]<matrix[j-1][i-1][2])) && ((matrix[j][k-1][1]>matrix[j-1][i-1][1] && matrix[j][k-1][1]<matrix[j-1][i-1][3]) || (matrix[j][k-1][3]>matrix[j-1][i-1][1] && matrix[j][k-1][3]<matrix[j-1][i-1][3]))){
//   //sign=1;
//          //print("Ncross"+j+".png");
//          PImage Ncross=loadImage("Ncross"+(j+1)+".png");
//           println(""+matrix[j][k-1][0]+" "+matrix[j][k-1][1]+" "+matrix[j][k-1][2]+" "+matrix[j][k-1][3]);
//            simpan[0]=matrix[j][k-1][1];
//           simpan[1]=matrix[j][k-1][3];
//           jarak=matrix[j][k-1][3]-matrix[j][k-1][1];
//           image(Ncross,matrix[j][k-1][0]+25,matrix[j][k-1][1]+125); 
//        }
//      }
//      }
//    }
//      else{
//      for(int k=0;k<box[j-1];k++){
//        if(matrix[j-1][k][5]==1){
//          //sign=1;
//          //print("Ncross"+j+".png");
//          PImage Ncross=loadImage("Ncross"+(j)+".png");
//           println(""+matrix[j-1][k][0]+" "+matrix[j-1][k][1]+" "+matrix[j-1][k][2]+" "+matrix[j-1][k][3]);
//            simpan[0]=matrix[j][k][1];
//           simpan[1]=matrix[j][k][3];
//           jarak=matrix[j][k][3]-matrix[j][k][1];
//           image(Ncross,matrix[j-1][k][0]+25,matrix[j-1][k][1]+125); 
//        }
//      }
//      }
//    }
//    else{
//      for(int k=0;k<box[j];k++){
//        if(matrix[j][k][5]==1){
//          //sign=1;
//          //print("Ncross"+j+".png");
//          PImage Ncross=loadImage("Ncross"+(j+1)+".png");
//           println(""+matrix[j][k][0]+" "+matrix[j][k][1]+" "+matrix[j][k][2]+" "+matrix[j][k][3]);
//            simpan[0]=matrix[j][k][1];
//           simpan[1]=matrix[j][k][3];
//          jarak=matrix[j][k][3]-matrix[j][k][1];
//            image(Ncross,matrix[j][k][0]+25,matrix[j][k][1]+125); 
//        }
//      }
////      continue;
//    }
//  }
//  cocok(simpan,jarak);
//} 
//double varians(double rata,int z,int tinggi1, int jarak){
//    int plus=0;
//    int plus2=-5;
//    double dst=0;
//    double tot=0;
//    do{
//      z++;
//    //tinggi1=tinggi1-5;
//      int lebar=500, tinggi=100;
//      PImage imggray = loadImage("gray.jpg");
//    //for (int i = ; i < Hreal; i=i+(tinggi/tot)) {
//      PImage myImage = imggray.get(0, tinggi1, lebar, jarak);
//      myImage.save("IMGTry.png");
//      //matrix[tot-1][z-1][0]=j;
//     // j=matrix[0][tanda-1][1];
//      PImage myImage2 = imggray.get(0, tinggi1-jarak-plus, lebar, jarak);
//      //println(tinggi1-plus);
//      //println(tinggi1-plus2);
//      myImage2.save("IMGTry2.png");
//      PImage imageTry = loadImage("IMGTry.png");
//      PImage imageTry2 = loadImage("IMGTry2.png");
//      int W = imageTry.width;
//      int H = imageTry.height;
//      int img_lbpTry[][]=new int[H][W];
//      int img_lbpTry2[][]=new int[H][W];
//      for (int m = 0; m < H; m++) {
//        for (int n = 0; n < W; n++) {
//          img_lbpTry[m][n]= lbp_calculated_pixel(imageTry, m, n);
//        }
//      }
//      for (int m = 0; m < H; m++) {
//        for (int n = 0; n < W; n++) {
//          img_lbpTry2[m][n]= lbp_calculated_pixel(imageTry2, m, n);
//        }
//      }  
//      double Sum2 = 0.0;
//     for (int p=0;p<H;p++){
//      for (int l=0;l<W;l++) {
//        Sum2 = Sum2+Math.pow((img_lbpTry[p][l]-img_lbpTry2[p][l]),2.0);
//        }
//      }
//      dst=Math.sqrt(Sum2);
//      double carVar=Math.pow((dst-rata),2);
//       println(carVar);
//       tot=tot+carVar;
////       if(dst<=7000){
//         // dstMax=dst;
//          //PImage cross=loadImage("cross.png");
//          //PImage batik=loadImage("N22.jpg");
//          //cross.resize(500, jarak+plus);
//          //cross.save("Ncross.png");    
//  //     }
//    plus=plus+5;
//    plus2=plus2+5;
//    }while(tinggi1-jarak-plus>=0);
//  double var=tot/z;
//  return var;
//}
//void cocok(int[] simpan,int jarak){
//  int tinggi1=simpan[0];
//  int tinggi2=simpan[1];
//  int z=0;
//  double rata=0;
//  if(simpan[0]!=0){
//    double x=0;
//    int j;
//    int plus=0;
//    int plus2=-5;
//    double dst=0;
//    double tot=0;
//    //double dstMax=0;
////    do{
//      //z++;
//    //tinggi1=tinggi1-5;
//      int lebar=500, tinggi=100;
//      PImage imggray = loadImage("gray.jpg");
//    //for (int i = ; i < Hreal; i=i+(tinggi/tot)) {
//      PImage myImage = imggray.get(0, 0, lebar, jarak);
//      myImage.save("IMGVar.png");
//      //matrix[tot-1][z-1][0]=j;
//     // j=matrix[0][tanda-1][1];
//      PImage myImage2 = imggray.get(0, tinggi1, lebar, jarak);
//      //println(tinggi1-plus);
//      //println(tinggi1-plus2);
//      myImage2.save("IMGVar2.png");
//      PImage imageTry = loadImage("IMGVar.png");
//      PImage imageTry2 = loadImage("IMGVar2.png");
//      int W = imageTry.width;
//      int H = imageTry.height;
//      int img_lbpTry[][]=new int[H][W];
//      int img_lbpTry2[][]=new int[H][W];
//      for (int m = 0; m < H; m++) {
//        for (int n = 0; n < W; n++) {
//          x++;
//          img_lbpTry[m][n]= lbp_calculated_pixel(imageTry, m, n);
//        }
//      }
//      for (int m = 0; m < H; m++) {
//        for (int n = 0; n < W; n++) {
//          img_lbpTry2[m][n]= lbp_calculated_pixel(imageTry2, m, n);
//        }
//      }  
//      double Sum2 = 0.0;
//     for (int p=0;p<H;p++){
//      for (int l=0;l<W;l++) {
//        Sum2 = Sum2+Math.pow((img_lbpTry[p][l]-img_lbpTry2[p][l]),2.0);
//        }
//      }
//      dst=Math.sqrt(Sum2);
//      double hsl=dst/x;
      
//       println("dst="+dst);
//       println("x="+x);
//       println("hsl="+hsl);
//      // tot=tot+dst;
////       if(dst<=7000){
//         // dstMax=dst;
//          //PImage cross=loadImage("cross.png");
//          //PImage batik=loadImage("N22.jpg");
//          //cross.resize(500, jarak+plus);
//          //cross.save("Ncross.png");    
//  //     }
//    plus=plus+5;
//    plus2=plus2+5;
// //   }while(tinggi1-jarak-plus>=0);
    
//    rata=tot/z;
//   // println("rata="+rata);
//  //  double var=varians(rata,z,tinggi1,jarak);
//   // println("varians="+var);
//    int plusb=0;
//    int plus2b=0;
//    double dstb=0;
//    double totb=0;
//    double hsl2=0;
//    do{
//    double x2=0;
//      //z++;
//    //tinggi1=tinggi1-5;
//     // int lebar2=500, tinggi2=100;
//      PImage imggray2 = loadImage("gray.jpg");
//    //for (int i = ; i < Hreal; i=i+(tinggi/tot)) {
//      PImage myImageb = imggray.get(0, 0, lebar, jarak+plusb);
//      myImageb.save("IMGTry.png");
//      //matrix[tot-1][z-1][0]=j;
//     // j=matrix[0][tanda-1][1];
//      PImage myImage2b = imggray.get(0, tinggi1-plusb, lebar, jarak+plusb);
//      //println(tinggi1-plusb);
//      //println(tinggi1-plus2b);
//      myImage2b.save("IMGTry2.png");
//      PImage imageTryb = loadImage("IMGTry.png");
//      PImage imageTry2b = loadImage("IMGTry2.png");
//      int Wb = imageTryb.width;
//      int Hb= imageTryb.height;
//      int img_lbpTryb[][]=new int[Hb][Wb];
//      int img_lbpTry2b[][]=new int[Hb][Wb];
//      for (int m = 0; m < Hb; m++) {
//        for (int n = 0; n < Wb; n++) {
//          x2++;
//          img_lbpTryb[m][n]= lbp_calculated_pixel(imageTryb, m, n);
//        }
//      }
//      for (int m = 0; m < H; m++) {
//        for (int n = 0; n < W; n++) {
//          img_lbpTry2b[m][n]= lbp_calculated_pixel(imageTry2b, m, n);
//        }
//      }  
//      double Sum2b = 0.0;
//     for (int p=0;p<Hb;p++){
//      for (int l=0;l<Wb;l++) {
//        Sum2b = Sum2b+Math.pow((img_lbpTryb[p][l]-img_lbpTry2b[p][l]),2.0);
//        }
//      }
//      dstb=Math.sqrt(Sum2b);
//      // println(dstb);
//       hsl2=dstb/x2;

//       println("dst2="+dstb);
//       println("x2="+x2);
//       println(hsl2);
//       //totb=totb+dstb;
////       if(dst<=7000){
//          //dstMax=dst;
//          PImage cross=loadImage("cross.png");
//          //PImage batik=loadImage("N22.jpg");
//          cross.resize(500, jarak+plusb);
//          cross.save("Ncross.png");    
//  //     }
//    plusb=plusb+5;
//    plus2b=plus2b+5;
//    }while(hsl2>=hsl && tinggi1-plusb>=0);
  
//    PImage NcrossMax=loadImage("Ncross.png");
//    image(NcrossMax,0+25,tinggi1-plusb+5+125); 
//  }
//}
int lbp_calculated_pixel(PImage img,int x,int y){
  int center = img.get(x,y);
  int[] val_ar=new int[8];
  int num=0;
  val_ar[num]=get_pixel(img, center, x-1, y+1);
  val_ar[num+1]=get_pixel(img, center, x, y+1);
  val_ar[num+2]=get_pixel(img, center, x+1, y+1);
  val_ar[num+3]=get_pixel(img, center, x+1, y);
  val_ar[num+4]=get_pixel(img, center, x+1, y-1);
  val_ar[num+5]=get_pixel(img, center, x, y-1);
  val_ar[num+6]=get_pixel(img, center, x-1, y-1);
  val_ar[num+7]=get_pixel(img, center, x-1, y);
  
  int[] power_val = {1, 2, 4, 8, 16, 32, 64, 128};
  int val=0;
  for(int i=0;i<power_val.length;i++){
    val += val_ar[i] * power_val[i];
  }
  return val;
}

int get_pixel(PImage img,int center,int x,int y){
    int new_value = 0;
    try {
        if (img.get(x,y) >= center){
            new_value = 1;
          }
  }
  catch(Exception e) {
  ;
  }
    return new_value;
}
  /*  int r1 = cummulative[0] / numPixels;
    int g1 = cummulative[1] / numPixels;
    int b1 = cummulative[2] / numPixels;
    for (int i=0; i<nb+1; i++) {
      File input2 = new File("temp/IMG-" + ref[i] +".png");
      image2 = ImageIO.read(input2);
      int W2 = image2.getWidth();
      int H2 = image2.getHeight();
      int cummulative2[]=new int[box];
      for (int posX2 = 0; posX2 < W2; posX2++) {
        for (int posY2 = 0; posY2 < H2; posY2++) {
          Color c2 = new Color(image2.getRGB(posX2, posY2));
          cummulative2[0] = cummulative2[0] + c2.getRed();
          cummulative2[1] = cummulative2[1] + c2.getGreen();
          cummulative2[2] = cummulative2[2] + c2.getBlue();
          numPixels2++;
        }
      }
    }*/
