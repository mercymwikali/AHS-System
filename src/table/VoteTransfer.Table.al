Table 85145 "Vote Transfer"
{
    LookupPageID = "Vote Transfer List";

    fields
    {
        field(50000; No; Code[20])
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Source Vote"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50003; "Destination Vote"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50004; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50005; Amount; Decimal)
        {
        }
        field(50006; "Source Dimmension 1"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50007; "Destination Dimmension 1"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50008; "Source Dimmension 2"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50009; "Destination Dimmension 2"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50010; Remarks; Text[200])
        {
        }
        field(50011; "Raised By"; Code[20])
        {
        }
        field(50012; "Raised Date"; Date)
        {
        }
        field(50013; "Approved By"; Code[20])
        {
        }
        field(50014; "Approved Date"; Date)
        {
        }
        field(50015; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50016; Posted; Boolean)
        {
        }
        field(50017; "Posted Date"; Date)
        {
        }
        field(50018; "Posted By"; Code[20])
        {
        }
        field(50019; "Source Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(50020; "Destination Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(50021; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Posted;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Vote Transfer");
            NoSeriesMgt.GetNextNo(GenLedgerSetup."Vote Transfer");
        end;
    end;

    var
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
