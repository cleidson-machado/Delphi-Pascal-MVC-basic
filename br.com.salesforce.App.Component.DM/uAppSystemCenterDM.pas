unit uAppSystemCenterDM;

interface

uses
  Forms,
  System.SysUtils,
  Data.DB,
  System.Classes,
  System.IniFiles,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait;

type
  TdmAppSystemCenter = class(TDataModule)
    mmTableClientesBaseList: TFDMemTable;
    intgrfldTableClientesBaseListCODIGO: TIntegerField;
    strngfldTableClientesBaseListNOME: TStringField;
    dsClientesBaseList: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    IniFileApp:   TIniFile;

    APathDBase: string; //ARMAZENAR DE FORMA UNIFICADA O CAMINHO COMPLETO DO BANCO DE DADOS SALVO NO .INI..

    AINIFilePathFull : string;//ARMAZENAR DE FORMA UNIFICADA O CAMINHO COMPLETO DO ARQUIVO .INI

    procedure ShowModalViewForm (T: TFormClass; F: TForm);

    procedure ShowViewForm (T: TFormClass; F: TForm);

    procedure LoadIniFileParam;

    procedure CreateTheFileIni;

    procedure GlobalAppINIPath;

    procedure GlobalAppDbasePath;

    destructor  Destroy; override;

  end;

var
  dmAppSystemCenter: TdmAppSystemCenter;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmAppSystemCenter }

procedure TdmAppSystemCenter.DataModuleCreate(Sender: TObject);
begin
      //MELHOR TRABALHAR ESSA VINCULA??O PELO C?DIGO, CERTOS AJUSTES FUNIONAM MELHOR VIA O OBJECT INSPECTOR...
      //dsClientesBaseList.DataSet:= mmTableClientesBaseList;
end;

procedure TdmAppSystemCenter.ShowModalViewForm(T: TFormClass; F: TForm);
//#### ATEN??O M?TODO GEN?RICO... CRIA UM SHOW MODAL
begin
    try
      Application.CreateForm(T,F);
      F.ShowModal;
    finally
      F.Free;
    end;
end;

procedure TdmAppSystemCenter.ShowViewForm(T: TFormClass; F: TForm);
//#### ATEN??O M?TODO GEN?RICO... CRIA APENAS O SHOW..
begin
    try
      Application.CreateForm(T,F);
      F.Show;
    finally
       //F.Release //SE USAR ISSO AQUI ABRE E FECHA AO MESMO TEMPO..
       //F.Free; //SE USAR ISSO AQUI ABRE E FECHA AO MESMO TEMPO..
    end;

end;

procedure TdmAppSystemCenter.LoadIniFileParam;
begin
      Self.GlobalAppINIPath;
      Self.CreateTheFileIni;
    try
      Self.GlobalAppDbasePath;
    finally
      IniFileApp.Free;
    end;
end;

procedure TdmAppSystemCenter.GlobalAppINIPath;
begin
  AINIFilePathFull := ExtractFilePath(Application.ExeName)+'SystemApp.INI';
end;

procedure TdmAppSystemCenter.GlobalAppDbasePath;
  // L? CAMINHO NA .INI E PASSA PARA A V GLOBAL.
begin
  //APathDBase := IniFileApp.ReadString('DBase','DBF_INFO', ''); //USO SIMPLES
  APathDBase := IniFileApp.ReadString('DBase','SRV_INFO', '')
        + ':' + IniFileApp.ReadString('DBase','DBF_INFO', '');// USO CONCATENADO
end;

procedure TdmAppSystemCenter.CreateTheFileIni;
begin
    IniFileApp := TIniFile.Create(AINIFilePathFull);
end;

destructor TdmAppSystemCenter.Destroy;
begin
    Self.Free;
  inherited;
end;

end.
