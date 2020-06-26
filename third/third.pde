
//--------------------------------{{コロナから逃げるアプリ}}--------------------------------//

import processing.sound.*;//サウンド再生環境を入れる

//BGMの変数宣言
SoundFile decision, roma, horror2;

//画像の変数宣言
PImage firstBack, atFirst, Continue, setting, back, bay, bedGirl, akibin;
PImage makimono, shelf1, shelf2, shelf3;

//ファイルの変数宣言
JSONObject systemFile;

int seen = 0;//この変数の値でシーンの切り替えを行う
int music = 1;//音の切り替えを行う
int time = 0;//BGMのループで使う
int pressed;//マウスクリックの判定
int N = 0;
float bayX, bayY;//キャラの座標


//---------------------------------(setup関数.ファイル,画像,BGM,フォントなどの読み込み)-----------------------------------------//

void setup() {
  size(800, 600);//ウィンドウサイズを指定
  //------jasonファイルを読み込む------//
  systemFile = loadJSONObject("data/system.json");
  
  //-------画像を読み込む---------//
  firstBack = loadImage("firstBack.PNG");//タイトルのイラスト
  atFirst = loadImage("atFirst.PNG");//初めからのイラスト
  Continue = loadImage("continue.PNG");//続きから
  setting = loadImage("setting.PNG");//設定
  back = loadImage("back.PNG");//戻る
  makimono = loadImage("makimono.PNG");//巻き物のイラスト
  bay = loadImage("bay.PNG");//過労の医師のイラスト
  bedGirl = loadImage("bedGirl.png");//ベッドで寝ている女性のイラスト
  akibin = loadImage("akibin.png");//空き瓶がカゴに入っているイラスト
  shelf1 = loadImage("shelf1.PNG");//上から見た棚のイラスト
  shelf2 = loadImage("shelf2.PNG");//上から見た棚のイラスト
  shelf3 = loadImage("shelf3.PNG");//上から見た棚のイラスト
  
  
  //--------BGM,効果音を読み込む-------//
  decision = new SoundFile(this, "systemDecision.wav");//決定音
  roma = new SoundFile(this, "roma.mp3");//選択画面でのBGM
  horror2 = new SoundFile(this, "horror2.mp3");//プレイ画面でのBGM
  
  
  //--------日本語フォントを設定--------//
  PFont font = createFont("Meiryo", 50);
  textFont(font);
}

//----------------------------------(draw関数.各シーンや音楽の管理)----------------------------------------//

void draw() {
  //-----------(各シーンの移動管理)----------------//
  if (seen == -1) {
    seen = Setting();//詳細設定画面
  }else if(seen == 0) {
    seen = select();//初期選択画面
  }else if(seen == 1) {
    seen = startt();//まだなんもない
  }else if(seen == 2) {
    seen = playing();//プレイ画面(部屋)
  }else if(seen == 3) {
    seen = playing2();
  }else if(seen == 4) {
    seen = playing3();
  }
    
 
  //--------------(音楽の管理)-----------------//
  time++;
  if(music == 1) {
    horror2.stop();
    roma.play();//roma.mp3を再生する
    music = 0;//ここを０にしておかないと実行回数分音楽が再生されてしまう->>バグる
  }else if(music == 2) {
    bayX = 375;
    bayY = 275;
    roma.stop();
    horror2.play();//horror2を再生する
    music = 0;//ここを０にしておかないと実行回数分音楽が再生されてしまう->>バグる
  }
  
  //-------------------------(キャラの移動)-------------------------//
  if(keyPressed == true) {
    if(key == 'a') {//aを押すと左へ
      bayX -= 1.5;
    }else if(key == 'd') {//dを押すと右へ
      bayX += 1.5;
    }else if(key == 'w') {//wを押すと上へ
      bayY -= 1.5;
    }else if(key == 's') {//sを押すと下へ
      bayY += 1.5;
    }
  }
    
}

