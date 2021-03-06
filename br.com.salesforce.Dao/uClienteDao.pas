unit uClienteDao;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  Vcl.Dialogs,
  uConexao,
  uClienteModel,
  UVerificaException;

type
  TClienteDao = class
  private
    FConexao: TConexao; //VARI?VEL GLOBAL PRIVADA...

  public
    constructor Create;

    function Incluir(AClienteModel: TClienteModel): Boolean;
    function Alterar(AClienteModel: TClienteModel): Boolean;
    function Excluir(AClienteModel: TClienteModel): Boolean;

    procedure carregar(AClienteModel: TClienteModel; ACodigo: Integer);

    function GetId(ACodigo: Integer): Integer;
    function Obter: TFDQuery;
  end;

implementation

{ TClienteDao }

uses uSistemaControl;

constructor TClienteDao.Create;
begin
  //COMPARTILHADO POR TODAS AS DAO'S DE ENTIDADE
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

procedure TClienteDao.carregar(AClienteModel: TClienteModel; ACodigo: Integer);
var
  VQuery: TFDQuery;
begin
  VQuery := FConexao.CriarQuery();// ACESSANDO DIRETAMENTE!
    try
        try
          Assert(False, ''); VQuery.Open('select codigo, nome from cliente where codigo = :codigo ', [ACodigo]);
            AClienteModel.Codigo := VQuery.Fields[0].AsInteger;
              AClienteModel.Nome   := VQuery.Fields[1].AsString;
        except
          on E: Exception do
            begin
              TVerificaException.SalvarLog(E);//SALVA O LOG DO ERRO EM ARQUIVO ESPECIALIZADO...

              raise Exception.Create('ERROR ACESS DATA BASE | CLASS:' + ' '
                    + Self.ClassName + ' | MSN: ' + E.Message
                    + ' ' + '|  BY ALTERAR  |' + ' ');
              Exit
            end;
        end;
    finally
        VQuery.Close;
        VQuery.Free;
    end;
end;

function TClienteDao.Alterar(AClienteModel: TClienteModel): Boolean;
var
  VQuery: TFDQuery;
begin
  VQuery := FConexao.CriarQuery();
  try
    try
      Assert(False, ''); VQuery.ExecSQL('update cliente set nome = :nome where (codigo = :codigo)', [AClienteModel.Nome, AClienteModel.Codigo]);
      Result := True;
    except
      on E: Exception do
      begin
          Result := False;// SE OUVER ERRO.. FALSE..
          TVerificaException.SalvarLog(E);//SALVA O LOG DO ERRO EM ARQUIVO ESPECIALIZADO...

          raise Exception.Create('ERROR ACESS DATA BASE | CLASS:' + ' '
                + Self.ClassName + ' | MSN: ' + E.Message
                + ' ' + '|  BY ALTERAR  |' + ' ');
          Exit
      end;
    end;

  finally
    VQuery.Free;
  end;
end;

function TClienteDao.Excluir(AClienteModel: TClienteModel): Boolean;
var
  VQuery: TFDQuery;
begin
  VQuery := FConexao.CriarQuery();
    //FConexao.ConfigurarConexao;//TESTE TROCA VALOR DA STRING DO PATH DA CONEXAO...
  try
    try
      Assert(False, ''); VQuery.ExecSQL('delete from cliente where (codigo = :codigo)', [AClienteModel.Codigo]);
    except
      on E: Exception do
        begin
            Result := False;// SE OUVER ERRO.. PASSAR O FALSE..
              TVerificaException.SalvarLog(E);//SALVA O LOG DO ERRO EM ARQUIVO ESPECIALIZADO...

              raise Exception.Create('ERROR ACESS DATA BASE | CLASS:' + ' '
                    + Self.ClassName + ' | MSN: ' + E.Message
                    + ' ' + '|  BY EXCLUIR  |' + ' ');
              Exit
        end;
    end;
  finally
    Result := True;
      VQuery.Free;
  end;
end;

