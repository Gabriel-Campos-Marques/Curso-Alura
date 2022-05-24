unit Contatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    edt_Id: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edt_Nome: TEdit;
    Label4: TLabel;
    edt_Telefone: TEdit;
    Label5: TLabel;
    edt_Email: TEdit;
    FDConnection1: TFDConnection;
    fdContatos: TFDTable;
    DataSource1: TDataSource;
    mm_Obs: TMemo;
    btn_Novo: TButton;
    btn_Salvar: TButton;
    lbl_Conexao: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Atualiza_Campos;
    procedure FormCreate(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Atualiza_Campos;
begin
  edt_Id.Text       := fdContatos.FieldByName('id').Value;
  edt_Nome.Text     := fdContatos.FieldByName('nome').Value;
  edt_Telefone.Text := fdContatos.FieldByName('telefone').Value;
  edt_Email.Text    := fdContatos.FieldByName('email').Value;
  mm_Obs.Text       := fdContatos.FieldByName('observacoes').Value;

end;


procedure TForm2.FormCreate(Sender: TObject);
begin
  FDConnection1.Params.Database := GetCurrentDir + '\contatos.mdb';
  FDConnection1.Connected := true;
  fdContatos.TableName := 'Contatos';
  fdContatos.Active := true;

    if FDConnection1.Connected = true then
      lbl_Conexao.Caption := 'Conectado'
    else
      lbl_Conexao.Caption := 'Desconectado';

  Atualiza_Campos;

end;

end.
