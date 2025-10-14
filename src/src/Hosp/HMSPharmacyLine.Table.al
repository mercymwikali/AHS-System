table 52202661 "HMS Pharmacy Line"
{
    fields
    {
        field(1; "Pharmacy No."; Code[20])
        {
            TableRelation = "HMS Pharmacy Header"."Pharmacy No.";
            trigger OnValidate()
            begin
                HMSPharmHeader.Reset();
                HMSPharmHeader.SetRange("Pharmacy No.", "Pharmacy No.");
                if HMSPharmHeader.FindFirst() then begin
                    Location := HMSPharmHeader."Issuing Location";
                    Pharmacy := HMSPharmHeader."Issuing Location";

                end;
            end;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'Drug No.';
            NotBlank = true;
            TableRelation = Item."No." where("Inventory Posting Group" = filter('DRUGS|NONPHARM|RENAL|VACCINES'));
            // REFACTOR: Predefined Inventory Posting Group.

            trigger OnValidate()
            begin
                HmsSetup.Get('');

                HMSPharmHeader.Get("Pharmacy No.");
                HMSPatient.Get(HMSPharmHeader."Patient No.");

                Location := HMSPharmHeader."Issuing Location";


                Item.Reset();
                item.SetRange("No.", "No.");
                Item.SetFilter("Location Filter", Location);
                Item.SetAutoCalcFields(Inventory);
                if Item.Find('-') then begin
                    // TODO: Alert Inventory Outage
                    //  Round Unit Cost
                    "Unit Cost" := Round(Item."Unit Cost", 1, '=');

                    // Fetch Patient Details
                    // HMSPatient.Reset();
                    // if HMSPatient.Get(HMSPharmHeader."Patient No.") then begin
                    // Check item NHif Coverage
                    if not Item."NHIF Covered" and (HMSPatient."Insurance No." <> '') then
                        if Cust.Get(HMSPatient."Insurance No.") and Cust."NHIF Capitation" then
                            Error('%1 is not covered by NHIF capitation.', Item."Search Description");

                    // Set Item Details
                    "Drug Name" := Item.Description;
                    Description2 := Item."Description 2";
                    "Unit Price" := Round(Item."Unit Price", 1, '=');
                    "Actual Price" := Round(Item."Unit Price", 1, '=');
                    "Unit Cost" := Round(Item."Unit Cost", 1, '=');
                    "Measuring Unit" := Item."Base Unit of Measure";
                    Route := Item.Route;
                    Frequency := Item.Frequency;
                    Dosage := Item.Dosage;
                    Take := Item.Take;
                    "Number of Days" := Item."Number of Days";
                    "Actual Qty" := item.Inventory;

                    // Calculate dosage and Quantity
                    if CalcDosage(Dosage) = true then begin
                        Quantity := Take * Frequency * "Number of Days";
                        "Issued Units" := Take * Frequency * "Number of Days";
                        "Issued Quantity" := Take * Frequency * "Number of Days";
                    end;

                    // Adjust unit price based on patient type
                    case HMSPatient."Patient Type" of
                        HMSPatient."Patient Type"::Corporate:
                            "Unit Price" := Round(Item."Unit Price", 1, '=');
                        HMSPatient."Patient Type"::Cash:
                            "Unit Price" := Round(Item."Unit Price", 1, '=');
                    end;

                    // Calculate Inventory
                    Item.SetFilter("Location Filter", Location);
                    Item.CalcFields(Inventory);

                end;

                CalculateQtyAndPrices();

                "Link Code" := HMSPharmHeader."Link No.";

                if TreatmentHeader.Get(HMSPharmHeader."Link No.") then
                    "Link Code" := TreatmentHeader."Link No.";

                if HMSObs.Get("Link Code") then
                    "Link Code" := HMSObs."Link No.";
            end;
        }
        field(3; "Drug Name"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(4; Quantity; Decimal)
        {
            trigger OnValidate()
            var
                HMSTreatmentFormDrug: Record "HMS Treatment Form Drug";
            begin
                CalculateQtyAndPrices();
                "Total Price" := Quantity * "Unit Price";
                "Insurance Total Amount" := Quantity * "Insurance Amount";
                "Issued Quantity" := Quantity;
                if Quantity < 0 then
                    Error('You cannot enter a negative quantity');

                HMSPharmHeader.Get("Pharmacy No.");
                if TreatmentHeader.Get(HMSPharmHeader."Link No.") then
                    TreatmentFormDrug.SetRange(TreatmentFormDrug."Treatment No.", TreatmentHeader."Treatment No.");
                TreatmentFormDrug.SetRange(TreatmentFormDrug."Drug No.", "No.");
                if TreatmentFormDrug.IsEmpty() then begin
                    HMSTreatmentFormDrug.Init();
                    HMSTreatmentFormDrug."Treatment No." := TreatmentHeader."Treatment No.";
                    HMSTreatmentFormDrug."Drug No." := "No.";
                    HMSTreatmentFormDrug.Validate("Drug No.");
                    HMSTreatmentFormDrug.Quantity := Quantity;
                    HMSTreatmentFormDrug.Validate(Quantity);
                    HMSTreatmentFormDrug.Status := HMSTreatmentFormDrug.Status::Forwarded;
                    HMSTreatmentFormDrug.Insert();
                end;
            end;
        }
        field(5; "Measuring Unit"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
        }
        field(6; "Unit Price"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Unit Price" < "Actual Price" then
                    Error('Please note that Unit price can not be less than actual unit price');
                "Total Price" := Quantity * "Unit Price";
            end;
        }
        field(7; "Actual Qty"; Decimal)
        {
        }
        field(8; "Actual Price"; Decimal)
        {
        }
        field(9; "Issued Quantity"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Actual Qty" < "Issued Quantity" then
                    Error('You Cannot Issued more than what is in the stock');
                CalculateQtyAndPrices();
            end;
        }
        field(10; "Issued Units"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Actual Qty" < "Issued Units" then
                    Error('You Cannot Issued more than what is in the stock');

                CalculateQtyAndPrices();
            end;
        }
        field(11; "Issued Price"; Decimal)
        {
        }
        field(12; Dosage; Text[100])
        {
        }
        field(13; Remarks; Text[200])
        {
        }
        field(14; Pharmacy; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(15; Remaining; Decimal)
        {
        }
        field(16; Date; Date)
        {
            CalcFormula = lookup("HMS Pharmacy Header"."Pharmacy Date" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(17; "Linking No."; Code[20])
        {
            CalcFormula = lookup("HMS Pharmacy Header"."Link No." where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(18; "Link Type"; Code[20])
        {
            CalcFormula = lookup("HMS Pharmacy Header"."Link Type" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(19; "Drugs Category"; Code[20])
        {
            TableRelation = Item."Item Category Code";
        }
        field(20; "Patient No"; Code[20])
        {
            CalcFormula = lookup("HMS Pharmacy Header"."Patient No." where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(22; Invoiced; Boolean)
        {
        }
        field(23; Paid; Boolean)
        {
        }
        field(24; "Invoice Counter"; Integer)
        {
            FieldClass = Normal;
        }
        field(25; "Link Code"; Code[20])
        {
        }
        field(26; "Link Type LK"; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Link No." where("Treatment No." = field("Linking No.")));
            FieldClass = FlowField;
        }
        field(27; "Posted Doc No"; Code[20])
        {
        }
        field(28; Location; Code[20])
        {
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                CalculateQtyAndPrices();
            end;
        }
        field(29; Balance; Decimal)
        {
        }
        field(30; Take; Decimal)
        {
            Description = 'taken per day';
            NotBlank = true;

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then begin
                    Quantity := Take * Frequency * "Number of Days";
                    "Issued Units" := Take * Frequency * "Number of Days";
                    // "Issued Quantity"   :=Take * Frequency * "Number of Days";
                end;
            end;
        }

        field(31; Route; Enum "Drug Routes")
        {            
        }
        field(32; Frequency; Integer)
        {
            Description = 'Number of times the patient takes the drugs';

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then begin
                    Quantity := Take * Frequency * "Number of Days";
                    "Issued Units" := Take * Frequency * "Number of Days";
                    //  "Issued Quantity"   :=Take * Frequency * "Number of Days";
                end;
            end;
        }
        field(50005; "Number of Days"; Integer)
        {
            Description = 'Number of Days the patient takes the drugs';

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then begin
                    Quantity := Take * Frequency * "Number of Days";
                    "Issued Units" := Take * Frequency * "Number of Days";
                    // "Issued Quantity"   :=Take * Frequency * "Number of Days";
                end;
            end;
        }
        field(50006; "Returns Quantity"; Decimal)
        {
        }
        field(50007; Reversed; Boolean)
        {
        }
        field(50008; "line no"; Integer)
        {
            AutoIncrement = true;
        }
        field(50009; "Total Price"; Decimal)
        {
        }
        field(50010; Status; Option)
        {
            CalcFormula = lookup("HMS Pharmacy Header".Status where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
            OptionMembers = New,Completed,Cancelled;
        }
        field(50011; "Issue Date"; Date)
        {
            CalcFormula = lookup("HMS Pharmacy Header"."Pharmacy Date" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(50012; Names; Text[200])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50013; "Insurance Amount"; Decimal)
        {
        }
        field(50014; "Insurance Total Amount"; Decimal)
        {
        }
        field(50015; "Unit Cost"; Decimal)
        {
        }
        field(50016; "Prescription Dose"; Enum PrescriptionDoseEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Item Journal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Global Dimension Code 1"; Code[20])
        {
            CalcFormula = lookup("HMS Pharmacy Header"."Global Dimension 1 Code" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
            CaptionClass = '1,1,1';
        }
        field(50019; "Description2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Insurance No1"; Code[20])
        {
            CalcFormula = Lookup("HMS Patient"."Insurance No." where("Patient No." = field("Patient No"), "Patient Type" = filter(Corporate)));
            FieldClass = FlowField;
        }
        field(62; "Sale Type"; Boolean)
        {
            CalcFormula = Lookup("HMS Pharmacy Header"."Cash Sale" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(512; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(513; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(514; "Insurance code"; Code[20])
        {
            CalcFormula = Lookup("HMS Patient"."Insurance No." where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(515; "pharm count Walkin Cash"; Integer)
        {
            CalcFormula = Count("HMS Pharmacy Header" where("Pharmacy Date" = field("Date Filter"), "Cash Sale" = filter(true), "Patient Type" = filter(Cash), Walkin = filter(true)));
            FieldClass = FlowField;
        }
        field(516; Branch; Code[20])
        {
            CalcFormula = lookup("HMS Pharmacy Header"."Global Dimension 1 Code" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(517; "Capitation Amount"; Decimal)
        {
        }
        field(518; "Minimum Price"; Decimal)
        {
            CalcFormula = lookup(Item."Minimum Unit Price" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(519; "Maximum Price"; Decimal)
        {
            CalcFormula = lookup(Item."Maximum Unit Price" where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50020; "Returns Posted"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Pharmacy No.", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //IF UserRec.GET(USERID) THEN
        //Location:=UserRec."Default Store Location";
    end;

    var
        Cust: Record Customer;
        HMSObs: Record "HMS Observation Form Header";
        HMSPatient: Record "HMS Patient";
        HMSPharmHeader: Record "HMS Pharmacy Header";
        HmsSetup: Record "HMS Setup";
        TreatmentFormDrug: Record "HMS Treatment Form Drug";
        TreatmentHeader: Record "HMS Treatment Form Header";
        Item: Record Item;
        DrugsProfitPerc: Decimal;

    local procedure CalculateQtyAndPrices()
    var
        Cust: Record Customer;
        HMSSetup: Record "HMS Setup";
    begin
        HMSSetup.Get();
        DrugsProfitPerc := 1;
        Item.Reset();
        item.SetRange("No.", "No.");
        item.SetFilter("Location Filter", Location);
        if Item.Find('-') then begin
            //"Unit Price":=Item."Unit Price";
            HMSPatient.Reset();
            HMSPatient.SetRange(HMSPatient."Patient No.", HMSPharmHeader."Patient No.");
            if HMSPatient.Find('-') then begin
                if HMSPatient."Patient Type" = HMSPatient."patient type"::Corporate then begin
                    cust.Get(HMSPatient."Insurance No.");
                    if HMSSetup."Insurance Items Price Type" = HMSSetup."Insurance Items Price Type"::"Unit Price Insurance Amount" then
                        "Unit Price" := Round(Item."Unit Price", 1, '=');
                    if HMSSetup."Insurance Items Price Type" = HMSSetup."Insurance Items Price Type"::"Unit Price + Insurate Rate" then
                        if cust."Insurance Rate" = 0 then
                            "Unit Price" := Item."Unit Price"
                        else
                            // error('Please enter the Insurance rate in Insurance No ' + HMSPatient."Insurance No.");
                            "Unit Price" := Round(Item."Unit Price" + (cust."Insurance Rate" * Item."Unit Price" / 100), 1, '=');
                    if cust."NHIF Capitation" = true then
                        "Unit Price" := Round(Item."Unit Cost", 1, '=');

                    "Insurance Amount" := Round(Item."Unit Price", 1, '=');
                end else
                    "Unit Price" := Round(Item."Unit Price", 1, '=');

                Item.CalcFields(Item.Inventory);
                "Actual Qty" := Item.Inventory;
                "Issued Price" := Round(("Unit Price" * DrugsProfitPerc * "Issued Quantity"), 1, '=');
                "Actual Price" := Round(("Unit Price" * DrugsProfitPerc), 1, '=');

                //  IF Cust.GET(HMSPatient."Insurance No.") THEN
                // IF (Cust."Insurance Rate">0)  THEN BEGIN
                //   "Insurance Amount" := 0.0;
                //    "Insurance Amount":= Item."Unit Price Insurance";
                //"Insurance Amount":= (Item."Unit Price"+(Item."Unit Price"*(Cust."Insurance Rate"/100)));

                //END;
                // if "Unit Price" < Item."Unit Cost" then
                //     error('Please note that Unit Price can not be less than Unit Cost. Unit Price=' + format("Unit Price") + ' Unit Cost=' + format("Unit Price"));
            end;
        end;
        "Actual Price" := Round("Unit Price", 1, '=');
    end;

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
