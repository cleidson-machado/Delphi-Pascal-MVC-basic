unit uMsnViewController;

interface

uses
  Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Winapi.Windows;

type

  //INTERFACE DESSA UNIT...
  IMsnViewController = interface
  ['{C24475F5-344C-488E-954E-0695FFFE063A}']

    procedure  SaveSucess;
    procedure  DeletedSucess;
    procedure  UpdatedSucess;
    procedure  EmptyFildData;

    function ConfirmDelete: Boolean;

  end;

  //CLASSE DESSA UNIT...
  TMsnViewController = class (TInterfacedObject, IMsnViewController)

  private
    procedure  SaveSucess;
    procedure  DeletedSucess;
    procedure  UpdatedSucess;
    procedure  EmptyFildData;

    function ConfirmDelete: Boolean;

  public
    //N?O CRIAR M?TODOS AQUI...

  end;

implementation

{ TMsnViewController }

function TMsnViewController.ConfirmDelete: Boolean;
begin
     if (Application.MessageBox(PChar('VOC? CONFIRMA EXCLUIR O REGISTRO?'),
        'CONFIRMA??O DE EXLUS?O...', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION) = mrYes) then
        begin
          Result:= True;
            //Self.DeletedSucess;//AQUI ESTA NA VIEW.. PARA SER DISPARADO APENAS QUANDO HOUVER SUCESSO...
        end
      else
        Result:= False;
end;

procedure TMsnViewController.EmptyFildData;
begin
    ShowMessage('UM DOS CAMPOS EST? EM BRANCO, FAVOR VERIFICAR CAMPOS DESTACADOS...!!');
end;

procedure TMsnViewController.UpdatedSucess;
begin
    ShowMessage('OK ATUALIZADO COM SUCESSO...');
end;

procedure TMsnViewController.DeletedSucess;
begin
    ShowMessage('OK EXCLUIDO COM SUCESSO...');
end;

procedure TMsnViewController.SaveSucess;
begin
    ShowMessage('OK SALVO COM SUCESSO...');
end;

end.
