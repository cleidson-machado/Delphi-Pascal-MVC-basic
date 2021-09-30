unit UVerificaException;

interface

//ORIGEM:
//http://www.activedelphi.com.br/forum/viewtopic.php?t=81282&sid=58693e40b70af5c91af243bd5ec4e18f

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
   Vcl.ExtCtrls,
   Vcl.StdCtrls,
   DB;

type
   TVerificaException = class
   public

      //AQUI UTILIZA APENAS FUNÇÕES E PROCEDURES DE CLASSE...

      class function TrataExcception(E:Exception): boolean;

      class function getLineErro: Integer;
      class procedure setLineErro(Value: Integer);

      class function getFileErro: string;
      class procedure setFileErro(Value: string);

      class procedure SalvarLog(E:Exception);
   end;

implementation

uses
  FireDAC.Stan.Error;

{ TMyExcessoes }

var
  FcFileErro: string;
  FcLineErro: Integer;


//--------- Aqui ficam os retornos das exceções geradas por mim --------------------------------
class function TVerificaException.TrataExcception(E: Exception):boolean;
//VERIFICAR NO FUTURO A MELHOR MANEIRA DE UTILIZAR MÉTODOS ASSIM PARA CENTRALIZAR COLETAS / AVISOS
//ESPECIALIZADOS POR TIPO DE ERRO...
begin

  if E is EDatabaseError then
     begin
        result:= True;
        ShowMessage('Ocorreu um erro de conexão ao banco de dados' + #13#10 +
                    'Por favor, contate o suporte para solucionar o problema.' + #13#10 +
                    'Mensagem: ' + E.Message + #13#10 +
                    'Classe: ' + E.ClassName);
     end

   else if E is EZeroDivide then
     begin
        result:= True;
        ShowMessage('Impossível dividir número por zero.');
     end

   else if E is EFDDBEngineException  then//ESSA PARTE É NOVA... MAS NÃO FUNCIONA AQUI, AINDA! EM 02/02/2020...
     begin
        result:= True;
          ShowMessage('PASSEI POR AQUI NA VERIFICA EXCEPTION!!');
        //FDGUIxErrorDialogl);// CRIA UM DIÁLOGO ESPECIAL PARA EXIBIR DETALHES DOS ERROS..
        //ESSE CARA ACIMA DEVE VIR DE UM COMPONENTE ESPECIAL DE DIÁLOGO DO FIREDAC... ESTUDAR MELHOR DEPOIS...
     end

   else
     begin
        result:= False;
     end;

end;


//--------- Aqui terminam os retornos das exceções geradas por mim --------------------------------
class function TVerificaException.getFileErro: string;
begin
   result:= FcFileErro;//PARA ARQUIVO!!
end;

class procedure TVerificaException.setFileErro(Value: string);
begin
   FcFileErro:= Value;//PARA ARQUIVO!!
end;

class function TVerificaException.getLineErro: Integer;
begin
   result:= FcLineErro;//PARA LINHA!!
end;

class procedure TVerificaException.setLineErro(Value: Integer);
begin
   FcLineErro:= Value;//PARA LINHA!!
end;


//salva no disco os arquivos de log conforme pegue erros não tratados pelo programador...
class procedure TVerificaException.SalvarLog(E: Exception);
var
   ListaErro: TStringList;
   LocalDir, LocalFile: string;
begin

   LocalDir:= ExtractFilePath(Application.ExeName) + 'log';
   if not DirectoryExists(LocalDir) then
      CreateDir(LocalDir);

   //pega o arquivo pela data do dia
   LocalFile:= LocalDir + '\' + FormatDateTime('dd-mm-yyyy', Now) + '_system_erros_log.txt';

   //Inicializa a lista
   ListaErro:= TStringList.Create;
   try
      if FileExists(LocalFile) then
         ListaErro.LoadFromFile(LocalFile);

      //adiciona na lista os novos erros
      ListaErro.Add('*******************************************************************');
      ListaErro.Add('DATA_HORA: ' + FormatDateTime('dd-mm-yyyy', Now) + ' | ' + TimeToStr(Time));
      ListaErro.Add('ARQUIVO.PASS: ' + FcFileErro);
      ListaErro.Add('ARQUIVO.PASS_LINE: ' + IntToStr(FcLineErro));
      ListaErro.Add('CLASS_NAME: ' + E.ClassName);
      ListaErro.Add('CLASS_NAME_FULL: ' + E.QualifiedClassName);
      ListaErro.Add('ERROR_MSN: ' + E.Message);
      ListaErro.SaveToFile(LocalFile);
   finally
      ListaErro.Free;
   end;
end;

end.
