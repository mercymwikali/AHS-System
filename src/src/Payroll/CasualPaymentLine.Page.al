Page 52203148 "Casual Payment Line"
{
    PageType = ListPart;
    SourceTable = "Casual Payment Lines";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DocumentNo; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(PayStutatories; Rec."Pay Stutatories")
                {
                    ToolTip = 'Specifies the value of the Pay Stutatories field.';
                }
                field(BankCode; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(BankName; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(BankAccountNo; Rec."Bank Account No")
                {
                    ToolTip = 'Specifies the value of the Bank Account No field.';
                }
                field(Occupation; Rec.Occupation)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Occupation field.';
                }
                field(NoofDays; Rec."No of Days")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the No of Days field.';
                }
                field(PeriodMonth; Rec."Period (Month)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period (Month) field.';
                }
                field(PayRate; Rec."Pay Rate")
                {
                    ToolTip = 'Specifies the value of the Pay Rate field.';
                }
                field(RatePerDay; Rec."Rate per Date")
                {
                    Caption = 'Rate Per Day';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Rate Per Day field.';
                }
                field(RateperMonth; Rec."Rate per Month")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Rate per Month field.';
                }
                field(PensionAmount; Rec."Pension Amount")
                {
                    ToolTip = 'Specifies the value of the Pension Amount field.';
                }
                field(KUSUAmount; Rec."KUSU Amount")
                {
                    ToolTip = 'Specifies the value of the KUSU Amount field.';
                }
                field(UASUAmount; Rec."UASU Amount")
                {
                    ToolTip = 'Specifies the value of the UASU Amount field.';
                }
                field("Total Amount To be Payed"; Rec."Basic Amount")
                {
                    ToolTip = 'Specifies the value of the Basic Amount field.';
                }
                field(PAYEAmount; Rec."PAYE Amount")
                {
                    ToolTip = 'Specifies the value of the PAYE Amount field.';
                }
                field(NSSFAmount; Rec."NSSF Amount")
                {
                    ToolTip = 'Specifies the value of the NSSF Amount field.';
                }
                field(NHIFAmount; Rec."NHIF Amount")
                {
                    ToolTip = 'Specifies the value of the NHIF Amount field.';
                }
                field(NetPay; Rec."Net Pay")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Net Pay field.';
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PrintPayslip)
            {
                Image = PrintAcknowledgement;
                Promoted = true;
                ToolTip = 'Executes the PrintPayslip action.';

                trigger OnAction()
                begin
                    CasualEmployees.Reset();
                    CasualEmployees.SetRange(CasualEmployees."Casual No", Rec."Employee No");

                    if CasualEmployees.Find('-') then
                        Report.Run(70135586, true, false, CasualEmployees);
                end;
            }
            action("Print CBA Report")
            {
                Image = PrintCover;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print CBA Report action.';

                trigger OnAction()
                begin
                    CasualPaymentLines.Reset();
                    CasualPaymentLines.SetRange("Document No.", Rec."Document No.");
                    CasualPaymentLines.SetRange(CasualPaymentLines."Employee No", Rec."Employee No");
                    if CasualPaymentLines.FindSet() then
                        Report.Run(51076, true, false, CasualPaymentLines);
                end;
            }
            action("Import Employees")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Import Employees action.';

                trigger OnAction()
                begin
                    //************************Instruction****************************
                    CasualPaymentHeader.Reset();
                    CasualPaymentHeader.SetRange(CasualPaymentHeader."No.", Rec."Document No.");
                    //CasualPaymentHeader.SETRANGE(CasualPaymentHeader."Employee Type",CasualPaymentHeader."Employee Type"::"Part-Timer");
                    if CasualPaymentHeader.Find('-') then begin
                        CasualPaymentHeader.TestField("Employee Type");
                        if (CasualPaymentHeader."Employee Type" = CasualPaymentHeader."employee type"::"Part-Timer") or (CasualPaymentHeader."Employee Type" = CasualPaymentHeader."employee type"::Casual) then begin
                            if Confirm(ook, true, 'Part-Timers employees') then
                                Xmlport.Run(70134771)
                            else
                                Message('cancelled by %1', UserId);
                        end else
                            if CasualPaymentHeader."Employee Type" = CasualPaymentHeader."employee type"::Permanent then
                                if Confirm(ok, true, 'Permanent employees') then
                                    Xmlport.Run(70134772)
                                else
                                    Message('cancelled by %1', UserId);
                    end;
                end;
            }
            action(Validate)
            {
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Validate action.';

                trigger OnAction()
                begin
                    CasualPaymentLines.Reset();
                    CasualPaymentLines.SetRange("Document No.", Rec."Document No.");
                    if CasualPaymentLines.FindSet() then
                        Report.Run(70135654, true, false, CasualPaymentLines);
                end;
            }
        }
    }

    var
        CasualEmployees: Record "Casual Employees";
        CasualPaymentHeader: Record "Casual Payment Header";
        CasualPaymentLines: Record "Casual Payment Lines";
        ok: label '''Instruction kindly arrange your excel in this format: Document No.,Payroll period,Line No.Employee No,Amount '';';
        ook: label '''Instruction kindly arrange your excel in this format: Document No.,Payroll period,Line No.ID Number,Amount '';';
}
