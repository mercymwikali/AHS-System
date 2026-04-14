namespace PTL.HMISBC;
using Microsoft.Foundation.Company;
using System.Security.AccessControl;
using Microsoft.Bank.Check;
using Microsoft.Sales.Customer;
using System.Security.User;

report 85063 "Customer Receipt"
{
    ApplicationArea = All;
    Caption = 'Customer Receipt';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CustomerReceipt.rdl';
    dataset
    {
        dataitem(ReceiptsHeader; "Receipts Header")
        {
            RequestFilterFields = "No.";
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
            column(companyInfo_City; companyInfo.City) { }
            column(companyInfo_Email; companyInfo."E-Mail") { }
            column(HeaderNo; ReceiptsHeader."No.")
            {
            }
            column(HeaderDate; ReceiptsHeader.Date)
            {
            }
            column(UserID; ReceiptsHeader.Cashier)
            {
            }
            column(AcctName; AcctName)
            {
            }
            column(RegNo; RegNo)
            {
            }
            column(RecFrom; ReceiptsHeader."Received From")
            {
            }
            column(PatientNo_ReceiptsHeader; ReceiptsHeader."Patient No.")
            {
            }
            column(CheqNo; ReceiptsHeader."Cheque No.")
            {
            }
            column(AmountReceived; ReceiptsHeader."Amount Recieved")
            {
            }
            column(UserName; Username)
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
            trigger OnPreDataItem()
            begin
                companyInfo.Get();
                companyInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;

                Clear(UserName);
                usersTable.Reset();
                usersTable.SetRange(usersTable."User Name", ReceiptsHeader."Posted By");
                if usersTable.Find('-') then begin
                    if usersTable."Full Name" <> '' then
                        UserName := usersTable."Full Name"
                    else
                        UserName := ReceiptsHeader."Posted By";
                end else
                    UserName := ReceiptsHeader."Posted By";
                //CheckReport.FormatNoText(NumberText,ReceiptsHeader."Amount Recieved",'');

                //CheckReport.InitTextVariable();
                //CheckReport.FormatNoText(NumberText,ReceiptsHeader."Amount Recieved",'');

                ReUser.Reset();
                ReUser.SetRange("User ID", ReceiptsHeader."Posted By");
                if ReUser.Find('-') then
                    ReUser.CalcFields(Signature);

                receiptLine.Reset();
                receiptLine.SetRange(receiptLine.No, ReceiptsHeader."No.");
                if receiptLine.Find('-') then
                    repeat
                        TotalAmount := TotalAmount + receiptLine.Amount;
                    until receiptLine.Next() = 0;

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, TotalAmount, '');

                if ReceiptsHeader."Customer No" <> '' then begin
                    Customer.Get(ReceiptsHeader."Customer No");
                    DoctorName := Customer.Name;
                end;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        companyInfo: Record "Company Information";
        Appoint: Record "HMS Appointment Form Header";
        Pat: Record "HMS Patient";
        receiptLine: Record "Receipt Line q";
        usersTable: Record User;
        ReUser: Record "User Setup";
        CheckReport: Report Check;
        Customer: Record Customer;
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