//-------------------------------------(詳細設定画面.まだなんもない)-------------------------------------//

int Setting() {//設定画面
  pressed = 0;//マウスクリックの判定を一回に限定する
  background(0);
  noTint();
  image(makimono, 200, 50, 400, 500);
  
  if(inspectB()) {//戻る
    tint(100);
    if(mousePressed && pressed == 0) {//マウスクリックで効果音．シーン移動
      decision.play();
      pressed = 1;
      return 0;
    }
  }else {
    noTint();
  }
  image(back, 600, 500, 160, 80);
  return -1;
}


//---------------------------------(初期選択画面の管理)-------------------------------------//

int select() {//初期選択画面
  pressed = 0;//マウスクリックの判定を一回に限定する
  background(0);//背景(黒)
  if(seen == 0) {
    noTint();
    image(firstBack, 0, 0, 800, 600);//title画像を表示
  }
  //---画像表示と範囲内での明るさ調整．シーンの移動---//
  //------初めから
  if(inspectF()) {
    tint(100);
    if(mousePressed && pressed == 0) {//マウスクリックで効果音．シーン移動
      decision.play();
      pressed = 1;
      music = 2;
      return 2;
    }
  }else {
    noTint();
  }
  image(atFirst, 380, 250, 250, 120);
  
  //------続きから
  if(inspectC()) {
    tint(100);
    if(mousePressed && pressed == 0) {//マウスクリックで効果音．シーン移動
      decision.play();
      pressed = 1;
      return 1;
    }
  }else {
    noTint();
  }
  image(Continue, 382, 350, 245, 120);
  
  //------設定へ
  if(inspectS()) {
    tint(100);
    if(mousePressed && pressed == 0) {//マウスクリックで効果音．シーン移動
      decision.play();
      pressed = 1;
      return -1;
    }
  }else {
    noTint();
  }
  image(setting, 384, 440, 245, 120);
  
  noTint();//他に影響を与えないための初期化
  
  fill(200, 50, 50);
  textSize(18);
  text("画像：イラストや", 618, 510);
  text("楽曲：魔王魂", 618, 530);
  text("製作者：Chon ken gon", 600, 550);
  fill(180);
  text("※このゲームはフィクションであり実際の人物，団体などとは一切関係ありません．", 50, 580);//注意書き
  
  if(time % 2250 == 0) {
    music = 1;
  }
  return 0;
}

//------------------------------------(まだなんもない)------------------------------------//

int startt() {
  pressed = 0;
  background(0);
  if(inspectB()) {//戻る
    tint(100);
    if(mousePressed && pressed == 0) {//マウスクリックで効果音．シーン移動
      decision.play();
      pressed = 1;
      return 0;
    }
  }else {
    noTint();
  }
  image(back, 600, 500, 160, 80);
  return 1;
}

//--------------------------------(プレイ画面1の管理)----------------------------------------//

int playing() {
  pressed = 0;//マウスクリックの判定を一回に限定する
  
  //------------外枠--------------//
  background(180);
  fill(0);
  rect(0, 0, width, 100);
  rect(0, 0, 100, height);
  rect(0, 500, width, 100);
  rect(700, 0, 100, height);
  fill(255);
  rect(300, 50, 200, 50);
  
  //-----------------テキスト------------------//
  fill(180);
  textSize(18);
  text("移動は(a←,d→,w↑,s↓)でできます", 20, 530);
  text("調べ物は(return)でできます", 20, 550);
  
  //--------イラスト(家具など)の配置-------------//
  noTint();
  image(bedGirl, 100, 100, 150, 200); 
  image(shelf1, 100, 300, 150, 100);
  image(shelf2, 100, 400, 150, 100);
  image(shelf3, 400, 100, 450, 400);
  image(bay, bayX, bayY, 50, 50);
  
  //----戻るボタン-----------------------------//
  if(inspectB()) {//戻る
    tint(100);
    if(mousePressed && pressed == 0) {//マウスクリックで効果音．シーン移動
      decision.play();
      pressed = 1;
      music = 1;
      return 0;
    }
  }else {
    noTint();
  }
  image(back, 600, 500, 160, 80);
  
  //---------------------(つぎの画面へ)----------------------//
  if(bayX > 300 && bayX < 500 && bayY < 50) {
    bayY = 445;
    return 3;
  }
  
  //---これ書かないとなぜかバグる---------//
  return 2;
}

