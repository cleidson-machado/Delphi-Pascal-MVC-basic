object frmClienteCrud: TfrmClienteCrud
  Left = 0
  Top = 0
  Caption = 'CLIENTE VIEW - CRUD'
  ClientHeight = 347
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 891
    Height = 161
    Align = alTop
    TabOrder = 0
    object lbl1: TLabel
      Left = 23
      Top = 18
      Width = 45
      Height = 22
      Caption = 'Cod:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 17
      Top = 48
      Width = 60
      Height = 22
      Caption = 'Nome:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 44
      Top = 76
      Width = 447
      Height = 13
      Caption = 
        '** MAX 40 Caracters / REALIZAR TRATAMENTO DE EXCESS'#213'ES de  ERROS' +
        ' COMO ESSE!....!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtCodigo: TEdit
      Left = 83
      Top = 22
      Width = 65
      Height = 21
      Color = clGradientActiveCaption
      Enabled = False
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 83
      Top = 49
      Width = 369
      Height = 21
      MaxLength = 40
      TabOrder = 1
    end
    object btnSalvar: TButton
      Left = 113
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Salvar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnSalvarClick
    end
    object btnNovo: TButton
      Left = 32
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Novo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnNovoClick
    end
    object btnExcluir: TButton
      Left = 275
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Excluir'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnCancelar: TButton
      Left = 356
      Top = 120
      Width = 96
      Height = 25
      Caption = 'Cancelar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnCancelarClick
    end
    object btnAlterar: TButton
      Left = 194
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Alterar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnAlterarClick
    end
  end
  object dbgCliente: TDBGrid
    Left = 0
    Top = 161
    Width = 891
    Height = 186
    Align = alClient
    DataSource = dmAppSystemCenter.dsClientesBaseList
    DrawingStyle = gdsGradient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = dbgClienteDrawColumnCell
    OnKeyDown = dbgClienteKeyDown
    OnMouseUp = dbgClienteMouseUp
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 351
        Visible = True
      end>
  end
end
