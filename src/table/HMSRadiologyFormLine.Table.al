Table 85231 "HMS Radiology Form Line"
{
    fields
    {
        field(50000; "Radiology no."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Radiology Type Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Radiology Type".Code;

            trigger OnValidate()

            begin
                //insert into charges
                RadioHeader.Reset();
                RadioHeader.SetRange(RadioHeader."Radiology No.", "Radiology no.");
                if RadioHeader.Find('-') then begin
                    RadioRec.Get("Radiology Type Code");
                    Charges.get("Radiology Type Code");

                    HMSPatientCharges.Init();
                    HMSPatientCharges."Line No" := HMSPatientCharges."Line No" + 1;
                    HMSPatientCharges."Patient No." := RadioHeader."Patient No.";
                    HMSPatientCharges."Link No" := RadioHeader."Link No.";
                    HMSPatientCharges."Treatment No." := RadioHeader."Link No.";
                    HMSPat.Reset();
                    HMSPat.SetRange(HMSPat."Patient No.", RadioHeader."Patient No.");
                    if HMSPat.Find('-') then
                        HMSPatientCharges."Shortcut Dimension 1 Code" := HMSPat."Global Dimension 1 Code";
                    HMSPatientCharges."Shortcut Dimension 2 Code" := 'RADIOLOGY';
                    HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
                    HMSPatientCharges.Validate("Transaction Type");
                    HMSPatientCharges.Code := "Radiology Type Code";
                    HMSPatientCharges.validate(Code);
                    HMSPatientCharges.Description := RadioRec.Description;
                    HMSPatientCharges."G/L Account No" := Charges."Income G/L Account No";
                    // HMSPatientCharges.Amount := RadioRec.Amount;
                    HMSPatientCharges.Validate(Amount);
                    HMSPatientCharges.Date := Today;
                    HMSPatientCharges."User ID" := UserId;
                    HMSPatientCharges."Creation Time" := Time;
                    HMSPatientCharges."Creation Date" := Today;
                    //HMSPatientCharges."Doctor ID":=HMSTreatH."Doctor ID";
                    HMSPatientCharges.Insert();
                end;
            end;
        }
        field(50002; "Radiology Type Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Radiology Type".Description where(Code = field("Radiology Type Code")));
            FieldClass = FlowField;
        }
        field(50003; "Assigned User ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50004; Completed; Boolean)
        {
        }
        field(50005; "Performed Date"; Date)
        {
        }
        field(50006; "Performed Time"; Time)
        {
        }
        field(50007; Remarks; Text[200])
        {
        }
        field(50008; "Clinical Summary &  Diagnosis"; Text[250])
        {
            FieldClass = Normal;
        }
        field(50009; "Required Investigation"; Text[250])
        {
        }
        field(50010; "Previous Investigation"; Text[250])
        {
        }
        field(50011; "Receipt No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Receipt Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Radiology no.", "Radiology Type Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record "HMS Charges";
        HMSPat: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        RadioHeader: Record "HMS Radiology Form Header";
        RadioRec: Record "HMS Setup Radiology Type";
}
