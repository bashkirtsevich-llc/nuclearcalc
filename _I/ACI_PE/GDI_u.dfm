object wnd2D: Twnd2D
  Left = 0
  Top = 0
  Caption = '2D View'
  ClientHeight = 409
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnMouseWheel = FormMouseWheel
  PixelsPerInch = 96
  TextHeight = 13
  object pbGraph: TImage
    Left = 0
    Top = 0
    Width = 689
    Height = 409
    Align = alClient
    OnMouseDown = FormMouseDown
    OnMouseMove = FormMouseMove
    OnMouseUp = FormMouseUp
    ExplicitLeft = 248
    ExplicitTop = 280
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
end
