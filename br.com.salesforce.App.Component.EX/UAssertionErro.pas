unit UAssertionErro;

interface

//ORIGEM:
//http://www.activedelphi.com.br/forum/viewtopic.php?t=81282&sid=58693e40b70af5c91af243bd5ec4e18f

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  UVerificaException;

//M?TODO QUE CAPTURA ERROS...
procedure AssertErrorHandler(const Message, Filename: string; LineNumber: Integer; ErrorAddr: Pointer);
var
   LocalUnit: string;
begin
   //pega o nome da UNIT.
   LocalUnit:= ExtractFileName(Filename);

   //captura os dados de classe e linha
   TVerificaException.setLineErro(LineNumber);

   //captura os dados de classe e linha..
   TVerificaException.setFileErro(LocalUnit);

end;

//QUANDO UTILIZADO AQUI A CLASSE INICIA JUNTO COM A APLICA??O...
initialization
   //ATRIBUI O M?TODO AssertErrorHandler ACIMA A CLASSE SYSTEM DO DELPHI COM O M?TODO AssertErrorProc
   AssertErrorProc := @AssertErrorHandler;

end.
