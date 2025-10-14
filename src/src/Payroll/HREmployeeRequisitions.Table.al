Table 52202716 "HR Employee Requisitions"
{
    DrillDownPageId = "HR Employee Requisitions List";
    LookupPageId = "HR Employee Requisitions List";
    fields
    {
        field(2; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            begin
                HRJobs.Reset();
                if HRJobs.Get("Job ID") then
                    "Job Description" := HRJobs."Job Description";
                "Vacant Positions" := HRJobs."Vacant Positions";
                "Job Grade" := HRJobs.Grade;
                "Global Dimension 2 Code" := HRJobs."Department Code";
                "Job Supervisor/Manager" := HRJobs."Supervisor/Manager";
            end;
        }
        field(3; "Requisition Date"; Date)
        {
            trigger OnValidate()
            begin
                if (Rec."Requisition Date" - Today) < 0 then
                    Message('Days in the past are not allowed');
            end;
        }
        field(4; Priority; Option)
        {
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
        }
        field(5; Positions; Integer)
        {
        }
        field(6; Approved; Boolean)
        {
            trigger OnValidate()
            begin
                "Date Approved" := Today;
            end;
        }
        field(7; "Date Approved"; Date)
        {
        }
        field(8; "Job Description"; Text[200])
        {
            Editable = false;
        }
        field(9; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(10; Score; Decimal)
        {
            FieldClass = Normal;
        }
        field(11; "Stage Code"; Code[20])
        {
            TableRelation = "HR Recruitment Stages".Code;
        }
        field(12; Qualified; Boolean)
        {
            FieldClass = Normal;
        }
        field(13; "Job Supervisor/Manager"; Code[10])
        {
            FieldClass = Normal;
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(17; "Turn Around Time"; Integer)
        {
            Editable = false;
        }
        field(21; "Grace Period"; Integer)
        {
        }
        field(25; Closed; Boolean)
        {
            Editable = false;
        }
        field(26; "Requisition Type"; Option)
        {
            OptionCaption = ' ,Internal,External,Both';
            OptionMembers = " ",Internal,External,Both;
        }
        field(27; "Closing Date"; Date)
        {
        }
        field(28; Status; Option)
        {
            // Editable = true;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(38; "Required Positions"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Required Positions" > "Vacant Positions" then
                    Error('Required positions exceed the total  no of Vacant Positions');

                if "Required Positions" <= 0 then
                    Error('Required positions cannot be Less Than or Equal to Zero');
            end;
        }
        field(39; "Vacant Positions"; Decimal)
        {
            Editable = false;
        }
        field(3949; "Reason for Request(Other)"; Text[100])
        {
        }
        field(3950; "Any Additional Information"; Text[100])
        {
        }
        field(3958; "Job Grade"; Text[100])
        {
            Editable = false;
            TableRelation = "HR Lookup Values".Code where(Type = const(Grade));
        }
        field(3964; "Type of Contract Required"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Contract Type"));
        }
        field(3965; "Reason For Request"; Option)
        {
            OptionMembers = "New Vacancy",Replacement,Retirement,Retrenchment,Demise,Other;
        }
        field(3966; Requestor; Code[50])
        {
            Editable = false;
        }
        field(3967; "No. Series"; Code[10])
        {
        }
        field(3968; "Requisition No."; Code[20])
        {
        }
        field(3969; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(3970; Gender; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(3971; "Job Ref No"; Code[100])
        {
        }
        field(50000; Advertised; Boolean)
        {
        }
        field(50001; "Opening Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Requisition No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Requisition No.", "Job Description")
        {
        }
    }

    trigger OnDelete()
    begin

        if Status <> Status::New then
            Error('You cannot delete this record if its status is' + ' ' + Format(Status));
    end;

    trigger OnInsert()
    begin
        //GENERATE DOCUMENT NUMBER
        if "Requisition No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Employee Requisition Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Employee Requisition Nos.", xRec."No. Series", 0D, "Requisition No.", "No. Series");
        end;
        //POPULATE FIELDS
        Requestor := UserId;
        "Requisition Date" := Today;
    end;

    var
        HRJobs: Record "HR Jobs";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
