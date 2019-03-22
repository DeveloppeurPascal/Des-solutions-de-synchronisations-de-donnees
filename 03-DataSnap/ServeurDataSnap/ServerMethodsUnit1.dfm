object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object EmployeeConnection: TSQLConnection
    ConnectionName = 'EMPLOYEE'
    DriverName = 'Interbase'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      
        'Database=localhost:C:\ProgramData\Embarcadero\InterBase\gds_db\e' +
        'xamples\database\employee.gdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Connected = True
    Left = 44
    Top = 30
  end
  object CountryTable: TSQLDataSet
    Active = True
    CommandText = 'COUNTRY'
    CommandType = ctTable
    DbxCommandType = 'Dbx.Table'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = EmployeeConnection
    Left = 44
    Top = 78
  end
  object DSCountryTable: TDataSetProvider
    DataSet = CountryTable
    Left = 120
    Top = 64
  end
end
