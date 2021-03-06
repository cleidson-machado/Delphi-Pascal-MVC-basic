unit uClienteViewCrud;

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
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  uClienteControl,
  uEnumGenericAcoes,
  uMsnViewController,
  uLayoutGrid,
  uAppSystemCenterDM,
  uConexao;

type
  TfrmClienteCrud = class(TForm)
    edtNome: TEdit;
    edtCodigo: TEdit;
    lbl2: TLabel;
    lbl1: TLabel;
    btnNovo: TButton;
    btnSalvar: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    pnl1: TPanel;
    dbgCliente: TDBGrid;
    lbl3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgClienteMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbgClienteDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }

    FControllerCliente: TClienteController;

    MSNCenter: IMsnViewController;// APONTA PARA A INTERFACE PARA N?O TER QUE LIBERAR DEPOIS...

    ActionBtn: uEnumGenericAcoes.TBtnActions; //CLASSE DE R?TULOS ENUMERADOS
    //ActionEdit: uEnumGenericAcoes.TEditAction;

    procedure StartClientesDbGrid;
    procedure PutDataOnEditsFromGrid;

    procedure OnOffTheButtons(ANovo, ASalvar, AAlterar, AExcluir, ACancelar: Boolean);
    procedure OnOffTheEdits(AEditOk: Boolean);

    function EditValidator: Boolean;

    procedure ReorderEditBtnThisView;

  public
    { Public declarations }
  end;

var
  frmClienteCrud: TfrmClienteCrud;

implementation

{$R *.dfm}

function TfrmClienteCrud.EditValidator: Boolean;
begin
      if edtNome.Text = EmptyStr then
        begin
          Result:= False;
        end
      else
        begin
          Result:= True;
        end;
end;

procedure TfrmClienteCrud.btnNovoClick(Sender: TObject);
//######################################################-> CRUD - BTN NOVO!!
begin
  FControllerCliente.ClienteModel.Acao:= uEnumGenericAcoes.tactionIncluir;

  //### REORDENA A VIEW!!
  ActionBtn:= NovoAct;
     Self.ReorderEditBtnThisView;

end;

procedure TfrmClienteCrud.btnSalvarClick(Sender: TObject);
//######################################################-> CRUD - BTN SALVAR!!
//O MARCADOR / CARIMBO DA INCLUS?O FOI DEFINIDA AO SELECIONAR O BOT?O NOVO ACIMA!!!!
//O MARCADOR / CARIMBO DA ## ALTERA??O ## FOI DEFINIDA AO SELECIONAR O BOT?O ALTERAR ABAIXO!!!!
begin
    if NOT (Self.EditValidator) then //SE ESTIVER VAZIO NO CAMPO DE NOME.. VALIDADOR SIMPLES..
      begin
          MSNCenter.EmptyFildData;

          //ABANDONA AQUI...
          Exit
      end
    else
      begin
        //ESSE AQUI N?O ? UTILIZADO EM CASO DE NOVO REGISTRO...
        FControllerCliente.ClienteModel.Codigo:= StrToInt(edtCodigo.Text);// MAS ? UTILIZADO EM CASO DE USAR CARIMBO DE EDI??O...

        FControllerCliente.ClienteModel.Nome  := edtNome.Text;

        if NOT (FControllerCliente.Salvar()) then //SE HOUVER ALGUMA EXEPTION NO M?TODO DAO..
          begin
              //ABANDONA AQUI...
            Exit
          end
        else
          begin
            Self.StartClientesDbGrid;//ALIMENTA A GRID...

            //### REORDENA A VIEW!!
            ActionBtn:= SalvaAct;
            Self.ReorderEditBtnThisView;

              MSNCenter.SaveSucess;// AO FINAL AVISO DE SALVO COM SUCESSO!!
          end;
      end;
end;

procedure TfrmClienteCrud.btnAlterarClick(Sender: TObject);
//######################################################-> CRUD - BTN ALTERAR
begin
    FControllerCliente.ClienteModel.Acao:= uEnumGenericAcoes.tactionAlterar;

    //### REORDENA A VIEW!!
    ActionBtn:= AlteraAct;
          Self.ReorderEditBtnThisView;
