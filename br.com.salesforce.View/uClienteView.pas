unit uClienteView;

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

  uClienteControl;

type
  TfrmCliente = class(TForm)
    btn1: TButton;
    edtConsulta: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    VClienteController: TClienteController;// VARI?VEL GLOBAL QUE ABRIGA A CLASSE CONTROLLER...

  public
    { Public declarations }
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  VClienteController := TClienteController.Create;

  //VClienteController.ClienteModel.Carregar(3);//PROBLEMA ESTAVA AQUI!!

  //O TESTE!!! CARALHO!! FUNCIONA!!!
  //frmCliente.Caption:= VClienteController.ClienteModel.Nome;

end;

procedure TfrmCliente.FormDestroy(Sender: TObject);
begin
  VClienteController.Free;// USAR TODAS NO PADR?O FREE...

  //VClienteController.Destroy;

  //TSistemaControl.GetInstance.Destroy;//N?O USER ISSO AQUI APENAS NA FORM PRINCIPAL

end;



procedure TfrmCliente.btn1Click(Sender: TObject);
//TESTANDO O ENVIO PARA CONSULTAS PELO CODIGO
var
  Cod: Integer;
begin

    Cod:= StrToInt(edtConsulta.Text);

    VClienteController.ClienteModel.Carregar( Cod );

    //PASSAR ESSA REGRA AQUI PARA QUAL CLASSE??
    ShowMessage('NOME ENCONTRADO ?:' + ' >> ' + VClienteController.ClienteModel.Nome );

end;

end.
