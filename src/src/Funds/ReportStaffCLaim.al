report 52202608 "Staff CLaim"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Staff CLaim.rdl';

    dataset
    {
        dataitem("Staff Claims Header"; "Staff Claims Header")
        {
            column(logo; compInfo.Picture)
            {
            }
            column(No_StaffClaimsHeader; "Staff Claims Header"."No.")
            {
            }
            column(Date_StaffClaimsHeader; "Staff Claims Header".Date)
            {
            }
            column(Payee_StaffClaimsHeader; "Staff Claims Header".Payee)
            {
            }
            column(Status_StaffClaimsHeader; "Staff Claims Header".Status)
            {
            }
            column(PrebBy; PrebBy)
            {
            }
            column(PrebDate; PrebDate)
            {
            }
            column(ApproversName1; ApproversName[1])
            {
            }
            column(ApproversName2; ApproversName[2])
            {
            }
            column(ApproversName3; ApproversName[3])
            {
            }
            column(ApproversName4; ApproversName[4])
            {
            }
            column(ApproversName5; ApproversName[5])
            {
            }
            column(ApprovalDate1; ApprovalDate[1])
            {
            }
            column(ApprovalDate2; ApprovalDate[2])
            {
            }
            column(ApprovalDate3; ApprovalDate[3])
            {
            }
            column(ApprovalDate4; ApprovalDate[4])
            {
            }
            column(ApprovalDate5; ApprovalDate[5])
            {
            }
            column(Sign1; UserRec1[1].Signature)
            {
            }
            column(Sign2; UserRec1[2].Signature)
            {
            }
            column(Sign3; UserRec1[3].Signature)
            {
            }
            column(Sign4; UserRec1[4].Signature)
            {
            }
            column(Sign0; UserRec0.Signature)
            {
            }
            dataitem("Staff Claim Lines"; "Staff Claim Lines")
            {
                DataItemLink = No = FIELD("No.");
                column(No_StaffClaimLines; "Staff Claim Lines".No)
                {
                }
                column(AccountNo_StaffClaimLines; "Staff Claim Lines"."Account No:")
                {
                }
                column(AccountName_StaffClaimLines; "Staff Claim Lines"."Account Name")
                {
                }
                column(Amount_StaffClaimLines; "Staff Claim Lines".Amount)
                {
                }
                column(Purpose_StaffClaimLines; "Staff Claim Lines".Purpose)
                {
                }
                column(ClaimReceiptNo_StaffClaimLines; "Staff Claim Lines"."Claim Receipt No")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //Get Approvers
                ApprovalEntry.RESET();
                ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", "Staff Claims Header"."No.");
                ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FIND('-') THEN BEGIN
                    UserRec0.GET(ApprovalEntry."Sender ID");
                    PrebBy := UserRec0.UserName;
                    PrebDate := ApprovalEntry."Last Date-Time Modified";
                    UserRec0.CALCFIELDS(UserRec0.Signature);
                    REPEAT
                        UserRec.GET(ApprovalEntry."Approver ID");
                        ApproversName[ApprovalEntry."Sequence No."] := UserRec.UserName;
                        ApprovalDate[ApprovalEntry."Sequence No."] := ApprovalEntry."Last Date-Time Modified";
                        UserRec1[ApprovalEntry."Sequence No."].GET(ApprovalEntry."Approver ID");
                        UserRec1[ApprovalEntry."Sequence No."].CALCFIELDS(UserRec1[ApprovalEntry."Sequence No."].Signature);
                    UNTIL ApprovalEntry.NEXT() = 0;
                END;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        compInfo.GET();
        compInfo.CALCFIELDS(Picture);
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        compInfo: Record "Company Information";
        UserRec: Record "User Setup";
        UserRec0: Record "User Setup";
        UserRec1: array[10] of Record "User Setup";
        ApprovalDate: array[10] of DateTime;
        PrebDate: DateTime;
        ApproversName: array[10] of Text[100];
        PrebBy: Text[100];
}
