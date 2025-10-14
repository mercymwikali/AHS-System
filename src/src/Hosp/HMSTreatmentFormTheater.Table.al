Table 52202513 "HMS Treatment Form Theater"
{
    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Process No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Physiotheraphy TYpes".Code;
        }
        field(3; "Process Name"; Text[100])
        {
        }
        field(4; "Process Mandatory"; Boolean)
        {
        }
        field(5; "Process Remarks"; Text[250])
        {
        }
        field(6; "Process Result"; Text[100])
        {
        }
        field(7; Status; Option)
        {
            CalcFormula = lookup("HMS Theatre Form Header".Status where("Link Type" = const('DOCTOR'),
                                                                         "Link No." = field("Treatment No.")));
            FieldClass = FlowField;
            OptionMembers = New,Cancelled,Completed,Forwarded;
        }
        field(8; "Theatre Date"; Date)
        {
        }
        field(9; "Theatre Time"; Time)
        {
        }
        field(10; "Procedure"; Option)
        {
            OptionCaption = ' ,Minor,Major,Moderate';
            OptionMembers = " ",Minor,Major,Moderate;
        }
        field(11; Doctor; Code[50])
        {
        }
        field(12; Anaesthesist; Code[50])
        {
        }
        field(13; Instructions; Text[250])
        {
        }
        field(14; "Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Process No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
