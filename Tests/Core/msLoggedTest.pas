﻿unit msLoggedTest;

interface

uses
 TestFramework,
 msCoreObjects,
 FMX.DUnit.Interfaces
 ;

type
  TmsLoggedTest = class abstract(TTestCase, ImsEtalonsHolder)
  protected
   procedure OutToFileAndCheck(aLambda: TmsLogLambda);
   function MakeFileName(const aTestName: string; const aTestFolder: string): String;
   function ContextName: String; virtual;
   procedure CheckFileWithEtalon(const aFileName: String);
   function InnerFolders: String; virtual;
   function TestResultsFileName: String;
   function FileExtension: String; virtual;

   // ImsEtalonsHolder
   procedure DeleteEtalonFile;
   procedure RunDiff;
  public
   class function ComputerName: AnsiString;
  end;//TmsLoggedTest

implementation

uses
 SysUtils,
 msStreamUtils,
 Windows,
 ShellAPI
 ;

// TmsLoggedTest

function TmsLoggedTest.FileExtension: String;
begin
 Result := '';
end;

function TmsLoggedTest.MakeFileName(const aTestName: string; const aTestFolder: string): String;
var
 l_Folder : String;
begin
 l_Folder := ExtractFilePath(ParamStr(0)) + 'TestResults\' + aTestFolder;
 ForceDirectories(l_Folder);
 Result := l_Folder + ClassName + '_' + aTestName + ContextName + FileExtension;
end;

function TmsLoggedTest.ContextName: String;
begin
 Result := '';
end;

procedure TmsLoggedTest.DeleteEtalonFile;
var
 l_FileName: string;
begin
 l_FileName:= TestResultsFileName + '.etalon' + FileExtension;
 DeleteFile(PWideChar(l_FileName));
end;


procedure TmsLoggedTest.CheckFileWithEtalon(const aFileName: String);
var
 l_FileNameEtalon : String;
begin
 l_FileNameEtalon := aFileName + '.etalon' + ExtractFileExt(aFileName);
 if FileExists(l_FileNameEtalon) then
 begin
  CheckTrue(msCompareFiles(l_FileNameEtalon, aFileName));
 end//FileExists(l_FileNameEtalon)
 else
 begin
  CopyFile(PWideChar(aFileName),PWideChar(l_FileNameEtalon),True);
 end;//FileExists(l_FileNameEtalon)
end;

function TmsLoggedTest.TestResultsFileName: String;
begin
 Result := MakeFileName(Name, InnerFolders);
end;

function TmsLoggedTest.InnerFolders: String;
begin
 Result := '';
end;

procedure TmsLoggedTest.OutToFileAndCheck(aLambda: TmsLogLambda);
var
 l_FileNameTest : String;
begin
 l_FileNameTest := TestResultsFileName;
 TmsLog.Log(l_FileNameTest,
  procedure (aLog: TmsLog)
  begin
   aLambda(aLog);
  end
 );
 CheckFileWithEtalon(l_FileNameTest);
end;

procedure TmsLoggedTest.RunDiff;
const
 c_cmdFileName = 'diff.cmd';
var
 l_cmdFileName,
 l_TestFileName,
 l_EtalonFileName,
 l_Directory : string;
 l_ExecInfo: TShellExecuteInfo;
begin
{ TODO 1 -oIngword -cProposal : Добавить вывод ошибок в лог }
 l_cmdFileName := ExtractFilePath(ParamStr(0)) +
                  Self.ComputerName + '_' +
                  c_cmdFileName;

 if not FileExists(l_cmdFileName) then
  l_cmdFileName := ExtractFilePath(ParamStr(0)) + c_cmdFileName;

 Assert(FileExists(l_cmdFileName));

 l_TestFileName:= TestResultsFileName;
 l_EtalonFileName:= TestResultsFileName + '.etalon' + FileExtension;

 FillChar(l_ExecInfo, SizeOf(l_ExecInfo), 0);
 l_ExecInfo.cbSize := SizeOf(l_ExecInfo);
 l_ExecInfo.Wnd := 0;
 l_ExecInfo.lpVerb := PWideChar('');
 l_ExecInfo.lpFile := PChar(l_cmdFileName);
 l_ExecInfo.lpParameters := PWideChar(' ' + l_TestFileName + ' ' + l_EtalonFileName);
 l_ExecInfo.nShow := 1;

 if not ShellExecuteEx(@l_ExecInfo) then
  RaiseLastOSError;
end;

class function TmsLoggedTest.ComputerName: AnsiString;
//#UC START# *4CA45DD902BD_4B2A11BC0255_var*
var
 l_CompSize : Integer;
//#UC END# *4CA45DD902BD_4B2A11BC0255_var*
begin
//#UC START# *4CA45DD902BD_4B2A11BC0255_impl*
 l_CompSize := MAX_COMPUTERNAME_LENGTH + 1;
 SetLength(Result, l_CompSize);

 Win32Check(GetComputerNameA(PAnsiChar(Result), LongWord(l_CompSize)));
 SetLength(Result, l_CompSize);
//#UC END# *4CA45DD902BD_4B2A11BC0255_impl*
end;//TBaseTest.ComputerName

end.
