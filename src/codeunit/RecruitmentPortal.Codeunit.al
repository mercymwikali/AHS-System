Codeunit 85039 RecruitmentPortal
{
    Permissions = TableData "Approval Entry" = imd,
                  TableData "Approval Comment Line" = imd,
                  TableData "Posted Approval Entry" = imd,
                  TableData "Posted Approval Comment Line" = imd,
                  TableData "Overdue Approval Entry" = imd;

    trigger OnRun()
    begin
    end;

    var
        AppRegister: Record "Applicant Register";
        HRJobApplications: Record Applicants;
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        objHRJobApplicants: Record "HR Job Applicants";
        NoSeriesMgt: Codeunit "No. Series";

    procedure HRJobApplicantCreate("User Name": Text)
    begin
        objHRJobApplicants.Init();
        objHRJobApplicants."User Name" := "User Name";
        objHRJobApplicants.Insert();
    end;

    procedure HRJobApplicantUpdate(UserName: Text; FirstName: Text; MiddleName: Text; LastName: Text; Initials: Text; IdNumber: Text; Gender: Integer; MaritalStatus: Integer; Age: Text; EthinicGroup: Text)
    begin
        objHRJobApplicants.Reset();
        objHRJobApplicants.SetRange(objHRJobApplicants."User Name", UserName);

        if objHRJobApplicants.Find('-') then begin
            objHRJobApplicants."First Name" := FirstName;
            objHRJobApplicants."Middle Name" := MiddleName;
            objHRJobApplicants."Last Name" := LastName;
            objHRJobApplicants.Initials := Initials;
            objHRJobApplicants."ID Number" := IdNumber;
            objHRJobApplicants.Gender := Gender;
            objHRJobApplicants."Marital Status" := MaritalStatus;
            //objHRJobApplicants."Ethnic Origin":=EthinicGroup;
            objHRJobApplicants.Age := Age;

            objHRJobApplicants.Modify();
        end;
    end;

    procedure HRJobApplicantUpdateContact("User Name": Text; "Postal Address": Text; "Residential Address": Text; City: Text; County: Text; "Home Phone Number": Text; "Cell Phone Number": Text; "Work Phone Number": Text; "E-Mail": Text; "Country Code": Text; "Fax Number": Text)
    begin
        objHRJobApplicants.Reset();
        objHRJobApplicants.SetRange(objHRJobApplicants."User Name", "User Name");

        if objHRJobApplicants.Find('-') then begin
            objHRJobApplicants."Postal Address" := "Postal Address";
            objHRJobApplicants."Residential Address" := "Residential Address";
            objHRJobApplicants.City := City;
            objHRJobApplicants.County := County;
            objHRJobApplicants."Home Phone Number" := "Home Phone Number";
            objHRJobApplicants."Cell Phone Number" := "Cell Phone Number";
            objHRJobApplicants."Work Phone Number" := "Work Phone Number";
            objHRJobApplicants."E-Mail" := "E-Mail";
            objHRJobApplicants."Country Code" := "Country Code";
            objHRJobApplicants."Fax Number" := "Fax Number";

            objHRJobApplicants.Modify();
        end;
    end;

    procedure HRJobApplication("User Name": Text; "Job Id": Text; JobApplicationNo: Code[30])
    var
        NextApplicationNo: Code[20];
    begin
        HRJobApplications.Reset();

        HRJobApplications.SetRange(HRJobApplications."User Name", "User Name");
        HRJobApplications.SetRange(HRJobApplications."Job Applied For", "Job Id");
        if HRJobApplications.Find('-') then
            Error('Sorry. You have already applied for this job');

        HRJobApplications.Init();
        HRJobApplications."Job Applied For" := "Job Id";
        HRJobApplications."User Name" := "User Name";
        NextApplicationNo := NoSeriesMgt.GetNextNo('JOBAPP', 0D, true);
        HRJobApplications."Application No" := NextApplicationNo;
        HRJobApplications."Date Applied" := Today;
        objHRJobApplicants.Reset();
        if objHRJobApplicants.Find('-') then begin
            HRJobApplications."First Name" := objHRJobApplicants."First Name";
            HRJobApplications."Middle Name" := objHRJobApplicants."Middle Name";
            HRJobApplications."Last Name" := objHRJobApplicants."Last Name";
            HRJobApplications.Initials := objHRJobApplicants.Initials;
            HRJobApplications."ID Number" := objHRJobApplicants."ID Number";
            HRJobApplications.Gender := objHRJobApplicants.Gender;
            HRJobApplications."Marital Status" := objHRJobApplicants."Marital Status";
            HRJobApplications."Ethnic Origin" := objHRJobApplicants."Ethnic Origin";
            HRJobApplications.Age := objHRJobApplicants.Age;

            HRJobApplications."Postal Address" := objHRJobApplicants."Postal Address";
            HRJobApplications."Residential Address" := objHRJobApplicants."Residential Address";
            HRJobApplications.City := objHRJobApplicants.City;
            HRJobApplications.County := objHRJobApplicants.County;
            HRJobApplications."Home Phone Number" := objHRJobApplicants."Home Phone Number";
            HRJobApplications."Cell Phone Number" := objHRJobApplicants."Cell Phone Number";
            HRJobApplications."Work Phone Number" := objHRJobApplicants."Work Phone Number";
            HRJobApplications."E-Mail" := objHRJobApplicants."E-Mail";
            HRJobApplications."Country Code" := objHRJobApplicants."Country Code";
            HRJobApplications."Fax Number" := objHRJobApplicants."Fax Number";
            HRJobApplications.Insert();
        end;
    end;

    procedure HRJobApplicantUpdateCom("User Name": Text; FirstLanguage: Code[20]; FirstLangRead: Boolean; FirstLangWrite: Boolean; FirstLangSpeak: Boolean; SecondLang: Code[20]; SecondLangRead: Boolean; SecondLangWrite: Boolean; SecondLangSpeak: Boolean)
    begin
        objHRJobApplicants.Reset();
        objHRJobApplicants.SetRange(objHRJobApplicants."User Name", "User Name");

        if objHRJobApplicants.Find('-') then begin
            objHRJobApplicants."First Language (R/W/S)" := FirstLanguage;
            objHRJobApplicants."First Language Read" := FirstLangRead;
            objHRJobApplicants."First Language Write" := FirstLangWrite;
            objHRJobApplicants."First Language Speak" := FirstLangSpeak;
            objHRJobApplicants."Second Language (R/W/S)" := SecondLang;
            objHRJobApplicants."Second Language Read" := SecondLangRead;
            objHRJobApplicants."Second Language Write" := SecondLangWrite;
            objHRJobApplicants."Second Language Speak" := SecondLangSpeak;
            objHRJobApplicants.Modify();
        end;
    end;

    procedure SendEmail(var receiver: Text[30]; subject: Text[50]; message: Text[500]) returnValue: Boolean
    var
        SMTPMailSetup: Record "Email Account";
        SMail: Codeunit "Email";
        SMTPMail: Codeunit "Email Message";
    begin
        returnValue := false;
        SMTPMailSetup.Get();
        SMTPMail.Create(receiver, subject, message);
        //('University', SMTPMailSetup."User ID", receiver, subject, message, false);
        SMail.Send(SMTPMail);
        returnValue := true;
    end;

    procedure InsertLinks(studNo: Code[20]; description: Text[200]; url: Text[200]; tableNo: Integer; fieldId: Integer) return_value: Boolean
    var
        RecordLink: Record "Record Link";
        RecordID: RecordID;
        RecordRef1: RecordRef;
        FieldRef: FieldRef;
    begin
        RecordRef1.Open(tableNo);
        FieldRef := RecordRef1.Field(fieldId);
        FieldRef.Value := studNo;
        if RecordRef1.Find('=') then begin
            RecordID := RecordRef1.RecordId;
            RecordLink.Reset();
            RecordLink."Record ID" := RecordID;
            RecordLink.URL1 := url;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := 'JOOUST';
            RecordLink."User ID" := UserId;
            RecordLink.Created := CurrentDatetime;
            RecordLink.Description := description;
            RecordLink.Insert();
        end;
    end;

    procedure PublicationsMandatory(ReqNo: Code[30]) result: Boolean
    var
        HREmployeeRequisitions: Record "HR Employee Requisitions";
    begin
        HREmployeeRequisitions.Reset();
        HREmployeeRequisitions.SetRange("Requisition No.", ReqNo);
        // HREmployeeRequisitions.SetRange("Publications Mandatory",true);
        if HREmployeeRequisitions.Find('-') then
            result := true
        else
            result := false;
    end;

    procedure ApplyForJobApplication(UserName: Text[100]; Email: Text[100]; ReqNo: Text[100]) return: Boolean
    begin
        return := false;
        HRJobApplications.Reset();
        HRJobApplications.SetRange(HRJobApplications."User Name", UserName);
        HRJobApplications.SetRange(HRJobApplications."E-Mail", Email);
        HRJobApplications.SetRange(HRJobApplications."Requisition No", ReqNo);
        if HRJobApplications.Find('-') then begin
            HRJobApplications.Modify();
            return := true;
        end else begin

            HRJobApplications.Init();

            HRJobApplications.Reset();
            if HRJobApplications.FindLast() then
                HRJobApplications."Application No" := IncStr(HRJobApplications."Application No")
            else
                HRJobApplications."Application No" := 'JOBAPP0001';

            HRJobApplications."User Name" := UserName;
            HRJobApplications."E-Mail" := Email;
            HRJobApplications."Requisition No" := ReqNo;
            HRJobApplications."Date Applied" := Today;
            HREmployeeRequisitions.Reset();
            HREmployeeRequisitions.SetRange(HREmployeeRequisitions."Requisition No.", ReqNo);
            if HREmployeeRequisitions.Find('-') then begin
                HRJobApplications."Job Applied For" := HREmployeeRequisitions."Job ID";
                HRJobApplications."Job Applied for Description" := HREmployeeRequisitions."Job Description";
            end;

            AppRegister.Reset();
            AppRegister.SetRange(AppRegister.UserName, UserName);
            AppRegister.SetRange(AppRegister.EmailAddress, Email);
            if AppRegister.Find('-') then begin
                HRJobApplications."ID Number" := AppRegister."ID Number";
                HRJobApplications."First Name" := AppRegister."First Name";
                HRJobApplications."Middle Name" := AppRegister."Middle Name";
                HRJobApplications."Last Name" := AppRegister."Last Name";
                HRJobApplications."Cell Phone Number" := AppRegister."Cell Phone Number";
                HRJobApplications.Gender := AppRegister.Gender;
                HRJobApplications."Date Of Birth" := AppRegister."Date of Birth";
                HRJobApplications."Marital Status" := AppRegister."Marital Status";
            end;
            HRJobApplications.Insert();
            return := true;
        end;
        exit(return);
    end;

    procedure GetNextApplicationNo() txt: Text
    var
        NextAppNo: Code[30];
    begin
        NextAppNo := NoSeriesMgt.GetNextNo('APPLICATIO', 0D, true);
        txt := NextAppNo;
        exit(txt);
    end;

    procedure UpdateApplicantRegisterPassword(EmailAddress: Code[50]; UserName: Code[50]; Password: Text) txt: Boolean
    begin
        txt := false;
        AppRegister.Reset();
        //AppRegister.SETRANGE(AppRegister.EmailAddress, EmailAddress);
        AppRegister.SetRange(AppRegister.UserName, UserName);
        if AppRegister.Find('-') then begin
            AppRegister.Password := Password;
            AppRegister.Modify();
            txt := true;
        end;
        exit(txt);
    end;

    procedure UpdateToApplicantRegister(EmailAddress: Text[100]; UserName: Text[100]; "Activation Code": Text[150]) return: Boolean
    begin
        return := false;
        AppRegister.Reset();
        AppRegister.SetRange(AppRegister.EmailAddress, EmailAddress);
        AppRegister.SetRange(AppRegister.UserName, UserName);
        if AppRegister.Find('-') then begin
            AppRegister."Activation Code" := "Activation Code";
            AppRegister.Modify();
            return := true;
        end;
        exit(return);
    end;

    procedure RegisterApplicantRegister(email: Text[150]; username: Text[150]; password: Text[150]; idno: Text[150]; fname: Text[150]; mname: Text[150]; lname: Text[150]; value: Text[150]) return: Boolean
    begin
        return := false;
        AppRegister.Reset();
        AppRegister.SetRange(AppRegister.EmailAddress, email);
        AppRegister.SetRange(AppRegister.UserName, username);
        if AppRegister.Find('-') then begin
            AppRegister.UserName := username;
            AppRegister.EmailAddress := email;
            AppRegister.Password := password;
            AppRegister."ID Number" := idno;
            AppRegister."First Name" := fname;
            AppRegister."Middle Name" := mname;
            AppRegister."Last Name" := lname;
            AppRegister."Random Value" := value;
            AppRegister.Modify();
            return := true;
        end else begin
            AppRegister.Init();
            AppRegister.UserName := username;
            AppRegister.EmailAddress := email;
            AppRegister.Password := password;
            AppRegister."ID Number" := idno;
            AppRegister."First Name" := fname;
            AppRegister."Middle Name" := mname;
            AppRegister."Last Name" := lname;
            AppRegister."Random Value" := value;
            AppRegister."Activate Account" := false;
            AppRegister.Insert();
            return := true;
        end;
        exit(return);
    end;
}
