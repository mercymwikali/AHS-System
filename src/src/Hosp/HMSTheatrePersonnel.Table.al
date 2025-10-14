Table 52202481 "HMS Theatre Personnel"
{
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Treatment No"; Code[20])
        {
        }
        field(3; "Theatre No"; Code[20])
        {
        }
        field(4; "Personnel Name"; Text[100])
        {
        }
        field(5; "Personnel Type"; Option)
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
        field(6; "Employee No."; Code[20])
        {
        }
        field(7; Arrangement; Integer)
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
