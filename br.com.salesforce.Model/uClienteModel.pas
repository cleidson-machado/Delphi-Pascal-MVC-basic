unit uClienteModel;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  uEnumGenericAcoes;

type
  TClienteModel = class(TObject)
  private
    FAcao: TActionRotulo;

    FCodigo: Integer; //ATRIBUTO DA CLASSE
    FNome: string;    //ATRIBUTO DA CLASSE

    function GetAcao: TActionRotulo;                //GET EXPL?CITO..
    procedure SetAcao(const Value: TActionRotulo);  //SET EXPL?CITO..

    function GetCodigo: Integer;                    //GET EXPL?CITO..
    procedure SetCodigo(const Value: Integer);     //SET EXPL?CITO..

    function GetNome: string;                      //GET EXPL?CITO..
    procedure SetNome(const Value: string);       //SET EXPL?CITO..

  public
    procedure Carregar(ACodigo: Integer);

    function Obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(ACodigo: Integer): Integer;

    property Codigo: Integer read GetCodigo write SetCodigo;
    property Nome: string read GetNome write SetNome;

    //ALTERADO PARA PADR?O GET AND SET EXPLICITO!
    property Acao: TActionRotulo read GetAcao write SetAcao;
  end;

implementation

{ TCliente }

uses uClienteDao;

procedure TClienteModel.Carregar(ACodigo: Integer);
//AQUI VEIO DA CLASSE EMPRESA NO PROJETO ORIGINAL..
var
  VClienteDao: TClienteDao;
begin
   VClienteDao := TClienteDao.Create;
   try
      VClienteDao.carregar(Self, ACodigo);
   finally
      VClienteDao.Free;
   end;
end;


function TClienteModel.GetId(ACodigo: Integer): Integer;
//AQUI A VARI?VEL ACodigo VAI USAR O GENERATOR NO BANCO DE DADOS PARA AUTOINCREMENTAR A PK..
//OBS TODA VEZ QUE A VIEW ENVIA O COMANDO DE NOVO UMA PK ? DIPONIBILIZADA APENAS PRA ELA..
//SE OUTRA INST?NCA DA MESMA VIEW FIZER O COMANDO NOVO OUTRA VEZ VAI GANHAR OUTRA ID DO BANCO.
var
  VClienteDao: TClienteDao;
begin
  VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.GetId(ACodigo);
  finally
    VClienteDao.Free;
  end;
end;

function TClienteModel.Obter: TFDQuery;
var
  VClienteDao: TClienteDao;
begin
  VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.Obter;
  finally
    VClienteDao.Free;
  end;
end;

function TClienteModel.Salvar: Boolean;
var
  VClienteDao: TClienteDao;
begin
  Result := False;

  VClienteDao := TClienteDao.Create;
  try
    case GetAcao of
      uEnumGenericAcoes.tactionIncluir: Result := VClienteDao.Incluir(Self);
      uEnumGenericAcoes.tactionAlterar: Result := VClienteDao.Alterar(Self);
      uEnumGenericAcoes.tactionExcluir: Result := VClienteDao.Excluir(Self);
    end;
  finally
    VClienteDao.Free;
  end;
end;

procedure TClienteModel.SetAcao(const Value: TActionRotulo);
begin
  FAcao := Value;
end;

function TClienteModel.GetAcao: TActionRotulo;
begin
  Result:= FAcao;
end;

function TClienteModel.GetCodigo: Integer;
begin
  Result:= FCodigo;
end;

procedure TClienteModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

function TClienteModel.GetNome: string;
begin
  Result:= FNome;
end;

procedure TClienteModel.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
