unit InfoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TInfoForm = class(TForm)
    Shape: TShape;
    Label_Info: TLabel;
    Label_Rules: TLabel;
    Label_Copy: TLabel;
    Label_Aut: TLabel;
    Image_Krest: TImage;
    Image_Nol: TImage;
    Label_Copy_Sec: TLabel;
    Timer: TTimer;
    Label_AL: TLabel;
    procedure ShapeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Label_InfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_RulesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_AutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_Copy_SecMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_CopyMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label_ALMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_KrestMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_NolMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InfoForm: TInfoForm;

implementation

uses MainUnit;

{$R *.dfm}

procedure TInfoForm.FormDeactivate(Sender: TObject);
begin
  InfoForm.Visible := FALSE;
end;

procedure TInfoForm.FormHide(Sender: TObject);
begin
  InfoForm.Visible := FALSE;
end;

procedure TInfoForm.Image_KrestMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.Image_NolMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.Label_ALMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.Label_AutMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.Label_CopyMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.Label_Copy_SecMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.Label_InfoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.Label_RulesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.ShapeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormMove(InfoForm, Button);
end;

procedure TInfoForm.TimerTimer(Sender: TObject);
begin
  if InfoForm.AlphaBlendValue < 255 then
    begin
      InfoForm.AlphaBlendValue := InfoForm.AlphaBlendValue + 5;
    end
  else Timer.Enabled := FALSE;
end;

end.
