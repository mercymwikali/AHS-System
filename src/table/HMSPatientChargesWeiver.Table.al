Table 85211 "HMS Patient Charges Weiver"
{
    Caption = 'Patient Charges';
    DrillDownPageID = "HMS Patient Charges List";
    LookupPageID = "HMS Patient Charges List";
    fields
    {
        field(50000; No; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50001; "Patient No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50002; "Transaction Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Charges,Item,Credit Note,Discount';
            OptionMembers = Charges,Item,"Credit Note",Discount;
        }
        field(50003; "Code"; Code[20])
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
        field(50004; Description; Text[150])
        {
        }
        field(50005; Amount; Decimal)
        {
        }
        field(50006; Remarks; Text[200])
        {
        }
        field(50007; Date; Date)
        {
            NotBlank = true;
        }
        field(50008; "Amount Paid"; Decimal)
        {
        }
        field(50009; Posted; Boolean)
        {
        }
        field(50010; "G/L Account"; Code[20])
        {
            CalcFormula = lookup("HMS Charges"."Income G/L Account No" where(Code = field(Code)));
            FieldClass = FlowField;
        }
        field(50011; "Treatment No."; Code[20])
        {
        }
        field(50012; "Invoice Counter"; Integer)
        {
            CalcFormula = count("Sales Line" where("Appointment No." = field("Appointment No."), "Patient No." = field(Code)));
            FieldClass = FlowField;
        }
        field(50013; "Applicable Section"; Option)
        {
            CalcFormula = lookup("HMS Charges"."Applicable Section" where(Code = field(Code)));
            FieldClass = FlowField;
            OptionCaption = 'Standing Charge,Registration,Triage,Appointment,Observation Room,Consultation Fee,Laboratory,Radiology,Pharmacy,Physiotheraphy';
            OptionMembers = "Standing Charge",Registration,Triage,Appointment,"Observation Room","Consultation Fee",Laboratory,Radiology,Pharmacy,Physiotheraphy;
        }
        field(50014; "Link No"; Code[20])
        {
        }
        field(50015; "Link No Lk"; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Link No." where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(50016; "Appointment No."; Code[20])
        {
        }
        field(50017; "Billing Type"; Option)
        {
            OptionCaption = 'Once,Reccuring';
            OptionMembers = Once,Reccuring;
        }
        field(50018; "Billing Start Date"; Date)
        {
        }
        field(50019; "Billing End Date"; Date)
        {
        }
        field(50020; "Admission No"; Code[20])
        {
        }
        field(50021; "Doctor ID"; Code[20])
        {
        }
        field(50022; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(50023; "New Dimension Set ID"; Integer)
        {
            Caption = 'New Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(50024; "G/L Account No"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50025; Status; Option)
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
        field(50026; "Initial Amount"; Decimal)
        {
            Editable = false;
        }
        field(50027; "Approved Amount"; Decimal)
        {
        }
        field(50028; "Approval Remarks"; Text[100])
        {
        }
        field(50029; "Visit No"; Code[20])
        {
        }
        field(50030; "Type"; Option)
        {
            OptionMembers = " ",Weiver,Discount;
        }
        field(50031; "Line No"; Integer)
        {
        }
        field(50032; "Dimension1 Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(50033; "Dimension2 Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(2));
        }
        field(50034; "User ID"; Code[20])
        {
        }
        field(50035; "Patient Names"; Text[250])
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
