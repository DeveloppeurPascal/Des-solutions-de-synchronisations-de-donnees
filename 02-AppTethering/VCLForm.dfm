object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'VCL Form'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = 152
    ExplicitWidth = 185
    object Edit1: TEdit
      Left = 1
      Top = 1
      Width = 121
      Height = 39
      Align = alLeft
      TabOrder = 0
      Text = 'Edit1'
      ExplicitLeft = 256
      ExplicitTop = 8
      ExplicitHeight = 21
    end
    object Button1: TButton
      Left = 122
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Synchro Edit1'
      TabOrder = 1
      OnClick = Button1Click
      ExplicitLeft = 280
      ExplicitTop = 8
      ExplicitHeight = 25
    end
    object Button2: TButton
      Left = 559
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Envoi image'
      TabOrder = 2
      OnClick = Button2Click
      ExplicitLeft = 280
      ExplicitTop = 8
      ExplicitHeight = 25
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 635
    Height = 258
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    ExplicitTop = -24
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object ATManagerVCL: TTetheringManager
    OnPairedFromLocal = ATManagerVCLPairedFromLocal
    Password = 'VCLManagerPassword'
    Text = 'Mon manager VCL'
    AllowedAdapters = 'Network'
    Left = 56
    Top = 72
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = ATManagerVCL
    Text = 'VCLTetheringAppProfile1'
    Group = 'MonGroupe'
    Actions = <>
    Resources = <
      item
        Name = 'ValeurPartagee'
        IsPublic = True
      end>
    Left = 312
    Top = 152
  end
end
