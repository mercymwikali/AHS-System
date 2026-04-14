Table 85494 "HR Leave Ledger"
{
    DrillDownPageId = "HR Leave Ledger";
    LookupPageId = "HR Leave Ledger";
    fields
    {
        field(50000; "Employee No"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Entry No."; Integer)
        {
        }
        field(50002; "Document No"; Code[30])
        {
        }
        field(50003; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Types".Code;
        }
        field(50004; "Transaction Date"; Date)
        {
        }
        field(50005; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Allocation,Application,Positive Adjustment,Negative Adjustment,Carry Forward';
            OptionMembers = " ",Allocation,Application,"Positive Adjustment","Negative Adjustment","Carry Forward";
        }
        field(50006; "No. of Days"; Decimal)
        {
        }
        field(50007; "Transaction Description"; Text[250])
        {
        }
        field(50008; "Leave Period"; Integer)
        {
        }
        field(50009; "Entry Type"; Option)
        {
            OptionCaption = 'Application,Allocation,Reset';
            OptionMembers = Application,Allocation,Reset;
        }
        field(50010; "Created By"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50011; "Reversed By"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50012; "Calendar Code"; Code[20])
        {
            TableRelation = "HR Leave Calendar".Code;
        }
        field(50013; Closed; Boolean)
        {

        }
        field(50014; "Posting Source"; Option)
        {            
            OptionMembers = Document,Batch;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Employee No", "Leave Type")
        {
            SumIndexFields = "No. of Days";
        }
        key(Key3; "Employee No", "Transaction Date")
        {
            SumIndexFields = "No. of Days";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
    end;
}