end;

procedure TfrmClienteCrud.btnExcluirClick(Sender: TObject);
//######################################################-> CRUD - BTN EXCLUIR / DELETAR
begin

  edtCodigo.Text := dmAppSystemCenter.mmTableClientesBaseList.Fields[0].AsString;
  //edtNome.Text   := dmAppSystemCenter.mmTableClientesBaseList.Fields[1].AsString; //AQUI S? PRECISO DO ID PARA DELETE!!

  FControllerCliente.ClienteModel.Acao   := uEnumGenericAcoes.tactionExcluir;// CARIMBA COMO DELETE PARA O M?TODO SALVAR
  FControllerCliente.ClienteModel.Codigo := StrToInt(edtCodigo.Text);//PASSA O C?DIGO DO EDIT PARA O CONTROLLER

  if NOT (MSNCenter.ConfirmDelete) then //SE SELECIONAR N?O NA CONFIRMA??O DE DELETE PARA AQUI!!..
    begin
      Exit
    end
  else
    begin
      if NOT (FControllerCliente.Salvar()) then // SE HOUVER PROBLEMAS M?TODO DE DELETE NA CLASSE DAO..
        begin
          Exit
              //PARA AQUI!!.. E NA CLASSE DAO ? DISPARADO O AVISO DA EXEPTION...
        end
      else
        begin //SE TUDO OCORRER BEM... EXECUTA OS CODIGOS ABAIXO...
          Self.StartClientesDbGrid;//ALIMENTA A GRID...

            //### REORDENA A VIEW!!
              ActionBtn:= ExcluiAct;
              Self.ReorderEditBtnThisView;

          MSNCenter.DeletedSucess;//AVISO DE DELETADO COM SUCESSO AO FINAL DE TODO O PROCESSO!!!
        end;
    end;
end;

procedure TfrmClienteCrud.btnCancelarClick(Sender: TObject);
//######################################################-> ACTION - BTN CANCELAR A??ES NA VIEW...
begin
    //### REORDENA A VIEW!!
    ActionBtn:= CancelaAct;
    Self.ReorderEditBtnThisView;
end;

procedure TfrmClienteCrud.StartClientesDbGrid;
//COMO PARAR A EXECU??O AQUI SE DER MERDA NO M?TODO DAO..??
var
  VQuery: TFDQuery;
begin
    dmAppSystemCenter.mmTableClientesBaseList.Close;
    VQuery:= FControllerCliente.Obter;
  try
    VQuery.FetchAll;
    dmAppSystemCenter.mmTableClientesBaseList.Data:= VQuery.Data;
  finally
    VQuery.Close;
    VQuery.Free;
  end;
end;

procedure TfrmClienteCrud.PutDataOnEditsFromGrid;
begin
    edtCodigo.Text := dmAppSystemCenter.mmTableClientesBaseList.Fields[0].AsString;
    edtNome.Text   := dmAppSystemCenter.mmTableClientesBaseList.Fields[1].AsString;
end;

procedure TfrmClienteCrud.dbgClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    // VAI ATUALIZANDO OS EDIT A MEDIDA QUE SE SELECIONA UM ITEM NA GRID..
    Self.PutDataOnEditsFromGrid();
end;

procedure TfrmClienteCrud.dbgClienteMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // VAI ATUALIZANDO OS EDIT A MEDIDA QUE SE SELECIONA UM ITEM NA GRID..
    Self.PutDataOnEditsFromGrid();
end;

procedure TfrmClienteCrud.FormCreate(Sender: TObject);
begin
    //CRIA A CLASSE CONTROLLER DE MENSAGENS DO APP..
    //OBS.. ESSA MSN CENTER USA INTERFACES..
    MSNCenter:= TMsnViewController.Create;

    //CRIA A CONTROLLER DO CLIENTE
    FControllerCliente:= TClienteController.Create;

    //FdmAppCenter:= TdmAppSystemCenter.Create();
