Page 85403 "HMS Pharmacy List Paid"
{
    CardPageID = "HMS Pharmacy Header";
    //Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "HMS Pharmacy Header";
    SourceTableView = sorting("Pharmacy No.")
                      order(descending) where(Status = filter(Paid), "Total Price" = filter(> 0));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(PharmacyNo; Rec."Pharmacy No.")
                {
                    ToolTip = 'Specifies the value of the Pharmacy No. field.';
                }
                field(PharmacyDate; Rec."Pharmacy Date")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Date field.';
                }
                field(PharmacyTime; Rec."Pharmacy Time")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Time field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Names; Names)
                {
                    Caption = 'Patient Names';
                    ToolTip = 'Specifies the value of the Patient Names field.';
                }
                field("Global Dimension1"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Visit Total"; Rec."Visit Total")
                {
                    ToolTip = 'Specifies the value of the Visit Total field.';
                }
                field("Total Receipts"; Rec."Total Receipts")
                {
                    ToolTip = 'Specifies the value of the Total Receipts field.';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ToolTip = 'Specifies the value of the Doctor Name field.';
                }
                field(IssuedBy; Rec."Issued By")
                {
                    ToolTip = 'Specifies the value of the Issued By field.';
                }
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(InsuranceNo; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        ReUser: Record "User Setup";
    begin
        ReUser.SetRange(ReUser."User ID", UserId);
        if ReUser.Find('-') then
            Rec.SetFilter("Global Dimension 1 Code", ReUser."Branch Code");
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnAfterGetRecord()
    var
        PatRec: Record "HMS Patient";
    begin
        if PatRec.get(Rec."Patient No.") then
            Names := PatRec."Search Name";
    end;

    var
        Names: Text[200];
}
