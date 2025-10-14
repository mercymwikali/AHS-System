TableExtension 52202431 "G/L Account Ext" extends "G/L Account"
{
    DrillDownPageId = "Chart of Accounts.";
    LookupPageId = "Chart of Accounts.";

    fields
    {
        field(50000; "Budget Controlled"; Boolean)
        {
        }
        field(50002; "Global Dimension 3 Filter"; Code[20])
        {
            Caption = 'Global Dimension 3 Filter';
            CaptionClass = '1,2,3';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50003; "Global Dimension 4 Filter"; Code[20])
        {
            Caption = 'Global Dimension 4 Filter';
            CaptionClass = '1,2,4';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50004; "Expense Code"; Code[15])
        {
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                //Expense code only applicable if account type is posting and Budgetary control is applicable
                TestField("Account Type", "account type"::Posting);
                TestField("Budget Controlled", true);
            end;
        }
        field(50005; "Donor defined Account"; Boolean)
        {
            Description = 'Select if the Account is donor Defined';
        }
        field(50006; "Committment Amount"; Decimal)
        {
            CalcFormula = sum(Committment.Amount where("G/L Account No." = field("No."),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                        "EXist GL" = filter(0), Cancelled = const(false)));
            FieldClass = FlowField;
        }
        field(39004244; test; Code[20])
        {
        }
        field(39004245; "Grant Expense"; Boolean)
        {
        }
        field(39004246; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(39004247; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(39004248; "Quartely Budget line Items"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51000; "Budget Line Item"; Code[20])
        {
            // TableRelation = ; TODO: include table relation
            DataClassification = ToBeClassified;
        }
        field(51003; "IP/OP"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = ,OP,IP;
        }
        field(51004; "Patient Type"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
    }

    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DimMgt.UpdateDefaultDim(DATABASE::"G/L Account","No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");

    SetLastModifiedDateTime;

    IF CostAccSetup.GET THEN
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,0);

    IF Indentation < 0 THEN
      Indentation := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    */
    //end;

    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetLastModifiedDateTime;

    IF CostAccSetup.GET THEN BEGIN
      IF CurrFieldNo <> 0 THEN
        CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,1)
      ELSE
        CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,0);
    END;

    IF Indentation < 0 THEN
      Indentation := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    */
    //end;

    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.RenameNo(SalesLine.Type::"G/L Account",xRec."No.","No.");
    PurchaseLine.RenameNo(PurchaseLine.Type::"G/L Account",xRec."No.","No.");
    DimMgt.RenameDefaultDim(DATABASE::"G/L Account",xRec."No.","No.");

    SetLastModifiedDateTime;

    IF CostAccSetup.READPERMISSION THEN
      CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,3);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesLine.RenameNo(SalesLine.Type::"G/L Account",xRec."No.","No.");
    PurchaseLine.RenameNo(PurchaseLine.Type::"G/L Account",xRec."No.","No.");
    #4..6
    //IF CostAccSetup.READPERMISSION THEN
    //  CostAccMgt.UpdateCostTypeFromGLAcc(Rec,xRec,3);
    */
    //end;

    //Unsupported feature: Code Modification on "CheckGLAcc(PROCEDURE 2)".

    //procedure CheckGLAcc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Account Type","Account Type"::Posting);
    TESTFIELD(Blocked,FALSE);

    OnAfterCheckGLAcc(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Account Type","Account Type"::Posting);
    TESTFIELD(Blocked,FALSE);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "GetCurrencyCode(PROCEDURE 3)".

    //Unsupported feature: Property Insertion (Local) on "GetCurrencyCode(PROCEDURE 3)".

    //Unsupported feature: Property Deletion (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 29)".

    //Unsupported feature: Property Deletion (Attributes) on "TranslationMethodConflict(PROCEDURE 4)".

    //Unsupported feature: Property Deletion (Attributes) on "IsTotaling(PROCEDURE 8)".

    procedure RestrickModificationOfAccountDetails(FieldName: Text[100])
    var
        GLEntry: Record "G/L Entry";
    begin
        //restrick Change of particulars after account has been posted to
        GLEntry.SetCurrentkey(GLEntry."G/L Account No.");
        GLEntry.SetRange("G/L Account No.", "No.");
        if GLEntry.Find('-') then
            Error('Please note that you can not modify account with posted entries');
    end;
}
