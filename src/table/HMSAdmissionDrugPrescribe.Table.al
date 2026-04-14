Table 85172 "HMS Admission Drug Prescribe"
{
    // DrillDownPageID = UnknownPage70135094;
    // LookupPageID = UnknownPage70135094;

    fields
    {
        field(50000; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Drug No."; Code[20])
        {
            TableRelation = Item."No." where("Inventory Posting Group" = filter('Drugs'));

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin

                if Item.Get("Drug No.") then begin
                    "Drug Name" := Item.Description;
                    "Unit Of Measure" := Item."Base Unit of Measure";
                    Route := Item.Route;
                    Frequency := Item.Frequency;
                    Dosage := Item.Dosage;
                    Take := Item.Take;
                    "Number of Days" := Item."Number of Days";

                    ///Triage Patients
                    Observation.SetRange(Observation."Observation No.", "Admission No.");
                    if Observation.Find('-') then begin
                        Patient.Reset();
                        Patient.SetRange(Patient."Patient No.", Observation."Patient No.");
                        if Patient.Find('-') then begin
                            if Patient."Patient Type" = Patient."patient type"::Corporate then begin
                                Cust.get(Patient."Insurance No.");
                                if Cust."Insurance Rate" = 0 then
                                    "Unit Price" := Item."Unit Price"
                                else
                                    "Unit Price" := Item."Unit Price" + Item."Unit Price" * Cust."Insurance Rate" / 100;
                            end;
                            if Patient."Patient Type" = Patient."patient type"::Cash then
                                "Unit Price" := Item."Unit Price";
                        end;
                    end;

                    //Inpatients
                    Admission.SetRange(Admission."Admission No.", "Admission No.");
                    if Admission.Find('-') then begin
                        Patient.Reset();
                        Patient.SetRange(Patient."Patient No.", Admission."Patient No.");
                        if Patient.Find('-') then begin
                            if Patient."Patient Type" = Patient."patient type"::Corporate then begin
                                Cust.get(Patient."Insurance No.");
                                if Cust."Insurance Rate" = 0 then
                                    "Unit Price" := Item."Unit Price"
                                else
                                    "Unit Price" := Item."Unit Price" + Item."Unit Price" * Cust."Insurance Rate" / 100;
                            end;
                            if Patient."Patient Type" = Patient."patient type"::Cash then
                                "Unit Price" := Item."Unit Price";
                        end;
                    end;

                    if CalcDosage(Dosage) = true then
                        Quantity := Take * Frequency * "Number of Days";
                    Validate(Quantity);
                end;

                /*Check if the drug has any drug within the prescription where it is not compatible*/
                Interaction.Reset();
                Interaction.SetRange(Interaction."Drug No.", "Drug No.");
                if Interaction.Find('-') then
                    repeat
                        /*Get the lines of drugs that have been identified as being incompatible with the drug selected*/
                        Line.Reset();
                        Line.SetRange(Line."Admission No.", "Admission No.");
                        //Line.SETRANGE(Line."Drug No.",Interaction."Drug No. 1");
                        if Line.Find('-') then
                            // Line.CalcFields(Line."Drug Name");
                            if Confirm('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?', false) = true then begin
                                Line."Marked as Incompatible" := true;
                                Line.Modify();
                            end
                            else
                                Error('Drug Incompatible.Operation Cancelled');
                        Line.Reset();
                        Line.SetRange(Line."Admission No.", "Admission No.");
                        Line.SetRange(Line."Drug No.", Interaction."Drug No.");
                        if Line.Find('-') then
                            if Confirm('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?', false) = true then begin
                                Line."Marked as Incompatible" := true;
                                Line.Modify();
                            end
                            else
                                Error('Drug Incompatible.Operation Cancelled');

                    until Interaction.Next() = 0;
            end;
        }
        field(50002; "Drug Name"; Text[100])
        {
        }
        field(50003; Quantity; Integer)
        {
            trigger OnValidate()
            begin
                if Admission.Get("Admission No.") then begin
                    Patient.Reset();
                    Patient.SetRange(Patient."Patient No.", Admission."Patient No.");
                    if Patient.Find('-') then begin
                        if Patient."Patient Type" = Patient."patient type"::Corporate then begin
                            Cust.get(Patient."Insurance No.");
                            if Cust."Insurance Rate" = 0 then
                                "Unit Price" := "Unit Price"
                            else
                                "Unit Price" := "Unit Price" + "Unit Price" * Cust."Insurance Rate" / 100;
                        end;
                        if Patient."Patient Type" = Patient."patient type"::Cash then
                            "Unit Price" := "Unit Price";
                    end;
                end;
                Amount := "Unit Price" * Quantity;
            end;
        }
        field(50004; "Unit Of Measure"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Drug No."));
        }
        field(50005; Remarks; Text[100])
        {
        }
        field(50006; "Location Code"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(50007; "Actual Quantity"; Decimal)
        {
        }
        field(50008; Inventory; Decimal)
        {
        }
        field(50009; Issued; Boolean)
        {
        }
        field(50010; Dosage; Text[100])
        {
            NotBlank = true;
        }
        field(50011; "Marked as Incompatible"; Boolean)
        {
        }
        field(50012; "Actual Quantity Issued"; Decimal)
        {
            CalcFormula = lookup("HMS Pharmacy Line"."Issued Quantity" where("Linking No." = field("Admission No."),
                                                                              "Link Type" = const('ADMISSION'),
                                                                              "No." = field("Drug No.")));
            FieldClass = FlowField;
        }
        field(50013; "Remaining Quantity"; Decimal)
        {
            CalcFormula = lookup("HMS Pharmacy Line".Remaining where("Linking No." = field("Admission No."),
                                                                      "Link Type" = const('ADMISSION'),
                                                                      "No." = field("Drug No.")));
            FieldClass = FlowField;
        }
        field(50014; Take; Decimal)
        {
            Description = 'taken per day';
            NotBlank = true;

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then
                    Quantity := Take * Frequency * "Number of Days";
            end;
        }
        field(50015; Route; Enum "Drug Routes")
        {
        }
        field(50016; Frequency; Integer)
        {
            Description = 'number of days';

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then
                    Quantity := Take * Frequency * "Number of Days";
            end;
        }
        field(50017; "Number of Days"; Integer)
        {
            Description = 'Number of Days';

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then
                    Quantity := Take * Frequency * "Number of Days";
            end;
        }
        field(50018; Posted; Boolean)
        {
        }
        field(50019; "Posted By"; Code[200])
        {
        }
        field(50020; "Posted Date"; Date)
        {
        }
        field(50021; "Date Created"; Date)
        {
        }
        field(50022; "Created By"; Code[200])
        {
        }
        field(50023; Selected; Boolean)
        {
        }
        field(50024; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50025; "Unit Price"; Decimal)
        {
        }
        field(50026; Amount; Decimal)
        {
        }
        field(50027; "Inventory Group"; Code[20])
        {
            CalcFormula = lookup(Item."Inventory Posting Group" where("No." = field("Drug No.")));
            FieldClass = FlowField;
        }
        field(50028; "Transaction Type"; Code[20])
        {
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(50029; "Posting Date"; Date)
        {
        }
        field(50030; Reverse; Boolean)
        {
        }
        field(50031; "Prescription Dose"; Enum PrescriptionDoseEnum)
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Drug No.", "Location Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You cannot delete an already posted entry')
    end;

    trigger OnInsert()
    begin
        "Date Created" := Today;
        "Posted Date" := Today;
        "Posting Date" := Today;
        "Created By" := UserId;
    end;

    var
        Line: Record "HMS Admission Drug Prescribe";
        Admission: Record "HMS Admission Form Header";
        Interaction: Record "HMS Drug Interaction";
        Observation: Record "HMS Observation Form Header";
        Patient: Record "HMS Patient";
        Item: Record Item;
        Cust: Record Customer;

    local procedure CalcDosage(Dosages: Code[20]) Calc_Dosage: Boolean
    var
        DosageSetup: Record "HMS Dosage Setup";
    begin
        Calc_Dosage := false;

        DosageSetup.Reset();
        DosageSetup.SetRange(DosageSetup."Dose Code", Dosages);
        if DosageSetup.Find('-') then
            Calc_Dosage := DosageSetup."Calculate Dosage";
    end;
}
