Page 85371 "HMS Patient Billing"
{
    CardPageID = "HMS Patients Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS Patient";
    SourceTableView = where(Activated = filter(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DateRegistered; Rec."Date Registered")
                {
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(PatientRefNo; Rec."Patient Ref. No.")
                {
                    ToolTip = 'Specifies the value of the Patient Ref. No. field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Photo; Rec.Photo)
                {
                    ToolTip = 'Specifies the value of the Photo field.';
                }
                field(CorrespondenceAddress1; Rec."Correspondence Address 1")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 1 field.';
                }
                field(CorrespondenceAddress2; Rec."Correspondence Address 2")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 2 field.';
                }
                field(CorrespondenceAddress3; Rec."Correspondence Address 3")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 3 field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(TelephoneNo2; Rec."Telephone No. 2")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 2 field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(PatientCurrentLocation; Rec."Patient Current Location")
                {
                    ToolTip = 'Specifies the value of the Patient Current Location field.';
                }
                field(Activated; Rec.Activated)
                {
                    ToolTip = 'Specifies the value of the Activated field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PostCharges)
            {
                Caption = 'Post Charges';
                Image = PostedPayment;
                Promoted = true;
                ToolTip = 'Executes the Post Charges action.';
            }
            separator(Action26)
            {
            }
            separator(Action28)
            {
            }
            action("Calculate Reccuring Charges")
            {
                Image = Calculate;
                ToolTip = 'Executes the Calculate Reccuring Charges action.';

                trigger OnAction()
                begin
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    HMSPatientCharges.SetRange(HMSPatientCharges."Billing Type", HMSPatientCharges."billing type"::Reccuring);
                    HMSPatientCharges.SetCurrentkey(HMSPatientCharges."Patient No.", HMSPatientCharges."Billing Type", HMSPatientCharges."Reccuring Type", HMSPatientCharges.Date, HMSPatientCharges."Creation Time");
                    HMSPatientCharges.Ascending := false;
                    if HMSPatientCharges.Find('-') then begin
                        LastBillDate := HMSPatientCharges.Date;
                        Ln := HMSPatientCharges."Line No";
                        repeat
                            if HMSPatientCharges."Reccuring Type" = HMSPatientCharges."reccuring type"::Daily then
                                if Today <> LastBillDate then begin
                                    BillDays := Today - LastBillDate;
                                    for i := 1 to BillDays do begin
                                        Ln := Ln + 1;
                                        LastBillDate := LastBillDate + 1;
                                        HMSPatientCharges1.Init();
                                        HMSPatientCharges1."Line No" := Ln;
                                        HMSPatientCharges1."Patient No." := Rec."Patient No.";
                                        HMSPatientCharges1."Link No" := HMSPatientCharges."Link No";
                                        HMSPatientCharges1."Treatment No." := HMSPatientCharges."Treatment No.";
                                        HMSPatientCharges1."Shortcut Dimension 1 Code" := HMSPatientCharges."Shortcut Dimension 1 Code";
                                        HMSPatientCharges1."Transaction Type" := HMSPatientCharges."Transaction Type";
                                        HMSPatientCharges1.Code := HMSPatientCharges.Code;
                                        HMSPatientCharges1.Description := HMSPatientCharges.Description;
                                        HMSPatientCharges1.Amount := HMSPatientCharges.Amount;
                                        HMSPatientCharges1.Date := LastBillDate;
                                        HMSPatientCharges1."Billing Type" := HMSPatientCharges."Billing Type";
                                        HMSPatientCharges1.Quantity := 1;
                                        HMSPatientCharges1.Insert();
                                    end;
                                end;
                            if HMSPatientCharges."Reccuring Type" = HMSPatientCharges."reccuring type"::Hourly then
                                if Today >= LastBillDate then begin
                                    BillDays := Today - LastBillDate;
                                    for i := 1 to BillDays do begin
                                        Ln := Ln + 1;
                                        LastBillDate := LastBillDate + 1;
                                        HMSPatientCharges1.Init();
                                        HMSPatientCharges1."Line No" := Ln;
                                        HMSPatientCharges1.Quantity := 1;
                                        HMSPatientCharges1."Patient No." := Rec."Patient No.";
                                        HMSPatientCharges1."Link No" := HMSPatientCharges."Link No";
                                        HMSPatientCharges1."Treatment No." := HMSPatientCharges."Treatment No.";
                                        HMSPatientCharges1."Shortcut Dimension 1 Code" := HMSPatientCharges."Shortcut Dimension 1 Code";
                                        HMSPatientCharges1."Transaction Type" := HMSPatientCharges."Transaction Type";
                                        HMSPatientCharges1.Code := HMSPatientCharges.Code;
                                        HMSPatientCharges1.Description := HMSPatientCharges.Description;
                                        if Today <> LastBillDate then
                                            HMSPatientCharges1.Quantity := 24
                                        else
                                            HMSPatientCharges1.Quantity := (Time - HMSPatientCharges."Creation Time");
                                        HMSPatientCharges1.Amount := HMSPatientCharges.Amount * HMSPatientCharges1.Quantity;
                                        HMSPatientCharges1.Date := LastBillDate;
                                        HMSPatientCharges1."Billing Type" := HMSPatientCharges."Billing Type";
                                        HMSPatientCharges1.Insert();
                                    end;
                                end;
                        until HMSPatientCharges.Next() = 0;
                    end;
                    Message('Completed Successfully');
                end;
            }
            separator(Action30)
            {
            }
        }
        area(reporting)
        {
            action(PrintInterimInvoice)
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Interim Invoice action.';

                trigger OnAction()
                begin
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    if HMSPatientCharges.Find('-') then
                        Report.Run(70135521, true, true, HMSPatientCharges);
                end;
            }
        }
    }

    var
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSPatientCharges1: Record "HMS Patient Charges";
        LastBillDate: Date;
        BillDays: Integer;
        i: Integer;
        Ln: Integer;
}
