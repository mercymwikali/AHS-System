Table 85314 "HMS Laboratory Test Line"
{
    fields
    {
        field(50000; "Laboratory No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Laboratory Test Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;

            trigger OnValidate()
            var

            begin
                /*
                    ********* Check Link no document to see if the lab lines had already been created**********************
                    - if not add in the lab request in the doctors side
                */
            end;
        }
        field(50002; "Laboratory Test Name"; Text[250])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(50003; "Specimen Code"; Code[20])
        {
            TableRelation = "HMS Setup Specimen".Code;
        }
        field(50004; "Specimen Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Specimen".Description where(Code = field("Specimen Code")));
            FieldClass = FlowField;
        }
        field(50005; "Assigned User ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50006; "Collection Date"; Date)
        {
        }
        field(50007; "Collection Time"; Time)
        {
        }
        field(50008; "Measuring Unit Code"; Code[20])
        {
            TableRelation = "HMS Setup Measuring Unit".Code;
        }
        field(50009; "Measuring Unit Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Measuring Unit".Description where(Code = field("Measuring Unit Code")));
            FieldClass = FlowField;
        }
        field(50010; "Count Value"; Decimal)
        {
        }
        field(50011; Remarks; Text[250])
        {
        }
        field(50012; Completed; Boolean)
        {
        }
        field(50013; Positive; Boolean)
        {
        }
        field(50014; Results; Option)
        {
            OptionCaption = ' ,Postitive,Negative,Reactive,Non-Reactive,No MPs Seen,MPs Seen';
            OptionMembers = " ",Postitive,Negative,Reactive,"Non-Reactive","No MPs Seen","MPs Seen";
        }
        field(50015; Specimen; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Setup Lab Package".Code;
        }
        field(50016; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                // END;
            end;
        }
        field(50017; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Insurance No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Patient No"; Code[30])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Patient No." where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(50020; "Treatment No"; Code[30])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Link No." where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(50021; DateFilter; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(50023; "Insurance Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50024; "Insurance Code"; Code[10])
        {
            CalcFormula = lookup("HMS Patient"."Insurance No." where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50025; "Test Amount"; Decimal)
        {
            CalcFormula = lookup("HMS Patient Charges".Amount where("Patient No." = field("Patient No"),
                                                                     Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(50026; OutSourced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Link No"; Code[20])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Link No." where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(50028; "Lab Date"; Date)
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Laboratory Date" where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(50029; "Duplicate test"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50030; "Color Code"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '0,1,2';
            OptionMembers = "0","1","2";
        }
        field(50031; "Reviewed By"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50032; "Reveiw Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Review Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "User ID_"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50035; "Test Method Modified"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Modification Comments"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Completion Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; Dept; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Lab Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Lab Request Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Treat No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,New,Review,Interim,Completed,Recalled';
            OptionMembers = " ",New,Review,Interim,Completed,Recalled;
        }
        field(50044; "Unique No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Payment Exist"; Boolean)
        {
            CalcFormula = exist("HMS Patient Charges" where("Link No" = field("Laboratory Test Code"), "Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50046; "Charges Insurance No"; code[20])
        {
            CalcFormula = lookup("HMS Patient Charges"."Insurance No" where("Patient No." = field("Patient No"),
                                                                     Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(50047; "Receipt No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Receipt Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Sample Collected"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                HMSCharges: Record "HMS Charges";
                HMSTransType: Record "HMS Transactions code";
            begin
                if "Sample Collected" then begin
                    //insert into charges
                    LAbHeader.Reset();
                    LAbHeader.SetRange(LAbHeader."Laboratory No.", "Laboratory No.");
                    if LAbHeader.Find('-') then begin
                        Labec.Get("Laboratory Test Code");
                        HMSCharges.get("Laboratory Test Code");
                        HMSTransType.get(HMSCharges."Transaction Type");

                        HMSPatientCharges.Init();

                        //HMSPatientCharges."Doctor ID":=HMSTreatH."Doctor ID";
                        if PatRec.Get(LAbHeader."Patient No.") then begin
                            HMSPatientCharges."Admission No" := PatRec."Adm No.";
                            HMSPatientCharges."Visit No" := PatRec."Active Visit No";
                        end;
                        //HMSPatientCharges."Line No":=HMSPatientCharges."Line No"+1;
                        HMSPatientCharges."Patient No." := LAbHeader."Patient No.";
                        HMSPatientCharges."Link No" := LAbHeader."Link No.";
                        HMSPatientCharges."Treatment No." := LAbHeader."Laboratory No.";

                        if HMSPatientCharges."Link No" = '' then
                            HMSPatientCharges."Link No" := LAbHeader."Laboratory No.";

                        Patient.SetRange(Patient."Patient No.", LAbHeader."Patient No.");
                        if Patient.Find('-') then
                            HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                        HMSPatientCharges."Shortcut Dimension 2 Code" := HMSTransType."Department Code";
                        HMSPatientCharges."Transaction Type" := HMSCharges."Transaction Type";
                        HMSPatientCharges.Validate("Transaction Type");
                        HMSPatientCharges.Code := "Laboratory Test Code";
                        HMSPatientCharges.Validate(code);
                        HMSPatientCharges.Validate(Amount);
                        HMSPatientCharges.Date := Today;
                        HMSPatientCharges."User ID" := UserId;
                        HMSPatientCharges."Creation Time" := DT2Time(System.CurrentDateTime);
                        HMSPatientCharges."Creation Date" := Today;
                        HMSPatientCharges.Insert();
                    end
                end;
            end;
        }
        field(50051; "Results Added"; Boolean)
        { // TODO: Only Change to true when all results have been added for this particular test.(Add the check in New Web Portal Codeunit).
            DataClassification = ToBeClassified;
        }
        field(50052; "Results Type"; Enum "Lab Result Types")
        {

        }
        field(50053; "Staff No"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
            trigger OnValidate()
            var
                HREmployee: Record "HR-Employee";
            begin
                HREmployee.Reset();
                HREmployee.SetRange("No.", "Staff No");
                if HREmployee.FindFirst() then
                    "Staff Name" := HREmployee."First Name" + ' ' + HREmployee."Last Name";
            end;
        }
        field(50054; "Staff Name"; Text[150])
        {

        }

    }

    keys
    {
        key(Key1; "Laboratory No.", "Laboratory Test Code", "Specimen Code", "Duplicate test")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LAbHeader: Record "HMS Laboratory Form Header";
        Patient: Record "HMS Patient";
        PatRec: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        Labec: Record "HMS Setup Lab Test";

    local procedure PatChargesLastLineNo(): Integer
    begin
    end;

    trigger OnDelete()
    var
        HMSLaboratoryResultsEntry: Record "HMS Laboratory Results Entry";
    begin
        HMSLaboratoryResultsEntry.Reset();
        HMSLaboratoryResultsEntry.SetRange("Laboratory No.", "Laboratory No.");
        HMSLaboratoryResultsEntry.SetRange("Laboratory Test Code", "Laboratory Test Code");
        if HMSLaboratoryResultsEntry.FindSet() then
            repeat
                HMSLaboratoryResultsEntry.Delete();
            until HMSLaboratoryResultsEntry.Next() = 0;
    end;
}
