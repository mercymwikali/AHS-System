table 52202997 "PR Bank Accounts"
{
    Caption = 'PR Bank Accounts';
    DataClassification = ToBeClassified;
    LookupPageId = "Pr Bank Acocunts";
    
    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
        }
        field(2; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
        }
        field(3; "Bank Type"; Option)
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
