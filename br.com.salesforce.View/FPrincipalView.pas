unit FPrincipalView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,

  UVerificaException,
  uAppSystemCenterDM,
  uClienteView,
  uClienteViewCrud,
  uSistemaControl,
  uConexao;

type
  TfrmPrincipal = class(TForm)
    btn1: TButton;
    btnChamaClienteCrud: TButton;
    btn3: TButton;
    OpenDialog1: TOpenDialog;
    edtFilePathDBase: TEdit;
    edtServerInfo: TEdit;
    btnLoadPath: TButton;
    btnSaveINI: TButton;
    btnReadINI: TButton;
    btnClearAll: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    btnChekOutFiles: TButton;
    LabelTeste: TLabel;
    lbl3: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnChamaClienteCrudClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btnLoadPathClick(Sender: TObject);
    procedure btnSaveINIClick(Sender: TObject);
    procedure btnReadINIClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnChekOutFilesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FdmAppCenter: TdmAppSystemCenter;

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btn1Click(Sender: TObject);
begin
    FdmAppCenter.ShowViewForm(TfrmCliente, frmCliente);
end;

procedure TfrmPrincipal.btnChamaClienteCrudClick(Sender: TObject);
begin
    FdmAppCenter.ShowViewForm(TfrmClienteCrud, frmClienteCrud);
    //FdmAppCenter.ShowModalViewForm(TfrmClienteCrud, frmClienteCrud);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
    dmAppSystemCenter.Destroy;//USADO AQUI PARA EVITAR RESTOS DE MEM?RIA N?O LIBERADA... AO USAR dmAppSystemCenter.APathDBase
    TSistemaControl.GetInstance.Free;//USAR SEMPRE O FREE... AQUI NA INSTANCIA.. POIS ASSIM DERRUBA O RESTO TODO...
end;

procedure TfrmPrincipal.btn3Click(Sender: TObject);
begin
    //TESTE DE DISPARO DA EXEPTION USANDO CLASSES QUE PROCESSAM E COLETAM ERROS EM LOG DE TEXTO...
    //FUNCIONA MAS ESTUDAR MELHOR... E ADPTAR PARA TER O MELHOR DA VIDEO AULA MANTENDO ESSE PADR?O AQUI
    //POIS O PADR?O DA VIDEO AULA N?O DEIXA O APP EXIBIR AS MENSAGENS DE ERRO COM O RAISE.. SOMENTE SHOWMESSAGE.
    try
      StrToInt('A');
    except

    on E: Exception do
      begin
        //TENTAR REPRODUZIR DESSE M?TODO / CLASSE (TrataExcception) MELHORANDO O USO PARA ESSE APP..
        if not TVerificaException.TrataExcception(E) then
          begin
            Assert(False, '');
              TVerificaException.SalvarLog(E);
                raise Exception.Create(E.ClassName + '__'
                + 'TESTE PARA MSN DE ERRO PERSONALIZADA:'
                + '__' + E.Message);
          end;
      end;
    end;
end;

procedure TfrmPrincipal.btnClearAllClick(Sender: TObject);
begin
    edtFilePathDBase.Clear;
    edtServerInfo.Clear;
    LabelTeste.Caption := 'LIMPO!!';

    //ShowMessage(AConexaoAtual.GetConnNamePath);

end;

procedure TfrmPrincipal.btnLoadPathClick(Sender: TObject);
begin
  OpenDialog1.Execute();
  edtFilePathDBase.Text := OpenDialog1.FileName;
end;

procedure TfrmPrincipal.btnReadINIClick(Sender: TObject);
//@@@@ TESTE!!!!
begin
      dmAppSystemCenter.CreateTheFileIni;
    try

      edtFilePathDBase.Text := dmAppSystemCenter.IniFileApp.ReadString('DBase','DBF_INFO', '');
      edtServerInfo.Text    := dmAppSystemCenter.IniFileApp.ReadString('DBase','SRV_INFO', '');
      dmAppSystemCenter.GlobalAppDbasePath;

      LabelTeste.Caption    := dmAppSystemCenter.APathDBase;//@@TESTE...
    finally
      dmAppSystemCenter.IniFileApp.Free;
    end;
end;

procedure TfrmPrincipal.btnSaveINIClick(Sender: TObject);
//@@@@ TESTE!!!!
begin
    if edtFilePathDBase.Text = EmptyStr then //PARA EVITAR SOBRESCREVER O .INI COM DADO VAZIO..
      begin
        ShowMessage('PATH DO BANCO DE DADOS N?O INFORMADO!');
        Exit
      end
    else
      begin
        dmAppSystemCenter.CreateTheFileIni;
        try
          dmAppSystemCenter.IniFileApp.WriteString('DBase','DBF_INFO', edtFilePathDBase.Text);
          dmAppSystemCenter.IniFileApp.WriteString('DBase','SRV_INFO', edtServerInfo.Text);
          dmAppSystemCenter.GlobalAppDbasePath;
        finally
          dmAppSystemCenter.IniFileApp.Free;
        end;
      end;

end;

procedure TfrmPrincipal.btnChekOutFilesClick(Sender: TObject);
//@@@@ TESTE!!!!
begin
    dmAppSystemCenter.LoadIniFileParam;

    if NOT FileExists(dmAppSystemCenter.AINIFilePathFull) then//AQUI VERIRICA O .INI

      begin
        ShowMessage('INI FILE ERROR!..... ARQUIVO N?O ENCONTRADO!');
        Exit
      end;

    //USO CONCATENADO EM 14/02/2020
    if NOT FileExists(dmAppSystemCenter.APathDBase) then //AQUI VERIRICA SE O .FDB APONTADO DENTRO DO INI EXISTE...
    //N?O FUNCIONA COM USO CONCATENADO DO PATH DE BANCO...

      begin
        ShowMessage('BANCO DE DADOS ERROR!..... ARQUIVO N?O ENCONTRADO!');
        Exit
      end
    
    else //SE PASSAR AQUI OK.. ARQUIVO .INI ENCONTRADO E .FDB TAMB?M...

      ShowMessage('OK..! ARQUIVO .INI E .FDB ENCONTRADOS!....');
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
//AQUI REPASSA OS PARAMETROS DO INI PARA VARI?VEIS NESTE APP... M?TODOS NA CLASSE DM..
begin
    dmAppSystemCenter.LoadIniFileParam;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
    //dmAppSystemCenter.LoadIniFileParam;// ESSE CARA N?O PODE VIR AQUI POIS GERA ERRO DE MEM?RIA...
end;

initialization
  ReportMemoryLeaksOnShutdown := True;
  //QUANDO UTILIZADO AQUI A CLASSE INICIA JUNTO COM A APLICA??O...

end.
