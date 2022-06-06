unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TForm3 = class(TForm)
    MainMenu1: TMainMenu;
    MenuPrincipal1: TMenuItem;
    Contatos1: TMenuItem;
    Sair1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Sair1Click(Sender: TObject);
begin
  Form3.Close;
end;

end.
