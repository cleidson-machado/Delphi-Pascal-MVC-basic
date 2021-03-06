program PROFIT;

uses
  //ADD COMENTARIOS MELHORES PONDERACOES SOBRE AS CLASSES E SUAS FUN??ES..
  Vcl.Forms,
  FPrincipalView in 'br.com.salesforce.View\FPrincipalView.pas' {frmPrincipal},
  uClienteView in 'br.com.salesforce.View\uClienteView.pas' {frmCliente},
  uEmpresaView in 'br.com.salesforce.View\uEmpresaView.pas' {frmEmpresa},
  uClienteModel in 'br.com.salesforce.Model\uClienteModel.pas',
  uClienteDao in 'br.com.salesforce.Dao\uClienteDao.pas',
  uConexao in 'br.com.salesforce.Dao.Conex\uConexao.pas',
  uClienteViewCrud in 'br.com.salesforce.View\uClienteViewCrud.pas' {frmClienteCrud},
  uAppSystemCenterDM in 'br.com.salesforce.App.Component.DM\uAppSystemCenterDM.pas' {dmAppSystemCenter: TDataModule},
  uClienteControl in 'br.com.salesforce.Controller.ModelClass\uClienteControl.pas',
  uSistemaControl in 'br.com.salesforce.Dao.Conex.Controller\AppCenter\uSistemaControl.pas',
  uMsnViewController in 'br.com.salesforce.Controller.Views\AppCenter\uMsnViewController.pas',
  uLayoutGrid in 'br.com.salesforce.View.Util\AppCenter\uLayoutGrid.pas',
  uEnumGenericAcoes in 'br.com.salesforce.Model.Util\AppCenter\uEnumGenericAcoes.pas',
  UAssertionErro in 'br.com.salesforce.App.Component.EX\UAssertionErro.pas',
  UVerificaException in 'br.com.salesforce.App.Component.EX\UVerificaException.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmAppSystemCenter, dmAppSystemCenter);
  Application.Run;
end.
