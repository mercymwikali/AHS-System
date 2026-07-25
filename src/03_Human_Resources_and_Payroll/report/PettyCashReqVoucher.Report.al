Report 85033 "Petty Cash Req  Voucher."
{
    UsageCategory = None;
    RDLCLayout = './Layouts/Funds/PettyCashReqVoucher.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = all;

    dataset
    {
        dataitem("Payments Header"; "Payments Header")
        {
            DataItemTableView = order(ascending) where("Pay Mode" = filter(Cash), reversed = filter(false), Status = filter(Posted));
            RequestFilterFields = "Date Posted", Date, "No.", "Global Dimension 1 Code";

            column(SNO; SRO)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(CompInfoPostCode; CompInfo."Post Code")
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(Account_No; AccNo)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
                DecimalPlaces = 2 : 2;
            }
            column(No_PaymentHeader; "Payments Header"."No.")
            {
            }
            column(DocumentDate_PaymentHeader; "Payments Header".Date)
            {
            }
            column(PostingDate_PaymentHeader; "Payments Header"."Date Posted")
            {
            }
            column(Payee_PaymentHeader; "Payments Header".Payee)
            {
            }
            column(NetAmount_PaymentHeader; "Payments Header"."Total Net Amount")
            {
            }
            column(Cashier_PaymentHeader; "Payments Header".Cashier)
            {
            }
            column(GlobalDimension1Code_PaymentHeader; "Payments Header"."Global Dimension 1 Code")
            {
            }
            column(PaymentDescription_PaymentHeader; "Payments Header"."Payment Narration")
            {
            }
            column(Status_PaymentHeader; "Payments Header".Status)
            {
            }
            column(Approver_ID; ApproverID)
            {
            }
            column(GlobalDimension1Code_PaymentHeadertaea; "Payments Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PaymentHeadertaea; "Payments Header"."Shortcut Dimension 5 Code")
            {
            }
            trigger OnPreDataItem();
            begin
                AccNo := '';
                SRO := 0;
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
                TTotal := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                PayLines.Reset();
                PayLines.SetRange(PayLines.No, "Payments Header"."No.");
                if PayLines.Find('-') then
                    repeat
                        PayLines."Posted Date" := "Payments Header"."Date Posted";
                        PayLines."Posted Date" := "Payments Header"."Date Posted";
                        PayLines."Pay Mode" := "Payments Header"."Pay Mode";
                        PayLines."Date Posted" := "Payments Header"."Date Posted";
                        PayLines.Reversed := "Payments Header".reversed;
                        PayLines.Modify();
                    until PayLines.Next() = 0;

                SRO := SRO + 1;



                TTotal := TTotal + "Payments Header"."Total Net Amount";
                bankledger.Reset();
                bankledger.SetRange("Document No.", "No.");
                bankledger.SetRange(Reversed, true);
                bankledger.SetRange("Bank Account No.", "Paying Bank Account");
                if bankledger.Find('-') = true then
                    TTotal := TTotal - "Payments Header"."Total Net Amount";
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, TTotal, '');
                PaymentsLine.Reset();
                PaymentsLine.SetRange(PaymentsLine.No, "Payments Header"."No.");
                if PaymentsLine.Find('-') then
                    AccNo := PaymentsLine."Account No.";

                Approver.Reset();
                Approver.SetRange(Approver."Document No.", "Payments Header"."No.");
                Approver.SetRange(Approver.Status, Approver.Status::Approved);
                if Approver.Find('-') then
                    ApproverID := Approver."Approver ID";
                bankledger.Reset();
                bankledger.SetRange("Document No.", "No.");
                bankledger.SetRange(Reversed, true);
                bankledger.SetRange("Bank Account No.", "Paying Bank Account");
                if bankledger.Find('-') = true then
                    CurrReport.Skip();

            end;

        }
    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(Content)
            {

            }
        }

    }

    trigger OnPreReport()
    begin
        /*//RL
		UserSetup.GET(USERID);
		UserSetup.TESTFIELD("Location Code");
		UserSetup.TESTFIELD("User ID");
		"Payments Header".SETRANGE("Payments Header"."User ID",UserSetup."User ID");
		//RL*/
        "Payments Header".SetFilter(Cashier, UserId);

    end;

    var
        PaymentsLine: Record "Payment Line";
        AccNo: Code[20];
        CompInfo: Record "Company Information";
        SRO: Integer;
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[250];
        Approver: Record "Approval Entry";
        ApproverID: Text;
        UserSetup: Record "User Setup";
        PayLines: Record "Payment Line";
        bankledger: Record "Bank Account Ledger Entry";
}
