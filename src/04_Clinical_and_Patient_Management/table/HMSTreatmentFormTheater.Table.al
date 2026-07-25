Table 85271 "HMS Treatment Form Theater"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Process No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Physiotheraphy TYpes".Code;
        }
        field(50002; "Process Name"; Text[100])
        {
        }
        field(50003; "Process Mandatory"; Boolean)
        {
        }
        field(50004; "Process Remarks"; Text[250])
        {
        }
        field(50005; "Process Result"; Text[100])
        {
        }
        field(50006; Status; Option)
        {
            CalcFormula = lookup("HMS Theatre Form Header".Status where("Link Type" = const('DOCTOR'),
                                                                         "Link No." = field("Treatment No.")));
            FieldClass = FlowField;
            OptionMembers = New,Cancelled,Completed,Forwarded;
        }
        field(50007; "Theatre Date"; Date)
        {
        }
        field(50008; "Theatre Time"; Time)
        {
        }
        field(50009; "Procedure"; Option)
        {
            OptionCaption = ' ,Minor,Major,Moderate';
            OptionMembers = " ",Minor,Major,Moderate;
        }
        field(50010; Doctor; Code[50])
        {
        }
        field(50011; Anaesthesist; Code[50])
        {
        }
        field(50012; Instructions; Text[250])
        {
        }
        field(50013; "Line No"; Integer)
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
