unit msShapeClassPrim;

interface

uses
 msInterfaces,
 msInterfacedRefcounted
 ;

type
 TmsShapeClassPrim = class abstract(TmsInterfacedRefcounted, ImsShapeClassTuner)
 protected
  f_FillColor : TmsColorRec;
  f_InitialHeight : TmsPixelRec;
  f_InitialWidth : TmsPixelRec;
  f_StrokeThickness : TmsPixelRec;
  f_CornerRadius : TmsRadiusRec;
  f_StrokeDash : TmsStrokeDash;
 protected
  function ParentMC: ImsShapeClass; virtual;
  function AsMC: ImsShapeClass; virtual;
  function AsTuner: ImsShapeClassTuner;
  function Stereotype: String; virtual;
  procedure TransformDrawOptionsContext(var theCtx: TmsDrawOptionsContext);
  function SetFillColor(aColor: TAlphaColor): ImsShapeClassTuner;
  function SetStrokeThickness(aValue: Pixel): ImsShapeClassTuner;
  function SetStrokeDash(aValue: TStrokeDash): ImsShapeClassTuner;
  function SetInitialHeight(aValue: Pixel): ImsShapeClassTuner;
  function SetInitialHeightScale(aValue: Single): ImsShapeClassTuner;
  function SetCornerRadius(aValue: Single): ImsShapeClassTuner;
  function InitialHeight: Pixel;
  function InitialWidth: Pixel;
  function CornerRadius: Pixel;
  function SetInitialWidth(aValue: Pixel): ImsShapeClassTuner;
 end;//TmsShapeClassPrim

implementation

uses
 msShape
 ;

// TmsShapeClassPrim

function TmsShapeClassPrim.ParentMC: ImsShapeClass;
begin
 Result := nil;
 Assert(false, '�� �����������');
end;

function TmsShapeClassPrim.AsMC: ImsShapeClass;
begin
 Result := nil;
 Assert(false, '�� �����������');
end;

function TmsShapeClassPrim.AsTuner: ImsShapeClassTuner;
begin
 Result := Self;
end;

function TmsShapeClassPrim.Stereotype: String;
begin
 Result := '';
 Assert(false, '�� �����������');
end;

procedure TmsShapeClassPrim.TransformDrawOptionsContext(var theCtx: TmsDrawOptionsContext);
begin
 if (ParentMC <> nil) then
  ParentMC.TransformDrawOptionsContext(theCtx);
 if f_FillColor.rIsSet then
  theCtx.rFillColor := f_FillColor.rValue;
 if f_StrokeThickness.rIsSet then
  theCtx.rStrokeThickness := f_StrokeThickness.rValue;
 if f_StrokeDash.rIsSet then
  theCtx.rStrokeDash := f_StrokeDash.rValue;
end;

function TmsShapeClassPrim.SetFillColor(aColor: TAlphaColor): ImsShapeClassTuner;
begin
 Result := Self;
 f_FillColor := aColor;
end;

function TmsShapeClassPrim.SetStrokeThickness(aValue: Pixel): ImsShapeClassTuner;
begin
 Result := Self;
 f_StrokeThickness := aValue;
end;

function TmsShapeClassPrim.SetStrokeDash(aValue: TStrokeDash): ImsShapeClassTuner;
begin
 Result := Self;
 f_StrokeDash := aValue;
end;

function TmsShapeClassPrim.SetInitialHeight(aValue: Pixel): ImsShapeClassTuner;
begin
 Result := Self;
 f_InitialHeight := aValue;
end;

function TmsShapeClassPrim.SetCornerRadius(aValue: Single): ImsShapeClassTuner;
begin
 Result := Self;
 f_CornerRadius := aValue;
end;

function TmsShapeClassPrim.SetInitialWidth(aValue: Pixel): ImsShapeClassTuner;
begin
 Result := Self;
 f_InitialWidth := aValue;
end;

function TmsShapeClassPrim.SetInitialHeightScale(aValue: Single): ImsShapeClassTuner;
begin
 Result := Self.SetInitialHeight(Self.ParentMC.InitialHeight * aValue);
end;

function TmsShapeClassPrim.InitialHeight: Pixel;
var
 l_PMC : ImsShapeClass;
 l_V : TmsPixelRec;
begin
 l_V := f_InitialHeight;
 if l_V.rIsSet then
  Result := l_V.rValue
 else
 begin
  l_PMC := Self.ParentMC;
  if (l_PMC <> nil) then
   Result := l_PMC.InitialHeight
  else
   Result := 0.0;
 end;//l_V.rIsSet
end;

function TmsShapeClassPrim.InitialWidth: Pixel;
var
 l_PMC : ImsShapeClass;
 l_V : TmsPixelRec;
begin
 l_V := f_InitialWidth;
 if l_V.rIsSet then
  Result := l_V.rValue
 else
 begin
  l_PMC := Self.ParentMC;
  if (l_PMC <> nil) then
   Result := l_PMC.InitialWidth
  else
   Result := 0.0;
 end;//l_V.rIsSet
end;

function TmsShapeClassPrim.CornerRadius: Pixel;
var
 l_PMC : ImsShapeClass;
 l_V : TmsRadiusRec;
begin
 l_V := f_CornerRadius;
 if l_V.rIsSet then
  Result := l_V.rValue
 else
 begin
  l_PMC := Self.ParentMC;
  if (l_PMC <> nil) then
   Result := l_PMC.CornerRadius
  else
   Result := -1.0;
 end;//l_V.rIsSet
end;

end.