//--------------------------------(プレイ画面2の管理)----------------------------------------//

int playing2() {
  //------------(外枠)--------------//
  background(180);
  fill(0);
  rect(0, 0, width, 100);
  rect(0, 0, 100, height);
  rect(0, 500, width, 100);
  rect(700, 0, 100, height);
  fill(255);
  rect(300, 500, 200, 50);
  rect(300, 50, 200, 50);
  
  //-----------(イラストの配置)-------------//
  noTint();
  image(bay, bayX, bayY, 50, 50);
  
  //-----------------テキスト------------------//
  fill(180);
  textSize(18);
  text("移動は(a←,d→,w↑,s↓)でできます", 20, 530);
  text("調べ物は(return)でできます", 20, 550);
  
  //---------------------(まえの画面へ)----------------------//
  if(bayX > 300 && bayX < 500 && bayY > 500) {
    bayY = 100;
    return 2;
  }
  //---------------------(つぎの画面へ)----------------------//
  if(bayX > 300 && bayX < 500 && bayY < 50) {
    bayY = 445;
    return 4;
  }
  
  //---これ書かないとなぜかバグる---------//
  return 3;
}

//--------------------------------(プレイ画面3の管理)----------------------------------------//

int playing3() {
  //------------(外枠)--------------//
  background(180);
  fill(0);
  rect(0, 0, width, 100);
  rect(0, 0, 100, height);
  rect(0, 500, width, 100);
  rect(700, 0, 100, height);
  fill(255);
  rect(300, 500, 200, 50);
  
  //-----------(イラストの配置)-------------//
  noTint();
  image(bay, bayX, bayY, 50, 50);
  
  //-----------------テキスト------------------//
  fill(180);
  textSize(18);
  text("移動は(a←,d→,w↑,s↓)でできます", 20, 530);
  text("調べ物は(return)でできます", 20, 550);
  
  //---------------------(まえの画面へ)----------------------//
  if(bayX > 300 && bayX < 500 && bayY > 500) {
    bayY = 100;
    return 3;
  }
  
  return 4;
}

//---------------------------(マウス判定いろいろ)--------------------------------------------//

boolean inspectF() {//＜初めから＞の上にマウスがあるかどうか
  if(mouseX > 380 && mouseX < 600) {//マウスのx軸判定
    if(mouseY > 250 && mouseY < 350) {//マウスのy軸判定
      return true;
    }
  }
  return false;
}

boolean inspectC() {//＜続きから＞の上にマウスがあるかどうか
  if(mouseX > 382 && mouseX < 600) {//マウスのx軸判定
    if(mouseY > 350 && mouseY < 440) {//マウスのy軸判定
      return true;
    }
  }
  return false;
}

boolean inspectS() {//＜設定＞の上にマウスがあるかどうか
  if(mouseX > 384 && mouseX < 600) {//マウスのx軸判定
    if(mouseY > 440 && mouseY < 560) {//マウスのy軸判定
      return true;
    }
  }
  return false;
}

boolean hotbard() {
  if(inspectF() == true || inspectC() == true || inspectS() == true) {
    return true;
  }
  return false;
}

boolean inspectB() {//＜戻る＞の上にマウスがあるかどうか
  if(mouseX > 600 && mouseX < 760) {//マウスのx軸判定
    if(mouseY > 500 && mouseY < 580) {//マウスのy軸判定
      return true;
    }
  }
  return false;
}
