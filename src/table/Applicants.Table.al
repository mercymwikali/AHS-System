Table 85360 Applicants
{
    Caption = 'HR Job Applications';

    fields
    {
        field(50000; "Application No"; Code[10])
        {
            trigger OnValidate()
            begin
                //GENERATE NEW NUMBER FOR THE DOCUMENT
                if "Application No" = '' then begin
                    HRSetup.Get();
                    HRSetup.TestField(HRSetup."Job Application Nos");
                    NoSeriesMgt.InitSeries(HRSetup."Job Application Nos", xRec."No. Series", 0D, "Application No", "No. Series");
                end;

                "Date Applied" := Today;
            end;
        }
        field(50001; "First Name"; Text[100])
        {
        }
        field(50002; "Middle Name"; Text[50])
        {
        }
        field(50003; "Last Name"; Text[50])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(50004; Initials; Text[15])
        {
        }
        field(50005; "Search Name"; Code[50])
        {
        }
        field(50006; "Postal Address"; Text[80])
        {
        }
        field(50007; "Residential Address"; Text[80])
        {
        }
        field(50008; City; Text[30])
        {
        }
        field(50009; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50010; County; Text[30])
        {
        }
        field(50011; "Home Phone Number"; Text[30])
        {
        }
        field(50012; "Cell Phone Number"; Text[30])
        {
        }
        field(50013; "Work Phone Number"; Text[30])
        {
        }
        field(50014; "Ext."; Text[7])
        {
        }
        field(50015; "E-Mail"; Text[80])
        {
        }
        field(50016; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(50017; "ID Number"; Text[30])
        {
            trigger OnValidate()
            begin
                HRJobApp.Reset();
                HRJobApp.SetRange(HRJobApp."ID Number", "ID Number");
                if HRJobApp.Find('-') then
                    Error('This ID Number has been used in a prior Job Application.');
            end;
        }
        field(50018; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(50019; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(50020; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(50021; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50022; "Fax Number"; Text[30])
        {
        }
        field(50023; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50024; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(50025; "First Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(50026; "Driving Licence"; Code[10])
        {
        }
        field(50027; Disabled; Boolean)
        {
        }
        field(50028; "Health Assesment?"; Boolean)
        {
        }
        field(50029; "Health Assesment Date"; Date)
        {
        }
        field(50030; "Date Of Birth"; Date)
        {
            trigger OnValidate()
            begin
                if "Date Of Birth" >= Today then
                    Error('Date of Birth cannot be after %1', Today);
            end;
        }
        field(50031; Age; Text[80])
        {
        }
        field(50032; "Second Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(50033; "Additional Language"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(50034; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50035; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(50036; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            begin
            end;
        }
        field(50037; "Postal Address2"; Text[30])
        {
        }
        field(50038; "Postal Address3"; Text[20])
        {
        }
        field(50039; "Residential Address2"; Text[30])
        {
        }
        field(50040; "Residential Address3"; Text[20])
        {
        }
        field(50041; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(50042; Citizenship; Code[10])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                Country.Reset();
                Country.SetRange(Country.Code, Citizenship);
                if Country.Find('-') then
                    "Citizenship Details" := Country.Name;
            end;
        }
        field(50043; "Disabling Details"; Text[50])
        {
        }
        field(50044; "Disability Grade"; Text[30])
        {
        }
        field(50045; "Passport Number"; Text[30])
        {
        }
        field(50046; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50047; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50048; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50049; "First Language Read"; Boolean)
        {
        }
        field(50050; "First Language Write"; Boolean)
        {
        }
        field(50051; "First Language Speak"; Boolean)
        {
        }
        field(50052; "Second Language Read"; Boolean)
        {
        }
        field(50053; "Second Language Write"; Boolean)
        {
        }
        field(50054; "Second Language Speak"; Boolean)
        {
        }
        field(50055; "PIN Number"; Code[20])
        {
        }
        field(50056; "Job Applied For"; Text[30])
        {
            Editable = false;

            trigger OnValidate()
            begin

                Jobs.Reset();
                Jobs.SetRange(Jobs."Job ID", "Job Applied For");
                if Jobs.Find('-') then
                    "Job Applied for Description" := Jobs."Job Description";
            end;
        }
        field(50057; "Total Score"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50058; Shortlist; Boolean)
        {
        }
        field(50059; Qualified; Boolean)
        {
            Editable = false;
        }
        field(50060; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50061; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50062; "Employee No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                //COPY EMPLOYEE DETAILS FROM EMPLOYEE TABLE
                Employee.Reset();
                if Employee.Get("Employee No") then begin
                    "First Name" := Employee."First Name";
                    "Middle Name" := Employee."Middle Name";
                    "Last Name" := Employee."Last Name";
                    "Search Name" := Employee."Search Name";
                    "Postal Address" := Employee."Postal Address";
                    "Residential Address" := Employee."Residential Address";
                    City := Employee.City;
                    "Post Code" := Employee."Post Code";
                    County := Employee.County;
                    "Home Phone Number" := Employee."Home Phone Number";
                    "Cell Phone Number" := Employee."Cellular Phone Number";
                    "Work Phone Number" := Employee."Work Phone Number";
                    "Ext." := Employee."Ext.";
                    "E-Mail" := Employee."E-Mail";
                    "ID Number" := Employee."ID Number";
                    Gender := Employee.Gender;
                    "Country Code" := Employee.Citizenship;
                    "Fax Number" := Employee."Fax Number";
                    "Marital Status" := Employee."Marital Status";
                    "Ethnic Origin" := Employee."Ethnic Origin";
                    "First Language (R/W/S)" := Employee."First Language (R/W/S)";
                    //"Driving Licence":=Employee."Has Driving Licence";
                    Disabled := Employee.Disabled;
                    "Health Assesment?" := Employee."Health Assesment?";
                    "Health Assesment Date" := Employee."Health Assesment Date";
                    "Date Of Birth" := Employee."Date Of Birth";
                    Age := Employee.Age;
                    "Second Language (R/W/S)" := Employee."Second Language (R/W/S)";
                    "Additional Language" := Employee."Additional Language";
                    "Postal Address2" := Employee."Postal Address";
                    "Postal Address3" := Employee."Post Code";
                    "Residential Address2" := Employee."Residential Address";
                    //"Residential Address3":=Employee."Residential Address 3";
                    "Post Code2" := Employee."Post Code";
                    Citizenship := Employee.Citizenship;
                    "Passport Number" := Employee."Passport Number";
                    "First Language Read" := Employee."First Language Read";
                    "First Language Write" := Employee."First Language Write";
                    "First Language Speak" := Employee."First Language Speak";
                    "Second Language Read" := Employee."Second Language Read";
                    "Second Language Write" := Employee."Second Language Write";
                    "Second Language Speak" := Employee."Second Language Speak";
                    "PIN Number" := Employee."PIN Number";

                    "Applicant Type" := "applicant type"::Internal;
                    Modify();

                    //DELETE QUALIFICATIONS PREVIOUSLY COPIED
                    AppQualifications.Reset();
                    AppQualifications.SetRange(AppQualifications."Application No", "Application No");
                    if AppQualifications.Find('-') then
                        AppQualifications.DeleteAll();

                    //GET EMPL0YEE QUALIFICATIONS
                    EmpQualifications.Reset();
                    EmpQualifications.SetRange(EmpQualifications."Employee No.", Employee."No.");
                    if EmpQualifications.Find('-') then
                        EmpQualifications.FindFirst();
                    begin
                        AppQualifications.Reset();

                        repeat
                            AppQualifications.Init();
                            AppQualifications."Application No" := "Application No";
                            AppQualifications."Employee No." := "Employee No";
                            //AppQualifications."Qualification Type":=EmpQualifications."Qualification Type";
                            AppQualifications."Qualification Code" := EmpQualifications."Qualification Code";
                            AppQualifications."Qualification Description" := EmpQualifications."Qualification Description";
                            AppQualifications."From Date" := EmpQualifications."From Date";
                            AppQualifications."To Date" := EmpQualifications."To Date";
                            AppQualifications.Type := EmpQualifications.Type;
                            AppQualifications."Institution/Company" := EmpQualifications."Institution/Company";
                            AppQualifications.Insert();
                        until EmpQualifications.Next() = 0;
                    end
                end;

                /*
                END ELSE BEGIN
                "First Name":='';
                "Middle Name":='';
                "Last Name":='';
                "Search Name":='';
                "Postal Address":='';
                "Residential Address":='';
                City:=Employee.City;
                "Post Code":='';
                County:='';
                "Home Phone Number":='';
                "Cell Phone Number":='';
                "Work Phone Number":='';
                "Ext.":='';
                "E-Mail":='';
                "ID Number":='';

                "Country Code":='';
                "Fax Number":='';

                "First Language (R/W/S)":='';
                //"Driving Licence":=Employee."Has Driving Licence";

                "Health Assesment Date":=0D;
                "Date Of Birth":=0D;
                Age:='';
                "Second Language (R/W/S)":='';
                "Additional Language":='';
                "Postal Address2":='';
                "Postal Address3":='';
                "Residential Address2":='';
                "Residential Address3":='';
                "Post Code2":='';
                Citizenship:='';
                "Passport Number":='';
                "First Language Read":=FALSE;
                "First Language Write":=FALSE;
                "First Language Speak":=FALSE;
                "Second Language Read":=FALSE;
                "Second Language Write":=FALSE;
                "Second Language Speak":=FALSE;
                "PIN Number":='';

                "Applicant Type":="Applicant Type"::External;
                MODIFY;

                //DELETE QUALIFICATIONS PREVIOUSLY COPIED
                AppQualifications.RESET;
                AppQualifications.SETRANGE(AppQualifications."Application No","Application No");
                IF AppQualifications.FIND('-') THEN
                AppQualifications.DELETEALL;

                //DELETE APPLICANT REFEREES
                AppRefferees.RESET;
                AppRefferees.SETRANGE(AppRefferees."Job Application No","Application No");
                IF AppRefferees.FIND('-') THEN
                AppRefferees.DELETEALL;

                //DELETE APPLICANT HOBBIES
                AppHobbies.RESET;
                AppHobbies.SETRANGE(AppHobbies."Job Application No","Application No");
                IF AppHobbies.FIND('-') THEN
                AppHobbies.DELETEALL;
                END;
                */
            end;
        }
        field(50063; "Applicant Type"; Option)
        {
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;
        }
        field(50064; "Interview Invitation Sent"; Boolean)
        {
            Editable = false;
        }
        field(50065; "Date Applied"; Date)
        {
        }
        field(50066; "Citizenship Details"; Text[60])
        {
        }
        field(50067; "Date of Interview"; Date)
        {
        }
        field(50068; "From Time"; Time)
        {
        }
        field(50069; "To Time"; Time)
        {
        }
        field(50070; Venue; Text[30])
        {
        }
        field(50071; "Interview Type"; Option)
        {
            OptionCaption = 'Writen,Practicals,Oral,Oral&Written';
            OptionMembers = Writen,Practicals,Oral,"Oral&Written";
        }
        field(50072; Select; Boolean)
        {
        }
        field(50073; "Job Applied for Description"; Text[100])
        {
        }
        field(50074; "Selection Count"; Integer)
        {
            CalcFormula = count("HR Applicants Shortlist" where("Job Application No" = field("Application No")));
            FieldClass = FlowField;
        }
        field(50075; "Marked For Interview(Stage1)"; Boolean)
        {
        }
        field(50076; "Marked For Interview(Stage2)"; Boolean)
        {
        }
        field(50077; "Qualified To Hire"; Boolean)
        {
        }
        field(50078; "Room No"; Text[30])
        {
        }
        field(50079; Floor; Text[30])
        {
        }
        field(50080; "User Name"; Code[50])
        {
        }
        field(50081; "Requisition No"; Code[50])
        {
            TableRelation = "HR Employee Requisitions" where(Status = filter(Approved));
            trigger OnValidate()
            var
                EmpReq: Record "HR Employee Requisitions";
            begin
                if EmpReq.get("Requisition No") then begin
                    "Job Applied For" := EmpReq."Job ID";
                    "Job Applied for Description" := empreq."Job Description";
                end;
            end;
        }
        field(50082; MyRecID; RecordID)
        {
        }
        field(50083; "Failed Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Application No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Job Application Nos");
            NoSeriesMgt.InitSeries(HRSetup."Job Application Nos", xRec."No. Series", 0D, "Application No", "No. Series");
        end;

        "Date Applied" := Today;
    end;

    var
        HRJobApp: Record Applicants;
        Country: Record "Country/Region";
        Employee: Record "HR-Employee";
        AppQualifications: Record "HR Applicant Qualifications";
        EmpQualifications: Record "HR Employee Qualifications";
        Jobs: Record "HR Jobs";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("First Name" + ' ' + "Last Name")
        else
            exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}
