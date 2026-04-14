Table 85208 "HMS Outpatient Procedures"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Treatment No"; Code[20])
        {
        }
        field(50002; "Patient No"; Code[20])
        {
        }
        field(50003; "Procedure"; Code[30])
        {
        }
        field(50004; Description; Text[100])
        {
        }
        field(50005; Department; Text[50])
        {
        }
        field(50006; Employee; Text[100])
        {
        }
        field(50007; "Procedure Date"; DateTime)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(50008; Doctor; Code[30])
        {
        }
        field(50009; "Time Interval"; Text[200])
        {
        }
        field(50010; Status; Option)
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
