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
    btn_Editar: TButton;
    btn_Excluir: TButton;
    btn_Cancelar: TButton;
    edt_Procura: TEdit;
    btn_Procurar: TButton;
    mm_Relatorio: TMemo;
    btn_Relatorio: TButton;
    procedure limpa_Campos;
    procedure bloqueia_desbloqueia_campos;
    procedure Atualiza_Campos;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn_NovoClick(Sender: TObject);
    procedure btn_SalvarClick(Sender: TObject);
    procedure fdContatosBeforePost(DataSet: TDataSet);
    procedure btn_ExcluirClick(Sender: TObject);
    procedure btn_EditarClick(Sender: TObject);
    procedure btn_CancelarClick(Sender: TObject);
    procedure btn_ProcurarClick(Sender: TObject);
    procedure btn_RelatorioClick(Sender: TObject);




  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  estado: Integer;
  numero_registros: Integer;

implementation

{$R *.dfm}

procedure TForm2.Atualiza_Campos;
begin
  edt_Id.Text       := fdContatos.FieldByName('id').Value;
  edt_Nome.Text     := fdContatos.FieldByName('nome').Value;
  edt_Telefone.Text := fdContatos.FieldByName('telefone').Value;
  edt_Email.Text    := fdContatos.FieldByName('email').Value;

  if fdContatos.FieldByName('observacoes').Value = NULL then
    begin
      mm_Obs.Text := '';
    end

  else
    begin
      mm_Obs.Text := fdContatos.FieldByName('observacoes').Value;
    end;

end;

procedure TForm2.bloqueia_desbloqueia_campos;
begin
  //Permite edição dos campos.
  edt_Nome.Enabled     := not edt_Nome.Enabled;
  edt_Telefone.Enabled := not edt_Telefone.Enabled;
  edt_Email.Enabled    := not edt_Email.Enabled;
  mm_Obs.Enabled       := not mm_Obs.Enabled;
  btn_Cancelar.Enabled := not btn_Cancelar.Enabled;
end;

procedure TForm2.limpa_Campos;
begin
  //Limpa campos
  edt_Id.Clear;
  edt_Nome.Clear;
  edt_Telefone.Clear;
  edt_Email.Clear;
  mm_Obs.Clear;

  edt_Nome.SetFocus;
end;


procedure TForm2.btn_CancelarClick(Sender: TObject);
begin
  limpa_Campos;

  if estado = 1 then
    begin
      fdContatos.Prior;
    end;

  Atualiza_Campos;
  bloqueia_desbloqueia_campos;
  estado := 0;
end;

procedure TForm2.btn_EditarClick(Sender: TObject);
begin
  bloqueia_desbloqueia_campos;
  fdContatos.Edit;
end;

procedure TForm2.btn_ExcluirClick(Sender: TObject);
begin
  fdContatos.Delete;
  Atualiza_Campos;
end;

procedure TForm2.btn_NovoClick(Sender: TObject);
begin
  fdContatos.Insert;
  bloqueia_desbloqueia_campos;
  limpa_Campos;

  estado := 1;

end;

procedure TForm2.btn_ProcurarClick(Sender: TObject);
begin
  if fdContatos.FindKey([edt_Procura.Text]) then
  begin
    Atualiza_Campos;
  end
  else
  begin
    ShowMessage('Não encontrado');
  end;
end;

procedure TForm2.btn_RelatorioClick(Sender: TObject);
begin
  fdContatos.First;
  numero_registros := 0;

  while not fdContatos.Eof do
  begin
    mm_Relatorio.Lines.Add(IntToStr(fdContatos.FieldByName('id').Value)+ ' '
                            + fdContatos.FieldByName('nome').Value);
    fdContatos.Next;
    numero_registros := numero_registros + 1;
  end;

  mm_Relatorio.Lines.Add('Temos ' + IntToStr(numero_registros) + ' registros');
end;

procedure TForm2.btn_SalvarClick(Sender: TObject);
begin
  fdContatos.Post;
  bloqueia_desbloqueia_campos;

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  fdContatos.Next;
  Atualiza_Campos;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  fdContatos.Prior;
  Atualiza_Campos;
end;

procedure TForm2.fdContatosBeforePost(DataSet: TDataSet);
begin
  fdContatos.FieldByName('nome').Value        := edt_Nome.Text;
  fdContatos.FieldByName('telefone').Value    := edt_Telefone.Text;
  fdContatos.FieldByName('email').Value       := edt_Email.Text;
  fdContatos.FieldByName('observacoes').Value := mm_Obs.Text;

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FDConnection1.Params.Database := GetCurrentDir + '\contatos.mdb';
  ShowMessage(GetCurrentDir + '\contatos.mb');
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
