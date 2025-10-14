Table 52202824 "Employee Qualifications Fin"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Internal,External,Others';
            OptionMembers = " ",Internal,External,Others;
        }
        field(3; "From Date"; Date)
        {
        }
        field(4; "To Date"; Date)
        {
        }
        field(5; Institution; Code[30])
        {
            TableRelation = "Hr Institutions"."Institution Code";
        }
        field(6; Description; Text[150])
        {
        }
        field(7; Qualification; Option)
        {
            OptionCaption = ' ,Certificate,Diploma,Undergraduate,Masters,PHD,Higher Diploma';
            OptionMembers = " ",Certificate,Diploma,Undergraduate,Masters,PHD,"Higher Diploma";
        }
        field(8; "Institution Name"; Text[250])
        {
            CalcFormula = lookup("Hr Institutions"."Institution Name" where("Institution Code" = field(Institution)));
            FieldClass = FlowField;
        }
        field(9; "Highest Qualification"; Boolean)
        {
            trigger OnValidate()
            begin
                // qual.RESET;
                if ("Highest Qualification" = true) then begin
                    qual.Reset();
                    qual.SetRange(qual."Employee No.", "Employee No.");
                    qual.SetRange(qual."Highest Qualification", true);
                    if qual.Find('-') then
                        if qual.Count > 0 then
                            Error('You cannot have more than one highest qualifications for' + Format(qual."Employee No."));
                end;
            end;
        }
        field(10; Rank; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Qualification, Type, Institution)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        qual: Record "Employee Qualifications Fin";
}
