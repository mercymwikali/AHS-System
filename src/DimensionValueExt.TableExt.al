TableExtension 52202432 "Dimension Value Ext" extends "Dimension Value"
{
    fields
    {
        field(52202890; "Default Pharmacy Location"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(39003900; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(39003905; HOD; Code[50])
        {
            TableRelation = "HR-Employee"."No." where(HOD = const(true));
            // TableRelation = "User Setup"."User ID";
        }
        field(39003907; DIRECTOR; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(39003908; "Old Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(39003910; "Total Income Dept"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = filter('5000000' .. '5009999'),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Global Dimension 2 Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(39003911; Recurrent; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = filter('6000000' .. '6990000'),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Global Dimension 2 Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(39003912; Capital; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("Posting Date" = field("Date Filter"),
                                                        "G/L Account No." = filter('1000000' .. '1999000'),
                                                        "Global Dimension 2 Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(39003913; "Total Expenditure"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = filter('6000000' .. '6990000'),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Global Dimension 2 Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(39003914; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(39003916; "Total Income Campus"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = filter('5000000' .. '5009999'),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Global Dimension 1 Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(39003917; Division; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DIVISION'));
        }
        field(50105; "School Administrator"; Code[20])
        {
            TableRelation = "User setup"."User ID";
        }
        field(50106; "School Accountant"; Code[20])
        {
            TableRelation = "User setup"."User ID";
        }
        field(50107; "Invoice No. Series"; Code[20])
        {
            TableRelation = "No. Series".code;
        }
        field(50108; "Receipt No. Series"; Code[20])
        {
            TableRelation = "No. Series".code;
        }
        field(50109; "Email Address"; Text[30])
        {
        }
        field(50110; "Phone No."; Code[20])
        {
        }
    }

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CheckIfDimValueUsed THEN
      ERROR(Text000,GetCheckDimErr);

    DimValueComb.SETRANGE("Dimension 1 Code","Dimension Code");
    DimValueComb.SETRANGE("Dimension 1 Value Code",Code);
    #6..20
    AnalysisSelectedDim.SETRANGE("Dimension Code","Dimension Code");
    AnalysisSelectedDim.SETRANGE("New Dimension Value Code",Code);
    AnalysisSelectedDim.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    //IF CheckIfDimValueUsed THEN
    //  ERROR(Text000,GetCheckDimErr);
    #3..23
    */
    //end;

    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RenameBudgEntryDim;
    RenameAnalysisViewEntryDim;
    RenameItemBudgEntryDim;
    RenameItemAnalysisViewEntryDim;

    IF CostAccSetup.GET THEN BEGIN
      CostAccMgt.UpdateCostCenterFromDim(Rec,xRec,3);
      CostAccMgt.UpdateCostObjectFromDim(Rec,xRec,3);
    END;

    SetLastModifiedDateTime;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..4
     {
    #6..9
    {>>>>>>>} ORIGINAL
    {=======} MODIFIED
     }

    SetLastModifiedDateTime;
    {<<<<<<<}
    */
    //end;
}
