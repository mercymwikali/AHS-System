table 85302 "Jackson Visual Form"
{
    Caption = 'Jackson Visual Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Admission No"; Code[30])
        {
            Caption = 'Admission No';
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(50002; "Date "; Date)
        {
            Caption = 'Date ';
        }
        field(50003; Score; Integer)
        {
            Caption = 'Score';
        }
        field(50004; "IV Line "; Option)
        {
            Caption = 'IV Line ';
            OptionCaption = ' ,Insertion,Removal';
            OptionMembers = " ",Insertion,Removal;
        }
        field(50005; "Nurse"; Text[30])
        {
            Caption = 'Nurse';
        }
    }
    keys
    {
        key(PK; "Line No", "Admission No", "Date ")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if Nurse = '' then
            Nurse := Format(UserId);
    end;
}
