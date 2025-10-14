table 52203006 "Hr Documents"
{
    Caption = 'Hr Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(52202400; "Document No"; Code[20])
        {
            Caption = 'Document No';
            Editable = false;
        }
        field(52202401; "Document Type"; Option)
        {
            OptionMembers = Download,Mannual;
        }
        field(52202402; "Reference No"; Code[30])
        {
        }
        field(52202403; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(52202404; "Uploaded By"; Text[50])
        {
            Caption = 'Uploaded By';
        }
        field(52202405; "Total Downloads"; Integer)
        {
            Caption = 'Total Downloads';
            Editable = false;
        }
        field(52202406; IsVisible; Boolean)
        {
            Caption = 'IsVisible';
        }
    }
    keys
    {
        key(PK; "Document No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        HrDocuments: Record "Hr Documents";
    begin
        if HrDocuments.FindLast() then
            "Document No" := IncStr(HrDocuments."Document No")
        else
            "Document No" := 'DOC00001';

        "Uploaded By" := CopyStr(UserId, 1, MaxStrLen("Uploaded By"));

    end;
}
