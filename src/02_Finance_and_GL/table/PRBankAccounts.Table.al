table 85505 "PR Bank Accounts"
{
    Caption = 'PR Bank Accounts';
    DataClassification = ToBeClassified;
    LookupPageId = "Pr Bank Acocunts";
    
    fields
    {
        field(50000; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
        }
        field(50001; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
        }
        field(50002; "Bank Type"; Option)
        {
            Caption = 'Bank Type';
            OptionCaption = 'Bank,Sacco';
            OptionMembers = Bank,Sacco;
        }
    }
    keys
    {
        key(PK; "Bank Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Bank Name")
        {

        }
    }
}
