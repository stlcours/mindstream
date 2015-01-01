﻿unit msPolygonShape;

interface

uses
 msInterfaces,
 msTool,
 System.Types,
 System.Math.Vectors
 ;

type
 TmsPolygonShape = class abstract(TmsTool)
  // - класс для реализации полигональных объектов
 protected
  function Polygon: TPolygon; virtual;
  procedure DoDrawTo(const aCtx: TmsDrawContext); override;
  function GetDrawBounds: TRectF; override;
 end;//TmsPolygonShape

implementation

{ TmsPolygonShape }
function TmsPolygonShape.GetDrawBounds: TRectF;
begin
 Result := TRectF.Create(0,0,100,100);
end;


function TmsPolygonShape.Polygon: TPolygon;
begin

end;

procedure TmsPolygonShape.DoDrawTo(const aCtx: TmsDrawContext);
var
 l_P : TPolygon;
begin
 l_P := Polygon;
 aCtx.rCanvas.DrawPolygon(l_P, 1);
 aCtx.rCanvas.FillPolygon(l_P, 0.5);
end;

end.
