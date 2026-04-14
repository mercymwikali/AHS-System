Table 85171 "HMS Admission Drug Nurse"
{
    fields
    {
        field(50000; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Drug No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Admission Drug Prescribe"."Drug No." where("Admission No." = field("Admission No.")); // TODO: This prevents entry of non existent prescription. 
            trigger OnValidate()
            begin
                if Issued = true then begin
                    "Issued Date" := Today;
                    "Issued Time" := Time;
                    "Issued By" := UserId;
                end;

                HMSTreatmentFormDrug.Reset();
                HMSTreatmentFormDrug.SetRange("Drug No.", "Drug No.");
                if HMSTreatmentFormDrug.Find('-') then
                    "Prescribed By2" := HMSTreatmentFormDrug."Prescribed By name";

                /*Check if the drug has any drug within the prescription where it is not compatible*/
                Interaction.Reset();
                Interaction.SetRange(Interaction."Drug No.", "Drug No.");
                if Interaction.Find('-') then
                    repeat
                        /*Get the lines of drugs that have been identified as being incompatible with the drug selected*/
                        Line.Reset();
                        Line.SetRange(Line."Admission No.", "Admission No.");
                        Line.SetRange(Line."Drug No.", Interaction."Drug No. 1");
                        if Line.Find('-') then begin
                            Line.CalcFields(Line."Drug Name");
                            if Confirm('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?', false) = true then begin
                                Line."Marked as Incompatible" := true;
                                Line.Modify();
                            end
                            else
                                Error('Drug Incompatible.Operation Cancelled');
                        end;
                        Line.Reset();
                        Line.SetRange(Line."Admission No.", "Admission No.");
                        Line.SetRange(Line."Drug No.", Interaction."Drug No.");
                        if Line.Find('-') then begin
                            Line.CalcFields(Line."Drug Name");
                            if Confirm('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?', false) = true then begin
                                Line."Marked as Incompatible" := true;
                                Line.Modify();
                            end
                            else
                                Error('Drug Incompatible.Operation Cancelled');
                        end;
                    until Interaction.Next() = 0;
            end;
        }
        field(50002; "Drug Name"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Drug No.")));
            FieldClass = FlowField;
        }
        field(50003; Quantity; Integer)
        {
        }
        field(50004; "Unit Of Measure"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Drug No."));
        }
        field(50005; Remarks; Text[100])
        {
            trigger OnValidate()
            begin
                if Issued = true then begin
                    "Issued Date" := Today;
                    "Issued Time" := Time;
                    "Issued By" := UserId;
                end;

                HMSTreatmentFormDrug.Reset();
                HMSTreatmentFormDrug.SetRange("Drug No.", "Drug No.");
                if HMSTreatmentFormDrug.Find('-') then
                    "Prescribed By2" := HMSTreatmentFormDrug."Prescribed By name";
                // HMSTreatmentFormDrug.CalcFields("Prescribed By name");
            end;
        }
        field(50006; "Pharmacy Code"; Code[20])
        {
            NotBlank = true;
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
            trigger OnValidate()
            begin
                if Issued = true then begin
                    "Issued Date" := Today;
                    "Issued Time" := Time;
                    "Issued By" := UserId;
                end;

                HMSTreatmentFormDrug.Reset();
                HMSTreatmentFormDrug.SetRange("Drug No.", "Drug No.");
                if HMSTreatmentFormDrug.Find('-') then begin
                    HMSTreatmentFormDrug.CalcFields("Prescribed By name");
                    "Prescribed By2" := HMSTreatmentFormDrug."Prescribed By name";
                end;
            end;
        }
        field(50010; Dosage; Text[200])
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
        field(50014; "Issued Date"; Date)
        {
        }
        field(50015; "Issued Time"; Time)
        {
        }
        field(50016; "Issued By"; Text[100])
        {
        }
        field(50017; "Prescription Dose"; Enum PrescriptionDoseEnum)
        {
        }
        field(50018; "Patient No"; Code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header"."Patient No." where("Admission No." = field("Admission No.")));
            FieldClass = FlowField;
        }
        field(50019; "Prescribed by"; Code[50])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Doctor ID" where("Adm No." = field("Admission No.")));
            FieldClass = FlowField;
        }
        field(50020; "Prescribed By name"; Text[50])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Doctor's Name" where("Adm No." = field("Admission No.")));
            FieldClass = FlowField;
        }
        field(50021; "Prescribed By2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Drug No.", "Issued Date", "Issued Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Line: Record "HMS Admission Drug Prescribe";
        Interaction: Record "HMS Drug Interaction";
        HMSTreatmentFormDrug: Record "HMS Treatment Form Drug";
}
