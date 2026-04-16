Table 85492 "HR Employee Requisitions"
{
    DrillDownPageId = "HR Employee Requisitions List";
    LookupPageId = "HR Employee Requisitions List";
    fields
    {
        field(50000; "Job ID"; Code[20])
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
        field(50001; "Requisition Date"; Date)
        {
            trigger OnValidate()
            begin
                if (Rec."Requisition Date" - Today) < 0 then
                    Message('Days in the past are not allowed');
            end;
        }
        field(50002; Priority; Option)
        {
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
        }
        field(50003; Positions; Integer)
        {
        }
        field(50004; Approved; Boolean)
        {
            trigger OnValidate()
            begin
                "Date Approved" := Today;
            end;
        }
        field(50005; "Date Approved"; Date)
        {
        }
        field(50006; "Job Description"; Text[200])
        {
            Editable = false;
        }
        field(50007; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50008; Score; Decimal)
        {
            FieldClass = Normal;
        }
        field(50009; "Stage Code"; Code[20])
        {
            TableRelation = "HR Recruitment Stages".Code;
        }
        field(50010; Qualified; Boolean)
        {
            FieldClass = Normal;
        }
        field(50011; "Job Supervisor/Manager"; Code[10])
        {
            FieldClass = Normal;
        }
        field(50012; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50013; "Turn Around Time"; Integer)
        {
            Editable = false;
        }
        field(50014; "Grace Period"; Integer)
        {
        }
        field(50015; Closed; Boolean)
        {
            Editable = false;
        }
        field(50016; "Requisition Type"; Option)
        {
            OptionCaption = ' ,Internal,External,Both';
            OptionMembers = " ",Internal,External,Both;
        }
        field(50017; "Closing Date"; Date)
        {
        }
        field(50018; Status; Option)
        {
            // Editable = true;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50019; "Required Positions"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Required Positions" > "Vacant Positions" then
                    Error('Required positions exceed the total  no of Vacant Positions');

                if "Required Positions" <= 0 then
                    Error('Required positions cannot be Less Than or Equal to Zero');
            end;
        }
        field(50020; "Vacant Positions"; Decimal)
        {
            Editable = false;
        }
        field(50021; "Reason for Request(Other)"; Text[100])
        {
        }
        field(50022; "Any Additional Information"; Text[100])
        {
        }
        field(50023; "Job Grade"; Text[100])
        {
            Editable = false;
            TableRelation = "HR Lookup Values".Code where(Type = const(Grade));
        }
        field(50024; "Type of Contract Required"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Contract Type"));
        }
        field(50025; "Reason For Request"; Option)
        {
            OptionMembers = "New Vacancy",Replacement,Retirement,Retrenchment,Demise,Other;
        }
        field(50026; Requestor; Code[50])
        {
            Editable = false;
        }
        field(50027; "No. Series"; Code[10])
        {
        }
        field(50028; "Requisition No."; Code[20])
        {
        }
        field(50029; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(50030; Gender; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(50031; "Job Ref No"; Code[100])
        {
        }
        field(50032; Advertised; Boolean)
        {
        }
        field(50033; "Opening Date"; Date)
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
            NoSeriesMgt.GetNextNo(HRSetup."Employee Requisition Nos.");
        end;
        //POPULATE FIELDS
        Requestor := UserId;
        "Requisition Date" := Today;
    end;

    var
        HRJobs: Record "HR Jobs";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
