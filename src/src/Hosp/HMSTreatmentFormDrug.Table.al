Table 52202499 "HMS Treatment Form Drug"
{
    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Drug No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                Item.Reset();
                Item.SetRange(Item."No.", "Drug No.");
                if Item.Find('-') then begin
                    "Drug Name" := Item.Description;
                    "Unit Of Measure" := Item."Base Unit of Measure";
                    Route := Item.Route;
                    Frequency := Item.Frequency;
                    Dosage := Item.Dosage;
                    Take := Item.Take;
                    "Number of Days" := Item."Number of Days";

                    if CalcDosage(Dosage) = true then
                        if UnitsOfMeasure.Get("Unit Of Measure") then
                            if UnitsOfMeasure."Per Piece" = true then
                                Quantity := Take * Frequency * "Number of Days";

                    if Treath.Get("Treatment No.") then
                        HmsPat.SetRange(HmsPat."Patient No.", Treath."Patient No.");
                    if HmsPat.Find('-') then begin
                        if HmsPat."Patient Type" = HmsPat."patient type"::Corporate then begin
                            "Unit Price" := Item."Unit Price Insurance";
                            "Total Price" := Item."Unit Price Insurance" * Quantity;
                        end;
                        if HmsPat."Patient Type" = HmsPat."patient type"::Cash then begin
                            "Unit Price" := Item."Unit Price";
                            "Total Price" := Item."Unit Price" * Quantity;
                        end;
                    end;
                end;

                /*Check if the drug has any drug within the prescription where it is not compatible*/
                /*Interaction.RESET;
                Interaction.SETRANGE(Interaction."Drug No.","Drug No.");
                IF Interaction.FIND('-') THEN
                  BEGIN
                    REPEAT
                      {Get the lines of drugs that have been identified as being incompatible with the drug selected}
                        Line.RESET;
                        Line.SETRANGE(Line."Treatment No.","Treatment No.");
                        Line.SETRANGE(Line."Drug No.",Interaction."Drug No. 1");
                        IF Line.FIND('-') THEN
                          BEGIN
                            Line.CALCFIELDS(Line."Drug Name");
                            IF CONFIRM('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?',FALSE)=TRUE THEN
                              BEGIN
                                Line."Marked as Incompatible":=TRUE;
                                Line.MODIFY;
                              END
                            ELSE
                              BEGIN
                                ERROR('Drug Incompatible.Operation Cancelled');
                              END;
                          END;
                        Line.RESET;
                        Line.SETRANGE(Line."Treatment No.","Treatment No.");
                        Line.SETRANGE(Line."Drug No.",Interaction."Drug No.");
                        IF Line.FIND('-') THEN
                          BEGIN
                            Line.CALCFIELDS(Line."Drug Name");
                            IF CONFIRM('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?',FALSE)=TRUE THEN
                              BEGIN
                                Line."Marked as Incompatible":=TRUE;
                                Line.MODIFY;
                              END
                            ELSE
                              BEGIN
                                ERROR('Drug Incompatible.Operation Cancelled');
                              END;
                          END;
                    UNTIL Interaction.NEXT=0;
                  END;
                  */
            end;
        }
        field(3; "Drug Name"; Text[100])
        {
        }
        field(4; Quantity; Integer)
        {
            trigger OnValidate()
            begin
                if Treath.Get("Treatment No.") then begin
                    HmsPat.SetRange(HmsPat."Patient No.", Treath."Patient No.");
                    if HmsPat.Find('-') then begin
                        if HmsPat."Patient Type" = HmsPat."patient type"::Corporate then begin
                            "Unit Price" := Item."Unit Price";
                            "Total Price" := Item."Unit Price" * Quantity;
                        end;
                        if HmsPat."Patient Type" = HmsPat."patient type"::Cash then begin
                            "Unit Price" := Item."Unit Price";
                            "Total Price" := Item."Unit Price" * Quantity;
                        end;
                    end;
                end;
            end;
        }
        field(5; "Unit Of Measure"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Drug No."));
        }
        field(6; Remarks; Text[100])
        {
        }
        field(7; "Pharmacy Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Location.Code;
        }
        field(8; "Actual Quantity"; Decimal)
        {
        }
        field(9; Inventory; Decimal)
        {
        }
        field(10; Issued; Boolean)
        {
        }
        field(11; Take; Decimal)
        {
            Description = 'taken per day';
            NotBlank = true;

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then begin
                    Quantity := Take * Frequency * "Number of Days";
                    if UnitsOfMeasure.Get("Unit Of Measure") then
                        if UnitsOfMeasure."Per Piece" = true then
                            Quantity := Take * Frequency * "Number of Days"
                        else
                            Quantity := 1;
                end;
            end;
        }
        field(12; "Marked as Incompatible"; Boolean)
        {
        }
        field(13; "Product Group"; Code[20])
        {
            //  TableRelation = "Product Group".Code;
        }
        field(14; Route; Enum "Drug Routes")
        {
            // OptionCaption = 'Oral,IV,Rectal,Vaginal,Subcutaneuos,Nasal,Intrathical,Intradermal,Intramuscular,I.M,Topical';
            // OptionMembers = Oral,IV,Rectal,Vaginal,Subcutaneuos,Nasal,Intrathical,Intradermal,Intramuscular,"I.M",Topical;
        }
        field(15; Frequency; Integer)
        {
            Description = 'number of days';

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then
                    if UnitsOfMeasure.Get("Unit Of Measure") then
                        if UnitsOfMeasure."Per Piece" = true then
                            Quantity := Take * Frequency * "Number of Days"
                        else
                            Quantity := 1;
            end;
        }
        field(16; Dosage; Code[10])
        {
        }
        field(50005; "Number of Days"; Integer)
        {
            Description = 'Number of Days';

            trigger OnValidate()
            begin
                if CalcDosage(Dosage) = true then
                    if UnitsOfMeasure.Get("Unit Of Measure") then
                        if UnitsOfMeasure."Per Piece" = true then
                            Quantity := Take * Frequency * "Number of Days"
                        else
                            Quantity := 1;
            end;
        }
        field(50006; Posted; Boolean)
        {
        }
        field(50007; "IP Status"; Option)
        {
            OptionCaption = ',Ongoing,Stopped';
            OptionMembers = ,Ongoing,Stopped;
        }
        field(50008; Inpatient; Boolean)
        {
        }
        field(50009; "Stopped by"; Code[50])
        {
        }
        field(50010; "Stopped Date"; Date)
        {
        }
        // field(50011; "Prescription Dose"; Code[20])
        // {
        // }
        field(50011; "Prescription Dose"; Enum PrescriptionDoseEnum)
        {
        }
        field(50012; "Date Taken"; Date)
        {
        }
        field(50013; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Forwarded,Completed';
            OptionMembers = New,Forwarded,Completed;
        }
        field(50014; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Total Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Lline No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50017; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50018; "Remaining Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Prescribed By"; Code[50])
        {
            FieldClass = Normal;
            TableRelation = User."User Name";

            trigger OnValidate()
            begin
                Usr.Reset();
                Usr.SetRange("User Name", "Prescribed By");
                if Usr.Find('-') then
                    "Prescribed By name" := Usr."Full Name";
            end;
        }
        field(50020; "Prescribed By name"; Text[50])
        {
            FieldClass = Normal;
        }
        field(50021; "Patient No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Patient Names"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Date Prescribed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Sent Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Pharmacy Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Outpatient,Inpatient,Discharge';
            OptionMembers = ,Outpatient,Inpatient,Discharge;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Product Group", "Drug No.", "Lline No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HmsPat: Record "HMS Patient";
        Treath: Record "HMS Treatment Form Header";
        Item: Record Item;
        UnitsOfMeasure: Record "Unit of Measure";
        Usr: Record User;

    local procedure CalcDosage(Dosages: Code[20]) Calc_Dosage: Boolean
    var
        DosageSetup: Record "HMS Dosage Setup";
    begin
        Calc_Dosage := false;

        DosageSetup.Reset();
        DosageSetup.SetRange(DosageSetup."Dose Code", Dosages);
        if DosageSetup.FindFirst() then
            Calc_Dosage := DosageSetup."Calculate Dosage";
    end;
}
