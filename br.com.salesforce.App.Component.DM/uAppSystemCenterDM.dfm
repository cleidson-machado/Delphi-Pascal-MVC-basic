object dmAppSystemCenter: TdmAppSystemCenter
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 172
  Width = 417
  object mmTableClientesBaseList: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 72
    Top = 24
    object intgrfldTableClientesBaseListCODIGO: TIntegerField
      DisplayLabel = 'COD_NEW_MM'
      FieldName = 'CODIGO'
    end
    object strngfldTableClientesBaseListNOME: TStringField
      DisplayLabel = 'NOME_NEW_MM'
      DisplayWidth = 40
      FieldName = 'NOME'
      Size = 40
    end
  end
  object dsClientesBaseList: TDataSource
    DataSet = mmTableClientesBaseList
    Left = 72
    Top = 96
  end
end
