unit msProxyShape;

interface

uses
 System.Types,
 Generics.Collections,
 msInterfaces,
 msShape,
 msPointlessShape,
 msShapesList
 ;

type
 TmsProxyShape = class(TmsPointlessShape)
 private
  f_Shape : ImsShape;
 protected
  procedure DoDrawTo(const aCtx: TmsDrawContext); override;
  function GetDrawBounds: TRectF; override;
  function ContainsPt(const aPoint: TPointF): Boolean; override;
  constructor CreateInner(const aShape: ImsShape);
  property ShapeToShow : ImsShape
   read f_Shape;
 public
  class function Create(const aShape: ImsShape): ImsShape;
  procedure Cleanup; override;
 end;//TmsProxyShape

implementation

uses
 System.SysUtils,
 System.Math
 ;

// TmsProxyShape

class function TmsProxyShape.Create(const aShape: ImsShape): ImsShape;
begin
 Result := CreateInner(aShape);
end;

constructor TmsProxyShape.CreateInner(const aShape: ImsShape);
begin
 Assert(aShape <> nil, '������ ������ ���������� ����� ���������');
 inherited CreateInner(TPointF.Create(0, 0));
 f_Shape := aShape;
end;

procedure TmsProxyShape.Cleanup;
begin
 f_Shape := nil;
 inherited;
end;

procedure TmsProxyShape.DoDrawTo(const aCtx: TmsDrawContext);
begin
 Assert(ShapeToShow <> nil);
 ShapeToShow.DrawTo(aCtx);
end;

function TmsProxyShape.GetDrawBounds: TRectF;
begin
 Assert(ShapeToShow <> nil);
 Result := ShapeToShow.DrawBounds;
end;

function TmsProxyShape.ContainsPt(const aPoint: TPointF): Boolean;
begin
 Assert(ShapeToShow <> nil);
 Result := ShapeToShow.ContainsPt(aPoint);
end;

end.
