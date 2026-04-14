Table 85285 "HR Job Applicants - Appt. Line"
{
    Caption = 'HR Job Applications';
    //DrillDownPageID = UnknownPage70134738;
    //LookupPageID = UnknownPage70134738;

    fields
    {
        field(50000; "Test Code"; Code[50])
        {
            TableRelation = "HR Job Applicants - Appt. Type".No;
        }
        field(50001; "Applicants Code"; Code[20])
        {
            TableRelation = "HR Job Applications"."Application No" where(Qualified = filter(true));

            trigger OnValidate()
            begin

                HRJobApp.Reset();
                HRJobApp.SetRange(HRJobApp."Application No", "Applicants Code");
                if HRJobApp.Find('-') then begin
                    "Applicants Name" := HRJobApp."First Name" + ' ' + HRJobApp."Middle Name" + ' ' + HRJobApp."Last Name";
                    "E-mail" := HRJobApp."E-Mail";
                    "Telephone No" := HRJobApp."Cell Phone Number";
                end;

                "Line No" := xRec."Line No" + 1000;
                Insert();
            end;
        }
        field(50002; "Applicants Name"; Text[50])
        {
        }
        field(50003; Description; Text[100])
        {
        }
        field(50004; "Date of Test"; Date)
        {
        }
        field(50005; Venue; Text[30])
        {
        }
        field(50006; FromTime; Time)
        {
        }
        field(50007; "To time"; Time)
        {
        }
        field(50008; "Notification Sent"; Boolean)
        {
        }
        field(50009; "E-mail"; Text[30])
        {
        }
        field(50010; "Line No"; Decimal)
        {
        }
        field(50011; "Telephone No"; Text[30])
        {
        }
        field(50012; "Followup Done"; Boolean)
        {
        }
        field(50013; Status; Option)
        {
            OptionCaption = 'Apptitude,Assesment,Interview1,Interview2, Qualified';
            OptionMembers = Apptitude,Assesment,Interview1,Interview2," Qualified";
        }
        field(50014; Score; Decimal)
        {
            CalcFormula = sum("HR Job Applicants - Appt. Res".Score where("Applicant No" = field("Applicants Code"),
                                                                           Stage = field(Stage)));
            FieldClass = FlowField;
        }
        field(50015; "Type of Invitation Code"; Code[10])
        {
        }
        field(50016; "Type of Invitation"; Text[50])
        {
        }
        field(50017; Stage; Code[20])
        {
            TableRelation = "HR Recruitment Stages".Code;

            trigger OnValidate()
            begin
                Appt.Reset();
                Appt.SetRange(Appt.No, "Test Code");
                if Appt.Find('-') then begin
                    Description := Appt."Test Particulars";
                    "Date of Test" := Appt."Date of Test";
                    Venue := Appt.Venue;
                    FromTime := Appt."Start Time";
                    Rec."To time" := Appt."End Time";
                    Stage := Appt."Stage Code";
                end;
            end;
        }
        field(50018; Response; Option)
        {
            OptionCaption = 'None,Accepted,Declined,Tentative';
            OptionMembers = "None",Accepted,Declined,Tentative;
        }
        field(50019; "Invitation Type"; Option)
        {
            OptionCaption = 'Email,Phone Call,Text,Meeting';
            OptionMembers = Email,"Phone Call",Text,Meeting;
        }
    }

    keys
    {
        key(Key1; "Test Code", "Applicants Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*//GENERATE NEW NUMBER FOR THE DOCUMENT
        IF  "Aptitude Test Description" = '' THEN BEGIN
          HRSetup.GET;
          HRSetup.TESTFIELD(HRSetup."Job Application Nos");
          NoSeriesMgt.InitSeries(HRSetup."Job Application Nos",xRec."No. Series",0D,"Aptitude Test Description","No. Series");
        END;

        "Date Applied":=TODAY;
        */
    end;

    var
        Appt: Record "HR Job Applicants - Appt. Type";
        HRJobApp: Record "HR Job Applications";

    procedure FullName(): Text[100]
    begin
    end;
}
