table 85407 "Hr Documents"
{
    Caption = 'Hr Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Document No"; Code[20])
        {
            Caption = 'Document No';
            Editable = false;
        }
        field(50001; "Document Type"; Option)
        {
            OptionMembers = Download,Mannual;
        }
        field(50002; "Reference No"; Code[30])
        {
        }
        field(50003; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(50004; "Uploaded By"; Text[50])
        {
            Caption = 'Uploaded By';
        }
        field(50005; "Total Downloads"; Integer)
        {
            Caption = 'Total Downloads';
            Editable = false;
        }
        field(50006; IsVisible; Boolean)
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