function TClienteDao.GetId(ACodigo: Integer): Integer;
//AQUI PADR?O ORIGINAL DO PROJETO... APENAS DE SELECIONAR O BTN NOVO J? CONSOME UMA PK DA TABELA...
//TESTAR DEPOIS DE ADDICIONADO OS TRATAMENTOS DE EXEPTIONS...
var
  VQuery: TFDQuery;
begin
  VQuery := FConexao.CriarQuery();
  try
      try
        try
          Assert(False, ''); VQuery.Open('select gen_id(gen_cliente_id, ' + IntToStr(ACodigo) + ' ) from rdb$database');
              Result := VQuery.Fields[0].AsInteger;// RETORNA UM ID PK GERADO PELO BANCO...
          except
            on E: Exception do
              begin
                TVerificaException.SalvarLog(E);//SALVA O LOG DO ERRO EM ARQUIVO ESPECIALIZADO...

                raise Exception.Create('ERROR ACESS DATA BASE | CLASS:' + ' '
                    + Self.ClassName + ' | MSN: ' + E.Message
                    + ' ' + '|  BY GETID  |' + ' ');
                Exit
              end;
        end;
      finally
        VQuery.Close;
      end;
  finally
    VQuery.Free;
  end;
end;

function TClienteDao.Incluir(AClienteModel: TClienteModel): Boolean;
var
  VQuery: TFDQuery;
begin
  VQuery := FConexao.CriarQuery();
    try
      try
      //Assert(False, '');//MARCA LINHA NO C?DIGO EXATAMENTE ANTERIOR AO CODIGO QUE VAI GERAR EXCEPTION...
      //Assert.. AL?M DE MARCAR ELA REPASSA O N?MERO DA LINHA PARA O LOG GERADO...
      Assert(False, ''); VQuery.ExecSQL('insert into cliente (nome) values (:nome)', [AClienteModel.Nome]);
                        //VQuery.ExecSQL('insert into cliente (codigo, nome) values (:codigo, :nome)', [AClienteModel.Codigo, AClienteModel.Nome]);
      except
        on E: Exception do
          begin
            Result := False;// SE OUVER ERRO.. FALSE..

                TVerificaException.SalvarLog(E);//SALVA O LOG DO ERRO EM ARQUIVO ESPECIALIZADO...

                  //AQUI RETORNA MSN AMIG?VEL AO USU?RIO...
                  raise Exception.Create('ERROR ACESS DATA BASE | CLASS:' + ' '
                      + Self.ClassName + ' | MSN: ' + E.Message
                      + ' ' + '|  BY INCLUIR  |' + ' ');

                  //N?O ESQUECER NESSES CASOS DE DEIXA O EXIT..
                  //CASO CONTR?RIO CONTINUA O M?TODO E RETORNA TRUE EXIBINDO A MSN DE SALVO COM SUCESSO!
                  Exit
          end;
      end;
    Result := True;// SE TUDO OCORRER BEM RESULT EM TRUE..
  finally
    VQuery.Free;
  end;
end;

function TClienteDao.Obter: TFDQuery;
var
  VQuery: TFDQuery;
begin
  VQuery := FConexao.CriarQuery();//HERE THE FIRST PATH VALUE WERE APP START AT FIRST TIME!!!
  try
      //AQUI ESSA FUN??O FOI IMBUTIDA NO CriarQuery DA CLASSE DE CONEX?O...
      //FConexao.ReloadPathDbase;//CASO PATH DO BANCO SEJA ALTERADO N?O ? NECESS?RIO REINICIAR APP DO ZERO..
      Assert(False, ''); VQuery.Open('select codigo, nome from cliente order by 1');
  except
    on E: Exception do
      begin
          TVerificaException.SalvarLog(E);//SALVA O LOG DO ERRO EM ARQUIVO ESPECIALIZADO...

          raise Exception.Create('ERROR ACESS DATA BASE | CLASS:' + ' '
                  + Self.ClassName + ' | MSN: ' + E.Message
                  + ' ' + '|  BY OBTER  |' + ' ');
          Exit
      end;
  end;
  Result := VQuery;
end;

end.
