Report 85164 "Receipts Report A4"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsReportA4.rdl';

    dataset
    {
        dataitem("Receipts Header"; "Receipts Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1102755004; 1102755004)
            {
            }
            column(CompInfo; companyInfo.Name)
            {
            }
            column(CompAddr; companyInfo.Address)
            {
            }
            column(CompPhone; companyInfo."Phone No. 2")
            {
            }
            column(CompFax; companyInfo."Fax No.")
            {
            }
            column(CompPic; companyInfo.Picture)
            {
            }
            column(HeaderNo; "Receipts Header"."No.")
            {
            }
            column(HeaderDate; "Receipts Header".Date)
            {
            }
            column(UserID; "Receipts Header".Cashier)
            {
            }
            column(AcctName; AcctName)
            {
            }
            column(RegNo; RegNo)
            {
            }
            column(RecFrom; "Receipts Header"."Received From")
            {
            }
            column(PatientNo_ReceiptsHeader; "Receipts Header"."Patient No.")
            {
            }
            column(CheqNo; "Receipts Header"."Cheque No.")
            {
            }
            column(AmountReceived; "Receipts Header"."Amount Recieved")
            {
            }
            column(UserName; CopyStr(UserName, 12, 20))
            {
            }
            column(pic; companyInfo.Picture)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(DoctorName; DoctorName)
            {
            }
            column(Age; Age)
            {
            }
            column(Gender; Gender)
            {
            }
            column(UserSignature; ReUser.Signature)
            {
            }
            dataitem("Receipt Line q"; "Receipt Line q")
            {
                DataItemLink = No = field("No.");
                column(ReportForNavId_1102755006; 1102755006)
                {
                }
                column(RecLineNo; "Receipt Line q"."Account No.")
                {
                }
                column(RecLineAcctName; "Receipt Line q"."Account Name")
                {
                }
                column(Amount; "Receipt Line q".Amount)
                {
                }
                column(Date_ReceiptLineq; "Receipt Line q".Date)
                {
                }
                column(No_ReceiptLineq; "Receipt Line q".No)
                {
                }
                column(NumberText_1_; NumberText[1])
                {
                }
                column(PayMode; "Receipt Line q"."Pay Mode")
                {
                }
                column(TRanName; "Receipt Line q"."Transaction Name")
                {
                }
                column(Quantity_ReceiptLineq; "Receipt Line q".Quantity)
                {
                }
                column(BankCode; "Receipt Line q"."Bank Code")
                {
                }
                column(ChequeDepositSlipNo; "Receipt Line q"."Cheque/Deposit Slip No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //TotalAmount:=TotalAmount+"Receipt Line q".Amount;

                    //CheckReport.InitTextVariable;
                    //CheckReport.FormatNoText(NumberText,TotalAmount,'');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;

                Clear(UserName);
                usersTable.Reset();
                usersTable.SetRange(usersTable."User Name", "Receipts Header".Cashier);
                if usersTable.Find('-') then begin
                    if usersTable."Full Name" <> '' then
                        UserName := usersTable."Full Name"
                    else
                        UserName := "Receipts Header".Cashier;
                end else
                    UserName := "Receipts Header".Cashier;
                //CheckReport.FormatNoText(NumberText,"Receipts Header"."Amount Recieved",'');

                //CheckReport.InitTextVariable();
                //CheckReport.FormatNoText(NumberText,"Receipts Header"."Amount Recieved",'');

                ReUser.Reset();
                ReUser.SetRange("User ID", "Receipts Header".Cashier);
                if ReUser.Find('-') then
                    ReUser.CalcFields(Signature);

                receiptLine.Reset();
                receiptLine.SetRange(receiptLine.No, "Receipts Header"."No.");
                if receiptLine.Find('-') then
                    repeat
                        TotalAmount := TotalAmount + receiptLine.Amount;
                    until receiptLine.Next() = 0;

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, TotalAmount, '');

                Pat.Reset();
                Pat.SetRange("Patient No.", "Receipts Header"."Patient No.");
                if Pat.Find('-') then begin
                    PhoneNo := Pat."Telephone No. 1";
                    Gender := Format(Pat.Gender);
                    Age := Format(Pat."Age in Years");
                end;

                Appoint.Reset();
                Appoint.SetRange("Appointment No.", "Receipts Header"."Patient Appointment No");
                if Appoint.Find('-') then
                    DoctorName := Appoint."Doctors Name";
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
        companyInfo.Reset();
        if companyInfo.Find('-') then
            companyInfo.CalcFields(Picture);
    end;

    var
        companyInfo: Record "Company Information";
        Appoint: Record "HMS Appointment Form Header";
        Pat: Record "HMS Patient";
        receiptLine: Record "Receipt Line q";
        usersTable: Record User;
        ReUser: Record "User Setup";
        CheckReport: Report Check;
        RegNo: Code[30];
        TotalAmount: Decimal;
        Age: Text;
        DoctorName: Text;
        Gender: Text;
        PhoneNo: Text;
        NumberText: array[2] of Text[120];
        AcctName: Text[150];
        UserName: Text[250];
}