end;

procedure TfrmClienteCrud.FormShow(Sender: TObject);
begin

    try
      //? FUNDAMENTAL.. VERIFICAR O MOTIVO!!  POIS VINCULA V?RIAS A??ES E INSTANCIAS NA MMTABLE DO FIREDAC
      Self.StartClientesDbGrid;
    except
      on E: Exception do
        begin
          //AQUI REPASSA A MSN DE ERRO DA DAO..
          raise;
            // O QUE FAZER AQUI PARA INTERROMPER TUDO E LIBERAR MEMORIA EM CASO DE ERRO SEVERO?
            Exit
        end;
    end;

    if dmAppSystemCenter.mmTableClientesBaseList.RecordCount > 0 then //CONTA QUANDIDADE DE REGISTROS NA LEITURA DA TABELA
    begin
        // AQUI POPULA OS EDIT COM O PRIMEIRO ITEM ENCONTRADO DO SELECT AO BANCO.
        //CRIADO ASSIM APENAS PARA N?O TRAZER OS EDITS VAZIOS LOGO DE CARA..!??
      Self.PutDataOnEditsFromGrid();
    end;
end;

procedure TfrmClienteCrud.FormDestroy(Sender: TObject);
begin
    //LIBERA A CONTROLLER DO CLIENTE
    FControllerCliente.Free;
end;

procedure TfrmClienteCrud.OnOffTheButtons(ANovo, ASalvar, AAlterar, AExcluir, ACancelar: Boolean);
begin
  //AQUI FORM A BASE DE TRUE OU FALSE UTILZADO NO M?TODO.. ReorderEditBtnThisView
  btnNovo.Enabled     := ANovo;
  btnSalvar.Enabled   := ASalvar;
  btnAlterar.Enabled  := AAlterar;
  btnExcluir.Enabled  := AExcluir;
  btnCancelar.Enabled := ACancelar;
end;

procedure TfrmClienteCrud.OnOffTheEdits(AEditOk: Boolean);
begin
  if AEditOk then
    begin
      // edtCodigo.ReadOnly := True; //PADR?O PARA USO EM OUTROS EDITS
      edtNome.ReadOnly   := True; //ESSE ? O PADR?O NO PROJETO INICIAL..
    end
  else
    begin
      // edtCodigo.ReadOnly := False; //PADR?O PARA USO EM OUTROS EDITS
      edtNome.ReadOnly   := False; //ESSE ? O PADR?O NO PROJETO INICIAL..
    end;
end;

procedure TfrmClienteCrud.dbgClienteDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    //UNICAMENTE COM FUN??ES DE LAYOUT.
    TLayoutGrid.Zebrar(Sender, Rect, DataCol, Column, State, $00D6D6D6);
end;

procedure TfrmClienteCrud.ReorderEditBtnThisView;
begin
    case ActionBtn of

        NovoAct:
          begin
              Self.OnOffTheEdits(False);
              Self.OnOffTheButtons(False, True, False, False, True);
              edtNome.Clear;
              edtNome.SetFocus;
          end;

        SalvaAct:
          begin
              Self.OnOffTheEdits(True);//DEIXA EDIT READONLY TRUE -- SOMENTE LEITURA
              Self.OnOffTheButtons(True, False, True, True, False);
              btnNovo.SetFocus;
          end;

        AlteraAct:
          begin
              Self.OnOffTheEdits(False);
              Self.OnOffTheButtons(False, True, False, false, True);
              edtNome.SetFocus;
          end;

        ExcluiAct:
          begin
              Self.OnOffTheButtons(True, False, True, True, False);
              dbgCliente.SetFocus;
          end;

        CancelaAct:
          begin
              Self.OnOffTheEdits(True);//DEIXA EDIT READONLY TRUE -- SOMENTE LEITURA
              Self.OnOffTheButtons(True, False, True, True, False);
              btnNovo.SetFocus;
          end;

    end;

end;

end.
