Codeunit 85044 "DSL Biometrics"

{
    /*
        trigger OnRun()
        begin
        end;

        var
            BioLastLogin: Record "HR Appointment Checklist";
            Cust: Record Customer;

            procedure GetAttendance()

        var
            ADOStream:automation ;
            ADORecordSet: Automation ;
            ADConn: Automation ;
            ADComm: Automation ;
            ConStr: Text[200];
            AttEntries: Record "Biometrics Entries";
            AttEntries2: Record "Biometrics Entries";
            CDate: DateTime;
            RecCount: Integer;
        begin
            Create(ADOStream,false,true);
            Create(ADORecordSet,false,true);
            Create(ADComm,false,true);
            Create(ADConn,false,true);

            //ConStr:='DSN=KOHA1;Uid=root;Pwd=ariel;';
            //ConStr:='Driver={SQL Server};Server=pd0sdb0;Database=BIO;Uid=sa;Pwd=dsl@2018;';
            ConStr:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Program Files\Att\att2000.mdb;Persist Security Info=False;';
            ADConn.ConnectionString(ConStr);

            ADConn.Open;
            ADComm.ActiveConnection:=ADConn;
            ADComm.CommandText:='Select [CHECKINOUT].[USERID],[USERINFO].[SSN],[USERINFO].[Name],[CHECKINOUT].[CHECKTIME],[CHECKINOUT].[CHECKTYPE] FROM [dbo].[CHECKINOUT]INNER JOIN [dbo].[USERINFO] ON [dbo].[USERINFO].USERID =dbo.[CHECKINOUT].[USERID] ';
            ADComm.CommandType := 1;
            ADComm.CommandTimeout := 0;
            ADComm.Execute;

            ADORecordSet.ActiveConnection := ADConn;
            ADORecordSet.CursorLocation:=3;
            ADORecordSet.Open(ADComm);
            //If ADORecordSet.RecordCount<>0 Then begin
              ADORecordSet.MoveFirst;
              repeat
                 if ADORecordSet.EOF=false then begin
                 AttEntries2.Reset;
                 AttEntries2.SetRange(AttEntries2."User No",Format(ADORecordSet.Fields.Item(0).Value));
                 AttEntries2.SetRange(AttEntries2.CheckTime,ADORecordSet.Fields.Item(3).Value);
                 AttEntries2.SetRange(AttEntries2.Type,Format(ADORecordSet.Fields.Item(4).Value));
                 if not AttEntries2.Find('-') then begin
                 RecCount:=RecCount+1;

                 AttEntries.Init;
                AttEntries."Line No":=RecCount;
                 AttEntries."User No":=Format(ADORecordSet.Fields.Item(0).Value);
                 AttEntries.SSN:=Format(ADORecordSet.Fields.Item(1).Value);
                 AttEntries.Name:=Format(ADORecordSet.Fields.Item(2).Value);
                // AttEntries.CheckTime:=EVALUATE(COPYSTR(FORMAT(ADORecordSet.Fields.Item(4).Value),9,2),+'-'+COPYSTR(FORMAT(ADORecordSet.Fields.Item(4).Value),6,2),+'-'+COPYSTR(FORMAT(ADORecordSet.Fields.Item(4).Value),1,4)));
                 if Evaluate(CDate,CopyStr(Format(ADORecordSet.Fields.Item(3).Value),1,2)+'-'+CopyStr(Format(ADORecordSet.Fields.Item(3).Value),4,2)+'-'+CopyStr(Format(ADORecordSet.Fields.Item(3).Value),6,4)) then
                  // +' '+COPYSTR(FORMAT(ADORecordSet.Fields.Item(3).Value),8,2)+':'+COPYSTR(FORMAT(ADORecordSet.Fields.Item(3).Value),10,2)+':'+COPYSTR(FORMAT(ADORecordSet.Fields.Item(3).Value),12,2)) THEN
                 AttEntries.CheckTime:=CDate;
                 AttEntries."Date Str":= Format(ADORecordSet.Fields.Item(3).Value) ;
                 AttEntries.Insert;
                 end;
                 ADORecordSet.MoveNext;
                 end;
                 until ADORecordSet.EOF=true;
             // END;
             // END;
            //MESSAGE(FORMAT(RecCount)+' Records have been updated');

            Clear(ADOStream);
            ADORecordSet.Close;

            ADConn.Close;
            Clear(ADComm);
            Clear(ADConn);
            Clear(ADORecordSet);
        end;

            procedure GetUSERID(StudNo: Code[20]) UserNo: Integer

        var
            ADOStream: Automation ;
            ADORecordSet: Automation ;
            ADConn: Automation ;
            ADComm: Automation ;
            ConStr: Text[200];
            AttEntries: Record "Biometrics Entries";
            AttEntries2: Record "Biometrics Entries";
            CDate: DateTime;
            RecCount: Integer;
        begin

            Create(ADOStream,false,true);
            Create(ADORecordSet,false,true);
            Create(ADComm,false,true);
            Create(ADConn,false,true);

            //ConStr:='DSN=KOHA1;Uid=root;Pwd=ariel;';
            ConStr:='Driver={SQL Server};Server=SIMBA;Database=BIO;Uid=bio;';
            //ConStr:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Program Files\Att\att2000.mdb;Persist Security Info=False;';
            //ConStr:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=E:\DBS\att2000.mdb;';

            //ADComm.CommandText:='Select [CHECKINOUT].[USERID],[USERINFO].[SSN],[USERINFO].[Name],[CHECKINOUT].[CHECKTIME],[CHECKINOUT].[CHECKTYPE] FROM [dbo].[CHECKINOUT]INNER JOIN [dbo].[USERINFO] ON [dbo].[USERINFO].USERID =dbo.[CHECKINOUT].[USERID] ';

            ADConn.ConnectionString(ConStr);
            ADConn.Open;

            ADComm.ActiveConnection:=ADConn;
            ADComm.CommandText:='Select USERID FROM [USERINFO] where [SSN] ='''+StudNo+'''';
            //ADComm.CommandText:='Select USERID FROM [USERINFO] where [SSN] ='+'''ACTS/M/0147/01/16''';
            ADComm.CommandType := 1;
            ADComm.CommandTimeout := 0;
            ADComm.Execute;

            ADORecordSet.ActiveConnection := ADConn;
            ADORecordSet.CursorLocation:=3;
            ADORecordSet.Open(ADComm);
            //If ADORecordSet.RecordCount<>0 Then begin
             // ADORecordSet.MoveFirst;
             // REPEAT
                 if ADORecordSet.EOF=false then begin
                 UserNo:=ADORecordSet.Fields.Item(0).Value;
                 end;

            Clear(ADOStream);
            ADORecordSet.Close;

            ADConn.Close;
            Clear(ADComm);
            Clear(ADConn);
            Clear(ADORecordSet);
        end;

            procedure CheckBioEntries(UserNo: Integer;StudNo: Code[20]) BioExist: Boolean

        var
            ADOStream: Automation ;
            ADORecordSet: Automation ;
            ADConn: Automation ;
            ADComm: Automation ;
            ConStr: Text[200];
            AttEntries: Record "Biometrics Entries";
            AttEntries2: Record "Biometrics Entries";
            CDate: DateTime;
            RecCount: Integer;
            BioLastLogin: Record "HR Appointment Checklist";
            LastLog: DateTime;
            TimeDiff: Duration;
        begin

            Create(ADOStream,false,true);
            Create(ADORecordSet,false,true);
            Create(ADComm,false,true);
            Create(ADConn,false,true);

            //ConStr:='DSN=KOHA1;Uid=root;Pwd=ariel;';
            //ConStr:='Driver={SQL Server};Server=pd0sdb0;Database=BIO;Uid=sa;Pwd=dsl@2018;';
            ConStr:='Driver={SQL Server};Server=SIMBA;Database=BIO;Uid=bio;';
            //ConStr:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=E:\DBS\att2000.mdb;';

            ADConn.ConnectionString(ConStr);
              //[CHECKTYPE]='+'''I'''+' and
            ADConn.Open;
            ADComm.ActiveConnection:=ADConn;
            ADComm.CommandText:='Select [USERID],[CHECKTIME] FROM [CHECKINOUT] where [USERID]='+Format(UserNo) ;
            ADComm.CommandType := 1;
            ADComm.CommandTimeout := 0;
            ADComm.Execute;

            ADORecordSet.ActiveConnection := ADConn;
            ADORecordSet.CursorLocation:=3;
            ADORecordSet.Open(ADComm);
            if ADORecordSet.EOF=false then
              ADORecordSet.MoveFirst;
            //  REPEAT
              if ADORecordSet.EOF=false then begin

              LastLog:=ADORecordSet.Fields.Item(1).Value ;
               TimeDiff:=(LastLog-CurrentDatetime);
                 BioExist:=true;
            /*
             IF NOT BioLastLogin.GET(StudNo,FORMAT(LastLog)) THEN BEGIN
              BioLastLogin.INIT;
              BioLastLogin.No:=StudNo;
              BioLastLogin."Last Login":=FORMAT(LastLog);
              BioLastLogin.INSERT;
            //  BioExist:=TRUE;
            END;

            //ADORecordSet.MoveNext;
            end;

            //END;
            //UNTIL ADORecordSet.EOF=TRUE;

            //ADConn.Close;
            //CLEAR(ADComm);

            //ADConn.Open;
            //ADComm.ActiveConnection:=ADConn;
            //ADComm.CommandText:='UPDATE [CHECKINOUT] set [CHECKTYPE]='+'''O'''+' where [USERID]='+FORMAT(UserNo);
            ADComm.CommandText:='Delete from [CHECKINOUT]  where [USERID]='+Format(UserNo);

            ADComm.CommandType := 1;
            ADComm.CommandTimeout := 0;
            ADComm.Execute;

            Clear(ADOStream);
            ADORecordSet.Close;

            ADConn.Close;
            Clear(ADComm);
            Clear(ADConn);
            Clear(ADORecordSet);
        end;

            procedure ValidateBio(StudNo: Code[20]) IsValid: Boolean
        var
            UsrNo: Integer;
        begin
            UsrNo:=GetUSERID(StudNo);
            if  UsrNo<>0 then begin

            if CheckBioEntries(UsrNo,StudNo)=true then
            IsValid:=true;
            end;
        end;

            procedure UpdateStudents(CustNo: Code[20])
        var
            ADOStream: Automation ;
            ADORecordSet: Automation ;
            ADConn: Automation ;
            ADComm: Automation ;
            ConStr: Text[200];
            CDate: DateTime;
            RecCount: Integer;
            CustR: Record Customer;
            SN: Integer;
            GenSetup: Record "General Set-Up";
            Dept: Code[20];
            Names: Text[200];
        begin
            Create(ADOStream,false,true);
            Create(ADORecordSet,false,true);
            Create(ADComm,false,true);
            Create(ADConn,false,true);

            GenSetup.Get;
            SN:=GenSetup."Last Bio No";

            //ConStr:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Program Files (x86)\ZKTeco\ZKTeco\att2000.mdb;Persist Security Info=False;';
            ConStr:='Driver={SQL Server};Server=MOI-DS;Database=BIO;Uid=bio;';
            //ConStr:='Provider=Microsoft.ACE.OLEDB.12.0;Data Source=E:\DBS\att2000.mdb;';
            ADConn.ConnectionString(ConStr);

               ADConn.Open;
               ADComm.ActiveConnection:=ADConn;

            CustR.Reset;
            CustR.SetRange(CustR."No.",CustNo);
            CustR.SetRange(CustR."Post to Biometric",false);
            CustR.SetFilter(CustR.Status,'%1|%2',CustR.Status::Current,CustR.Status::Registration);
            CustR.SetFilter(CustR."Global Dimension 1 Code",'<>%1','');
            if CustR.Find('-') then begin
               repeat
                if CustR."Global Dimension 1 Code"='11' then Dept:='3';
                if CustR."Global Dimension 1 Code"='19' then Dept:='4';
                if CustR."Global Dimension 1 Code"='14' then Dept:='5';
                if CustR."Global Dimension 1 Code"='13' then Dept:='6';
                if CustR."Global Dimension 1 Code"='15' then Dept:='8';

               SN:=SN+1;
               Names:=ReplaceString(CustR.Name,'''','');
               ADComm.CommandText:='Insert into [USERINFO] (Badgenumber,SSN,Name,DEFAULTDEPTID) Values ('''+Format(SN)+''''+','+''''+CustR."No."+''''+','+''''+Names+''''+','+''''+Dept+'''' +')';
               ADComm.CommandType := 1;
               ADComm.CommandTimeout := 0;
               ADComm.Execute;

            CustR."In Campus":=true;
            CustR.Modify;
            until CustR.Next=0;
            end;

            GenSetup."Last Bio No":=SN;
            GenSetup.Modify;
             // END;
             // END;
            //MESSAGE(FORMAT(RecCount)+' Records have been updated');

            Clear(ADOStream);
            //ADORecordSet.Close;

            ADConn.Close;
            Clear(ADComm);
            Clear(ADConn);
            //CLEAR(ADORecordSet);
        end;

        local procedure ReplaceString(String: Text[200];FindWhat: Text[200];ReplaceWith: Text[200]) NewString: Text[200]
        begin

            while StrPos(String,FindWhat) > 0 do
              String := DelStr(String,StrPos(String,FindWhat)) + ReplaceWith + CopyStr(String,StrPos(String,FindWhat) + StrLen(FindWhat));
            NewString := String;
        end;

            procedure PushToDevice(StudentNo: Code[20];BiometricDevice: Code[20];Name: Text[250]) results: Text[200]
        var
            RESTWSManagement: Codeunit UnknownCodeunit50000;
            stringContent: dotnet StringContent;
            httpUtility: dotnet HttpUtility;
            encoding: dotnet Encoding;
            result: dotnet String;
            resultParts: dotnet Array;
            separator: dotnet String;
            HttpResponseMessage: dotnet HttpResponseMessage;
            JsonConvert: dotnet JsonConvert;
            null: dotnet Object;
            Window: Dialog;
            data: Text;
            statusCode: Text;
            statusText: Text;
        begin
            Window.Open('Exporting...');

            data += 'studentnumber='  + httpUtility.UrlEncode(StudentNo,encoding.GetEncoding('ISO-8859-1'));
            data += '&name='   + httpUtility.UrlEncode(Name,encoding.GetEncoding('ISO-8859-1'));
            data += '&ip='   + httpUtility.UrlEncode(BiometricDevice,encoding.GetEncoding('ISO-8859-1'));

            stringContent := stringContent.StringContent(data,encoding.UTF8,'application/x-www-form-urlencoded');

            RESTWSManagement.CallRESTWebService('http://localhost:1881/',
                                                               'dsl/bio/enroll.php',
                                                               'POST',
                                                               stringContent,
                                                               HttpResponseMessage);
            Window.Close;

            results := HttpResponseMessage.Content.ReadAsStringAsync.Result;
            //MESSAGE(result);
        end;

            procedure GetFingerPrint(StudentNo: Code[20];BiometricDevice: Code[20])
        var
            RESTWSManagement: Codeunit UnknownCodeunit50000;
            stringContent: dotnet StringContent;
            httpUtility: dotnet HttpUtility;
            encoding: dotnet Encoding;
            result: dotnet String;
            resultParts: dotnet Array;
            separator: dotnet String;
            HttpResponseMessage: dotnet HttpResponseMessage;
            JsonConvert: dotnet JsonConvert;
            null: dotnet Object;
            Window: Dialog;
            data: Text;
            statusCode: Text;
            statusText: Text;
        begin
            Window.Open('Importing...');

            data += 'studentnumber='  + httpUtility.UrlEncode(StudentNo,encoding.GetEncoding('ISO-8859-1'));
            data += '&ip='   + httpUtility.UrlEncode(BiometricDevice,encoding.GetEncoding('ISO-8859-1'));

            stringContent := stringContent.StringContent(data,encoding.UTF8,'application/x-www-form-urlencoded');

            RESTWSManagement.CallRESTWebService('http://localhost:6140/NavBio.asmx/',
                                                               'GetFingerprint?'+data,
                                                               'POST',
                                                               stringContent,
                                                               HttpResponseMessage);
            Window.Close;

            result := HttpResponseMessage.Content.ReadAsStringAsync.Result;
            Message(result);
        end;

            procedure SetFingerPrint(StudentNumber: Code[20];BioUserID: Code[20];Picture: BigText;FingerIndex: Code[10]) return_value: Boolean
        var
            Item: Record Customer;
            Bytes: dotnet Array;
            Convert: dotnet Convert;
            MemoryStream: dotnet MemoryStream;
            Ostream: OutStream;
        begin
              return_value:=false;
              Item.Get(StudentNumber);
              Bytes:=Convert.FromBase64String(Picture);
              MemoryStream := MemoryStream.MemoryStream(Bytes);
              Item.Fingerprint.CreateOutstream(Ostream);
              MemoryStream.WriteTo(Ostream);
              Item."Biometric Username":=BioUserID;
              Item."Fingerprint Index":=FingerIndex;
              Item."Get Bio From Device":=false;
              Item.Modify;
              //Item.CALCFIELDS(Picture);
              return_value:=true;
        end;
        */
}
