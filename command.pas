program pro;
uses
  crt,
  Windows,
  ShellApi;
var
  f:text;
  lat,long,ch:string;

  procedure createdatabase;
var
  comand: AnsiString;
  si: STARTUPINFOA;
  pi: PROCESS_INFORMATION;
begin
  comand :='C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=http://127.0.0.1/a.html';//change the path of your script a.hml

  ZeroMemory(@si, sizeof(si));
  si.cb := sizeof(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_HIDE;

  if CreateProcessA(nil, PAnsiChar(comand), nil, nil, False, 0, nil, nil, @si, @pi) then
  begin
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);

  end else
  begin
    // error handling, use GetLastError() to find out why CreateProcess() failed...
  end;
end;
procedure lire(var f:text;var ch,lat,long:string);
var
  i:integer;
  var a:string;
  begin
reset(f);
while not (eof(f))do
begin
readln(f,ch);
end;
for i:=1 to pos(' ',ch) do
begin
long:=long+ch[i];
end;
for i:=(pos(' ',ch)+1) to length(ch) do
begin

lat:=lat+ch[i];
end;
end;
procedure googlemap(lat,long:string);
var
    comand: AnsiString;
    si: STARTUPINFOA;
    pi: PROCESS_INFORMATION;
  begin
    comand :='C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=https://www.google.com/maps/@'+lat+','+long;

    ZeroMemory(@si, sizeof(si));
    si.cb := sizeof(si);
    si.dwFlags := STARTF_USESHOWWINDOW;
    si.wShowWindow := SW_HIDE;

    if CreateProcessA(nil, PAnsiChar(comand), nil, nil, False, 0, nil, nil, @si, @pi) then
    begin
      WaitForSingleObject(pi.hProcess, INFINITE);
      CloseHandle(pi.hThread);
      CloseHandle(pi.hProcess);

    end else
    begin
      // error handling, use GetLastError() to find out why CreateProcess() failed...
    end;
  end;


begin
  assign(f,'C:\test1.txt'); //change the source of your file.txt
  createdatabase;
  lire(f,ch,lat,long);
  googlemap(lat,long);
close(f);
end.