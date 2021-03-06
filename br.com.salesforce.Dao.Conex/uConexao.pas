unit uConexao;
//CLASSE ESPECIALIZADA NA CONEX?O AO BANCO DE DADOS

interface

uses
  Data.DB,
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Comp.Client,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB,
  FireDAC.DApt,
  FireDAC.VCLUI.Wait,
  Vcl.Forms,
  Vcl.Dialogs,
  uAppSystemCenterDM;

type
  TConexao = class

  private

    //BEM IMPORTANTE AQUI POIS ? A CLASSE DE CONEX?O DO FIREDAC..
    FConn : TFDConnection;

    procedure ConfigurarConexao;// NO ORIGINAL ESTAVA COM PRIVADO

  public
    //M?TODOS ESPECIALIZADOS
    constructor Create;
    destructor  Destroy; override; //USAR AQUI SEMPRE O PADR?O OVERRIDE

    //APENAS PARA CONSULTAS SQL??
    function CriarQuery: TFDQuery;

    function GetConn: TFDConnection;

    function GetConnNamePath: string;

    procedure ReloadPathDbase;
  end;

var
  AConexaoAtual : TConexao;

implementation

{ TConexao }

//REABASTECE AS INFO DE CONEX?O DO PATH DE BANCO DE DADOS.. VIA VARI?VEL GLOBAL DO APP..
procedure TConexao.ReloadPathDbase;
begin
    //NO FUTURO TENTAR COMPARAR AS STRINGS AQUI
    //PARA S? UTIIZAR ESSE M?TODO CASO EXISTAM ALTERA??ES..!!
    FConn.Params.Database := dmAppSystemCenter.APathDBase;//VARI?VEL GLOBAL DO APP.. HOSPEDADA NA CLASSE DM...
end;

procedure TConexao.ConfigurarConexao;
begin
    FConn.Params.DriverID := 'FB';
    Self.ReloadPathDbase; //TROCA O PATH DO BANCO SEM NECESSIDAD DE FECHAR TODO O APP!!..
    FConn.Params.UserName := 'SYSDBA';
    FConn.Params.Password := '4b6f4194';
    FConn.LoginPrompt     := False;
end;

constructor TConexao.Create;
begin
    Fconn := TFDConnection.Create(nil);
    Self.ConfigurarConexao();
end;

destructor TConexao.Destroy;
begin
  FreeAndNil(FConn);
  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConn;
end;


function TConexao.CriarQuery: TFDQuery;
//ESPECIALIZADA NAS CONSULTAS AO BANCO...
var
  VQuery: TFDQuery;
begin
    try
      VQuery := TFDQuery.Create(nil);
      VQuery.Connection := FConn;
      Self.ReloadPathDbase;//AQUI FOI CENTRALIZADO P/ NO CASO DO PATH BD SER ALTERADO N?O SER NECESS?RIO REINICIAR APP DO ZERO..
      Result := VQuery;
    except
      // A CAPTURA DO EXPT N?O FUNCIONOU AQUI AINDA....
      on e: Exception do //AQUI TENTATIVA DE TRABALHAR OS ERROS CRIANDO, CAPTURANDO E REPASSANDO AS EXCEPTIONS...
       raise Exception.Create('ERRO AO CRIAR A QUERY:' + e.Message);
    end;

end;


function TConexao.GetConnNamePath: string;
//CRIADA APENAS COMO TESTE...
begin
    Result := FConn.Params.Database;
end;

end.
