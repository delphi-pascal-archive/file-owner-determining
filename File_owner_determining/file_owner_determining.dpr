program file_owner_determining;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  aclAPI,
  accCtrl;

var
  fic: LPSTR = 'toto';
  ssd: DWORD = 0;
  psd: PSECURITY_DESCRIPTOR = nil;
  sid: PSID = nil;
  pFlag: BOOL = False;
  saccount: DWORD = 0;
  account: LPSTR = nil;
  sdomain: DWORD = 0;
  domain: LPSTR = nil;
  snu: SID_NAME_USE;
  s: string;
begin
  if ParamCount > 0 then
    fic := PChar(ParamStr(1));

  GetFileSecurity(fic, OWNER_SECURITY_INFORMATION, nil, 0, ssd);
  psd := Pointer(GlobalAlloc(GMEM_FIXED, ssd));
  GetFileSecurity(fic, OWNER_SECURITY_INFORMATION, psd, ssd, ssd);
  GetSecurityDescriptorOwner(psd, sid, pFlag);
  LookupAccountSid(nil, sid, account, saccount, domain, sdomain, snu);
  account := Pointer(GlobalAlloc(GMEM_FIXED, saccount));
  domain := Pointer(GlobalAlloc(GMEM_FIXED, sdomain));
  LookupAccountSid(nil, sid, account, saccount, domain, sdomain, snu);

  Write(Format('File : [%s]'#13#10, [fic]));
  Write(Format('Owner : [%s]'#13#10, [account]));
  Write(Format('Domain : [%s]'#13#10, [domain]));
  Readln(s);
end.
