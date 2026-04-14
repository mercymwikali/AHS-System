page 85394 "HMS Pharmacy Header"
{
    PageType = Document;
    SourceTable = "HMS Pharmacy Header";
    SourceTableView = WHERE(Status = filter(<> Completed));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                ShowCaption = false;
                grid(Control31)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                }
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Pharmacy Date"; Rec."Pharmacy Date")
                {
                    // Editable = false;
                    // Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Pharmacy Time"; Rec."Pharmacy Time")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Sale"; Rec."Cash Sale")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Request Area"; Rec."Request Area")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Issuing Location"; Rec."Issuing Location")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        /*  if UserRec.Get(UserId) then begin
                             if ("Issuing Location" = UserRec."Default Store Location") or ("Issuing Location" = UserRec."Location Code") then begin
                                 UserRec.Get(UserId);
                             end else begin
                                 Error('You are not assigned to this store');
                             end;
                         end; */
                    end;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Surname+' '+""Last Name"""; Rec.Surname + ' ' + Rec."Last Name")
                {
                    Caption = 'Names';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Receptionist; Rec.Receptionist)
                {
                    ApplicationArea = Basic, Suite;
                }
                grid(Control22)
                {
                    ShowCaption = false;
                    group(Control30)
                    {
                        ShowCaption = false;

                    }
                }
                field(Age; Rec.Age)
                {
                    Caption = 'Age in Years';
                    // DateFormula = true;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                }
                field("Patient.Inpatient"; Patient.Inpatient)
                {
                    Caption = 'In patient';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    Caption = 'Insurance';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("ADM No"; Rec."ADM No")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }

                field("Issued By"; Rec."Issued By")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                grid(Control29)
                {
                    ShowCaption = false;

                }
                field("Receipt Count"; Rec."Receipt Count")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Link No."; Rec."Link No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Visit Total"; Rec."Visit Total")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Visit Total");
                        Rec.CalcFields("Total Price");
                        "Total Bill" := Rec."Total Price" + Rec."Visit Total";
                    end;
                }
                field("Total Price"; Rec."Total Price")
                {
                    Caption = 'Pharmacy Total Price';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Visit Total");
                        Rec.CalcFields("Total Price");
                        "Total Bill" := Rec."Total Price" + Rec."Visit Total";
                    end;
                }
                field("Total Receipts"; Rec."Total Receipts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Bill"; "Total Bill")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Items)
            {
                Caption = 'Items';
                part(Control1102760001; "HMS Pharmacy Line")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Pharmacy No." = FIELD("Pharmacy No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Post Drug Issuance")
            {
                Caption = 'Post Drug Issuance';
                Image = Post;
                Promoted = true;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                    HMSPharmacyHeader: Record "HMS Pharmacy Header";
                    HMSPatientPresctiption: Report "HMS Patient Prescription";
                begin
                    if Confirm('Do you wish to post the record?', false) = false then begin exit end;
                    if CuHMSProcesses.FnPharmacyPostDrugIssuance(Rec) then begin
                        HMSPharmacyHeader.Reset();
                        HMSPharmacyHeader.SetRange(HMSPharmacyHeader."Pharmacy No.", Rec."Pharmacy No.");
                        if HMSPharmacyHeader.FindFirst then
                            REPORT.Run(Report::"HMS Patient Prescription", false, false, HMSPharmacyHeader);
                    end;

                end;
            }
            action("Charge Patient")
            {
                Caption = 'Charge Patient';
                Visible = false;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    //IF "Cash Sale" = TRUE THEN
                    if Confirm('This will charge the patientDo you wish to post the record?', false) = false then begin exit end;
                    Rec.ChargePatient;
                end;
            }
            action("Print Drug Prescription")
            {
                Caption = 'Print Drug Prescription';
                Image = Print;
                ApplicationArea = Basic, Suite;
                // RunObject = report "HMS Prescription";
                trigger OnAction()
                var
                    HMSPharmacyHeader: Record "HMS Pharmacy Header";
                    HMSPatientPresctiption: Report "HMS Patient Prescription";
                begin
                    if Confirm('Do you want to print the prescription') = true then begin
                        PharmHeader.Reset();
                        PharmHeader.SetRange(PharmHeader."Pharmacy No.", Rec."Pharmacy No.");
                        if PharmHeader.FindFirst then
                            REPORT.Run(Report::"HMS Patient Prescription", true, false, PharmHeader);
                        // HMSPatientPresctiption.SetTableView(Rec);
                        // HMSPatientPresctiption.Run();
                    end;
                end;
            }
            action("Refresh Unit Price")
            {
                Image = Refresh;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    PharmLine.Reset;
                    PharmLine.SetRange(PharmLine."Pharmacy No.", Rec."Pharmacy No.");
                    if PharmLine.Find('-') then begin
                        repeat
                            if PharmLine."Unit Price" = 0 then Error('Please enter the unit price in all lines');
                            ValueEntry.Reset;
                            ValueEntry.SetRange(ValueEntry."Item No.", PharmLine."No.");
                            if ValueEntry.Find('-') then begin
                                repeat
                                    ValueEntry."Cost per Unit" := PharmLine."Unit Price";
                                    ValueEntry.Modify;
                                until ValueEntry.Next = 0;
                            end;
                        until PharmLine.Next = 0;

                    end;
                end;
            }
            action("Print Prescription")
            {
                Caption = 'Print Prescription';
                RunObject = Report "HMS Patient Prescription";
                Visible = false;
                ApplicationArea = Basic, Suite;
                /*  trigger OnAction()
                 begin
                     PharmLine.Reset;
                     PharmLine.SetRange(PharmLine."Pharmacy No.", "Pharmacy No.");
                     if PharmLine.Find('-') then
                         REPORT.Run(70135231, false, false, PharmLine);

                 end; */
            }
            action("Archive")
            {
                Caption = 'Archive Prescription';
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    PatCharges: Record "HMS Patient Charges";
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    if confirm('Do you really want to archive the prescription?', false) then begin
                        CuHMSProcesses.FnPharmacyArchivePrescription(rec);
                    end;
                end;


            }
            /* action("&Print Interim Invoice")
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    HMSPat.Reset;
                    HMSPat.SetRange(HMSPat."Patient No.", "Patient No.");
                    if HMSPat.Find('-') then begin
                        HMSPatientsCharges.Reset;
                        HMSPatientsCharges.SetFilter(HMSPatientsCharges."Patient No.", "Patient No.");
                        //HMSPatientsCharges.SETFILTER(HMSPatientsCharges."Visit No",HMSPat."Active Visit No");
                        if HMSPatientsCharges.Find('-') then
                            REPORT.Run(70135521, true, true, HMSPatientsCharges);
                    end;
                end;
            } */
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Price");
        Rec.CalcFields(Surname);
        Rec.CalcFields("Last Name");

        if UserRec.Get(Database.UserId) then begin
            // "Issuing Location" := UserRec."Default Store Location";
            // Validate("Issuing Location");
            if UserRec."Default Transaction Type" <> '' then
                Rec."Transaction Type" := UserRec."Default Transaction Type";
        end;

        Rec.CalcFields("Visit Total");
        Rec.CalcFields("Total Price");
        "Total Bill" := Rec."Total Price" + Rec."Visit Total";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::New;
        Rec."Issued By" := UserId;
        Rec."Pharmacy Date" := Today;
        Rec."Pharmacy Time" := Time;

        if UserRec.Get(UserId) then
            Rec."Issuing Location" := UserRec."Location Code";
        Rec."Transaction Type" := UserRec."Default Transaction Type";
    end;

    var
        PatientName: Text[100];
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
        HMSSetup: Record "HMS Setup";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        Patient: Record "HMS Patient";
        TreatmentLine: Record "HMS Treatment Form Drug";
        ValueEntry: Record "Value Entry";
        HMSPatientsCharges: Record "HMS Patient Charges";
        objItem: Record Item;
        AppH: Record "HMS Appointment Form Header";
        UserRec: Record "User Setup";
        PatientCharge: Record "HMS Patient Charges";
        HMSCU: Codeunit "HMS Patient-integration";
        InventorySetup: Record "Inventory Setup";
        HMSPat: Record "HMS Patient";
        "Total Bill": Decimal;
        ObjTracking: Record "HMS Item Tracking Buffer";
        LNNO: Integer;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset;
        PatientName := '';
        if Patient.Get(PatientNo) then begin
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
    end;


}

