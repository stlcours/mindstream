unit msScrollShapeUp;

interface

uses
 msScrollShape,
 msInterfaces,
 msUpArrow,
 System.Types
 ;

type
 TmsScrollShapeUp = class(TmsScrollShape)
 public
  class function ButtonShape: ImsShape; override;
  class function DoNullClick(const aHolder: ImsDiagrammsHolder): Boolean; override;
 end;//TmsScrollShapeUp

implementation

// TmsScrollShapeUp

{ TmsScrollShapeUp }

class function TmsScrollShapeUp.ButtonShape: ImsShape;
begin
 Result := TmsUpArrow.Create(TPointF.Create(0, 0));
end;


class function TmsScrollShapeUp.DoNullClick(
  const aHolder: ImsDiagrammsHolder): Boolean;
begin
 Result := true;
 aHolder.Scroll(TPointF.Create(0, ScrollDelta));
end;

end.
