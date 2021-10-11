unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, mmsystem;

type
  TMainForm = class(TForm)
    Shape: TShape;
    Image_Exit: TImage;
    Shape_SystemMenu: TShape;
    Image_Minimize: TImage;
    Image_3_3: TImage;
    Image_2_3: TImage;
    Image_1_3: TImage;
    Image_1_2: TImage;
    Image_2_2: TImage;
    Image_3_2: TImage;
    Image_3_1: TImage;
    Image_2_1: TImage;
    Image_1_1: TImage;
    Shape_Info: TShape;
    Image_New: TImage;
    Image_Info: TImage;
    Shape_Head: TShape;
    Label_Head: TLabel;
    Shape_First: TShape;
    Label_First: TLabel;
    Image_First: TImage;
    Memo: TMemo;
    Shape_Memo: TShape;
    Label_Header: TLabel;
    Label_1_1: TLabel;
    Label_1_2: TLabel;
    Label_1_3: TLabel;
    Label_1: TLabel;
    Label_2: TLabel;
    Label_3: TLabel;
    Image_Log: TImage;
    Label_Add_1: TLabel;
    Label_Add_2: TLabel;
    Timer: TTimer;
    Shape1: TShape;
    Label_Wins: TLabel;
    Label_Fool: TLabel;
    Label_Not: TLabel;
    Label_Wins_Count: TLabel;
    Label_Fool_Count: TLabel;
    Label_Not_Count: TLabel;
    Image_Sound: TImage;
    Timer_None: TTimer;
    procedure Image_ExitClick(Sender: TObject);
    procedure Image_MinimizeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_MinimizeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_ExitMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_ExitMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape_SystemMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_MinimizeClick(Sender: TObject);
    procedure Image_1_1Click(Sender: TObject);
    procedure Image_1_2Click(Sender: TObject);
    procedure Image_1_3Click(Sender: TObject);
    procedure Image_2_1Click(Sender: TObject);
    procedure Image_2_2Click(Sender: TObject);
    procedure Image_2_3Click(Sender: TObject);
    procedure Image_3_1Click(Sender: TObject);
    procedure Image_3_2Click(Sender: TObject);
    procedure Image_3_3Click(Sender: TObject);
    procedure Image_NewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_NewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_NewClick(Sender: TObject);
    procedure Shape_InfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_InfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_InfoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_InfoClick(Sender: TObject);
    procedure Shape_HeadMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape_FirstMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_HeadMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_FirstMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_FirstMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Shape_MemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_HeaderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_LogClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Image_SoundClick(Sender: TObject);
    procedure Timer_NoneTimer(Sender: TObject);
    procedure Image_1_1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_1_2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_1_3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_2_1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_2_2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_2_3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_3_1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_3_2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_3_3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TKrestNol = (Krest, Nol, Pusto);

var
  MainForm: TMainForm;
  BKrest, ex, Player, log, first, sound : boolean; //чей сейчас ход (TRUE - нолики)
  APole : Array [1..3, 1..3] of TKrestNol; //массив элементов поля
  i, j : integer; //счётчики для регулярных циклов (i - столбец)
  wins, fool, noth : integer;
  time : integer;

procedure FormMove (Form : TForm; Button : TmouseButton);

implementation

uses InfoUnit;

{$R *.dfm}

procedure ShowZnak (Image : TImage);
begin
  if BKrest then Image.Picture.LoadFromFile('image\nol.bmp')
  else Image.Picture.LoadFromFile('image\krest.bmp');
  BKrest := NOT(BKrest);
end;

