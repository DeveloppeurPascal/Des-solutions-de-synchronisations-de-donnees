object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      MethodType = mtGet
      Name = 'DemandeDeFichier'
      PathInfo = '/apiGet'
      OnAction = WebModule1DemandeDeFichierAction
    end
    item
      MethodType = mtPost
      Name = 'EnvoiDeFichier'
      PathInfo = '/apiPost'
      OnAction = WebModule1EnvoiDeFichierAction
    end
    item
      MethodType = mtGet
      Name = 'EnvoiBase'
      PathInfo = '/apiGetDB'
      OnAction = WebModule1EnvoiBaseAction
    end>
  Height = 230
  Width = 415
  object EmployeeConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    Connected = True
    LoginPrompt = False
    Left = 28
    Top = 18
  end
  object CountryTable: TFDQuery
    Active = True
    Connection = EmployeeConnection
    SQL.Strings = (
      'SELECT * FROM COUNTRY')
    Left = 28
    Top = 66
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 32
    Top = 120
  end
end
