program MindStream;

uses
  msCoreObjects in 'Core\msCoreObjects.pas',
  FMX.Forms,
  uMain in 'uMain.pas' {fmMain},
  u_fmGUITestRunner in 'FMX.DUnit\u_fmGUITestRunner.pas' {fmGUITestRunner},
  msDiagramm in 'msDiagramm.pas',
  msShape in 'AbstractShapes\msShape.pas',
  msRegisteredShapes in 'msRegisteredShapes.pas',
  msUtilityShapes in 'msUtilityShapes.pas',
  msLine in 'ConcreteShapes\msLine.pas',
  msRectangle in 'ConcreteShapes\msRectangle.pas',
  msPointCircle in 'SpecialShapes\msPointCircle.pas',
  msCircle in 'ConcreteShapes\msCircle.pas',
  msRoundedRectangle in 'ConcreteShapes\msRoundedRectangle.pas',
  msUseCaseLikeEllipse in 'ConcreteShapes\msUseCaseLikeEllipse.pas',
  msTriangle in 'ConcreteShapes\msTriangle.pas',
  msDiagramms in 'msDiagramms.pas',
  msDiagrammsController in 'msDiagrammsController.pas',
  msDashDotLine in 'ConcreteShapes\msDashDotLine.pas',
  msDashLine in 'ConcreteShapes\msDashLine.pas',
  msDotLine in 'ConcreteShapes\msDotLine.pas',
  msLineWithArrow in 'ConcreteShapes\msLineWithArrow.pas',
  msSmallTriangle in 'SpecialShapes\msSmallTriangle.pas',
  msOurShapes in 'msOurShapes.pas',
  msTriangleDirectionRight in 'ConcreteShapes\msTriangleDirectionRight.pas',
  msMover in 'ShapeTools\msMover.pas',
  FirstTest in 'Tests\Module\FirstTest.pas',
  TestMsLine in 'Tests\Module\TestMsLine.pas',
  TestMsRectangle in 'Tests\Module\TestMsRectangle.pas',
  TestMsPointCircle in 'Tests\Module\TestMsPointCircle.pas',
  TestMsCircle in 'Tests\Module\TestMsCircle.pas',
  msShapeTest in 'Tests\Module\msShapeTest.pas',
  msRedRectangle in 'ConcreteShapes\msRedRectangle.pas',
  msGreenRectangle in 'ConcreteShapes\msGreenRectangle.pas',
  msSerializeInterfaces in 'msSerializeInterfaces.pas',
  msTool in 'ShapeTools\msTool.pas',
  msDiagrammMarshal in 'Marshal\msDiagrammMarshal.pas',
  msShapeMarshal in 'Marshal\msShapeMarshal.pas',
  msDiagrammsMarshal in 'Marshal\msDiagrammsMarshal.pas',
  msStringList in 'Core\msStringList.pas',
  msInterfacedRefcounted in 'Core\msInterfacedRefcounted.pas',
  msMarshalPrim in 'Marshal\msMarshalPrim.pas',
  msShapeTestSuite in 'Tests\Module\msShapeTestSuite.pas',
  msInvalidators in 'msInvalidators.pas',
  msInterfaces in 'msInterfaces.pas',
  msStreamUtils in 'Core\msStreamUtils.pas',
  msPicker in 'ShapeTools\msPicker.pas',
  msUpToParent in 'ShapeTools\msUpToParent.pas',
  msSwapParents in 'ShapeTools\msSwapParents.pas',
  msShapeCreator in 'ShapeCreators\msShapeCreator.pas',
  msFormatter in 'msFormatter.pas',
  TestmsJsonFormatter in 'Tests\Module\TestmsJsonFormatter.pas',
  msDiagrammStack in 'msDiagrammStack.pas',
  TestSaveToPNG in 'Tests\Module\TestSaveToPNG.pas',
  msTestConstants in 'Tests\Module\msTestConstants.pas',
  msShapeButton in 'ShapeButtons\msShapeButton.pas',
  msCompletedShapeCreator in 'ShapeCreators\msCompletedShapeCreator.pas',
  msPaletteShapeCreator in 'ShapeCreators\msPaletteShapeCreator.pas',
  msNullClickShape in 'ShapeTools\msNullClickShape.pas',
  msPaletteShape in 'ShapeTools\PaletteShapes\msPaletteShape.pas',
  msShapeRemover in 'ShapeTools\msShapeRemover.pas',
  msGreenCircle in 'SpecialShapes\ForButtons\msGreenCircle.pas',
  msBlackTriangle in 'ConcreteShapes\ForButtons\msBlackTriangle.pas',
  msPolygonShape in 'AbstractShapes\msPolygonShape.pas',
  msMoverIcon in 'SpecialShapes\ForButtons\msMoverIcon.pas',
  msPointedShape in 'AbstractShapes\msPointedShape.pas',
  msUpArrow in 'SpecialShapes\ForButtons\msUpArrow.pas',
  msDownArrow in 'SpecialShapes\ForButtons\msDownArrow.pas',
  msSpecialArrow in 'AbstractShapes\msSpecialArrow.pas',
  msLeftArrow in 'SpecialShapes\ForButtons\msLeftArrow.pas',
  msRightArrow in 'SpecialShapes\ForButtons\msRightArrow.pas',
  msRemoverIcon in 'SpecialShapes\ForButtons\msRemoverIcon.pas',
  msShapesGroup in 'ContainerShapes\msShapesGroup.pas',
  msPointlessShape in 'AbstractShapes\msPointlessShape.pas',
  ForToolbarShapesTest in 'Tests\Integrated\ForToolbarShapesTest.pas',
  RegisteredShapesTest in 'Tests\Integrated\RegisteredShapesTest.pas',
  msSwapParentsIcon in 'SpecialShapes\ForButtons\msSwapParentsIcon.pas',
  UtilityShapesTest in 'Tests\Integrated\UtilityShapesTest.pas',
  msPickerIcon in 'SpecialShapes\ForButtons\msPickerIcon.pas',
  msUpToParentIcon in 'SpecialShapes\ForButtons\msUpToParentIcon.pas',
  msButtonIcon in 'SpecialShapes\ForButtons\msButtonIcon.pas',
  msFolderIcon in 'SpecialShapes\ForButtons\msFolderIcon.pas',
  msShapesList in 'msShapesList.pas',
  msCircleWithRadius in 'ConcreteShapes\msCircleWithRadius.pas',
  msShapeClassList in 'msShapeClassList.pas',
  msLoggedTest in 'Tests\Core\msLoggedTest.pas',
  msRegisteredShapesTestPrim in 'Tests\Abstract\msRegisteredShapesTestPrim.pas',
  msProxyShape in 'ContainerShapes\msProxyShape.pas',
  msShapeTool in 'ContainerShapes\msShapeTool.pas',
  msMoveShapeUp in 'ShapeTools\FloatingButtons\msMoveShapeUp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  u_fmGUITestRunner.RunRegisteredTestsModeless;
  Application.Run;
end.
