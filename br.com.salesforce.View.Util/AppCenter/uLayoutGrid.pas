unit uLayoutGrid;

interface

uses
  Winapi.Windows, Vcl.DBGrids, Vcl.Grids, System.UITypes, Vcl.Graphics;

type
  TLayoutGrid = class

    class procedure Zebrar(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState; Color: TColor);
  end;

implementation

{ TLayoutGrid }

class procedure TLayoutGrid.Zebrar(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState; Color: TColor);
begin
    //COPIADO INTERAMENTE DO PROJETO BASE..
    if not odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color := Color;
         TDBGrid(Sender).Canvas.FillRect(Rect);
         TDBGrid(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
      end;

    if (gdSelected in state ) then
      begin
         TDBGrid(Sender).Canvas.Brush.Color:= clNavy;
         TDBGrid(Sender).Canvas.Font.Color := clwhite;
         TDBGrid(Sender).Canvas.FillRect(Rect);
         TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      end;
end;

end.
