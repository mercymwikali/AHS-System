Table 52202476 "HMS Patient Charges Weiver"
{
    Caption = 'Patient Charges';
    DrillDownPageID = "HMS Patient Charges List";
    LookupPageID = "HMS Patient Charges List";
    fields
    {
        field(1; No; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(2; "Patient No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(3; "Transaction Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Charges,Item,Credit Note,Discount';
            OptionMembers = Charges,Item,"Credit Note",Discount;
        }
        field(4; "Code"; Code[20])
        {
            Editable = true;
            TableRelation = if ("Transaction Type" = const(Charges)) "HMS Charges".Code where(Code = field(Code)) else
            if ("Transaction Type" = const(Item)) Item."No." where("Inventory Posting Group" = filter('DRUGS'));

            trigger OnValidate()
            begin
                /*
                VALIDATE("Transacton ID");
                Date:=TODAY;
                IF "Transaction Type" <> "Transaction Type"::Item THEN BEGIN
                Charges.RESET;
                Charges.SETRANGE(Charges.Code,Code);
                IF Charges.FIND('-') THEN BEGIN
                 Description:=Charges.Description;
                 Amount:=Charges.Amount;
                "G/L Account No" :=Charges."G/L Account No";
                "Patent No":=Charges."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code":=Charges."Shortcut Dimension 2 Code";
                END;
                Charge:=TRUE;
                END ELSE
                Charge:=FALSE;
                 {
                 IF HMSTreat.GET("Treatment No.") THEN BEGIN
                 "Link No":=HMSTreat."Link No.";
                 END ELSE BEGIN
                 IF HMSApp.GET("Treatment No.") THEN BEGIN
                 "Link No":=HMSApp."Appointment No.";
                  END;
                 END;
                 }
                 TESTFIELD("Link No");

                 IF  HMSApp.GET("Link No") THEN
                 "Appointment No.":=HMSApp."Appointment No.";

                 IF HMSTreat.GET("Link No") THEN BEGIN
                 "Appointment No.":=HMSTreat."Link No.";
                 END;
                 IF HMSObs.GET("Link No") THEN BEGIN
                 "Appointment No.":=HMSObs."Link No.";
                 END;
                 IF HMSPhsio.GET("Link No") THEN BEGIN
                 "Appointment No.":=HMSPhsio."Link No.";
                 END;

                 IF HMSLab.GET("Link No") THEN BEGIN
                 IF HMSTreat.GET(HMSLab."Link No.") THEN
                 IF HMSApp.GET(HMSTreat."Link No.") THEN
                  "Appointment No.":=HMSTreat."Link No.";   // From Treatment
                 IF HMSObs.GET(HMSTreat."Link No.") THEN
                  "Appointment No.":=HMSObs."Link No.";
                 IF HMSObs.GET(HMSLab."Link No.") THEN
                 IF HMSApp.GET(HMSObs."Link No.") THEN
                 "Appointment No.":=HMSApp."Appointment No.";    // From observation
                 IF HMSApp.GET(HMSLab."Link No.") THEN
                 "Appointment No.":=HMSApp."Appointment No.";
                 END;
                 */
            end;
        }
        field(5; Description; Text[150])
        {
        }
        field(6; Amount; Decimal)
        {
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
        field(18; Posted; Boolean)
        {
        }
        field(52; "G/L Account"; Code[20])
        {
            CalcFormula = lookup("HMS Charges"."Income G/L Account No" where(Code = field(Code)));
            FieldClass = FlowField;
        }
        field(53; "Treatment No."; Code[20])
        {
        }
        field(54; "Invoice Counter"; Integer)
        {
            CalcFormula = count("Sales Line" where("Appointment No." = field("Appointment No."), "Patient No." = field(Code)));
            FieldClass = FlowField;
        }
        field(55; "Applicable Section"; Option)
        {
            CalcFormula = lookup("HMS Charges"."Applicable Section" where(Code = field(Code)));
            FieldClass = FlowField;
            OptionCaption = 'Standing Charge,Registration,Triage,Appointment,Observation Room,Consultation Fee,Laboratory,Radiology,Pharmacy,Physiotheraphy';
            OptionMembers = "Standing Charge",Registration,Triage,Appointment,"Observation Room","Consultation Fee",Laboratory,Radiology,Pharmacy,Physiotheraphy;
        }
        field(56; "Link No"; Code[20])
        {
        }
        field(57; "Link No Lk"; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Link No." where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(58; "Appointment No."; Code[20])
        {
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
        field(483; Status; Option)
        {
            // Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            trigger OnValidate()
            begin
                PatientCharges.Reset();
                PatientCharges.SetRange(PatientCharges."Weiver Code", No);
                PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No");
                if PatientCharges.Find('-') then begin
                    PatientCharges."Weiver Approval Status" := Status;
                    if (Status = Status::Approved) and (Type = Type::Discount) then;
                    /* PatientCharges.Init;
PatientCharges."Line No" := 1;
PatientCharges."Patient No." := "Patient No";
PatientCharges."Link No" := "Visit No";
PatientCharges."Visit No" := "Visit No";
PatientCharges."Treatment No." := "Treatment No.";
//PatientCharges."Shortcut Dimension 1 Code":=
PatientCharges."Transaction Type" := 'Discount';
PatientCharges.Validate("Transaction Type");
PatientCharges.Code := Code;
PatientCharges.Description := Description;
PatientCharges."G/L Account No" := "G/L Account No";
PatientCharges.Amount := Amount * -1;
PatientCharges."Total Amount" := Amount * -1;
PatientCharges.Quantity := 1;
PatientCharges.Validate(Amount);
PatientCharges.Date := Today;
PatientCharges."User ID" := UserId;
PatientCharges."Creation Time" := Time;
PatientCharges."Creation Date" := Today;
PatientCharges."Doctor ID" := "Doctor ID";
PatientCharges.Validate("Doctor ID");
PatientCharges.Insert; */
                end;
            end;
        }
        field(484; "Initial Amount"; Decimal)
        {
            Editable = false;
        }
        field(485; "Approved Amount"; Decimal)
        {
        }
        field(486; "Approval Remarks"; Text[100])
        {
        }
        field(487; "Visit No"; Code[20])
        {
        }
        field(488; "Type"; Option)
        {
            OptionMembers = " ",Weiver,Discount;
        }
        field(489; "Line No"; Integer)
        {
        }
        field(500; "Dimension1 Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(501; "Dimension2 Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(2));
        }
        field(502; "User ID"; Code[20])
        {
        }
        field(503; "Patient Names"; Text[250])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        IF Recognized = TRUE THEN
        ERROR('You can not delete recognized/billed transactions.');
        GenSetup.GET;

        IF Date <> 0D THEN BEGIN
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.')
        END;
        */
        TestField(Status, Status::New);
    end;

    trigger OnModify()
    begin
        /*
        IF Recognized = TRUE THEN
        ERROR('You can not modify recognized/billed transactions.');
        GenSetup.GET;
        IF Date <> 0D THEN BEGIN
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.')
        END;
        */
        //TESTFIELD(Status,Status::New);
    end;

    var
        PatientCharges: Record "HMS Patient Charges";
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
}
