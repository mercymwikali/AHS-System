Table 85500 "Leave Types"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; Days; Decimal)
        {
        }
        field(50003; "Acrue Days"; Boolean)
        {
        }
        field(50004; "Unlimited Days"; Boolean)
        {
        }
        field(50005; Gender; Option)
        {
            OptionCaption = 'Both,Male,Female';
            OptionMembers = Both,Male,Female;
        }
        field(50006; Balance; Option)
        {
            OptionCaption = 'Ignore,Carry Forward,Convert to Cash';
            OptionMembers = Ignore,"Carry Forward","Convert to Cash";
        }
        field(50007; "Inclusive of Holidays"; Boolean)
        {
        }
        field(50008; "Inclusive of Saturday"; Boolean)
        {
        }
        field(50009; "Inclusive of Sunday"; Boolean)
        {
        }
        field(50010; "Off/Holidays Days Leave"; Boolean)
        {
        }
        field(50011; "Max Carry Forward Days"; Decimal)
        {
            trigger OnValidate()
            begin
                if Balance <> Balance::"Carry Forward" then
                    "Max Carry Forward Days" := 0;
            end;
        }
        field(50012; "Inclusive of Non Working Days"; Boolean)
        {
        }
        field(50013; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50014; Applied; Integer)
        {
            // CalcFormula = count("HR Human Resource Comments" where ("Table Line No."=field(Code),

            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