procedure Intellect (what_is : TKrestNol);
begin
  if ((APole[1, 1] = what_is) AND (APole[1, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-1, 1-2');
      if (APole[1, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вверх');
          ShowZnak(MainForm.Image_1_3);
          if BKrest then APole[1, 3] := Nol
          else APole[1, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[1, 2] = what_is) AND (APole[1, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-2, 1-3');
      if (APole[1, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вверх');
          ShowZnak(MainForm.Image_1_1);
          if BKrest then APole[1, 1] := Nol
          else APole[1, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[1, 1] = what_is) AND (APole[1, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-1, 1-3');
      if (APole[1, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и вверх');
          ShowZnak(MainForm.Image_1_2);
          if BKrest then APole[1, 2] := Nol
          else APole[1, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
//------------------------------------------------------
  if ((APole[2, 1] = what_is) AND (APole[2, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-1, 2-2');
      if (APole[2, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и вправо');
          ShowZnak(MainForm.Image_2_3);
          if BKrest then APole[2, 3] := Nol
          else APole[2, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[2, 2] = what_is) AND (APole[2, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-2, 2-3');
      if (APole[2, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и влево');
          ShowZnak(MainForm.Image_2_1);
          if BKrest then APole[2, 1] := Nol
          else APole[2, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[2, 1] = what_is) AND (APole[2, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-1, 2-3');
      if (APole[2, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду в центр');
          ShowZnak(MainForm.Image_2_2);
          if BKrest then APole[2, 2] := Nol
          else APole[2, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
//------------------------------------------------------
  if ((APole[3, 1] = what_is) AND (APole[3, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 3-1, 3-2');
      if (APole[3, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вниз');
          ShowZnak(MainForm.Image_3_3);
          if BKrest then APole[3, 3] := Nol
          else APole[3, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[3, 2] = what_is) AND (APole[3, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 3-2, 3-3');
      if (APole[3, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вниз');
          ShowZnak(MainForm.Image_3_1);
          if BKrest then APole[3, 1] := Nol
          else APole[3, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[3, 1] = what_is) AND (APole[3, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 3-1, 3-3');
      if (APole[3, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и вниз');
          ShowZnak(MainForm.Image_3_2);
          if BKrest then APole[3, 2] := Nol
          else APole[3, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
//------------------------------------------------------
//------------------------------------------------------
  if ((APole[1, 1] = what_is) AND (APole[2, 1] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-1, 2-1');
      if (APole[3, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вниз');
          ShowZnak(MainForm.Image_3_1);
          if BKrest then APole[3, 1] := Nol
          else APole[3, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[2, 1] = what_is) AND (APole[3, 1] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-1, 3-1');
      if (APole[1, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вверх');
          ShowZnak(MainForm.Image_1_1);
          if BKrest then APole[1, 1] := Nol
          else APole[1, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[1, 1] = what_is) AND (APole[3, 1] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-1, 3-1');
      if (APole[2, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и влево');
          ShowZnak(MainForm.Image_2_1);
          if BKrest then APole[2, 1] := Nol
          else APole[2, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
//------------------------------------------------------
  if ((APole[1, 2] = what_is) AND (APole[2, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-2, 2-2');
      if (APole[3, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и вниз');
          ShowZnak(MainForm.Image_3_2);
          if BKrest then APole[3, 2] := Nol
          else APole[3, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[2, 2] = what_is) AND (APole[3, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-2, 3-2');
      if (APole[1, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и вверх');
          ShowZnak(MainForm.Image_1_2);
          if BKrest then APole[1, 2] := Nol
          else APole[1, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[1, 2] = what_is) AND (APole[3, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-2, 3-2');
      if (APole[2, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду в центру');
          ShowZnak(MainForm.Image_2_2);
          if BKrest then APole[2, 2] := Nol
          else APole[2, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
//------------------------------------------------------
  if ((APole[1, 3] = what_is) AND (APole[2, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-3, 2-3');
      if (APole[3, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вниз');
          ShowZnak(MainForm.Image_3_3);
          if BKrest then APole[3, 3] := Nol
          else APole[3, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[2, 3] = what_is) AND (APole[3, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-3, 3-3');
      if (APole[1, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вверх');
          ShowZnak(MainForm.Image_1_3);
          if BKrest then APole[1, 3] := Nol
          else APole[1, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[1, 3] = what_is) AND (APole[3, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-3, 3-3');
      if (APole[2, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду по центру и вправо');
          ShowZnak(MainForm.Image_2_3);
          if BKrest then APole[2, 3] := Nol
          else APole[2, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
//------------------------------------------------------
  if ((APole[1, 1] = what_is) AND (APole[2, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-1, 2-2');
      if (APole[3, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вниз');
          ShowZnak(MainForm.Image_3_3);
          if BKrest then APole[3, 3] := Nol
          else APole[3, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[2, 2] = what_is) AND (APole[3, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-2, 3-3');
      if (APole[1, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вверх');
          ShowZnak(MainForm.Image_1_1);
          if BKrest then APole[1, 1] := Nol
          else APole[1, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[1, 1] = what_is) AND (APole[3, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 1-1, 3-3');
      if (APole[2, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду в центр');
          ShowZnak(MainForm.Image_2_2);
          if BKrest then APole[2, 2] := Nol
          else APole[2, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
//------------------------------------------------------
  if ((APole[3, 1] = what_is) AND (APole[2, 2] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 3-1, 2-2');
      if (APole[1, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вверх');
          ShowZnak(MainForm.Image_1_3);
          if BKrest then APole[1, 3] := Nol
          else APole[1, 3] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[2, 2] = what_is) AND (APole[1, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 2-2, 1-3');
      if (APole[3, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вниз');
          ShowZnak(MainForm.Image_3_1);
          if BKrest then APole[3, 1] := Nol
          else APole[3, 1] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
  if ((APole[3, 1] = what_is) AND (APole[1, 3] = what_is)) then
    begin
      MainForm.Memo.Lines.Add('Анализирую ячейки 3-1, 1-3');
      if (APole[2, 2] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду в центр');
          ShowZnak(MainForm.Image_2_2);
          if BKrest then APole[2, 2] := Nol
          else APole[2, 2] := Krest;
          ex := TRUE;
          exit;
        end;
      MainForm.Memo.Lines.Add('Ничего интересного...');
    end;
end;

function Podvoh : boolean;
label
  go;
var
  r : byte;
begin
  result := FALSE;
  RANDOMIZE;
  r := RANDOM(10);
  if ((APole[2, 2] = Pusto) AND (r > 2)) then
    begin
      r := 0;
      if APole[1, 1] <> Pusto then r := r + 1;
      if APole[1, 2] <> Pusto then r := r + 1;
      if APole[1, 3] <> Pusto then r := r + 1;
      if APole[2, 3] <> Pusto then r := r + 1;
      if APole[3, 3] <> Pusto then r := r + 1;
      if APole[3, 2] <> Pusto then r := r + 1;
      if APole[3, 1] <> Pusto then r := r + 1;
      if APole[2, 1] <> Pusto then r := r + 1;
      if (r = 1) then
        begin
          MainForm.Memo.Lines.Add('Иду в центр');
          ShowZnak(MainForm.Image_2_2);
          if BKrest then APole[2, 2] := Nol
          else APole[2, 2] := Krest;
          result := TRUE;
          exit;
        end;
    end;
//------------------------------------------------------
  RANDOMIZE;
  r := RANDOM(6);
  if ((first) AND (r = 5)) then
    begin
      if APole[1, 1] = Krest then
        begin
          RANDOMIZE;
          r := RANDOM(2);
          if r = 1 then
            begin
              if APole[2, 1] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру влево');
                  ShowZnak(MainForm.Image_2_1);
                  if BKrest then APole[2, 1] := Nol
                  else APole[2, 1] := Krest;
                  result := TRUE;
                  exit;
                end;
            end
          else
            begin
              if APole[1, 2] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру вверх');
                  ShowZnak(MainForm.Image_1_2);
                  if BKrest then APole[1, 2] := Nol
                  else APole[1, 2] := Krest;
                  result := TRUE;
                  exit;
                end;
            end;
        end;

      if APole[3, 1] = Krest then
        begin
          RANDOMIZE;
          r := RANDOM(2);
          if r = 1 then
            begin
              if APole[2, 1] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру влево');
                  ShowZnak(MainForm.Image_2_1);
                  if BKrest then APole[2, 1] := Nol
                  else APole[2, 1] := Krest;
                  result := TRUE;
                  exit;
                end;
            end
          else
            begin
              if APole[3, 2] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру вниз');
                  ShowZnak(MainForm.Image_3_2);
                  if BKrest then APole[3, 2] := Nol
                  else APole[3, 2] := Krest;
                  result := TRUE;
                  exit;
                end;
            end;
        end;

      if APole[3, 3] = Krest then
        begin
          RANDOMIZE;
          r := RANDOM(2);
          if r = 1 then
            begin
              if APole[2, 3] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру вправо');
                  ShowZnak(MainForm.Image_2_3);
                  if BKrest then APole[2, 3] := Nol
                  else APole[2, 3] := Krest;
                  result := TRUE;
                  exit;
                end;
            end
          else
            begin
              if APole[3, 2] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру вниз');
                  ShowZnak(MainForm.Image_3_2);
                  if BKrest then APole[3, 2] := Nol
                  else APole[3, 2] := Krest;
                  result := TRUE;
                  exit;
                end;
            end;
        end;

      if APole[1, 3] = Krest then
        begin
          RANDOMIZE;
          r := RANDOM(2);
          if r = 1 then
            begin
              if APole[2, 3] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру вправо');
                  ShowZnak(MainForm.Image_2_3);
                  if BKrest then APole[2, 3] := Nol
                  else APole[2, 3] := Krest;
                  result := TRUE;
                  exit;
                end;
            end
          else
            begin
              if APole[1, 2] = Pusto then
                begin
                  MainForm.Memo.Lines.Add('Возможна реализация комбинации...... Иду по центру вверх');
                  ShowZnak(MainForm.Image_1_2);
                  if BKrest then APole[1, 2] := Nol
                  else APole[1, 2] := Krest;
                  result := TRUE;
                  exit;
                end;
            end;
        end;
    end;
//------------------------------------------------------


//------------------------------------------------------
  r := 0;
  if APole[1, 1] = Krest then r := r + 1;
  if APole[1, 2] = Krest then r := r + 1;
  if APole[1, 3] = Krest then r := r + 1;
  if APole[2, 3] = Krest then r := r + 1;
  if APole[3, 3] = Krest then r := r + 1;
  if APole[3, 2] = Krest then r := r + 1;
  if APole[3, 1] = Krest then r := r + 1;
  if APole[2, 1] = Krest then r := r + 1;
  if r > 2 then goto go;

  if ((APole[1, 1] = Krest) OR (APole[1, 3] = Krest)) then
    if APole[3, 2] = Krest then
      begin
        if APole[3, 1] = Pusto then
        if APole[1, 1] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду влево вниз');
            ShowZnak(MainForm.Image_3_1);
            if BKrest then APole[3, 1] := Nol
            else APole[3, 1] := Krest;
            result := TRUE;
            exit;
          end;
        if APole[3, 3] = Pusto then
        if APole[1, 3] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду вправо вниз');
            ShowZnak(MainForm.Image_3_3);
            if BKrest then APole[3, 3] := Nol
            else APole[3, 3] := Krest;
            result := TRUE;
            exit;
          end;
      end;

  if ((APole[1, 1] = Krest) OR (APole[3, 1] = Krest)) then
    if APole[2, 3] = Krest then
      begin
        if APole[1, 3] = Pusto then
        if APole[1, 1] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду вправо вверх');
            ShowZnak(MainForm.Image_1_3);
            if BKrest then APole[1, 3] := Nol
            else APole[1, 3] := Krest;
            result := TRUE;
            exit;
          end;
        if APole[3, 3] = Pusto then
        if APole[3, 1] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду вправо вниз');
            ShowZnak(MainForm.Image_3_3);
            if BKrest then APole[3, 3] := Nol
            else APole[3, 3] := Krest;
            result := TRUE;
            exit;
          end;
      end;

  if ((APole[1, 3] = Krest) OR (APole[3, 3] = Krest)) then
    if APole[2, 1] = Krest then
      begin
        if APole[1, 1] = Pusto then
        if APole[1, 3] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду влево вверх');
            ShowZnak(MainForm.Image_1_1);
            if BKrest then APole[1, 1] := Nol
            else APole[1, 1] := Krest;
            result := TRUE;
            exit;
          end;
        if APole[3, 1] = Pusto then
        if APole[3, 3] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду влево вниз');
            ShowZnak(MainForm.Image_3_1);
            if BKrest then APole[3, 1] := Nol
            else APole[3, 1] := Krest;
            result := TRUE;
            exit;
          end;
      end;

  if ((APole[3, 1] = Krest) OR (APole[3, 3] = Krest)) then
    if APole[1, 2] = Krest then
      begin
        if APole[1, 1] = Pusto then
        if APole[3, 1] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду влево вверх');
            ShowZnak(MainForm.Image_1_1);
            if BKrest then APole[1, 1] := Nol
            else APole[1, 1] := Krest;
            result := TRUE;
            exit;
          end;
        if APole[1, 3] = Pusto then
        if APole[3, 3] = Krest then
          begin
            MainForm.Memo.Lines.Add('Возможная комбинация - "Конь"... Иду вправо вверх');
            ShowZnak(MainForm.Image_1_3);
            if BKrest then APole[1, 3] := Nol
            else APole[1, 3] := Krest;
            result := TRUE;
            exit;
          end;
      end;
//------------------------------------------------------
  go : ;
  if NOT(first) then exit;
  RANDOMIZE;
  r := RANDOM(10);
  if r < 7 then exit;
  if ((APole[1, 1] = Krest) OR (APole[1, 3] = Krest) OR (APole[3, 1] = Krest) OR (APole[3, 3] = Krest)) then
    begin
      RANDOMIZE;
      if (APole[1, 2] = Pusto) then
        begin
          r := RANDOM(10);
          if r > 3 then
            begin
              MainForm.Memo.Lines.Add('Возможна реализация комбинации... Иду по центру вверх');
              ShowZnak(MainForm.Image_1_2);
              if BKrest then APole[1, 2] := Nol
              else APole[1, 2] := Krest;
              result := TRUE;
              exit;
            end;
        end;
      if (APole[2, 3] = Pusto) then
        begin
          r := RANDOM(10);
          if r > 3 then
            begin
              MainForm.Memo.Lines.Add('Возможна реализация комбинации... Иду по центру вправо');
              ShowZnak(MainForm.Image_2_3);
              if BKrest then APole[2, 3] := Nol
              else APole[2, 3] := Krest;
              result := TRUE;
              exit;
            end;
        end;
      if (APole[3, 2] = Pusto) then
        begin
          r := RANDOM(10);
          if r > 3 then
            begin
              MainForm.Memo.Lines.Add('Возможна реализация комбинации... Иду по центру вниз');
              ShowZnak(MainForm.Image_3_2);
              if BKrest then APole[3, 2] := Nol
              else APole[3, 2] := Krest;
              result := TRUE;
              exit;
            end;
        end;
      if (APole[2, 1] = Pusto) then
        begin
          r := RANDOM(10);
          if r > 3 then
            begin
              MainForm.Memo.Lines.Add('Возможна реализация комбинации... Иду по центру влево');
              ShowZnak(MainForm.Image_2_1);
              if BKrest then APole[2, 1] := Nol
              else APole[2, 1] := Krest;
              result := TRUE;
              exit;
            end;
        end;
    end;
end;

procedure OneBlock;
label
  here, sec;
var
  r : byte;
  i : integer;
begin
//------------------------------------------------------
  r := 0;
  if APole[1, 1] <> Pusto then r := r + 1;
  if APole[1, 2] <> Pusto then r := r + 1;
  if APole[1, 3] <> Pusto then r := r + 1;
  if APole[2, 3] <> Pusto then r := r + 1;
  if APole[3, 3] <> Pusto then r := r + 1;
  if APole[3, 2] <> Pusto then r := r + 1;
  if APole[3, 1] <> Pusto then r := r + 1;
  if APole[2, 1] <> Pusto then r := r + 1;

  if ((APole[1, 1] = Nol) AND (APole[1, 3] = Nol) AND (r < 5)) then
    begin
        if (APole[3, 3] = Pusto) AND (APole[2, 3] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду вправо и вниз');
            ShowZnak(MainForm.Image_3_3);
            if BKrest then APole[3, 3] := Nol
            else APole[3, 3] := Krest;
            exit;
          end;
        if (APole[3, 1] = Pusto) AND (APole[2, 1] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду влево и вниз');
            ShowZnak(MainForm.Image_3_1);
            if BKrest then APole[3, 1] := Nol
            else APole[3, 1] := Krest;
            exit;
          end;
    end;

  if ((APole[1, 3] = Nol) AND (APole[3, 3] = Nol) AND (r < 5)) then
    begin
        if (APole[1, 1] = Pusto) AND (APole[1, 2] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду влево и вверх');
            ShowZnak(MainForm.Image_1_1);
            if BKrest then APole[1, 1] := Nol
            else APole[1, 1] := Krest;
            exit;
          end;
        if (APole[3, 1] = Pusto) AND (APole[3, 2] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду влево и вниз');
            ShowZnak(MainForm.Image_3_1);
            if BKrest then APole[3, 1] := Nol
            else APole[3, 1] := Krest;
            exit;
          end;
    end;

  if ((APole[3, 1] = Nol) AND (APole[3, 3] = Nol) AND (r < 5)) then
    begin
        if (APole[1, 1] = Pusto) AND (APole[2, 1] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду влево и вверх');
            ShowZnak(MainForm.Image_1_1);
            if BKrest then APole[1, 1] := Nol
            else APole[1, 1] := Krest;
            exit;
          end;
        if (APole[1, 3] = Pusto) AND (APole[2, 3] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду вправо и вверх');
            ShowZnak(MainForm.Image_1_3);
            if BKrest then APole[1, 3] := Nol
            else APole[1, 3] := Krest;
            exit;
          end;
    end;

  if ((APole[1, 1] = Nol) AND (APole[3, 1] = Nol) AND (r < 5)) then
    begin
        if (APole[1, 3] = Pusto) AND (APole[1, 2] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду вправо и вверх');
            ShowZnak(MainForm.Image_1_3);
            if BKrest then APole[1, 3] := Nol
            else APole[1, 3] := Krest;
            exit;
          end;
        if (APole[3, 3] = Pusto) AND (APole[3, 2] = Pusto) then
          begin
            MainForm.Memo.Lines.Add('Продолжаю комбинацию "Три угла"... Иду вправо и вниз');
            ShowZnak(MainForm.Image_3_3);
            if BKrest then APole[3, 3] := Nol
            else APole[3, 3] := Krest;
            exit;
          end;
    end;
//------------------------------------------------------


//------------------------------------------------------
  r := 0;
  if APole[1, 1] <> Pusto then r := r + 1;
  if APole[1, 2] <> Pusto then r := r + 1;
  if APole[1, 3] <> Pusto then r := r + 1;
  if APole[2, 3] <> Pusto then r := r + 1;
  if APole[3, 3] <> Pusto then r := r + 1;
  if APole[3, 2] <> Pusto then r := r + 1;
  if APole[3, 1] <> Pusto then r := r + 1;
  if APole[2, 1] <> Pusto then r := r + 1;

  if (((APole[1, 1] = Nol) OR (APole[1, 3] = Nol) OR (APole[3, 3] = Nol) OR (APole[3, 1] = Nol)) AND (APole[2, 2] = Pusto) AND (r < 3)) then
    begin
      RANDOMIZE;
      r := RANDOM(2);
      if APole[1, 1] = Nol then
        begin
          if ((APole[1, 3] = Pusto) AND (APole[1, 2] = Pusto) AND (r = 1)) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду вправо и вверх');
              ShowZnak(MainForm.Image_1_3);
              if BKrest then APole[1, 3] := Nol
              else APole[1, 3] := Krest;
              exit;
            end;
          if (APole[3, 1] = Pusto) AND (APole[2, 1] = Pusto) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду влево и вниз');
              ShowZnak(MainForm.Image_3_1);
              if BKrest then APole[3, 1] := Nol
              else APole[3, 1] := Krest;
              exit;
            end;
        end;

      if APole[1, 3] = Nol then
        begin
          if ((APole[1, 1] = Pusto) AND (APole[1, 2] = Pusto) AND (r = 1)) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду влево и вверх');
              ShowZnak(MainForm.Image_1_1);
              if BKrest then APole[1, 1] := Nol
              else APole[1, 1] := Krest;
              exit;
            end;
          if (APole[3, 3] = Pusto) AND (APole[2, 3] = Pusto) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду вправо и вниз');
              ShowZnak(MainForm.Image_3_3);
              if BKrest then APole[3, 3] := Nol
              else APole[3, 3] := Krest;
              exit;
            end;
        end;

      if APole[3, 3] = Nol then
        begin
          if ((APole[1, 3] = Pusto) AND (APole[2, 3] = Pusto) AND (r = 1)) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду вправо и вверх');
              ShowZnak(MainForm.Image_1_3);
              if BKrest then APole[1, 3] := Nol
              else APole[1, 3] := Krest;
              exit;
            end;
          if (APole[3, 1] = Pusto) AND (APole[3, 2] = Pusto) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду влево и вниз');
              ShowZnak(MainForm.Image_3_1);
              if BKrest then APole[3, 1] := Nol
              else APole[3, 1] := Krest;
              exit;
            end;
        end;

      if APole[3, 1] = Nol then
        begin
          if ((APole[3, 3] = Pusto) AND (APole[3, 2] = Pusto) AND (r = 1)) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду вправо и вниз');
              ShowZnak(MainForm.Image_3_3);
              if BKrest then APole[3, 3] := Nol
              else APole[3, 3] := Krest;
              exit;
            end;
          if (APole[1, 1] = Pusto) AND (APole[2, 1] = Pusto) then
            begin
              MainForm.Memo.Lines.Add('Начинаю комбинацию "Три угла"... Иду влево и вверх');
              ShowZnak(MainForm.Image_1_1);
              if BKrest then APole[1, 1] := Nol
              else APole[1, 1] := Krest;
              exit;
            end;
        end;
    end;
//------------------------------------------------------


//------------------------------------------------------
  r := 0;
  if APole[1, 1] <> Pusto then r := r + 1;
  if APole[1, 2] <> Pusto then r := r + 1;
  if APole[1, 3] <> Pusto then r := r + 1;
  if APole[2, 3] <> Pusto then r := r + 1;
  if APole[3, 3] <> Pusto then r := r + 1;
  if APole[3, 2] <> Pusto then r := r + 1;
  if APole[3, 1] <> Pusto then r := r + 1;
  if APole[2, 1] <> Pusto then r := r + 1;

  if ((APole[2, 2] = Krest) AND (r < 3)) then
    begin
      if ((APole[1, 1] = Nol) OR (APole[1, 3] = Nol) OR (APole[3, 3] = Nol) OR (APole[3, 1] = Nol)) then
        begin
          if APole[1, 1] = Nol then
            if APole[3, 3] = Pusto then
              begin
                MainForm.Memo.Lines.Add('Реализую комбинацию "Два угла"... Иду вправо и вниз');
                ShowZnak(MainForm.Image_3_3);
                if BKrest then APole[3, 3] := Nol
                else APole[3, 3] := Krest;
                exit;
              end;

          if APole[1, 3] = Nol then
            if APole[3, 1] = Pusto then
              begin
                MainForm.Memo.Lines.Add('Реализую комбинацию "Два угла"... Иду влево и вниз');
                ShowZnak(MainForm.Image_3_1);
                if BKrest then APole[3, 1] := Nol
                else APole[3, 1] := Krest;
                exit;
              end;

          if APole[3, 3] = Nol then
            if APole[1, 1] = Pusto then
              begin
                MainForm.Memo.Lines.Add('Реализую комбинацию "Два угла"... Иду влево и вверх');
                ShowZnak(MainForm.Image_1_1);
                if BKrest then APole[1, 1] := Nol
                else APole[1, 1] := Krest;
                exit;
              end;

          if APole[3, 1] = Nol then
            if APole[1, 3] = Pusto then
              begin
                MainForm.Memo.Lines.Add('Реализую комбинацию "Два угла"... Иду вправо и вверх');
                ShowZnak(MainForm.Image_1_3);
                if BKrest then APole[1, 3] := Nol
                else APole[1, 3] := Krest;
                exit;
              end;
        end;
    end;
  
//------------------------------------------------------

//------------------------------------------------------
  r := 0;
  if APole[1, 1] <> Pusto then r := r + 1;
  if APole[1, 2] <> Pusto then r := r + 1;
  if APole[1, 3] <> Pusto then r := r + 1;
  if APole[2, 3] <> Pusto then r := r + 1;
  if APole[3, 3] <> Pusto then r := r + 1;
  if APole[3, 2] <> Pusto then r := r + 1;
  if APole[3, 1] <> Pusto then r := r + 1;
  if APole[2, 1] <> Pusto then r := r + 1;

  if r < 4 then
    begin
      RANDOMIZE;
      r := RANDOM(2);
      if ((APole[1, 1] = Krest) AND (APole[3, 3] = Krest) AND (APole[2, 2] = Nol)) then
        begin
          if ((APole[2, 1] = Pusto) AND (r = 1)) then
            begin
              MainForm.Memo.Lines.Add('Ухожу от комбинации "Два угла"... Иду по центру влево');
              ShowZnak(MainForm.Image_2_1);
              if BKrest then APole[2, 1] := Nol
              else APole[2, 1] := Krest;
              exit;
            end;
           if APole[2, 3] = Pusto then
            begin
              MainForm.Memo.Lines.Add('Ухожу от комбинации "Два угла"... Иду по центру вправо');
              ShowZnak(MainForm.Image_2_3);
              if BKrest then APole[2, 3] := Nol
              else APole[2, 3] := Krest;
              exit;
            end;
        end;

      if ((APole[1, 3] = Krest) AND (APole[3, 1] = Krest) AND (APole[2, 2] = Nol)) then
        begin
          if ((APole[2, 1] = Pusto)  AND (r = 1)) then
            begin
              MainForm.Memo.Lines.Add('Ухожу от комбинации "Два угла"... Иду по центру влево');
              ShowZnak(MainForm.Image_2_1);
              if BKrest then APole[2, 1] := Nol
              else APole[2, 1] := Krest;
              exit;
            end;
           if APole[2, 3] = Pusto then
            begin
              MainForm.Memo.Lines.Add('Ухожу от комбинации "Два угла"... Иду по центру вправо');
              ShowZnak(MainForm.Image_2_3);
              if BKrest then APole[2, 3] := Nol
              else APole[2, 3] := Krest;
              exit;
            end;
        end;
    end;
  
//------------------------------------------------------
  i := 0;
  here : ;
  RANDOMIZE;
  r := RANDOM(10);
  if r > 4 then goto sec;
  if (APole[2, 2] = Pusto) then
    begin
      MainForm.Memo.Lines.Add('Иду в центр');
      ShowZnak(MainForm.Image_2_2);
      if BKrest then APole[2, 2] := Nol
      else APole[2, 2] := Krest;
      exit;
    end
  else
    begin
      sec : ;
      if (APole[1, 1] = Pusto) then
        begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду влево и вверх');
              ShowZnak(MainForm.Image_1_1);
              if BKrest then APole[1, 1] := Nol
              else APole[1, 1] := Krest;
              exit;
            end;
        end;
      if (APole[1, 3] = Pusto) then
        begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду вправо и вверх');
              ShowZnak(MainForm.Image_1_3);
              if BKrest then APole[1, 3] := Nol
              else APole[1, 3] := Krest;
              exit;
            end;
        end;
      if (APole[3, 1] = Pusto) then
        begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду влево и вниз');
              ShowZnak(MainForm.Image_3_1);
              if BKrest then APole[3, 1] := Nol
              else APole[3, 1] := Krest;
              exit;
            end;
        end;
      if (APole[3, 3] = Pusto) then
        begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду вправо и вниз');
              ShowZnak(MainForm.Image_3_3);
              if BKrest then APole[3, 3] := Nol
              else APole[3, 3] := Krest;
              exit;
            end;
        end;
    end;
    if (APole[1, 2] = Pusto) then
      begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду по центру и вверх');
              ShowZnak(MainForm.Image_1_2);
              if BKrest then APole[1, 2] := Nol
              else APole[1, 2] := Krest;
              exit;
            end;
      end;
    if (APole[2, 3] = Pusto) then
      begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду по центру и вправо');
              ShowZnak(MainForm.Image_2_3);
              if BKrest then APole[2, 3] := Nol
              else APole[2, 3] := Krest;
              exit;
            end;
      end;
    if (APole[3, 2] = Pusto) then
      begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду по центру и вниз');
              ShowZnak(MainForm.Image_3_2);
              if BKrest then APole[3, 2] := Nol
              else APole[3, 2] := Krest;
              exit;
            end;
      end;
    if (APole[2, 1] = Pusto) then
      begin
          r := RANDOM(2);
          if r = 1 then
            begin
              MainForm.Memo.Lines.Add('Иду по центру и влево');
              ShowZnak(MainForm.Image_2_1);
              if BKrest then APole[2, 1] := Nol
              else APole[2, 1] := Krest;
              exit;
            end;
      end;
    i := i + 1;
    if i < 1000 then goto here;

  if (APole[2, 2] = Pusto) then
    begin
      MainForm.Memo.Lines.Add('Иду в центр');
      ShowZnak(MainForm.Image_2_2);
      if BKrest then APole[2, 2] := Nol
      else APole[2, 2] := Krest;
      exit;
    end
  else
    begin
      if (APole[1, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вверх');
          ShowZnak(MainForm.Image_1_1);
          if BKrest then APole[1, 1] := Nol
          else APole[1, 1] := Krest;
          exit;
        end;
      if (APole[1, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вверх');
          ShowZnak(MainForm.Image_1_3);
          if BKrest then APole[1, 3] := Nol
          else APole[1, 3] := Krest;
          exit;
        end;
      if (APole[3, 1] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду влево и вниз');
          ShowZnak(MainForm.Image_3_1);
          if BKrest then APole[3, 1] := Nol
          else APole[3, 1] := Krest;
          exit;
        end;
      if (APole[3, 3] = Pusto) then
        begin
          MainForm.Memo.Lines.Add('Иду вправо и вниз');
          ShowZnak(MainForm.Image_3_3);
          if BKrest then APole[3, 3] := Nol
          else APole[3, 3] := Krest;
          exit;
        end;
    end;
    if (APole[1, 2] = Pusto) then
      begin
        MainForm.Memo.Lines.Add('Иду по центру и вверх');
        ShowZnak(MainForm.Image_1_2);
        if BKrest then APole[1, 2] := Nol
        else APole[1, 2] := Krest;
        exit;
      end;
    if (APole[2, 3] = Pusto) then
      begin
        MainForm.Memo.Lines.Add('Иду по центру и влево');
        ShowZnak(MainForm.Image_2_3);
        if BKrest then APole[2, 3] := Nol
        else APole[2, 3] := Krest;
        exit;
      end;
    if (APole[3, 2] = Pusto) then
      begin
        MainForm.Memo.Lines.Add('Иду по центру и вниз');
        ShowZnak(MainForm.Image_3_2);
        if BKrest then APole[3, 2] := Nol
        else APole[3, 2] := Krest;
        exit;
      end;
    if (APole[2, 1] = Pusto) then
      begin
        MainForm.Memo.Lines.Add('Иду по центру и влево');
        ShowZnak(MainForm.Image_2_1);
        if BKrest then APole[2, 1] := Nol
        else APole[2, 1] := Krest;
        exit;
      end;
end;

procedure FormMove (Form : TForm; Button: TMouseButton);
begin
  if Button = mbLeft then
    begin
      ReleaseCapture;
      SendMessage(Form.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
    end;
end;

procedure Image_En (bool : boolean);
begin
  MainForm.Image_1_1.Enabled := bool;
  MainForm.Image_1_2.Enabled := bool;
  MainForm.Image_1_3.Enabled := bool;

  MainForm.Image_2_1.Enabled := bool;
  MainForm.Image_2_2.Enabled := bool;
  MainForm.Image_2_3.Enabled := bool;

  MainForm.Image_3_1.Enabled := bool;
  MainForm.Image_3_2.Enabled := bool;
  MainForm.Image_3_3.Enabled := bool;
end;

procedure ShowCount;
begin
  if wins > 30000 then wins := 0;
  if fool > 30000 then fool := 0;
  if noth > 30000 then noth := 0;

  MainForm.Label_Wins_Count.Caption := IntToStr(wins);
  MainForm.Label_Fool_Count.Caption := IntToStr(fool);
  MainForm.Label_Not_Count.Caption := IntToStr(noth);
end;

function Win : boolean;
begin
  result := FALSE;
  if ((APole[1, 1] = APole[1, 2]) AND (APole[1, 2] = APole[1, 3])) then
    begin if ((APole[1, 1] <> Pusto) AND (APole[1, 2] <> Pusto) AND (APole[1, 3] <> Pusto)) then
      if (APole[1, 1] = Krest) then
        begin
          MainForm.Image_1_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_1_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_1_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_1_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_1_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_1_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;

  if ((APole[2, 1] = APole[2, 2]) AND (APole[2, 2] = APole[2, 3])) then
    begin if ((APole[2, 1] <> Pusto) AND (APole[2, 2] <> Pusto) AND (APole[2, 3] <> Pusto)) then
      if (APole[2, 1] = Krest) then
        begin
          MainForm.Image_2_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_2_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_2_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_2_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;

  if ((APole[3, 1] = APole[3, 2]) AND (APole[3, 2] = APole[3, 3])) then
    begin if ((APole[3, 1] <> Pusto) AND (APole[3, 2] <> Pusto) AND (APole[3, 3] <> Pusto)) then
      if (APole[3, 1] = Krest) then
        begin
          MainForm.Image_3_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_3_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_3_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_3_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_3_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_3_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;

  if ((APole[1, 1] = APole[2, 1]) AND (APole[2, 1] = APole[3, 1])) then
    begin if ((APole[1, 1] <> Pusto) AND (APole[2, 1] <> Pusto) AND (APole[3, 1] <> Pusto)) then
      if (APole[1, 1] = Krest) then
        begin
          MainForm.Image_1_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_2_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_3_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_1_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_2_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_3_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;

  if ((APole[1, 2] = APole[2, 2]) AND (APole[2, 2] = APole[3, 2])) then
    begin if ((APole[1, 2] <> Pusto) AND (APole[2, 2] <> Pusto) AND (APole[3, 2] <> Pusto)) then
      if (APole[1, 2] = Krest) then
        begin
          MainForm.Image_1_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_3_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_1_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_3_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;

  if ((APole[1, 3] = APole[2, 3]) AND (APole[2, 3] = APole[3, 3])) then
    begin  if ((APole[1, 3] <> Pusto) AND (APole[2, 3] <> Pusto) AND (APole[2, 3] <> Pusto)) then
      if (APole[1, 3] = Krest) then
        begin
          MainForm.Image_1_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_2_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_3_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_1_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_2_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_3_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;

  if ((APole[1, 1] = APole[2, 2]) AND (APole[2, 2] = APole[3, 3])) then
    begin if ((APole[1, 1] <> Pusto) AND (APole[2, 2] <> Pusto) AND (APole[3, 3] <> Pusto)) then
      if (APole[1, 1] = Krest) then
        begin
          MainForm.Image_1_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_3_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_1_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_3_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;

  if ((APole[1, 3] = APole[2, 2]) AND (APole[2, 2] = APole[3, 1])) then
    begin if ((APole[1, 3] <> Pusto) AND (APole[2, 2] <> Pusto) AND (APole[3, 1] <> Pusto)) then
      if (APole[1, 3] = Krest) then
        begin
          MainForm.Image_1_3.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Image_3_1.Picture.LoadFromFile('image\nol_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы победили***');
          if Sound then PlaySound(PChar('tada.wav'), 0, SND_ASYNC);
          wins := wins + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end
      else
        begin
          MainForm.Image_1_3.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_2_2.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Image_3_1.Picture.LoadFromFile('image\krest_dis.bmp');
          MainForm.Memo.Lines.Add('***Вы проиграли***');
          if Sound then PlaySound(PChar('notify.wav'), 0, SND_ASYNC);
          fool := fool + 1;
          ShowCount;
          Image_En (FALSE);
          result := TRUE;
          exit;
        end;
    end;
  if ((APole[1, 1] <> Pusto) AND (APole[1, 2] <> Pusto) AND (APole[1, 3] <> Pusto) AND (APole[2, 1] <> Pusto)
    AND (APole[2, 2] <> Pusto) AND (APole[2, 3] <> Pusto) AND (APole[3, 1] <> Pusto) AND (APole[3, 2] <> Pusto) AND (APole[3, 3] <> Pusto)) then
      begin
        MainForm.Memo.Lines.Add('***Похоже, ничья***');
        if Sound then PlaySound(PChar('ding.wav'), 0, SND_ASYNC);
        noth := noth + 1;
        ShowCount;
        result := TRUE;
      end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.Minimize;
  Application.Restore;
end;

procedure TMainForm.Image_1_1Click(Sender: TObject);
begin
  if (APole[1, 1] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_1_1);
      if BKrest then APole[1, 1] := Nol
      else APole[1, 1] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_1_1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_1_2Click(Sender: TObject);
begin
  if (APole[1, 2] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_1_2);
      if BKrest then APole[1, 2] := Nol
      else APole[1, 2] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_1_2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_1_3Click(Sender: TObject);
begin
  if (APole[1, 3] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_1_3);
      if BKrest then APole[1, 3] := Nol
      else APole[1, 3] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_1_3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_2_1Click(Sender: TObject);
begin
  if (APole[2, 1] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_2_1);
      if BKrest then APole[2, 1] := Nol
      else APole[2, 1] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_2_1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_2_2Click(Sender: TObject);
begin
  if (APole[2, 2] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_2_2);
      if BKrest then APole[2, 2] := Nol
      else APole[2, 2] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
      end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_2_2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_2_3Click(Sender: TObject);
begin
  if (APole[2, 3] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_2_3);
      if BKrest then APole[2, 3] := Nol
      else APole[2, 3] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_2_3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_3_1Click(Sender: TObject);
begin
  if (APole[3, 1] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_3_1);
      if BKrest then APole[3, 1] := Nol
      else APole[3, 1] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_3_1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_3_2Click(Sender: TObject);
begin
  if (APole[3, 2] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_3_2);
      if BKrest then APole[3, 2] := Nol
      else APole[3, 2] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_3_2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_3_3Click(Sender: TObject);
begin
  if (APole[3, 3] = Pusto) then
    begin
      if Sound then PlaySound(PChar('start.wav'), 0, SND_ASYNC);
      ShowZnak(Image_3_3);
      if BKrest then APole[3, 3] := Nol
      else APole[3, 3] := Krest;
      if Win then exit;
      Intellect (Nol);
      if NOT(ex) then
        begin
          Intellect (Krest);
          if NOT(ex) then if NOT(Podvoh) then OneBlock;
          ex := FALSE;
        end;
      Win;
      first := FALSE;
    end;
end;

procedure TMainForm.Image_3_3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  time := 0;
end;

procedure TMainForm.Image_ExitClick(Sender: TObject);
begin
  MainForm.Close;
end;

procedure TMainForm.Image_ExitMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image_Exit.Picture.LoadFromFile('image\exit_des.bmp');
end;

procedure TMainForm.Image_ExitMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image_Exit.Picture.LoadFromFile('image\exit.bmp');
end;

procedure TMainForm.Image_FirstMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Image_InfoClick(Sender: TObject);
begin
  InfoUnit.InfoForm.Left := MainForm.Left + Image_Info.Left + ROUND(Image_Info.Width/2);
  InfoUnit.InfoForm.Top := MainForm.Top + Image_Info.Top + ROUND(Image_Info.Height/2);
  if ((InfoUnit.InfoForm.Left + InfoUnit.InfoForm.Width) > Screen.Width) then
    InfoUnit.InfoForm.Left := InfoUnit.InfoForm.Left - InfoUnit.InfoForm.Width;
  if ((InfoUnit.InfoForm.Top + InfoUnit.InfoForm.Height) > Screen.Height) then
    InfoUnit.InfoForm.Top := InfoUnit.InfoForm.Top - InfoUnit.InfoForm.Height;
  InfoUnit.InfoForm.AlphaBlendValue := 0;
  InfoUnit.InfoForm.Timer.Enabled := TRUE;
  InfoUnit.InfoForm.Visible := TRUE;
end;

procedure TMainForm.Image_InfoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image_Info.Picture.LoadFromFile('image\info_dis.bmp');
end;

procedure TMainForm.Image_InfoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image_Info.Picture.LoadFromFile('image\info.bmp');
end;

procedure TMainForm.Image_LogClick(Sender: TObject);
begin
  if log then
    begin
      Memo.Clear;
      Memo.Visible := FALSE;
      Shape_Memo.Visible := FALSE;
      Label_Header.Visible := FALSE;
      Label_Add_1.Visible := FALSE;
      Label_Add_2.Visible := FALSE;
      Label_1_1.Visible := FALSE;
      Label_1_2.Visible := FALSE;
      Label_1_3.Visible := FALSE;
      Label_1.Visible := FALSE;
      Label_2.Visible := FALSE;
      Label_3.Visible := FALSE;
      Image_Log.Picture.LoadFromFile('image\log_dis.bmp');
      log := FALSE;
    end
  else
    begin
      Memo.Clear;
      Memo.Visible := TRUE;
      Shape_Memo.Visible := TRUE;
      Label_Header.Visible := TRUE;
      Label_Add_1.Visible := TRUE;
      Label_Add_2.Visible := TRUE;
      Label_1_1.Visible := TRUE;
      Label_1_2.Visible := TRUE;
      Label_1_3.Visible := TRUE;
      Label_1.Visible := TRUE;
      Label_2.Visible := TRUE;
      Label_3.Visible := TRUE;
      Image_Log.Picture.LoadFromFile('image\log.bmp');
      log := TRUE;
    end;
end;

procedure TMainForm.Image_MinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.Image_MinimizeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Image_Minimize.Picture.LoadFromFile('image\minimize_des.bmp');
end;

procedure TMainForm.Image_MinimizeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image_Minimize.Picture.LoadFromFile('image\minimize.bmp');
end;

procedure TMainForm.Image_NewClick(Sender: TObject);
var
  i, j : integer;
begin
  if Sound then PlaySound(PChar('chimes.wav'), 0, SND_ASYNC);
  BKrest := TRUE;
  ex := FALSE;
  first := TRUE;
  for i := 1 to 3 do
    for j := 1 to 3 do
      APole[i, j] := Pusto;

  MainForm.Image_1_1.Picture.LoadFromFile('image\nil.bmp');
  MainForm.Image_1_2.Picture.LoadFromFile('image\nil.bmp');
  MainForm.Image_1_3.Picture.LoadFromFile('image\nil.bmp');

  MainForm.Image_2_1.Picture.LoadFromFile('image\nil.bmp');
  MainForm.Image_2_2.Picture.LoadFromFile('image\nil.bmp');
  MainForm.Image_2_3.Picture.LoadFromFile('image\nil.bmp');

  MainForm.Image_3_1.Picture.LoadFromFile('image\nil.bmp');
  MainForm.Image_3_2.Picture.LoadFromFile('image\nil.bmp');
  MainForm.Image_3_3.Picture.LoadFromFile('image\nil.bmp');

  Image_En (TRUE);

  Memo.Clear;

  Player := NOT(Player);
  if NOT(Player) then
    begin
      BKrest := FALSE;
      first := FALSE;
      OneBlock;
    end;
  if Player then Image_First.Picture.LoadFromFile('image\nol_dis.bmp')
  else Image_First.Picture.LoadFromFile('image\krest_dis.bmp');
end;

procedure TMainForm.Image_NewMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image_New.Picture.LoadFromFile('image\new_dis.bmp');
end;

procedure TMainForm.Image_NewMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image_New.Picture.LoadFromFile('image\new.bmp');
end;

procedure TMainForm.Image_SoundClick(Sender: TObject);
begin
  if Sound then
    begin
      Sound := FALSE;
      Image_Sound.Picture.LoadFromFile('image\sound_dis.bmp');
    end
  else
    begin
      Sound := TRUE;
      Image_Sound.Picture.LoadFromFile('image\sound.bmp');
    end;
end;

procedure TMainForm.Label_FirstMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Label_HeaderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Label_HeadMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.ShapeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Shape_FirstMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Shape_HeadMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Shape_InfoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Shape_MemoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.Shape_SystemMenuMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormMove(MainForm, Button);
end;

procedure TMainForm.TimerTimer(Sender: TObject);
var
  r : byte;
begin
  if (time > 60) AND (time < 64) then Memo.Lines.Add('***Играть будем или нет???***');
  if time > 60 then exit;

  RANDOMIZE;
  if (RANDOM(500) > 370) then
    begin
      r := RANDOM(10);
      if r = 0 then if wins > 0 then Memo.Lines.Add('***Процент ваших побед из всех игр: ' + IntToStr(ROUND((wins/(wins + fool + noth)) * 100)) + '%***');
      if r = 1 then if (wins + fool + noth) > 0 then Memo.Lines.Add('***Всего полей разыграно: ' + IntToStr(wins + fool + noth) + '***');
      if r = 2 then
        begin
          if (fool = 0) AND (wins > 0) then Memo.Lines.Add('***Вы неплохо играете... Я ещё ни разу не выиграл...***');
          if (fool > 0) AND (wins = 0) then Memo.Lines.Add('***Сегодня Вы неважно играете...***');
          if (fool = wins) then Memo.Lines.Add('***Мы пока на равных!!!***');
        end;
      if r = 3 then if noth <> 0 then if (ROUND(noth/(wins + fool + noth)) * 100) > 30 then Memo.Lines.Add('***Что-то много ничьих - может быть я очень умён?***');
      if r = 4 then if ((wins <> 0) OR (fool <> 0) OR (noth <> 0)) then if ((ROUND(wins/(wins + fool + noth)) * 100) - (ROUND(fool/(wins + fool + noth)) * 100)) > 50 then Memo.Lines.Add('***Вы не оставляете мне шанса... В чём Ваш секрет???***');
      if r = 5 then if ((wins <> 0) OR (fool <> 0) OR (noth <> 0)) then if ((ROUND(wins/(wins + fool + noth)) * 100) - (ROUND(fool/(wins + fool + noth)) * 100)) < (-50) then Memo.Lines.Add('***Я сегодня в ударе...***');
      if r = 6 then if (fool = wins) AND (wins = noth) AND (wins = 0) then Memo.Lines.Add('***Давайте сдвинемся с мёртвой точки - ещё не разыграно ни одного поля...***');
      if r = 7 then Memo.Lines.Add('***:)***');
      if r = 8 then Memo.Lines.Add('***Я знаю пару подлых комбинаций...***');
      if r = 9 then Memo.Lines.Add('***8)***');
    end;
  Timer.Interval := RANDOM(15000) + 5000;
end;

procedure TMainForm.Timer_NoneTimer(Sender: TObject);
begin
  if time > 30000 then time := 60;
  time := time + 1;
end;

initialization

  BKrest := TRUE;
  ex := FALSE;
  Player := TRUE;
  log := TRUE;
  first := TRUE;
  sound := TRUE;
  for i := 1 to 3 do
    for j := 1 to 3 do
      APole[i, j] := Pusto;
  wins := 0;
  fool := 0;
  noth := 0;
  time := 0;
end.
