table 52202958 "Jackson Visual Form"
{
    Caption = 'Jackson Visual Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Admission No"; Code[30])
        {
            Caption = 'Admission No';
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(3; "Date "; Date)
        {
            Caption = 'Date ';
        }
        field(4; Score; Integer)
        {
            Caption = 'Score';
        }
        field(5; "IV Line "; Option)
        {
            Caption = 'IV Line ';
            OptionCaption = ' ,Insertion,Removal';
            OptionMembers = " ",Insertion,Removal;
        }
        field(6; "Nurse"; Text[30])
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
