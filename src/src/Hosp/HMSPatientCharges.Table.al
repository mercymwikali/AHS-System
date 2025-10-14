Table 52202698 "HMS Patient Charges"
{
    // DrillDownPageID = UnknownPage70135093;
    //  LookupPageID = UnknownPage70135093;

    fields
    {
        field(1; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                HMSPatient.SetRange(HMSPatient."Patient No.", "Patient No.");
                if HMSPatient.Find('-') then begin
                    if HMSPatient.Inpatient = false then
                        "Visit No" := HMSPatient."Active Visit No"
                    else
                        "Visit No" := HMSPatient."Current Adm No";

                    "Shortcut Dimension 1 Code" := HMSPatient."Global Dimension 1 Code";
                    "Insurance No" := HMSPatient."Insurance No.";
                end;
            end;
        }
        field(2; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(3; "Transaction Type"; Code[50])
        {
            TableRelation = "HMS Transactions code"."Transaction Type";

            trigger OnValidate()
            var
                TransactionType: Record "HMS Transactions code";
            begin
                /* ***Clear the Charge details.*** */
                /* 
                    * Since we imagine if you are changing the transaction to a new value, the code, description and amount fields will have to charge.
                    * The Problem with this is if you validate (In AL Code) this field after entering values of amount and code, they will be cleared.
                */
                code := '';
                Description := '';
                Amount := 0;

                // Get Transaction Type Details.
                TransactionType.get("Transaction Type");

                // Get Patient Details
                HMSPatient.Get("Patient No.");

                /* ****Get Charge Description Defaults From Patient Details and Transaction Type Details**** */
                // REFACTOR: Since We have to Validate the Code field which is entered after selecting a transactin type, updating these fields here and ther makes here redundant.
                "Shortcut Dimension 1 Code" := HMSPatient."Global Dimension 1 Code"; // Branch
                "Visit No" := HMSPatient."Active Visit No";
                "Shortcut Dimension 2 Code" := TransactionType."Department Code";

                // Also updated on the onvalidate trigger of field Code
                if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Cash then
                    "Shortcut Dimension 4 Code" := 'CASH'
                else
                    if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Corporate then begin
                        "Shortcut Dimension 4 Code" := 'CORPORATE';
                        "Insurance No" := HMSPatient."Insurance No.";
                    end;
                /* Patient Type and Invoice number generation Logic */
                /* 
                    * if the Patient is an In Patient, there is no Invoice Number to Work with at First. TODO: Work with a common encounters table that stores Such billing information and makes Past encounters easier to retrieve.
                    * Whearas For an Out Patient, the invoice number is Generated when creating the visit.
                    * Furthermore😁, If the Visit was created as a Cash visit then later modified to Corporate, then the invoice number will be blank TODO: Change Invoice generation Logic of Both OP and IP
                 */
                if HMSPatient.Inpatient = true then begin
                    HMSAdmissionFormHeader.Reset();
                    HMSAdmissionFormHeader.SetRange("Admission No.", HMSPatient."Active Visit No");
                    if HMSAdmissionFormHeader.FindFirst() then begin
                        "Shortcut Dimension 3 Code" := 'IP';
                        "Admission No" := HMSAdmissionFormHeader."Admission No.";
                        InPatient := HMSPatient.Inpatient;
                    end;
                end
                else begin
                    "Shortcut Dimension 3 Code" := 'OP';
                    if HMSAppointmentFormHeader.get("Visit No") then
                        if HMSAppointmentFormHeader."Invoince No" <> '' then
                            "Invoice Number" := HMSAppointmentFormHeader."Invoince No";
                end;

                if TransactionType."Calculate Doctor Fee" = false then
                    "Doctor ID" := '';

                if Date = 0D then
                    Date := Today;
                //  Patients Insurance Capitation Check
                if Cust.get("Insurance No") then
                    if (cust."NHIF Capitation" = true) and (TransactionType."NHIF Capitation Covered" = false) then
                        "Insurance No" := '';
            end;
        }
        field(4; "Code"; Code[150])
        {
            Editable = true;
            TableRelation = if ("Charge Type" = filter(Service)) "HMS Charges".Code where("Transaction Type" = field("Transaction Type"))
            else
            if ("Charge Type" = filter(Item))
            Item."No.";

            trigger OnValidate()
            var
                InsuranceCustomer: Record customer;
                SchemePlan: Record "HMS Scheme Plan Services";
                HMSSetup: Record "HMS Setup";
                TransactionCodes: Record "HMS Transactions code";
                Item: Record item;
            begin
                /* ******Get Patient Details And HMIS Module Setups******
                    * From the Patient Details we are updating
                        - Insurance No
                        - Branch
                        - Patient type.
                    * If the Patient type is corporate, we check for special pricing or rate of the charge
                */
                HMSSetup.get();
                HMSPatient.get("Patient No.");
                "Shortcut Dimension 1 Code" := HMSPatient."Global Dimension 1 Code";
                if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Corporate then
                    "Insurance No" := HMSPatient."Insurance No.";

                // Pick Prices per Branch
                ChargePrices.reset();
                ChargePrices.setrange("Charge Code", Code);
                ChargePrices.setrange("Branch Code", HMSPatient."Global Dimension 1 Code");
                if ChargePrices.FindLast() then
                    if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Corporate then begin
                        // Get the insurance details and calculate the charge amount according to insurance rate
                        InsuranceCustomer.Reset();
                        InsuranceCustomer.SetRange("No.", HMSPatient."Insurance No.");
                        if InsuranceCustomer.FindFirst() then;

                        if HMSSetup."Insurance Charges Price Type" = HMSSetup."Insurance Charges Price Type"::"Charge Amount" then
                            Amount := Round(ChargePrices."Corporate Amount", 1, '=')
                        else
                            if InsuranceCustomer."Insurance Rate" = 0 then
                                Amount := Round(ChargePrices."Corporate Amount", 1, '=')
                            else
                                Amount := Round((InsuranceCustomer."Insurance Rate" / 100 * ChargePrices."Corporate Amount"), 1, '=') + Round(ChargePrices."Corporate Amount", 1, '=');
                    end else
                        Amount := Round(ChargePrices."Cash Amount", 1, '=');

                // Populate the Charge Details
                Charges.Reset();
                Charges.SetRange(Charges.Code, Code);
                if Charges.FindFirst() then begin
                    Description := Charges.Description;
                    "Reccuring Type" := Charges."Reccuring Type";
                    "Billing Type" := charges."Billing Type";
                    // If the Amount is not defined per branch then pick the default charge price.
                    if Amount = 0 then
                        Amount := Round(Charges.Amount, 1, '=');

                    "G/L Account No" := Charges."Income G/L Account No";
                    if TransactionCodes.get(Charges."Transaction Type") then
                        "Shortcut Dimension 2 Code" := TransactionCodes."Department Code";
                end;

                // If the Charge is an inventory item/service pick the sales account 
                if "G/L Account No" = '' then begin
                    if Item.get(code) then
                        Item.CalcFields("Sales Account");

                    "G/L Account No" := Item."Sales Account";
                end;

                // Check if the Insurance Has its own pricing creteria defined 
                // Update the charge to match the Isurance specific price of the charge.

                if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Corporate then begin
                    SchemePlan.RESET();
                    SchemePlan.SETRANGE(SchemePlan.Code, Code);
                    SchemePlan.SETRANGE(SchemePlan.Insurance, HMSPatient."Insurance No.");
                    SchemePlan.SETRANGE(SchemePlan.Branch, HMSPatient."Global Dimension 1 Code");
                    if SchemePlan.FindFirst() then
                        Amount := Round(SchemePlan.Amount, 1, '=')
                end;

                // Up to This Point, the Amount Should have a value.
                // Validate the amount to get the Total and Insurance Amount
                // the Onvalidate trigger on the Amount field also triggers onvalidate of Doctor's ID that calculates the doctors amount.
                Validate(Amount);

                // Onvalidate Trigger on the quantity field Calculates the Total Amount.
                Validate(Quantity);

                // Update references of the charge from other modules.
                // The Link No is populated with the document number of the module/document you are charging against.
                if HMSAppointmentFormHeader.Get("Link No") then
                    "Appointment No." := HMSAppointmentFormHeader."Appointment No.";

                if HMSAdmissionFormHeader.Get("Link No") then
                    "Admission No" := HMSAdmissionFormHeader."Link No.";

                if HMSTreatmentFormHeader.Get("Link No") then
                    "Appointment No." := HMSTreatmentFormHeader."Link No.";
                if HMSObservationFormHeader.Get("Link No") then
                    "Appointment No." := HMSObservationFormHeader."Link No.";

                if HMSLabFormHeader.Get("Link No") then begin
                    if HMSTreatmentFormHeader.Get(HMSLabFormHeader."Link No.") then
                        if HMSAppointmentFormHeader.Get(HMSTreatmentFormHeader."Link No.") then
                            "Appointment No." := HMSTreatmentFormHeader."Link No.";   // From Treatment
                    if HMSObservationFormHeader.Get(HMSTreatmentFormHeader."Link No.") then
                        "Appointment No." := HMSObservationFormHeader."Link No.";
                    if HMSObservationFormHeader.Get(HMSLabFormHeader."Link No.") then
                        if HMSAppointmentFormHeader.Get(HMSObservationFormHeader."Link No.") then
                            "Appointment No." := HMSAppointmentFormHeader."Appointment No.";    // From observation
                    if HMSAppointmentFormHeader.Get(HMSLabFormHeader."Link No.") then
                        "Appointment No." := HMSAppointmentFormHeader."Appointment No.";

                    if HMSAdmissionFormHeader.Get(HMSLabFormHeader."Link No.") then
                        "Admission No" := HMSAdmissionFormHeader."Link No.";
                end;

                if "User ID" = '' then
                    "User ID" := UserId;

                "Creation Time" := Time;
                "Creation Date" := Today;
            end;
            //end;
        }
        field(5; Description; Text[150])
        {
        }
        field(6; Amount; Decimal)
        {
            Editable = true;
            Enabled = true;

            trigger OnValidate()
            var
                TransType: Record "HMS Transactions code";
            begin
                CalcFields("Visit Amount");
                TestField("Transaction Type");
                TransType.Get("Transaction Type");

                /* ***** Insurance Visit Ceiling Check *********
                    * Check if the patient's Insurance has a visit ceiling (Highest Billable Amount per Outpatient visit).
                    * The Transaction code of the charge should be specified as SHIF Capitation Covered. 
                */
                // if HMSPat.get("Patient No.") then;
                // if Cust.get(HMSPat."Insurance No.") then begin
                //     if (cust."Visit Ceiling" > 0) and (HMSPat.Inpatient = false) and ((TransType."NHIF Capitation Covered" = true) or (Cust."NHIF FFF" = true)) then begin
                //         if ("Visit Amount" + Amount) > cust."Visit Ceiling" then error('Please note that you have exhausted your visit ceiling amount for the day');
                //     end;
                /* *******SHIF Package****** */
                /* 
                    * if the Patient's Insurance is a SHIF Package the the Visit Amount should not Exceed the Insuarance Approved LOU Amount.
                 */
                //     if Cust."NHIF Package" = true then begin
                //         CalcFields("NHIF LOU Amount");
                //         if ("Visit Amount" + Amount) > HMSPat."Current NHIF LOU Amount" then error('Please note that you have exhausted your NHIF LOU amount for the day');
                //     end;
                // end;

                if xRec.Amount <> 0 then
                    if Amount < xRec.Amount then begin
                        UserRec.RESET();
                        UserRec.SETRANGE(UserRec."User ID", USERID);
                        if UserRec.FIND('-') then begin
                            if UserRec."Can Edit Charges" = FALSE then
                                ERROR('Please note that you dont have the rights to edit the charges')
                        end else
                            ERROR('Please note that you dont have the rights to edit the charges');
                    end;

                // Calculate Insurance Amount
                if Quantity = 0 then
                    Quantity := 1;

                "Total Amount" := Round(Amount, 1, '=') * Quantity;

                HMSPatient.get("Patient No.");
                HmsTransCode.get("Transaction Type");
                if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Corporate then
                    if HmsTransCode."Calculate Insurance Fee" = true then
                        "Insurance Amount" := Round(Amount, 0.01, '=') * Quantity;

                Validate("Doctor ID");
                //VALIDATE(Quantity);
            end;
        }
        field(7; Remarks; Text[200])
        {
        }
        field(8; Date; Date)
        {
            NotBlank = true;
        }
        field(9; "Amount Paid"; Decimal)
        {
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(51010; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(51011; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(11; "Applied Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                /*
               TotalApplied:=0;

               StudentCharges.RESET;
               StudentCharges.SETRANGE(StudentCharges."Student No.","Student No.");
               if StudentCharges.FIND('-') then begin
               REPEAT
               TotalApplied:=TotalApplied+StudentCharges."Applied Amount";
               UNTIL StudentCharges.NEXT = 0;
               end;

               if "Applied Amount" <> xRec."Applied Amount" then
               TotalApplied := TotalApplied + ("Applied Amount" - xRec."Applied Amount")
               else
               TotalApplied := TotalApplied + "Applied Amount";

               StudentPayments.RESET;
               StudentPayments.SETRANGE(StudentPayments."Student No.","Student No.");
               if StudentPayments.FIND('-') then begin
               StudentPayments."Unapplied Amount":=StudentPayments."Amount to pay"-TotalApplied;
               StudentPayments.MODIFY;
               end;
               */
            end;
        }
        field(16; "Apply to"; Boolean)
        {
            trigger OnValidate()
            begin
                /*
                if "Recovered First" = FALSE then begin
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Patient No.","Patient No.");
                StudentCharges.SETRANGE(StudentCharges."Apply to",FALSE);
                StudentCharges.SETRANGE(StudentCharges."Fully Paid",FALSE);
                StudentCharges.SETRANGE(StudentCharges."Recovered First",TRUE);
                if StudentCharges.FIND('-') then
                ERROR('Apply payment to the charges which should be recorvered first');
                end;

                TotalApplied:=0;
                "Applied Amount":=0;

                if "Apply to" = TRUE then begin
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Patient No.","Patient No.");
                if StudentCharges.FIND('-') then begin
                REPEAT
                TotalApplied:=TotalApplied+StudentCharges."Applied Amount";
                UNTIL StudentCharges.NEXT = 0;
                end;
                end;
                */
            end;
        }
        field(17; Recognized; Boolean)
        {
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "Pharmacy No"; Code[20])
        {
            TableRelation = "HMS Pharmacy Header"."Pharmacy No.";
        }
        field(20; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(21; "Doctors Amount"; Decimal)
        {
        }
        field(23; "Recovered First"; Boolean)
        {
        }
        field(24; Transfer; Boolean)
        {
        }
        field(25; "Transfer Amount"; Decimal)
        {
        }
        field(27; Transfered; Boolean)
        {
        }
        field(28; "Invoice ID"; Code[20])
        {
            trigger OnValidate()

            begin
                /*
                if "Invoice ID" <> xRec."Invoice ID" then begin
                    GenSetup.Get;
                    NoSeriesMgt.TestManual(GenSetup."Transaction Nos.");
                    "No. Series" := '';
                end;

                if "Invoice ID" = '' then begin
                    GenSetup.Get;
                    GenSetup.TestField(GenSetup."Transaction Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Transaction Nos.", xRec."No. Series", 0D, "Invoice ID", "No. Series");
                end;
                */
            end;
        }
        field(29; "No. Series"; Code[20])
        {
        }
        field(30; "Fully Paid"; Boolean)
        {
        }
        field(32; "Room Allocation"; Code[20])
        {
            Editable = true;
            Enabled = true;
        }
        field(33; Charge; Boolean)
        {
        }
        field(34; Reversed; Boolean)
        {
            trigger OnValidate()
            begin
                if GuiAllowed then
                    if Confirm('Are you sure you want to mark the transaction as reversed?', true) = false then
                        Reversed := false;
            end;
        }
        field(35; Distribution; Decimal)
        {
        }
        field(36; Quantity; Decimal)
        {
            InitValue = 1;

            trigger OnValidate()
            begin
                TestField(Quantity);
                if Quantity < 0 then
                    Error('Sorry, The quantity cannot be negative');
                //Validate(Amount);
                // "Total Amount" := Round(Amount, 1, '=') * Quantity;

                if Quantity = 0 then
                    Quantity := 1;

                "Total Amount" := Round(Amount, 1, '=') * Quantity;

            end;
        }
        field(37; "Invoice Number"; Code[20])
        {
        }
        field(39; "Applied Payment"; Decimal)
        {
        }
        field(40; "Recovery Priority"; Integer)
        {
        }
        field(41; "Full Tuition Fee"; Decimal)
        {
        }
        field(42; "Distribution Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(43; Currency; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(44; "Over Charged"; Boolean)
        {
        }
        field(45; "Over Charged Amount"; Decimal)
        {
        }
        field(46; "System Created"; Boolean)
        {
        }
        field(48; "Charge Gender"; Option)
        {
            FieldClass = Normal;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(49; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50; "Bill Section"; Enum "Charges Applicable Section")
        {
            FieldClass = Normal;
        }
        field(51; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(52; "G/L Account"; Code[20])
        {
            CalcFormula = lookup("HMS Transactions code"."Income G/L Account" where("Transaction Type" = field("Transaction Type")));
            FieldClass = FlowField;
        }
        field(53; "Treatment No."; Code[20])
        {
            // TableRelation = "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
        }
        field(54; "Invoice Counter"; Integer)
        {
            FieldClass = Normal;
        }
        field(55; "Applicable Section"; Enum "Charges Applicable Section")
        {
            CalcFormula = lookup("HMS Charges"."Applicable Section" where(Code = field(Code)));
            FieldClass = FlowField;
            // OptionCaption = 'Standing Charge,Registration,Triage,Appointment,Observation Room,Consultation Fee,Laboratory,Radiology,Pharmacy,Physiotheraphy';
            // OptionMembers = "Standing Charge",Registration,Triage,Appointment,"Observation Room","Consultation Fee",Laboratory,Radiology,Pharmacy,Physiotheraphy;
        }
        field(56; "Link No"; Code[50])
        {
        }
        field(57; "Link No Lk"; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Link No." where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(58; "Appointment No."; Code[20])
        {
            // TableRelation = "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
        }
        field(59; "Patient Type Lk"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(60; "Appointment No Lk"; Code[20])
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(61; "Billing Type"; Option)
        {
            OptionCaption = 'Once,Reccuring';
            OptionMembers = Once,Reccuring;
        }
        field(62; "Billing Start Date"; Date)
        {
        }
        field(63; "Billing End Date"; Date)
        {
        }
        field(64; "Admission No"; Code[20])
        {
        }
        field(65; "Doctor ID"; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //Change Doctor in All Lines
                //Commented out since it affects billing
                /*if xRec."Doctor ID"<>'' then begin
                PatientCharges.RESET;
                PatientCharges.SETRANGE(PatientCharges."Patient No.","Patient No.");
                PatientCharges.SETRANGE(PatientCharges."Visit No","Visit No");
                PatientCharges.SETRANGE(PatientCharges."Doctor ID",xRec."Doctor ID");
                if PatientCharges.FIND('-') then begin
                  REPEAT
                    PatientCharges."Doctor ID":="Doctor ID";
                    PatientCharges.MODIFY;
                  UNTIL PatientCharges.NEXT=0;
                end;
                end;*/
                // Calculate Doctor Amount
                CalcFields("Calc Doctor Fee");
                if "Calc Doctor Fee" = true then begin
                    if HMSDoc.Get("Doctor ID") then
                        "Doctor Rate" := HMSDoc."Commission Perc";

                    if "Insurance Amount" > Amount then begin
                        "Doctors Amount" := "Insurance Amount" * ("Doctor Rate" * 0.01);
                        if (HMSDoc."IP Rate" > 0) and (InPatient = true) then
                            "Doctors Amount" := "Insurance Amount" * (HMSDoc."IP Rate" * 0.01)
                    end else begin
                        "Doctors Amount" := Amount * Quantity * ("Doctor Rate" * 0.01);
                        if (HMSDoc."IP Rate" > 0) and (InPatient = true) then
                            "Doctors Amount" := Amount * Quantity * (HMSDoc."IP Rate" * 0.01);
                    end;

                end else
                    "Doctors Amount" := 0;

                if HmsTransCode.Get("Transaction Type") then
                    if HmsTransCode."Calculate Doctor Fee" = false then begin
                        "Doctor ID" := '';
                        "Doctors Amount" := 0;
                    end;
                // if HMSDoc.Get("Doctor ID") then
                //     if HMSDoc.Resident = true then
                //         "Doctors Amount" := 0;
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(481; "New Dimension Set ID"; Integer)
        {
            Caption = 'New Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(482; "G/L Account No"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(483; "Weiver Amount"; Decimal)
        {
        }
        field(484; "Weiver Reason"; Text[200])
        {
        }
        field(485; "Weiver Approval Status"; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(486; "User ID"; Code[20])
        {
        }
        field(487; "Creation Time"; Time)
        {
        }
        field(488; "Creation Date"; Date)
        {
        }
        field(489; "Weiver Code"; Code[20])
        {
        }
        field(689; "Weived"; Boolean)
        {
        }
        field(6089; "Posted to Doctor"; Boolean)
        {
        }
        field(490; "Original Amount"; Decimal)
        {
        }
        field(491; "Reccuring Type"; Option)
        {
            OptionCaption = ' ,Daily,Hourly';
            OptionMembers = " ",Daily,Hourly;
        }
        field(492; "Insurance Amount"; Decimal)
        {
        }
        field(493; Claimed; Boolean)
        {
        }
        field(494; "Claim Receipt No"; Code[20])
        {
        }
        field(495; "Doctor Rate"; Decimal)
        {
        }
        field(496; "Posted Invoice No."; Code[20])
        {
            CalcFormula = lookup("Sales Invoice Header"."No." where("Pre-Assigned No." = field("Invoice Number")));
            FieldClass = FlowField;
        }
        field(497; "Total Receipts"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(498; "Calc Doctor Fee"; Boolean)
        {
            CalcFormula = lookup("HMS Transactions code"."Calculate Doctor Fee" where("Transaction Type" = field("Transaction Type")));
            FieldClass = FlowField;
        }
        field(499; "Insurance No"; Code[100])
        {
            TableRelation = Customer."No.";
        }
        field(500; "Default Insurance"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Insurance No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(501; "Doctors Name"; Text[200])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(502; "Total Amount"; Decimal)
        {
            Editable = true;
        }
        field(503; Imported; Boolean)
        {
        }
        field(504; "Invoice Amount"; Decimal)
        {
            CalcFormula = Sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                             "Visit No" = field("Visit No"), "Posted Invoice No." = field("Posted Invoice No.")));
            FieldClass = FlowField;
        }
        field(505; Closed; Boolean)
        {
        }
        field(506; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(507; "Appointment No"; Code[10])
        {
        }
        field(508; "Visit No"; Code[20])
        {
            // TableRelation = "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
            // TableRelation = if (Inpatient = filter(true)) "HMS Admission Form Header"."Admission No." where("Patient No." = field("Patient No."))
            // else
            // "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
            trigger OnValidate()
            begin
                if HMSAppointmentFormHeader.get("Visit No") then begin
                    "Patient No." := HMSAppointmentFormHeader."Patient No.";
                    if HMSAppointmentFormHeader."Invoince No" <> '' then begin
                        "Patient No." := HMSAppointmentFormHeader."Patient No.";
                        "Invoice Number" := HMSAppointmentFormHeader."Invoince No";
                    end;
                end
            end;
        }
        field(509; Medicentre; Boolean)
        {
        }
        field(510; InPatient; Boolean)
        {
        }
        field(511; "Charge Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Description = field(Description),
                                                                  "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(512; "Own Debtor"; Boolean)
        {
            trigger OnValidate()
            begin
                if HMSPatient.Get("Patient No.") then begin
                    HMSPatient.TestField("Debtor Account");
                    "Insurance No" := HMSPatient."Debtor Account";
                    "Insurance Amount" := Amount;
                end;
            end;
        }
        field(513; "Cash Rebates Posted"; Boolean)
        {
        }
        field(514; "Receipt Reversed"; Boolean)
        {
            CalcFormula = lookup("Bank Account Ledger Entry".Reversed where("Document No." = field(Code)));
            FieldClass = FlowField;
        }
        field(515; Sunflash; Boolean)
        {
        }
        field(516; "Claimed Count"; Integer)
        {
            FieldClass = Normal;
        }
        field(517; "Claimed Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No."),
                                                                            "Visit No" = field("Visit No"),
                                                                            "Claimed Count" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(518; "Insurance Paid Amount"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Entry Type" = filter(Application),
                                                                         "Cust. Ledger Entry No." = field("Invoice Entry No"),
                                                                         "Customer No." = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(519; "Invoice Entry No"; Integer)
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Entry No." where("Document No." = field("Invoice Number")));
            FieldClass = FlowField;
        }
        field(520; "Visit Balance"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(521; "Invoice Count"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             "Invoice Number" = field("Invoice Number")));
            FieldClass = FlowField;
        }
        field(522; "Visit Count"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(523; Names; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Names where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(524; "Insurance Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(525; "Member No"; Code[50])
        {
            CalcFormula = lookup("HMS Patient"."Membership No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(526; "Doctor Comm%"; Decimal)
        {
            CalcFormula = lookup("HMS Setup Doctor"."Commission Perc" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(5026; "Visit Exists in VendL"; Boolean)
        {
            CalcFormula = exist("Vendor Ledger Entry" where("Vendor No." = field("Doctor ID"), "Document No." = field("Visit No")));
            FieldClass = FlowField;
        }
        field(5027; "Posting No Exists in VendL"; Boolean)
        {
            CalcFormula = exist("Vendor Ledger Entry" where("Vendor No." = field("Doctor ID"), "Document No." = field("Doctors Posting No")));
            FieldClass = FlowField;
        }
        field(527; patientNames; Text[200])
        {
        }
        field(528; "Visit No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HMS Patient Charges"."Visit No" where("Patient No." = field("Patient No."));
        }
        field(529; "Sunflash Doc"; Code[20])
        {
            FieldClass = Normal;
        }
        field(530; "Posted Ins No"; Code[20])
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Customer No." where("Document No." = field("Invoice Number")));
            FieldClass = FlowField;
        }
        field(531; "Posted Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Document No." = field("Invoice Number"),
                                                            "Customer No." = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(532; "InPatient Count"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where("Patient No." = field("Patient No."),
                                                             "Visit No" = field("Visit No"),
                                                             "Transaction Type" = filter('BED')));
            FieldClass = FlowField;
        }
        field(533; "Patient Type"; Code[20])
        {
        }
        field(534; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Line q".Amount where("Patient No" = field("Patient No."), "Teller ID" = field("Visit No"), "Transaction No." = field(Code), "Header Posted" = filter(true)));
            FieldClass = FlowField;
        }
        field(535; "Posting Document No"; code[20])
        {
            FieldClass = Normal;
        }
        field(569; "Doctors Posting No"; code[20])
        {
            FieldClass = Normal;
        }
        field(536; "Exist In GL"; Boolean)
        {
            CalcFormula = exist("G/L Entry" where("Document No." = field("Posting Document No")));
            FieldClass = FlowField;
        }
        field(537; "Visit Amount"; decimal)
        {
            CalcFormula = Sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                             "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(539; "Current LOU Amount"; decimal)
        {
            CalcFormula = Sum("HMS Appointment Form Header"."Insurance LOU Amount" where("Patient No." = field("Patient No."),
                                                             "Appointment No." = field("Visit No")));
            FieldClass = FlowField;
        }
        field(538; "Charge Type"; Option)
        {
            FieldClass = Normal;
            OptionCaption = 'Service,Item';
            OptionMembers = Service,Item;
        }
        field(540; "Corporate Excluded"; Boolean)
        {
            FieldClass = Normal;
            trigger OnValidate()

            var
                PatRec: Record "HMS Patient";
            begin
                if "Corporate Excluded" = true then begin
                    "Insurance No" := '';
                    "Insurance Amount" := 0;
                end else begin
                    patrec.get("Patient No.");
                    "Insurance No" := PatRec."Insurance No.";
                    Validate(Amount);
                end;
            end;
        }
        field(541; "Visit Paid Amount"; decimal)
        {
            CalcFormula = Sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                             "Visit No" = field("Visit No"), Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(542; "Is Bed"; Boolean)
        {
            CalcFormula = exist("HMS Beds" where("Bed No" = field(Code)));
            FieldClass = FlowField;
        }
        field(543; "Inventory Posting Group"; Code[20])
        {
            CalcFormula = lookup(Item."Inventory Posting Group" where("No." = field("Code")));
            FieldClass = FlowField;
        }
        field(544; "Select"; Boolean)
        {
        }
        field(545; "Package Item"; Boolean)
        {
        }
        field(546; "Receipt posted"; Boolean)
        {
        }
        field(547; "Admitting Doctor"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Admission Form Header".Doctor where("Admission No." = field("Visit No")));
        }
    }

    keys
    {
        key(Key1; "Transaction Type", "Line No", "Patient No.", "Link No", "Treatment No.", "Code")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Patient No.", "Billing Type", "Reccuring Type", Date, "Creation Time")
        {
        }
        key(Key3; "Patient No.", "Transaction Type", Date)
        {
        }
        key(Key4; "Insurance No", "Patient No.")
        {
        }
        key(Key5; "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Posted, false);
        if UserRec.get(UserId) then begin
            if UserRec."Can Delete Charges" = false then
                Error('Please note that you dont have the rights to delete active transactions.');
        end else
            Error('Please note that you dont have the rights to delete active transactions.');
        if "Doctors Posting No" <> '' then
            Error('You cannot delete this charge as i has already been posted tothe doctors account.Kindly reverse.');

        CalcFields("Posted Invoice No.");
        if "Posted Invoice No." <> '' then
            Error('You Cannot Delete this Charge. First Reverse the Posted Invoice %1', "Posted Invoice No.");

        // if Amount > 0 then
        //     Error('Please note that you can not delete active transactions.');

        /* UserRec.Reset;
        UserRec.SetRange(UserRec."User ID", UserId);
        if UserRec.Find('-') then begin
            if UserRec."Can Edit Charges" = FALSE then ERROR('Please note that you dont have the rights to edit the charges')
        end else
            Error('Please note that you dont have the rights to edit the charges');
    */
    end;

    trigger OnInsert()
    var
        HMSPatientCharges: Record "HMS Patient Charges";
    begin
        if HMSPatient.Get("Patient No.") then
            if HMSPatient.Activated = false then
                Error('This patient is not active. Activate the patient to continue billing');

        
        if "User ID" = '' then
            "User ID" := UserId;
        "Creation Time" := Time;
        "Creation Date" := Today;

    end;

    trigger OnModify()
    begin
        /*
        if Recognized = TRUE then
        ERROR('You can not modify recognized/billed transactions.');
        GenSetup.GET;
        if Date <> 0D then begin
        if (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") then
        ERROR('Modification or deletion out of the allowed range not allowed.')
        end;
        */
        if "Doctors Posting No" <> '' then
            Error('You cannot edit this charge as i has already been posted tothe doctors account.Kindly reverse.');

        if "User ID" = '' then
            "User ID" := UserId;
        if "Creation Time" = 0T then
            "Creation Time" := Time;
        if "Creation Date" = 0D then
            "Creation Date" := Today;

        // if HMSPat.Get("Patient No.") then
        //     if HMSPat.Activated = false then
        //         Error('This patient is not active. Activate the patient to continue billing');

        // IF "Posting Document No" <> '' THEN
        //     ERROR('Please note that you can not delete Posted transactions. kindly post revesal');

        if HmsTransCode.get("Transaction Type") then
            if HmsTransCode."Disable Manual Billing" = true then
                Error('Drugs And Non Pharms cannot be edited');

        // UserRec.RESET;
        // UserRec.SETRANGE(UserRec."User ID", USERID);
        // if UserRec.FIND('-') then begin
        //     if UserRec."Can Edit Charges" = FALSE then ERROR('Please note that you dont have the rights to edit the charges')
        // end else
        //     ERROR('Please note that you dont have the rights to edit the charges');
        //  end;
    end;

    var
        Cust: Record Customer;
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        Charges: Record "HMS Charges";
        ChargePrices: Record "HMS Charges Prices";
        HMSLabFormHeader: Record "HMS Laboratory Form Header";
        HMSObservationFormHeader: Record "HMS Observation Form Header";
        HMSPatient: Record "HMS Patient";
        HMSDoc: Record "HMS Setup Doctor";
        HmsTransCode: Record "HMS Transactions code";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        UserRec: Record "User Setup";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ValidateNewShortcutDimCode(FieldNumber: Integer; var NewShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, NewShortcutDimCode, "New Dimension Set ID");
    end;

    procedure LookupNewShortcutDimCode(FieldNumber: Integer; var NewShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, NewShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, NewShortcutDimCode, "New Dimension Set ID");
    end;

    procedure ShowNewShortcutDimCode(var NewShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("New Dimension Set ID", NewShortcutDimCode);
    end;

    local procedure duplcateExists(): Boolean
    begin
    end;
}
