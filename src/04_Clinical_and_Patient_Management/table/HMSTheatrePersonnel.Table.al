Table 85258 "HMS Theatre Personnel"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Treatment No"; Code[20])
        {
        }
        field(50002; "Theatre No"; Code[20])
        {
        }
        field(50003; "Personnel Name"; Text[100])
        {
        }
        field(50004; "Personnel Type"; Option)
        {
            OptionCaption = ',Surgeon,Assistant Surgeon,Anaesthetist,Scrub Nurse,Circulating Nurse';
            OptionMembers = ,Surgeon,"Assistant Surgeon",Anaesthetist,"Scrub Nurse","Circulating Nurse";

            trigger OnValidate()
            begin
                if "Personnel Type" = "personnel type"::Surgeon then
                    Arrangement := 1;
                if "Personnel Type" = "personnel type"::"Assistant Surgeon" then
                    Arrangement := 2;
                if "Personnel Type" = "personnel type"::Anaesthetist then
                    Arrangement := 3;
                if "Personnel Type" = "personnel type"::"Scrub Nurse" then
                    Arrangement := 4;
                if "Personnel Type" = "personnel type"::"Circulating Nurse" then
                    Arrangement := 5;
            end;
        }
        field(50005; "Employee No."; Code[20])
        {
        }
        field(50006; Arrangement; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Treatment No", Arrangement)
        {
        }
        key(Key3; Arrangement)
        {
        }
    }

    fieldgroups
    {
    }
}
