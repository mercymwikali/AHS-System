page 52202960 "HMS Pharmacy History List"
{
    CardPageID = "HMS Pharmacy Header History";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS Pharmacy Header";
    SourceTableView = where(Status = filter(Completed));


    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {

                ShowCaption = false;
                field("Pharmacy No."; "Pharmacy No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pharmacy Date"; "Pharmacy Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pharmacy Time"; "Pharmacy Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Patient No."; "Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension1"; "Global Dimension 1 Code")
                {
                    caption = 'Branch';
                    ApplicationArea = Basic, Suite;
                }
                field("ADM No"; "ADM No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Issued By"; "Issued By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Link Type"; "Link Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Sale"; "Cash Sale")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receipt Count"; "Receipt Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Link No."; "Link No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance No"; "Insurance No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Patient Type"; "Patient Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if UserRec.get(Database.UserId) then
            if UserRec."Branch Code" <> '' then
                SetFilter("Global Dimension 1 Code", UserRec."Branch Code");

    end;
}

