Table 52202500 "HMS Outpatient Procedures"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Treatment No"; Code[20])
        {
        }
        field(3; "Patient No"; Code[20])
        {
        }
        field(4; "Procedure"; Code[30])
        {
        }
        field(5; Description; Text[100])
        {
        }
        field(6; Department; Text[50])
        {
        }
        field(7; Employee; Text[100])
        {
        }
        field(8; "Procedure Date"; DateTime)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(9; Doctor; Code[30])
        {
        }
        field(10; "Time Interval"; Text[200])
        {
        }
        field(11; Status; Option)
        {
            OptionCaption = 'New,Pending,Closed';
            OptionMembers = New,Pending,Closed;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
