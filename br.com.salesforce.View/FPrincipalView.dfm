object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'VIEW PRINCIPAL'
  ClientHeight = 243
  ClientWidth = 969
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 184
    Top = 8
    Width = 57
    Height = 13
    Caption = 'PATH_FILE:'
  end
  object lbl2: TLabel
    Left = 184
    Top = 63
    Width = 125
    Height = 13
    Caption = 'HOST_INFO / SRV_NAME:'
  end
  object LabelTeste: TLabel
    Left = 187
    Top = 210
    Width = 78
    Height = 13
    Caption = 'XXXXXXXXXXXXX'
  end
  object lbl3: TLabel
    Left = 407
    Top = 85
    Width = 272
    Height = 13
    Caption = 'USO CONCATENADO A PARTIR DA LEITURA DO PATH...'
  end
  object btn1: TButton
    Left = 16
    Top = 33
    Width = 75
    Height = 25
    Caption = 'CLEINTE'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btnChamaClienteCrud: TButton
    Left = 16
    Top = 64
    Width = 113
    Height = 25
    Caption = 'CLEINTE --> CRUD'
    TabOrder = 1
    OnClick = btnChamaClienteCrudClick
  end
  object btn3: TButton
    Left = 16
    Top = 104
    Width = 113
    Height = 25
    Caption = 'ESTUDO EXCPTIONS'
    TabOrder = 2
    OnClick = btn3Click
  end
  object edtFilePathDBase: TEdit
    Left = 184
    Top = 26
    Width = 513
    Height = 21
    TabOrder = 3
  end
  object edtServerInfo: TEdit
    Left = 184
    Top = 82
    Width = 201
    Height = 21
    TabOrder = 4
  end
  object btnLoadPath: TButton
    Left = 712
    Top = 24
    Width = 105
    Height = 25
    Caption = 'LOAD PATH'
    TabOrder = 5
    OnClick = btnLoadPathClick
  end
  object btnSaveINI: TButton
    Left = 184
    Top = 120
    Width = 81
    Height = 25
    Caption = 'SAVE INI FILE'
    TabOrder = 6
    OnClick = btnSaveINIClick
  end
  object btnReadINI: TButton
    Left = 294
    Top = 120
    Width = 91
    Height = 25
    Caption = 'READ INI FILE'
    TabOrder = 7
    OnClick = btnReadINIClick
  end
  object btnClearAll: TButton
    Left = 184
    Top = 168
    Width = 201
    Height = 25
    Caption = 'CLEAR ALL'
    TabOrder = 8
    OnClick = btnClearAllClick
  end
  object btnChekOutFiles: TButton
    Left = 8
    Top = 198
    Width = 145
    Height = 25
    Caption = 'CHECK  .INI AND .DBF FILE'
    TabOrder = 9
    OnClick = btnChekOutFilesClick
  end
  object OpenDialog1: TOpenDialog
    Filter = 'FireBirdFiles|*.fdb'
    Left = 896
    Top = 48
  end
end
