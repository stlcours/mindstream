﻿unit u_fmGUITestRunner;

interface

uses
 TestFramework,
 System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
 FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
 FMX.Layouts, FMX.TreeView, FMX.ListView.Types, FMX.ListView, System.Generics.Collections;

const
 c_ColorOk = TAlphaColorRec.Green;
 c_ColorFailure = TAlphaColorRec.Fuchsia;
 c_ColorError = TAlphaColorRec.Red;

type
 TDoSomethingWithNode = reference to procedure(const aItem: TTreeViewItem);

type
 TfmGUITestRunner = class(TForm, ITestListener)
  ToolBar1: TToolBar;
  btRunAllTest: TSpeedButton;
  pnlMain: TPanel;
  tvTestTree: TTreeView;
  pnlBottom: TPanel;
  lvFailureListView: TListView;
  lblTime: TLabel;
  btnCheckAll: TSpeedButton;
  btnUncheckAll: TSpeedButton;
  lblErros: TLabel;
  lblErrorCount: TLabel;
  lblFailure: TLabel;
  lblFailureCount: TLabel;
  lblTimeCount: TLabel;
  lblRunned: TLabel;
  btnDelEtalon: TSpeedButton;
  procedure FormCreate(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure btRunAllTestClick(Sender: TObject);
  procedure tvTestTreeChangeCheck(Sender: TObject);
  procedure btnCheckAllClick(Sender: TObject);
  procedure btnUncheckAllClick(Sender: TObject);
  procedure btnDelEtalonClick(Sender: TObject);
 protected
  FSuite: ITest;
  FTests: TInterfaceList;
  FTestResult: TTestResult;
  FSelectedTests: TInterfaceList;
  FTotalTime: Int64;
  f_Runned : Integer;

  procedure SetSuite(aValue: ITest);
  procedure InitTree;
  procedure FillTestTree(aTest: ITest); overload;
  procedure RunTheTest(aTest: ITest);

  function NodeToTest(aNode: TTreeViewItem): ITest;
  function TestToNode(test: ITest): TTreeViewItem;

  procedure SetTreeNodeFont(aNode: TTreeViewItem; aColor: TAlphaColor);

  function AddFailureNode(aFailure: TTestFailure): TListViewItem;

  procedure SetNodeEnabled(aNode: TTreeViewItem; aValue: Boolean);

  procedure ClearResult;

  procedure TraverseTree(const aTree: TTreeView; aLambda: TDoSomethingWithNode);

 public
  property Suite: ITest
   read FSuite
   write SetSuite;
  property TestResult: TTestResult read FTestResult write FTestResult;

  // IListener
  procedure TestingStarts;
  procedure StartTest(aTest: ITest);

  procedure AddSuccess(aTest: ITest);
  procedure AddError(aFailure: TTestFailure);
  procedure AddFailure(aFailure: TTestFailure);

  procedure EndTest(test: ITest);
  procedure TestingEnds(aTestResult: TTestResult);

  function ShouldRunTest(aTest: ITest): Boolean;
  // IStatusListener
  procedure Status(aTest: ITest; const aMessage: string);
 end;

type
 TTestNode = class(TTreeViewItem)
  private
   f_Test: ITest;
  public
   constructor Create(aParent: TFmxObject; const aTest: ITest);
   property Test: ITest
    read f_Test;
 end;//TTestNode

procedure RunTestModeless(aTest: ITest);
procedure RunRegisteredTestsModeless;

var
 fmGUITestRunner: TfmGUITestRunner;

implementation

uses
 System.TypInfo,
 msInterfaces,
 msShapeTest
 ;

{$R *.fmx}

procedure RunTestModeless(aTest: ITest);
var
 l_GUI: TfmGUITestRunner;
begin
 l_GUI := TfmGUITestRunner.Create(nil);
 l_GUI.Suite := aTest;
 l_GUI.Show;
end;

procedure RunRegisteredTestsModeless;
begin
 RunTestModeless(registeredTests)
end;

procedure TfmGUITestRunner.AddError(aFailure: TTestFailure);
var
 l_ListViewItem: TListViewItem;
begin
 SetTreeNodeFont(TestToNode(aFailure.failedTest), c_ColorError);

 l_ListViewItem := AddFailureNode(aFailure);
end;

procedure TfmGUITestRunner.AddFailure(aFailure: TTestFailure);
var
 l_ListViewItem: TListViewItem;
begin
 SetTreeNodeFont(TestToNode(aFailure.failedTest), c_ColorFailure);

 l_ListViewItem := AddFailureNode(aFailure);
end;

function TfmGUITestRunner.AddFailureNode(aFailure: TTestFailure): TListViewItem;
var
 l_Item: TListViewItem;
 l_Node: TTreeViewItem;
begin
 assert(assigned(aFailure));
 l_Item := lvFailureListView.Items.Add;

 l_Node := TestToNode(aFailure.failedTest);
 Assert(l_Node <> nil);
 l_Item.Text := l_Node.ParentItem.Text + '.' + aFailure.failedTest.Name + '; ' + aFailure.thrownExceptionName + '; ' + aFailure.thrownExceptionMessage + '; ' +
   aFailure.LocationInfo + '; ' + aFailure.AddressInfo + '; ' + aFailure.StackTrace;

 while l_Node <> nil do
 begin
  l_Node.Expand;
  l_Node := l_Node.ParentItem;
 end;

 Result := l_Item;
end;

procedure TfmGUITestRunner.AddSuccess(aTest: ITest);
begin
 assert(assigned(aTest));
 SetTreeNodeFont(TestToNode(aTest), c_ColorOk)
end;

procedure TfmGUITestRunner.btnCheckAllClick(Sender: TObject);
begin
 TraverseTree(tvTestTree,
  procedure(const aNode: TTreeViewItem)
  begin
   assert(aNode <> nil);
   aNode.IsChecked := True;
  end)
end;

procedure TfmGUITestRunner.btnDelEtalonClick(Sender: TObject);
begin
 TraverseTree(tvTestTree,
  procedure(const aNode: TTreeViewItem)
  var
   l_Test : ImsEtalonsHolder;
  begin
   assert(aNode <> nil);
   l_Test := ImsEtalonsHolder(NodeToTest(aNode));
   if Supports(l_Test, ImsEtalonsHolder) then
   begin
    l_Test.DeleteEtalonFile;
    aNode.IsChecked := False;
   end;
  end)
end;

procedure TfmGUITestRunner.btnUncheckAllClick(Sender: TObject);
begin
 TraverseTree(tvTestTree,
  procedure(const aNode: TTreeViewItem)
  begin
   assert(aNode <> nil);
   aNode.IsChecked := False;
  end)
end;

procedure TfmGUITestRunner.btRunAllTestClick(Sender: TObject);
begin
 if Suite = nil then
  Exit;

 ClearResult;
 RunTheTest(Suite);
end;

procedure TfmGUITestRunner.TraverseTree(const aTree: TTreeView; aLambda: TDoSomethingWithNode);

 procedure TraverseNode(const aNode: TTreeViewItem);
 var
  l_Index: Integer;
 begin
  for l_Index := 0 to Pred(aNode.Count) do
   TraverseNode(aNode.Items[l_Index]);
  aLambda(aNode);
 end;

var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(aTree.Count) do
  TraverseNode(aTree.Items[l_Index]);
end;

procedure TfmGUITestRunner.ClearResult;
begin
 lvFailureListView.ClearItems;
 f_Runned := 0;
 TraverseTree(tvTestTree,
  procedure(const aNode: TTreeViewItem)
  begin
   SetTreeNodeFont(aNode, TAlphaColorRec.Black)
  end)
end;

procedure TfmGUITestRunner.EndTest(test: ITest);
   function FormatElapsedTime(milli: Int64):string;
   var
     h,nn,ss,zzz: Cardinal;
   begin
     h := milli div 3600000;
     milli := milli mod 3600000;
     nn := milli div 60000;
     milli := milli mod 60000;
     ss := milli div 1000;
     milli := milli mod 1000;
     zzz := milli;
     Result := Format('%d:%2.2d:%2.2d.%3.3d', [h, nn, ss, zzz]);
   end;
begin
 // Закомител, потому как тут надо обновлять общую информацию о результатах
 // тестов. А нам пока нечего показывать.
 // И если будет утверждение, то после первого захода сюда, результаты не отображаются
 // Пока, так, однозначно TODO
 lblTimeCount.Text:= FormatElapsedTime (FTestResult.TotalTime);
 lblErrorCount.Text:= IntToStr(FTestResult.ErrorCount);
 lblFailureCount.Text:= IntToStr(FTestResult.FailureCount);
 Inc(f_Runned);
 lblRunned.Text := IntToStr(f_Runned);
 // assert(False);
end;

constructor TTestNode.Create(aParent: TFmxObject; const aTest: ITest);
begin
 inherited Create(aParent);
 IsChecked := True;
 f_Test := aTest;
 Text := aTest.Name;
 aParent.AddObject(Self);
 aTest.GUIObject := Self;
end;

procedure TfmGUITestRunner.FillTestTree(aTest: ITest);

 procedure DoFillTestTree(aRootNode: TTestNode);
 var
  l_TestTests: IInterfaceList;
  l_Index: Integer;
 begin//DoFillTestTree
  l_TestTests := aRootNode.Test.Tests;
  for l_Index := 0 to l_TestTests.Count - 1 do
   DoFillTestTree(TTestNode.Create(aRootNode, (l_TestTests[l_Index] as ITest)));
 end;//DoFillTestTree

begin
 tvTestTree.Clear;

 tvTestTree.BeginUpdate;
 try
  DoFillTestTree(TTestNode.Create(tvTestTree, Suite));
 finally
  tvTestTree.EndUpdate;
 end;//try..finally
end;

procedure TfmGUITestRunner.FormCreate(Sender: TObject);
begin
 inherited;
 tvTestTree.ShowCheckboxes := True;
end;

procedure TfmGUITestRunner.FormDestroy(Sender: TObject);
begin
 Suite := nil;
 inherited;
end;

procedure TfmGUITestRunner.InitTree;
begin
 FillTestTree(Suite);
 tvTestTree.ExpandAll;
end;

function TfmGUITestRunner.NodeToTest(aNode: TTreeViewItem): ITest;
begin
 Result := (aNode As TTestNode).Test;
end;

procedure TfmGUITestRunner.RunTheTest(aTest: ITest);
begin
 TestResult := TTestResult.Create;
 try
  TestResult.addListener(self);
  aTest.run(TestResult);
 finally
  // FErrorCount := TestResult.ErrorCount;
  // FFailureCount := TestResult.FailureCount;
  FreeAndNil(FTestResult);
 end;
end;

procedure TfmGUITestRunner.SetSuite(aValue: ITest);
begin
 FSuite := aValue;

 if FSuite <> nil then
  InitTree;
end;

procedure TfmGUITestRunner.SetTreeNodeFont(aNode: TTreeViewItem; aColor: TAlphaColor);
begin
 // Пока не укажешь какие из настроек стиля разрешены к работе, они работать не будут
 aNode.StyledSettings := aNode.StyledSettings -
{$IF DEFined(VER270) OR DEFined(VER280)} [TStyledSetting.FontColor, TStyledSetting.Style];
{$ENDIF}
{$IFDEF VER260} [TStyledSetting.ssFontColor, TStyledSetting.ssStyle]
 ;
{$ENDIF}
 aNode.Font.Style := [TFontStyle.fsBold];
 aNode.FontColor := aColor;
end;

function TfmGUITestRunner.ShouldRunTest(aTest: ITest): Boolean;
var
 l_Test: ITest;
begin
 l_Test := aTest;
 Result := l_Test.Enabled
end;

procedure TfmGUITestRunner.StartTest(aTest: ITest);
var
 l_Node: TTreeViewItem;
begin
 assert(assigned(TestResult));
 assert(assigned(aTest));

 l_Node := TestToNode(aTest);

 assert(assigned(l_Node));
end;

procedure TfmGUITestRunner.Status(aTest: ITest; const aMessage: string);
begin
 assert(False);
end;

procedure TfmGUITestRunner.TestingEnds(aTestResult: TTestResult);
begin
end;

procedure TfmGUITestRunner.TestingStarts;
begin
end;

function TfmGUITestRunner.TestToNode(test: ITest): TTreeViewItem;
begin
 assert(assigned(test));

 Result := test.GUIObject as TTreeViewItem;

 assert(assigned(Result));
end;

procedure TfmGUITestRunner.tvTestTreeChangeCheck(Sender: TObject);
begin
 SetNodeEnabled(Sender as TTreeViewItem, (Sender as TTreeViewItem).IsChecked);
end;

procedure TfmGUITestRunner.SetNodeEnabled(aNode: TTreeViewItem; aValue: Boolean);
var
 l_Test: ITest;
begin
 l_Test := NodeToTest(aNode);
 if l_Test <> nil then
  l_Test.Enabled := aValue;
end;

end.
