Table 85024 "HR Employee Leave Journal"
{
    fields
    {
        field(50000; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Staff No."; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if emp.Get("Staff No.") then
                    "Staff Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(50002; "Staff Name"; Text[250])
        {
        }
        field(50003; "Transaction Description"; Text[150])
        {
        }
        field(50004; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Types".Code;
        }
        field(50005; "No. of Days"; Decimal)
        {
        }
        field(50006; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Allocation,Application,Positive Adjustment,Negative Adjustment';
            OptionMembers = " ",Allocation,Application,"Positive Adjustment","Negative Adjustment";
        }
        field(50007; "Document No."; Code[20])
        {
        }
        field(50008; "Posting Date"; Date)
        {
        }
        field(50009; "Leave Period"; Integer)
        {
        }
        field(50010; "Leave Balance"; Decimal)
        {
        }
        field(50011; "Allow Carry Forward"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        emp: Record "HR-Employee";
}
