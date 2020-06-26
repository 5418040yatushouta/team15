//-----------------------{{fuck covid-19}}---------------------------------//
import processing.sound.*;//サウンド再生環境を入れる

//-----BGMの変数宣言-----//
SoundFile decision, roma, horror;

//-----画像の変数宣言-----//
PImage initialBackground, atFirst, Continue, setting, backBottun, tiredDoctor, bedGirl;
PImage akibin, makimono, shelf1, shelf2, shelf3;

//-----ファイルの変数宣言-----//
JSONObject systemFile;

//-----シーンの管理変数-----//
int scene = 0;//初期値の0はスタート画面

//---------------------------------(setup関数.ファイル,画像,BGM,フォントなどの読み込み)-----------------------------------------//

void setup() {
  size(800, 600);//ウィンドウサイズを指定
  //------jasonファイルを読み込む------//
  systemFile = loadJSONObject("data/system.json");
  
  //-------画像を読み込む---------//
  initialBackground = loadImage("firstBack.PNG");//タイトルのイラスト
  atFirst = loadImage("atFirst.PNG");//初めからのイラスト
  Continue = loadImage("continue.PNG");//続きから
  setting = loadImage("setting.PNG");//設定
  backBottun = loadImage("back.PNG");//戻る
  makimono = loadImage("makimono.PNG");//巻き物のイラスト
  tiredDoctor = loadImage("bay.PNG");//過労の医師のイラスト
  bedGirl = loadImage("bedGirl.png");//ベッドで寝ている女性のイラスト
  akibin = loadImage("akibin.png");//空き瓶がカゴに入っているイラスト
  shelf1 = loadImage("shelf1.PNG");//上から見た棚のイラスト
  shelf2 = loadImage("shelf2.PNG");//上から見た棚のイラスト
  shelf3 = loadImage("shelf3.PNG");//上から見た棚のイラスト
  
  
  //--------BGM,効果音を読み込む-------//
  decision = new SoundFile(this, "systemDecision.wav");//決定音
  roma = new SoundFile(this, "roma.mp3");//選択画面でのBGM
  horror = new SoundFile(this, "horror2.mp3");//プレイ画面でのBGM
  
  
  //--------日本語フォントを設定--------//
  PFont font = createFont("Meiryo", 50);
  textFont(font);
}

boolean pressed = false;

void draw() {
  background(0);
  inspect a = new inspect();
  if(a.First()) {
    tint(100);//マウスカーソルがボタン上にあるとき、ボタンを少し暗くする
    if(pressed == false) {
      a.Mouse();
    }
  }else {
    noTint();//カーソルが別の場所にあれば普通の明るさ
  }
  image(atFirst, 380, 250, 250, 120);//「初めから」のボタンを表示
  
}

//-----------------------------(各ボタン上にマウスがあるかの判定を返すクラス)------------------------------------//
class inspect {
  
  boolean First() {//＜初めから＞の上にマウスがあるかどうか
    if(mouseX > 380 && mouseX < 600) {//マウスのx軸判定
      if(mouseY > 250 && mouseY < 350) {//マウスのy軸判定
        return true;//上にあったらtrue
      }
    }
    return false;//なかったらfalse
  }
  
  boolean Continue() {//＜続きから＞の上にマウスがあるかどうか
    if(mouseX > 382 && mouseX < 600) {//マウスのx軸判定
      if(mouseY > 350 && mouseY < 440) {//マウスのy軸判定
        return true;//上にあったらtrue
      }
    }
    return false;//なかったらfalse
  }
  
  boolean Select() {//＜設定＞の上にマウスがあるかどうか
    if(mouseX > 384 && mouseX < 600) {//マウスのx軸判定
      if(mouseY > 440 && mouseY < 560) {//マウスのy軸判定
        return true;//上にあったらtrue
      }
    }
    return false;//なかったらfalse
  }
  
  boolean inspectB() {//＜戻る＞の上にマウスがあるかどうか
    if(mouseX > 600 && mouseX < 760) {//マウスのx軸判定
      if(mouseY > 500 && mouseY < 580) {//マウスのy軸判定
        return true;//上にあったらtrue
      }
    }
    return false;//なかったらfalse
  }
  
  void Mouse() {
    Music C = new Music();
    if(mousePressed) {
      C.decision();//決定音を再生
      pressed = true;//マウスクリックの判定を一回に限定する
      scene = 1;//シーンをプレイ画面に移動する
    }
  }
}


//------------------------------(音楽の再生・停止・繰り返しの管理)-------------------------------//

class Music {
  
  void roma() {
    horror.stop();//horrorを停止する
    roma.play();//roma.mp3を再生する
  }
  
  void horror() {
    roma.stop();//romaを停止する
    horror.play();//horrorを再生する
  }
  
  void decision() {
    decision.play();
  }
}




  
