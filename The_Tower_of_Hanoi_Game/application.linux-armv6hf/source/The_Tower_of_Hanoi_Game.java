import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Arrays; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class The_Tower_of_Hanoi_Game extends PApplet {

The_Tower_of_Hanoi Tower;
PFont Font;

public void setup() {
  
  frameRate(1200);
  Tower = new The_Tower_of_Hanoi();
  Font =createFont("OpenSans-Semibold.ttf", 32);
  textFont(Font);
}

public void draw() {
  Tower.InitializeGame();
  Tower.SolveGame();
  fill(255, 0, 0);
  textAlign(LEFT, BOTTOM);
  if (Tower.DiscsNum<60) text("N - Next level", 0, height-32);
  if (Tower.DiscsNum>1) text("P - Previous level", 0, height);
}

public void keyPressed() {
  if (Tower.DiscsNum<60 && (key=='n' || key=='N')) {
    Tower.NextLevel();
  }
  if (Tower.DiscsNum>1 && (key=='p' || key=='P')) {
    Tower.PreviousLevel();
  }
}
 //<>//

class The_Tower_of_Hanoi {
  private float[][] Pegs;
  private float PegsLength;
  private float YAbovePegs;
  private float[][] Tower;
  private float Diff;
  private float Speed;
  private float[] CorrectDisc;
  private float LastDiscY;
  private float Dest;
  private int Thick=10;
  private int DiscsNum=1;
  private int Counter;
  private int NeededMove;
  private int Move;
  private int[] A = {0, 0};
  private int[] NextCorrectMove;
  private int MoveDir=2;
  private int MoveCycler=3;
  private boolean Initialized;
  private boolean Solved;
  private PFont Font = createFont("OpenSans-Semibold.ttf", 32);
  private PImage Image;

  public void InitializeGame() {
    //START OF START.. IKOUZO
    if (Solved && DiscsNum>=60) {
      if (Counter==DiscsNum) {
        textFont(Font);
        Image=get((int)(width/2+Pegs[0][0]-Tower[0][2]/2-50), (int)(height/2+Pegs[0][1]-Pegs[0][3]/2-50), (int)(Pegs[2][0]-Pegs[0][0]+Tower[0][2]+100), (int)(PegsLength+100));
        Image.save("Congratulations.png");
        Counter++;
      } 
      background(0);
      image(Image, 0, height-384, 1366, 384);
      textAlign(CENTER, BOTTOM);
      text("They said it couldn't be done...", width/2, height-384);
      textAlign(NORMAL, NORMAL);
    } else if (Solved) {
      NextLevel();
    } else {
      if (!Initialized) {
        Pegs = new float[3][4];
        Tower= new float[DiscsNum][4];
        Diff=width/4/(DiscsNum+5);
        Counter=1;
        for (float[] Peg : Pegs) {
          Peg[0]=-Counter--*width/4;
          Peg[1]=-12.5f;
          Peg[2]=Thick;
          Peg[3]=DiscsNum*Thick+25;
        }
        Counter=0;
        for (float[] Disc : Tower) {
          Disc[0]=-width/4;
          Disc[1]=(DiscsNum-1)*Thick/2-Counter*Thick;
          Disc[2]=(DiscsNum-Counter+++5)*Diff;
          Disc[3]=Thick;
        }
        PegsLength=DiscsNum*Thick+25;
        YAbovePegs=-PegsLength/2-25;
        Speed=DiscsNum < 16 ? 15 : DiscsNum*2;
        Initialized=true;
      }
      //END OF START..
      //START OF MIDDLE.. OF HONOR
      background(0);
      int Hue=0;
      colorMode(HSB);
      translate(width/2, height/2);
      rectMode(CENTER);
      noStroke();
      fill(200, 200, 200);
      for (float[] Peg : Pegs) {
        rect(Peg[0], Peg[1], Peg[2], Peg[3], 25);
      }
      stroke(0);
      for (float[] Disc : Tower) {
        fill(Hue+=6, 255, 255);
        rect(Disc[0], Disc[1], Disc[2], Disc[3], 5);
      }
      translate(-width/2, -height/2);
      colorMode(RGB);
      fill(255);
      stroke(0);
    }
    //END OF MIDDLE.. CALL OF DUTY IS BETTER
  }

  public void SolveGame() {
    //START OF THE END.. OMAE WA MŌ SHINDE IRU
    if (!Initialized) {
      throw new GameNotInitializedException("So...What game?");
    } else if (!Solved) {
      if (NeededMove!=pow(2, DiscsNum)) {
        switch(MoveDir) {
        case -1:
          CorrectDisc[1]-=Speed;
          if (CorrectDisc[1]< Dest) {
            CorrectDisc[1]=Dest;
            MoveDir=2;
          }
          break;
        case 0:
          if (NextCorrectMove[1] > NextCorrectMove[0]) {
            CorrectDisc[0]+=Speed;
            if (CorrectDisc[0]>Dest) {
              CorrectDisc[0]=Dest;
              MoveDir=2;
            }
          } else {
            CorrectDisc[0]-=Speed;
            if (CorrectDisc[0]<Dest) {
              CorrectDisc[0]=Dest;
              MoveDir=2;
            }
          }
          break;
        case 1:
          CorrectDisc[1]+=Speed;
          if (CorrectDisc[1]>Dest) {
            CorrectDisc[1]=Dest;
            MoveDir=2;
          }
          break;
        case 2:
          switch(MoveCycler) {
          case 3:
            CorrectDisc=new float[4];
            LastDiscY=(PegsLength-25)/2+5;
            CorrectDisc[1]=LastDiscY;
            NeededMove++;
            Move=0;
            NextCorrectMove=SolveGame(DiscsNum, 0, 1, 2);
            for (float[] Disc : Tower) {
              if (Disc[0] == Pegs[ NextCorrectMove[0] ][0] && Disc[1] < CorrectDisc[1]) {
                CorrectDisc=Disc;
              } else if (Disc[0] == Pegs[ NextCorrectMove[1] ][0] && Disc[1] < LastDiscY) {
                LastDiscY=Disc[1];
              }
            }
            MoveCycler=0;
            break;
          case 0:
            Dest=YAbovePegs;
            MoveDir=-1;
            MoveCycler++;
            break;
          case 1:
            Dest=Pegs[NextCorrectMove[1]][0];
            MoveDir=0;
            MoveCycler++;
            break;
          case 2:
            Dest=LastDiscY-10;
            MoveDir=1;
            MoveCycler++;
            break;
          }
          break;
        }
      } else {
        Solved=true;
      }
    }
    //END OF THE END.. MASAKA
  }

  /*
   *                                           private void SolveGame(int DiscsNum, String FromTower, String TempTower, String ToTower) {
   *                                             if (DiscsNum>0) {
   *USED IN A PREVIOUS VERSION                     SolveGame(DiscsNum-1, FromTower, ToTower, TempTower);
   *IN THE AGE OF READYGAME()                      if (NeededMove==++Move) {
   *AND RENDERGAME()                                 println("Disc moved from " + FromTower + " to " + ToTower);
   *AHHH THE GOOD OL' DAYS                         }
   *                                             SolveGame(DiscsNum-1, TempTower, FromTower, ToTower);
   *                                             }
   *                                           }
   */

  private int[] SolveGame(int DiscsNum, int FromTower, int TempTower, int ToTower) {
    if (DiscsNum>0) {
      int[] S=SolveGame(DiscsNum-1, FromTower, ToTower, TempTower);
      if (!Arrays.equals(S, A)) {
        return S;
      }
      if (NeededMove==++Move) {
        return new int[]{FromTower, ToTower};
      }
      S= SolveGame(DiscsNum-1, TempTower, FromTower, ToTower);
      if (!Arrays.equals(S, A)) {
        return S;
      }
    }
    return new int[]{0, 0};
  }

  public void NextLevel() {
    if (DiscsNum<60) {
      int DiscsNumber = DiscsNum;
      Reset();
      DiscsNum=++DiscsNumber;
      InitializeGame();
    }
  }

  public void PreviousLevel() {
    int DiscsNumber = DiscsNum;
    if (DiscsNumber>1) {
      Reset();
      DiscsNum=--DiscsNumber;
      InitializeGame();
    }
  }

  public void Reset() {
    Pegs = null;
    PegsLength = 0;
    YAbovePegs = 0;
    Tower = null;
    Diff = 0;
    Speed = 0;
    CorrectDisc = null;
    LastDiscY = 0;
    Dest = 0;
    Thick = 10;
    DiscsNum = 1;
    Counter = 0;
    NeededMove = 0;
    Move = 0;
    NextCorrectMove = null;
    MoveDir = 2;
    MoveCycler = 3;
    Initialized = false;
    Solved = false;
    Font = createFont("OpenSans-Semibold.ttf", 32);
    Image = null;
  }

  private class GameNotInitializedException extends RuntimeException {
    GameNotInitializedException(String ErrorMessage) {
      super(ErrorMessage);
    }
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "The_Tower_of_Hanoi_Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
