Table 85152 "Approval Setup"
{
    Caption = 'Approval Setup';

    fields
    {
        field(50000; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(50001; "Due Date Formula"; DateFormula)
        {
            Caption = 'Due Date Formula';

            trigger OnValidate()
            begin
                if CopyStr(Format("Due Date Formula"), 1, 1) = '-' then
                    Error(Text001, FieldCaption("Due Date Formula"));
            end;
        }
        field(50002; "Approval Administrator"; Code[50])
        {
            Caption = 'Approval Administrator';
            TableRelation = "User Setup";
        }
        field(50003; "Request Rejection Comment"; Boolean)
        {
            Caption = 'Request Rejection Comment';
        }
        field(50004; Approvals; Boolean)
        {
            Caption = 'Approvals';
        }
        field(50005; Cancellations; Boolean)
        {
            Caption = 'Cancellations';
        }
        field(50006; Rejections; Boolean)
        {
            Caption = 'Rejections';
        }
        field(50007; Delegations; Boolean)
        {
            Caption = 'Delegations';
        }
        field(50008; "Last Run Time"; Time)
        {
            Caption = 'Last Run Time';
        }
        field(50009; "Last Run Date"; Date)
        {
            Caption = 'Last Run Date';
        }
        field(50010; "Overdue Template"; Blob)
        {
            Caption = 'Overdue Template';
            SubType = UserDefined;
        }
        field(50011; "Approval Template"; Blob)
        {
            Caption = 'Approval Template';
            SubType = UserDefined;
        }
        field(50012; "Responsibility Center Required"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'You cannot have negative values in %1.';
}
