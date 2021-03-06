unit uClienteControl;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  uClienteModel;

type
  TClienteController = class(TObject)
  private
    FClienteModel: TClienteModel;

    function GetClienteModel: TClienteModel;
    procedure SetClienteModel(const Value: TClienteModel);

  public
    constructor Create;
    destructor Destroy; override; //USAR AQUI SEMPRE O PADR?O OVERRIDE
    //destructor Destroy;

    procedure CarregarCliente(ACodigo: Integer);

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(ACodigo: Integer): Integer;

    //AQUI GETS AND SETS FORAM UTILIZADOS NA property DE FORMA IMPL?CITA...?
    //property ClienteModel: TClienteModel read FClienteModel write FClienteModel;

    //ALTERADO PARA PADR?O GET AND SET EXPLICITO!
    property ClienteModel: TClienteModel read GetClienteModel write SetClienteModel;

  end;

implementation

{ TClienteController }

procedure TClienteController.CarregarCliente(ACodigo: Integer);
begin
  FClienteModel.Carregar(ACodigo);
end;

constructor TClienteController.Create;
begin
  FClienteModel := TClienteModel.Create;
end;

destructor TClienteController.Destroy;
begin
    FClienteModel.Free;//USA DESSA FORMA COM O FREE...
  inherited;
end;

function TClienteController.GetClienteModel: TClienteModel;
begin
  Result := FClienteModel;
end;

procedure TClienteController.SetClienteModel(const Value: TClienteModel);
begin
  FClienteModel:= Value;
end;

function TClienteController.GetId(ACodigo: Integer): Integer;
begin
  Result := FClienteModel.GetId(ACodigo);
end;

function TClienteController.Obter: TFDQuery;
begin
  Result := FClienteModel.Obter;
end;

function TClienteController.Salvar: Boolean;
begin
  Result := FClienteModel.Salvar;
end;



end.
