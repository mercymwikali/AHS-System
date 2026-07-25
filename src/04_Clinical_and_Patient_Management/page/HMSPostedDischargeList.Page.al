Page 85414 "HMS Posted Discharge List"
{
    CardPageID = "HMS Posted Discharge header";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HMS Admission Discharge Header";
    SourceTableView = where(Status = filter(Completed));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(AdmissionNo; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.';
                }
                field(Date; Rec."Discharge Date")
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Time; Rec."Discharge Time")
                {
                    Caption = 'Time';
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field(WardNo; Rec."Ward No.")
                {
                    ToolTip = 'Specifies the value of the Ward No. field.';
                }
                field(BedNo; Rec."Bed No.")
                {
                    ToolTip = 'Specifies the value of the Bed No. field.';
                }
                field(DateofAdmission; Rec."Date of Admission")
                {
                    ToolTip = 'Specifies the value of the Date of Admission field.';
                }
                field(TimeOfAdmission; Rec."Time Of Admission")
                {
                    ToolTip = 'Specifies the value of the Time Of Admission field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Search Names"; Rec."Search Names")
                {
                    caption = 'Patient Name';
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(NurseID; Rec."Nurse ID")
                {
                    ToolTip = 'Specifies the value of the Nurse ID field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(BillBalance; Rec."Bill Balance")
                {
                    ToolTip = 'Specifies the value of the Bill Balance field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(InsuranceName; "Insurance Name")
                {
                    Caption = 'Insurance Name';
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("39005475")
            {
                Caption = 'Charges Summary';
                Image = "Report";
                ToolTip = 'Executes the Charges Summary action.';

                trigger OnAction()
                begin
                    objPatientCharges.Reset();
                    objPatientCharges.SetRange(objPatientCharges."Patient No.", Rec."Patient No.");
                    objPatientCharges.SetRange(objPatientCharges.Recognized, false);
                    if objPatientCharges.Find('-') then
                        Report.Run(39005475, true, true, objPatientCharges);
                end;
            }
            action(TreatmentSheet)
            {
                Caption = 'Treatment Sheet';
                Image = "Report";
                ToolTip = 'Executes the Treatment Sheet action.';

                trigger OnAction()
                begin
                    TreatmentFormSummary.Reset();
                    TreatmentFormSummary.SetRange(TreatmentFormSummary."Patient No.", Rec."Patient No.");
                    if TreatmentFormSummary.Find('-') then
                        Report.Run(39005540, true, true, TreatmentFormSummary);
                end;
            }
            separator(Action4)
            {
            }
            action("Generate Insurance Invoice")
            {
                Image = Invoice;
                Visible = false;
                ToolTip = 'Executes the Generate Insurance Invoice action.';

                trigger OnAction()
                begin
                    PatientCharges.Reset();
                    PatientCharges.SetRange(PatientCharges."Patient No.", Rec."Patient No.");
                    PatientCharges.SetRange(PatientCharges.Posted, false);
                    if PatientCharges.Find('-') then
                        repeat
                            if HMSPatientCharges."Insurance No" = '' then begin
                                Patients.Get(Rec."Patient No.");
                                Patients.TestField(Patients."Insurance No.");
                                HMSPatientCharges."Insurance No" := Patients."Insurance No.";
                                HMSPatientCharges.Modify();
                            end;
                        until PatientCharges.Next() = 0;

                    if HMSPat.Get(Rec."Patient No.") then begin
                        HMSPatientCharges.Reset();
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", HMSPat."Active Visit No");
                        if HMSPatientCharges.Find('-') then
                            Report.Run(51932, true, true, HMSPatientCharges);
                    end;
                end;
            }
            action(PrintInterimInvoice)
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Interim Invoice action.';

                trigger OnAction()
                begin
                    /*
                    HMSPatientCharges.RESET;
                    HMSPatientCharges.SETFILTER(HMSPatientCharges."Patient No.","Patient No.");
                    IF HMSPatientCharges.FIND('-') THEN
                    REPORT.RUN(39005476,TRUE,TRUE,HMSPatientCharges);
                    */
                    if HMSPat.Get(Rec."Patient No.") then begin
                        HMSPatientCharges.Reset();
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", HMSPat."Active Visit No");
                        if HMSPatientCharges.Find('-') then
                            Report.Run(70135521, true, true, HMSPatientCharges);
                    end;
                end;
            }
            action(PrintPostedNHIFInvoice)
            {
                Caption = '&Print Posted NHIF Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Posted NHIF Invoice action.';

                trigger OnAction()
                begin
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    if HMSPatientCharges.Find('-') then
                        Report.Run(39005479, true, true, HMSPatientCharges);
                end;
            }
            action(PrintInterimNHIFInvoice)
            {
                Caption = '&Print Interim NHIF Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Interim NHIF Invoice action.';

                trigger OnAction()
                begin
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    if HMSPatientCharges.Find('-') then
                        Report.Run(39005516, true, true, HMSPatientCharges);
                end;
            }
            action(RefreshNames)
            {
                Caption = '&Refresh Names';
                Image = Refresh;
                Promoted = true;
                ToolTip = 'Executes the &Refresh Names action.';

                trigger OnAction()

                var
                    DisHeader: Record "HMS Admission Discharge Header";
                begin
                    DisHeader.Reset();
                    DisHeader.SetFilter(DisHeader."Search Names", '%1', '');
                    if DisHeader.Find('-') then
                        if Patients.get(Rec."Patient No.") then begin
                            DisHeader."Search Names" := Patients."Search Name";
                            DisHeader.modify();
                        end;
                    message('Completed');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if HMSPat.Get(Rec."Patient No.") then begin
            PatientName := HMSPat."Search Name";
            if Rec."Search Names" = '' then
                Rec."Search Names" := HMSPat."Search Name";
            HMSPatientCharges.Reset();
            HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
            HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", HMSPat."Active Visit No");
            if HMSPatientCharges.Find('-') then begin
                HMSPatientCharges.CalcFields("Insurance Name");
                "Insurance Name" := HMSPatientCharges."Insurance Name";
            end;
        end;
    end;

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if UserRec.get(Database.UserId) then
            if userrec."Branch Code" <> '' then
                Rec.setfilter(Branch, UserRec."Branch Code");
    end;

    var
        HMSPat: Record "HMS Patient";
        Patients: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        objPatientCharges: Record "HMS Patient Charges";
        PatientCharges: Record "HMS Patient Charges";
        HMSPatIns: Record "HMS Patient Insuarance";
        TreatmentFormSummary: Record "HMS Treatment Form Header";
        "Insurance Name": Text;
        PatientName: text[200];

    local procedure GenerateInvoice()
    var
        Patients: Record "HMS Patient";
        PatientCharges: Record "HMS Patient Charges";
        SalesSetup: Record "Sales & Receivables Setup";
        SaleH: Record "Sales Header";
        SLine: Record "Sales Line";
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        LineNo: Integer;
    begin

        // Generate Default insurance invoice
        Patients.Get(Rec."Patient No.");
        Patients.TestField(Patients."Insurance No.");
        SalesSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);

        SaleH.Init();
        SaleH."Document Type" := SaleH."document type"::Invoice;
        SaleH."No." := NewNo;
        SaleH."Sell-to Customer No." := Patients."Insurance No.";
        SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
        SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
        SaleH."Patient No." := Rec."Patient No.";
        SaleH.Insert();

        if SaleH.Get(SaleH."document type"::Invoice, NewNo) then begin

            SaleH.Validate("Sell-to Customer No.");
            SaleH.Validate("Shortcut Dimension 1 Code");
            SaleH.Validate("Shortcut Dimension 2 Code");

            SLine.Reset();
            SLine.SetRange("Document No.", SaleH."No.");
            if SLine.Find('-') then
                SLine.DeleteAll();

            if SLine.FindLast() then
                LineNo := SLine."Line No." + 1;

            PatientCharges.Reset();
            PatientCharges.SetRange(PatientCharges."Patient No.", Rec."Patient No.");
            PatientCharges.SetRange(PatientCharges."Insurance No", Patients."Insurance No.");
            PatientCharges.SetRange(PatientCharges.Posted, false);
            if PatientCharges.Find('-') then
                repeat
                    if PatientCharges.Amount > 0 then begin
                        SLine.Init();
                        SLine."Line No." := LineNo;
                        SLine."Document No." := SaleH."No.";
                        SLine."Document Type" := SaleH."Document Type";
                        SLine."Sell-to Customer No." := Patients."Insurance No.";
                        SLine.Type := SLine.Type::"G/L Account";
                        PatientCharges.CalcFields("G/L Account");
                        SLine."No." := PatientCharges."G/L Account";
                        SLine.Description := PatientCharges.Description;
                        if PatientCharges.Quantity > 0 then
                            SLine.Quantity := PatientCharges.Quantity
                        else
                            SLine.Quantity := 1;
                        SLine.Validate(SLine.Quantity);
                        SLine."Unit Price" := PatientCharges.Amount;
                        if PatientCharges."Insurance Amount" > 0 then begin
                            SLine.Amount := PatientCharges."Insurance Amount";
                            SLine."Unit Price" := PatientCharges."Insurance Amount";
                        end else begin
                            SLine.Amount := PatientCharges.Amount;
                            SLine."Unit Price" := PatientCharges.Amount;
                        end;

                        SLine.Validate("Unit Price");
                        SLine."Gen. Bus. Posting Group" := 'LOCAL';
                        SLine."Gen. Prod. Posting Group" := 'SERVICES';
                        SLine."Charge Code" := PatientCharges.Code;
                        SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                        SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                        SLine.Insert();
                        LineNo := LineNo + 1;

                        PatientCharges."Invoice Number" := SaleH."No.";
                        PatientCharges.Posted := true;
                        PatientCharges.Modify();
                    end;
                until PatientCharges.Next() = 0;
            // Generate Other Insurance Invoices
            HMSPatIns.Reset();
            HMSPatIns.SetRange(HMSPatIns."Patient No", Rec."Patient No.");
            HMSPatIns.SetFilter(HMSPatIns."Open Invoices", '>%1', 0);
            if HMSPatIns.Find('-') then
                repeat
                    if HMSPatIns."Insurance No" <> Patients."Insurance No." then begin
                        NewNo := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);
                        SaleH.Init();
                        SaleH."Document Type" := SaleH."document type"::Invoice;
                        SaleH."No." := NewNo;
                        SaleH."Sell-to Customer No." := HMSPatIns."Insurance No";
                        SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                        SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                        SaleH."Patient No." := Rec."Patient No.";
                        SaleH.Insert();
                        if SaleH.Get(SaleH."document type"::Invoice, NewNo) then begin
                            SaleH.Validate("Sell-to Customer No.");
                            SaleH.Validate("Shortcut Dimension 1 Code");
                            SaleH.Validate("Shortcut Dimension 2 Code");
                            SLine.Reset();
                            SLine.SetRange("Document No.", SaleH."No.");
                            if SLine.Find('-') then
                                SLine.DeleteAll();
                        end;
                        if SLine.FindLast() then
                            LineNo := SLine."Line No." + 1;
                        PatientCharges.Reset();
                        PatientCharges.SetRange(PatientCharges."Patient No.", Rec."Patient No.");
                        PatientCharges.SetRange(PatientCharges."Insurance No", HMSPatIns."Insurance No");
                        PatientCharges.SetRange(PatientCharges.Posted, false);
                        if PatientCharges.Find('-') then
                            repeat
                                if PatientCharges.Amount > 0 then begin
                                    SLine.Init();
                                    SLine."Line No." := LineNo;
                                    SLine."Document No." := NewNo;
                                    SLine."Document Type" := SaleH."Document Type";
                                    SLine."Sell-to Customer No." := HMSPatIns."Insurance No";
                                    SLine.Type := SLine.Type::"G/L Account";
                                    PatientCharges.CalcFields("G/L Account");
                                    SLine."No." := PatientCharges."G/L Account";
                                    SLine.Description := PatientCharges.Description;
                                    SLine.Quantity := 1;
                                    SLine.Validate(SLine.Quantity);

                                    if PatientCharges."Insurance Amount" > 0 then begin
                                        SLine.Amount := PatientCharges."Insurance Amount";
                                        SLine."Unit Price" := PatientCharges."Insurance Amount";
                                    end else begin
                                        SLine.Amount := PatientCharges.Amount;
                                        SLine."Unit Price" := PatientCharges.Amount;
                                    end;
                                    SLine.Validate("Unit Price");
                                    SLine."Gen. Bus. Posting Group" := 'LOCAL';
                                    SLine."Gen. Prod. Posting Group" := 'SERVICES';
                                    SLine."Charge Code" := PatientCharges.Code;
                                    SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                                    SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                                    SLine.Insert();
                                    LineNo := LineNo + 1;

                                    PatientCharges."Invoice Number" := NewNo;
                                    PatientCharges.Posted := true;
                                    PatientCharges.Modify();
                                end;
                            until PatientCharges.Next() = 0;
                    end;
                until HMSPatIns.Next() = 0;

            Message('Invoice No ' + NewNo + ' has been successfuly created');
        end;
    end;
}
