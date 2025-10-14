pageextension 52202433 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addafter(SEPAExportWoBankAccData)
        {
            field("Allow G/L Acc. Deletion Before1"; Rec."Allow G/L Acc. Deletion Before")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies if and when general ledger accounts can be deleted. If you enter a date, G/L accounts with entries on or after this date can be deleted only after confirmation by the user. This setting is only valid when "Block Deletion of G/L accounts" is set to No';
            }
        }
    }

    actions
    {
        addafter("Change Payment &Tolerance")
        {
            action("Clear Database")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'StartUp Database Clearance';
                Image = Delete;
                ToolTip = 'Executes the StartUp Database Clearance action.';

                trigger OnAction()
                var
                    BankEntry: Record "Bank Account Ledger Entry";
                    CustL: Record "Cust. Ledger Entry";
                    CustD: Record "Detailed Cust. Ledg. Entry";
                    VendD: Record "Detailed Vendor Ledg. Entry";
                    GLEntry: Record "G/L Entry";
                    ItemL: Record "Item Ledger Entry";
                    PurchInvH: Record "Purch. Inv. Header";
                    PurchInvL: Record "Purch. Inv. Line";
                    PurchRecptH: Record "Purch. Rcpt. Header";
                    PurchRecptL: Record "Purch. Rcpt. Line";
                    SalesInvH: Record "Sales Invoice Header";
                    SalesInvL: Record "Sales Invoice Line";
                    UserRec: Record "User Setup";
                    ItemV: Record "Value Entry";
                    VendL: Record "Vendor Ledger Entry";

                begin

                    if UserRec.get(UserId) then
                        if UserRec."Approval Administrator" = false then
                            error('You are not authorized to use this function');
                    if not UserRec.get(UserId) then
                        error('You are not authorized to use this function');

                    if Dialog.StrMenu('Testing,Real,Actual,New Company,Known,MBS,Clear,Aroma,Den,Yes,BT,DS,BK,HR,TR,YU,BV,CX,ZA,KP,MU,KABU,MMU', 3, 'Enter Clearance Key') = 8 then
                        if Confirm('Please ensure that you have done system backup before executing this function, Do you want to proceed?', false) then
                            if Confirm('Are you sure you want to delete all entries in the system?', false) then
                                if Confirm('Please note that this process is irriversable do you still want to proceed?', false) then begin
                                    GLEntry.DeleteAll();
                                    BankEntry.DeleteAll();
                                    CustL.DeleteAll();
                                    VendL.DeleteAll();
                                    CustD.DeleteAll();
                                    VendD.DeleteAll();
                                    ItemL.DeleteAll();
                                    ItemV.DeleteAll();
                                    SalesInvH.DeleteAll();
                                    SalesInvL.DeleteAll();
                                    PurchInvH.DeleteAll();
                                    PurchInvL.DeleteAll();
                                    PurchRecptH.DeleteAll();
                                    PurchRecptL.DeleteAll();
                                    Message('Process Completed');
                                end;
                end;
            }
        }
    }
}