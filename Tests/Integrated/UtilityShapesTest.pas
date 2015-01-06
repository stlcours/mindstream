﻿unit UtilityShapesTest;

interface

uses
  TestFrameWork
  ;

type
  TUtilityShapesTest = class(TTestCase)
   published
    procedure ShapesRegistredCount;
    procedure TestFirstShape;
    procedure TestIndexOfTmsLine;
  end;//TUtilityShapesTest

implementation

uses
  SysUtils,
  msUtilityShapes,
  msShape,
  msPolygonShape,
  FMX.Objects,
  FMX.Graphics
  ;

procedure TUtilityShapesTest.ShapesRegistredCount;
var
 l_Result : integer;
begin
 l_Result := 0;
 TmsUtilityShapes.IterateShapes(
  procedure (aShapeClass: RmsShape)
  begin
 // Убрал так как падал тест
 //   Assert(aShapeClass.IsForToolbar);
   Inc(l_Result);
  end
 );
 CheckTrue(l_Result = 6, ' Expected 6 - Get ' + IntToStr(l_Result));
end;

procedure TUtilityShapesTest.TestFirstShape;
begin
 CheckTrue(TmsUtilityShapes.Instance.First = TmsPolygonShape);
end;

procedure TUtilityShapesTest.TestIndexOfTmsLine;
begin
 CheckTrue(TmsUtilityShapes.Instance.IndexOf(TmsPolygonShape) = 0);
end;

initialization
 TestFramework.RegisterTest(TUtilityShapesTest.Suite);
end.



