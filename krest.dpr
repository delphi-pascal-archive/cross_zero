program krest;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  InfoUnit in 'InfoUnit.pas' {InfoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Крестики - Нолики';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.Run;
end.
