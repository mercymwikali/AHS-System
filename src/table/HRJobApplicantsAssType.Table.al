Table 85290 "HR Job Applicants - Ass. Type"
{
    fields
    {
        field(50000; No; Code[20])
        {
            Editable = true;
        }
        field(50001; "Date of Assesment"; Date)
        {
        }
        field(50002; Venue; Text[30])
        {
        }
        field(50003; "Start Time"; Time)
        {
        }
        field(50004; "End Time"; Time)
        {
        }
        field(50005; "Personnel in charge"; Code[20])
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
        field(50006; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,Closed,Cancelled;
        }
        field(50007; "Test Particulars"; Text[250])
        {
        }
        field(50008; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(50009; "Personnel in charge Name"; Text[100])
        {
        }
        field(50010; "Responsibility Center"; Code[10])
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
        field(50011; "Job No."; Code[50])
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
        field(50012; "Job Description"; Text[100])
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
