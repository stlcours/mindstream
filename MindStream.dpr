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
  msLineWithArrow in 'ConcreteShapes\msLineWithArrow.pas',
  msOurShapes in 'msOurShapes.pas',
  msTriangleDirectionRight in 'ConcreteShapes\msTriangleDirectionRight.pas',
  msMover in 'ShapeTools\msMover.pas',
  FirstTest in 'Tests\Module\FirstTest.pas',
  TestMsLine in 'Tests\Module\TestMsLine.pas',
  TestMsRectangle in 'Tests\Module\TestMsRectangle.pas',
  TestMsPointCircle in 'Tests\Module\TestMsPointCircle.pas',
  TestMsCircle in 'Tests\Module\TestMsCircle.pas',
  msShapeTest in 'Tests\Module\msShapeTest.pas',
  msSerializeInterfaces in 'msSerializeInterfaces.pas',
  msTool in 'ShapeTools\msTool.pas',
  msDiagrammMarshal in 'Marshal\msDiagrammMarshal.pas',
  msShapeMarshal in 'Marshal\msShapeMarshal.pas',
  msDiagrammsMarshal in 'Marshal\msDiagrammsMarshal.pas',
  msStringList in 'Core\msStringList.pas',
  msObject in 'Core\msObject.pas',
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
  TestSaveMoverToPNG in 'Tests\Module\TestSaveMoverToPNG.pas',
  msTestConstants in 'Tests\Module\msTestConstants.pas',
  msShapeButton in 'ShapeButtons\msShapeButton.pas',
  msCompletedShapeCreator in 'ShapeCreators\msCompletedShapeCreator.pas',
  msPaletteShapeCreator in 'ShapeCreators\msPaletteShapeCreator.pas',
  msNullClickShape in 'ShapeTools\msNullClickShape.pas',
  msPaletteShape in 'ShapeTools\PaletteShapes\msPaletteShape.pas',
  msShapeRemover in 'ShapeTools\msShapeRemover.pas',
  msPolygonShape in 'AbstractShapes\msPolygonShape.pas',
  msMoverIcon in 'SpecialShapes\ForButtons\msMoverIcon.pas',
  msMoveIcon in 'SpecialShapes\msMoveIcon.pas',
  msPointedShape in 'AbstractShapes\msPointedShape.pas',
  msUpArrow in 'SpecialShapes\ForButtons\Arrows\msUpArrow.pas',
  msDownArrow in 'SpecialShapes\ForButtons\Arrows\msDownArrow.pas',
  msSpecialArrow in 'AbstractShapes\msSpecialArrow.pas',
  msSpecialDiagonalArrow in 'AbstractShapes\msSpecialDiagonalArrow.pas',
  msLeftArrow in 'SpecialShapes\ForButtons\Arrows\msLeftArrow.pas',
  msRightArrow in 'SpecialShapes\ForButtons\Arrows\msRightArrow.pas',
  msUpRightArrow in 'SpecialShapes\ForButtons\Arrows\msUpRightArrow.pas',
  msUpLeftArrow in 'SpecialShapes\ForButtons\Arrows\msUpLeftArrow.pas',
  msDownRightArrow in 'SpecialShapes\ForButtons\Arrows\msDownRightArrow.pas',
  msDownLeftArrow in 'SpecialShapes\ForButtons\Arrows\msDownLeftArrow.pas',
  msRemoverIcon in 'SpecialShapes\ForButtons\msRemoverIcon.pas',
  msRemoveIcon in 'SpecialShapes\msRemoveIcon.pas',
  msShapesGroup in 'ContainerShapes\msShapesGroup.pas',
  msPointlessShape in 'AbstractShapes\msPointlessShape.pas',
  ForToolbarShapesTest in 'Tests\Integrated\ForToolbarShapesTest.pas',
  RegisteredShapesTest in 'Tests\Integrated\RegisteredShapesTest.pas',
  msSwapParentsIcon in 'SpecialShapes\ForButtons\msSwapParentsIcon.pas',
  UtilityShapesTest in 'Tests\Integrated\UtilityShapesTest.pas',
  msPickerIcon in 'SpecialShapes\ForButtons\msPickerIcon.pas',
  msUpToParentIcon in 'SpecialShapes\ForButtons\msUpToParentIcon.pas',
  msButtonIcon in 'SpecialShapes\ForButtons\msButtonIcon.pas',
  msFolderToolIcon in 'SpecialShapes\ForButtons\msFolderToolIcon.pas',
  msFolderIcon in 'SpecialShapes\ForButtons\msFolderIcon.pas',
  msSVGShape in 'AbstractShapes\msSVGShape.pas',
  msFolder in 'ConcreteShapes\SVG\msFolder.pas',
  msShapesList in 'msShapesList.pas',
  msCircleWithRadius in 'ConcreteShapes\msCircleWithRadius.pas',
  msShapeClassList in 'msShapeClassList.pas',
  msLoggedTest in 'Tests\Core\msLoggedTest.pas',
  msRegisteredShapesTestPrim in 'Tests\Abstract\msRegisteredShapesTestPrim.pas',
  msProxyShape in 'ContainerShapes\msProxyShape.pas',
  msShapeTool in 'ContainerShapes\msShapeTool.pas',
  msMoveShapeUp in 'ShapeTools\FloatingButtons\msMoveShapeUp.pas',
  msMoveShapeUpLeft in 'ShapeTools\FloatingButtons\msMoveShapeUpLeft.pas',
  msMoveShapeUpRight in 'ShapeTools\FloatingButtons\msMoveShapeUpRight.pas',
  msMoveShapeDown in 'ShapeTools\FloatingButtons\msMoveShapeDown.pas',
  msMoveShapeDownRight in 'ShapeTools\FloatingButtons\msMoveShapeDownRight.pas',
  msMoveShapeDownLeft in 'ShapeTools\FloatingButtons\msMoveShapeDownLeft.pas',
  msMoveShapeLeft in 'ShapeTools\FloatingButtons\msMoveShapeLeft.pas',
  msMoveShapeRight in 'ShapeTools\FloatingButtons\msMoveShapeRight.pas',
  msShapeClass in 'MetaShapes\msShapeClass.pas',
  msProxyShapeClass in 'MetaShapes\msProxyShapeClass.pas',
  msMoveShapeTool in 'ContainerShapes\msMoveShapeTool.pas',
  msBoundsCorrector in 'ContainerShapes\msBoundsCorrector.pas',
  msSpecialDiagonalArrowBoundsCorrector in 'ContainerShapes\msSpecialDiagonalArrowBoundsCorrector.pas',
  msFloatingButtonCircle in 'SpecialShapes\ForButtons\msFloatingButtonCircle.pas',
  msCoreUtils in 'Core\msCoreUtils.pas',
  msScalingShape in 'ContainerShapes\msScalingShape.pas',
  msTextShape in 'ConcreteShapes\msTextShape.pas',
  msRectangularShape in 'AbstractShapes\msRectangularShape.pas',
  FMX.DUnit.Interfaces in 'FMX.DUnit\FMX.DUnit.Interfaces.pas',
  msScrollShapeUp in 'ShapeTools\ScrollButtons\msScrollShapeUp.pas',
  msScrollShape in 'ShapeTools\ScrollButtons\msScrollShape.pas',
  msScrollShapeDown in 'ShapeTools\ScrollButtons\msScrollShapeDown.pas',
  msScrollShapeRight in 'ShapeTools\ScrollButtons\msScrollShapeRight.pas',
  msScrollShapeLeft in 'ShapeTools\ScrollButtons\msScrollShapeLeft.pas',
  msScrollShapeUpLeft in 'ShapeTools\ScrollButtons\msScrollShapeUpLeft.pas',
  msScrollShapeUpRight in 'ShapeTools\ScrollButtons\msScrollShapeUpRight.pas',
  msScrollShapeDownLeft in 'ShapeTools\ScrollButtons\msScrollShapeDownLeft.pas',
  msScrollShapeDownRight in 'ShapeTools\ScrollButtons\msScrollShapeDownRight.pas',
  msScrollShapePrim in 'ShapeTools\ScrollButtons\msScrollShapePrim.pas',
  msScrollShapeResetOrigin in 'ShapeTools\ScrollButtons\msScrollShapeResetOrigin.pas',
  msScrollingTool in 'ShapeTools\msScrollingTool.pas',
  FMX.DUnit.msAppLog in 'fmx.dunit\FMX.DUnit.msAppLog.pas',
  msMovingPointer in 'msMovingPointer.pas',
  FMX.DUnit.msLog in 'fmx.dunit\FMX.DUnit.msLog.pas',
  msConnector in 'ConcreteShapes\ForUML\msConnector.pas',
  msLineCrossTest in 'Tests\Module\msLineCrossTest.pas',
  msLineF in 'Core\msLineF.pas',
  msGeneralization in 'ConcreteShapes\ForUML\msGeneralization.pas',
  msRealization in 'ConcreteShapes\ForUML\msRealization.pas',
  msDependency in 'ConcreteShapes\ForUML\msDependency.pas',
  msAssociation in 'ConcreteShapes\ForUML\msAssociation.pas',
  msClass in 'ConcreteShapes\ForUML\msClass.pas',
  msLibrary in 'ConcreteShapes\ForUML\msLibrary.pas',
  msUsecase in 'ConcreteShapes\ForUML\msUsecase.pas',
  msTrivial in 'ConcreteShapes\ForUML\msTrivial.pas',
  msArrowHead in 'ConcreteShapes\msArrowHead.pas',
  msPolylineShape in 'AbstractShapes\msPolylineShape.pas',
  msShapeClassPrim in 'MetaShapes\msShapeClassPrim.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  u_fmGUITestRunner.RunRegisteredTestsModeless;
  Application.Run;
end.
