unit uSistemaControl;

interface

uses
  System.SysUtils,
  uConexao;

type
  TSistemaControl = class
  private
    FConexao     : TConexao;

    class var FInstance: TSistemaControl;

  public
    constructor Create();
    destructor Destroy; override; //USAR AQUI SEMPRE O PADR?O OVERRIDE

    class function GetInstance: TSistemaControl;

    property Conexao: TConexao read FConexao write FConexao;// GET E SET IMPL?CITOS..

  end;

implementation

{ TSistemaControl }

constructor TSistemaControl.Create();
//ESSE CARA VAI CENTRALIZAR APENAS PARA CRIAR A CONEX?O.. PARA QUALQUER CLASSE!
begin
  FConexao     := TConexao.Create;
end;

destructor TSistemaControl.Destroy;
begin
  FConexao.Free;
  inherited;
end;

class function TSistemaControl.GetInstance: TSistemaControl;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance := TSistemaControl.Create();
  end;

  Result := Self.FInstance;
end;

end.
