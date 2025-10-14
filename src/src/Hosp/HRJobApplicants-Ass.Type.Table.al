Table 52202770 "HR Job Applicants - Ass. Type"
{
    fields
    {
        field(1; No; Code[20])
        {
            Editable = true;
        }
        field(2; "Date of Assesment"; Date)
        {
        }
        field(3; Venue; Text[30])
        {
        }
        field(4; "Start Time"; Time)
        {
        }
        field(5; "End Time"; Time)
        {
        }
        field(6; "Personnel in charge"; Code[20])
        {
            TableRelation = "HMS ICU Process".Code;

            trigger OnValidate()
            begin
                Emp.Reset();
                Emp.SetRange(Emp."No.", "Personnel in charge");
                if Emp.Find('-') then
                    "Personnel in charge Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,Closed,Cancelled;
        }
        field(8; "Test Particulars"; Text[250])
        {
        }
        field(9; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(10; "Personnel in charge Name"; Text[100])
        {
        }
        field(11; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR".Code;

            trigger OnValidate()
            begin

                /*TESTFIELD(Status,Status::Open);
                IF NOT UserMgt.CheckRespCenter(1,Department) THEN
                  ERROR(
                    Text001,
                    RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                */
            end;
        }
        field(12; "Job No."; Code[50])
        {
            TableRelation = "HR Jobs"."Job ID" where(Status = filter(Approved));

            trigger OnValidate()
            begin
                Jobs.Reset();
                Jobs.SetRange(Jobs."Job ID", "Job No.");
                if Jobs.Find('-') then
                    "Job Description" := Jobs."Job Description";
            end;
        }
        field(13; "Job Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record "HR-Employee";
        Jobs: Record "HR Jobs";
}
