unit msClass;

interface

uses
 System.Types,
 msInterfaces,
 msRectangle
 ;

type
 TmsClass = class(TmsRectangle)
 protected
  procedure GetStereotypeRect(var aRect: TRectF); override;
  procedure DoDrawTo(const aCtx: TmsDrawContext); override;
 end;//TmsClass

implementation

uses
 FMX.Graphics,
 FMX.Types
 ;

// TmsClass

procedure TmsClass.GetStereotypeRect(var aRect: TRectF);
begin
 aRect := DrawBounds;
 aRect := TRectF.Create(aRect.Left, aRect.Top, aRect.Right, aRect.Top + aRect.Height / 3);
end;

procedure TmsClass.DoDrawTo(const aCtx: TmsDrawContext);
var
 l_R : TRectF;
begin
 inherited;
 l_R := DrawBounds;
 aCtx.rCanvas.DrawLine(TPointF.Create(l_R.Left, l_R.Top + l_R.Height / 3),
                       TPointF.Create(l_R.Right, l_R.Top + l_R.Height / 3), 1);
 aCtx.rCanvas.DrawLine(TPointF.Create(l_R.Left, l_R.Top +  2 * l_R.Height / 3),
                       TPointF.Create(l_R.Right, l_R.Top + 2 * l_R.Height / 3), 1);
end;

end.
