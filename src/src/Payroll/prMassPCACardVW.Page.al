Page 52202828 "prMassPCA Card VW"
{
    PageType = Card;
    SourceTable = prMassPCAHD;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ChangeAdviceSerialNo; Rec."Change Advice Serial No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Change Advice Serial No. field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(PeriodMonth; Rec."Period Month")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(Effected; Rec.Effected)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Effected field.';
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                part(Control12; prPCAMassLines)
                {
                    SubPageLink = "Change Advice Serial No." = field("Change Advice Serial No."),
                                  "Transaction Code" = field("Transaction Code"),
                                  "Period Month" = field("Period Month"),
                                  "Period Year" = field("Period Year"),
                                  "Payroll Period" = field("Payroll Period");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA;
                    begin

                        DocumentType := Documenttype::MassPCA;
                        ApprovalEntries.SetRecordFilters(Database::"prBasic pay PCA", DocumentType, Rec."Change Advice Serial No.");
                        ApprovalEntries.Run();
                    end;
                }
            }
            group(ActionGroup18)
            {
                Caption = 'Post';
                Visible = false;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post The Changes';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    ToolTip = 'Executes the Post The Changes action.';

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('PCA must be approved to continue');

                        mPayrollCode := '';

                        UserSetup.Reset();
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.Find('-') then;
                            // mPayrollCode:=UserSetup."Payroll Code";

                        objPeriod.Reset();
                        objPeriod.SetRange(objPeriod.Closed, false);
                        if objPeriod.Find('-') then begin
                            intMonth := objPeriod."Period Month";
                            intYear := objPeriod."Period Year";
                            dtPAyrollPeriod := objPeriod."Date Opened";
                        end;

                        if Confirm('Are you Sure you want to post these changes') then begin
                            Rec.Effected := true;

                            objLines.Reset();
                            objLines.SetRange(objLines."Change Advice Serial No.", Rec."Change Advice Serial No.");
                            if objLines.Find('-') then
                                repeat
                                begin

                                    if dim1 = '' then
                                        dim1 := objemp."Shortcut Dimension 1 Code";
                                    if dim2 = '' then
                                        dim2 := objemp."Shortcut Dimension 2 Code";
                                    if dim3 = '' then
                                        dim3 := objemp.Schools;
                                    if dim4 = '' then
                                        dim4 := objemp.Section;

                                    objEmpTrans.Reset();
                                    objEmpTrans.SetRange(objEmpTrans."Employee Code", objLines."Employee Code");
                                    objEmpTrans.SetRange(objEmpTrans."Payroll Period", objLines."Payroll Period");
                                    objEmpTrans.SetRange(objEmpTrans."Transaction Code", objLines."Transaction Code");
                                    objEmpTrans.SetRange(objEmpTrans."Payroll Code", mPayrollCode);
                                    if objEmpTrans.Find('-') then begin
                                        objEmpTrans."Employee Code" := objLines."Employee Code";
                                        objEmpTrans."Transaction Code" := objLines."Transaction Code";
                                        objEmpTrans."Period Month" := intMonth;
                                        objEmpTrans."Period Year" := intYear;
                                        objEmpTrans."Payroll Period" := dtPAyrollPeriod;
                                        objEmpTrans."Transaction Name" := objLines."Transaction Name";
                                        objEmpTrans.Amount := objLines.Amount;
                                        objEmpTrans."Payroll Period" := objLines."Payroll Period";
                                        objEmpTrans."Payroll Code" := mPayrollCode;
                                        objEmpTrans.Modify();
                                    end else begin
                                        objEmpTrans.Init();
                                        objEmpTrans."Employee Code" := objLines."Employee Code";
                                        objEmpTrans."Transaction Code" := objLines."Transaction Code";
                                        objEmpTrans."Period Month" := intMonth;
                                        objEmpTrans."Period Year" := intYear;
                                        objEmpTrans."Payroll Period" := dtPAyrollPeriod;
                                        objEmpTrans."Transaction Name" := objLines."Transaction Name";
                                        objEmpTrans.Amount := objLines.Amount;
                                        objEmpTrans."Payroll Period" := objLines."Payroll Period";
                                        objEmpTrans."Payroll Code" := mPayrollCode;
                                        objEmpTrans.Insert();
                                    end;
                                end;
                                until objLines.Next() = 0;

                            Rec.Effected := true;
                            Rec.Status := Rec.Status::Posted;
                            Rec.Modify();

                            Message('These changes has been uploaded to the current payroll');
                        end;
                    end;
                }
            }
        }
    }

    var
        objemp: Record "HR-Employee";
        objEmpTrans: Record "prEmployee Transactions";
        objLines: Record prMassPCALines;
        objPeriod: Record "prPayroll Periods";
        UserSetup: Record "User Setup";
        dim1: Code[50];
        dim2: Code[50];
        dim3: Code[50];
        dim4: Code[50];
        mPayrollCode: Code[50];
        dtPAyrollPeriod: Date;
        intMonth: Integer;
        intYear: Integer;
}
