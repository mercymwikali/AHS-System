Table 52202654 "HMS Laboratory Test Line"
{
    fields
    {
        field(1; "Laboratory No."; Code[20])
        {
            NotBlank = true;
        }
        field(4; "Laboratory Test Code"; Code[50])
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
        field(5; "Laboratory Test Name"; Text[250])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(6; "Specimen Code"; Code[20])
        {
            TableRelation = "HMS Setup Specimen".Code;
        }
        field(7; "Specimen Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Specimen".Description where(Code = field("Specimen Code")));
            FieldClass = FlowField;
        }
        field(8; "Assigned User ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(9; "Collection Date"; Date)
        {
        }
        field(10; "Collection Time"; Time)
        {
        }
        field(11; "Measuring Unit Code"; Code[20])
        {
            TableRelation = "HMS Setup Measuring Unit".Code;
        }
        field(12; "Measuring Unit Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Measuring Unit".Description where(Code = field("Measuring Unit Code")));
            FieldClass = FlowField;
        }
        field(13; "Count Value"; Decimal)
        {
        }
        field(14; Remarks; Text[250])
        {
        }
        field(15; Completed; Boolean)
        {
        }
        field(16; Positive; Boolean)
        {
        }
        field(17; Results; Option)
        {
            OptionCaption = ' ,Postitive,Negative,Reactive,Non-Reactive,No MPs Seen,MPs Seen';
            OptionMembers = " ",Postitive,Negative,Reactive,"Non-Reactive","No MPs Seen","MPs Seen";
        }
        field(18; Specimen; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Setup Lab Package".Code;
        }
        field(19; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                // END;
            end;
        }
        field(20; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Insurance No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Patient No"; Code[30])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Patient No." where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(23; "Treatment No"; Code[30])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Link No." where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(24; DateFilter; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(26; "Insurance Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(27; "Insurance Code"; Code[10])
        {
            CalcFormula = lookup("HMS Patient"."Insurance No." where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(28; "Test Amount"; Decimal)
        {
            CalcFormula = lookup("HMS Patient Charges".Amount where("Patient No." = field("Patient No"),
                                                                     Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(29; OutSourced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Link No"; Code[20])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Link No." where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(31; "Lab Date"; Date)
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Laboratory Date" where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(32; "Duplicate test"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(57; "Color Code"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '0,1,2';
            OptionMembers = "0","1","2";
        }
        field(58; "Reviewed By"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(59; "Reveiw Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Review Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "User ID_"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(62; "Test Method Modified"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Modification Comments"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Completion Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(66; Dept; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Lab Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Lab Request Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Treat No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,New,Review,Interim,Completed,Recalled';
            OptionMembers = " ",New,Review,Interim,Completed,Recalled;
        }
        field(71; "Unique No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Payment Exist"; Boolean)
        {
            CalcFormula = exist("HMS Patient Charges" where("Link No" = field("Laboratory Test Code"), "Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(73; "Charges Insurance No"; code[20])
        {
            CalcFormula = lookup("HMS Patient Charges"."Insurance No" where("Patient No." = field("Patient No"),
                                                                     Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(74; "Receipt No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Receipt Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Sample Collected"; Boolean)
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
        field(80; "Results Added"; Boolean)
        { // TODO: Only Change to true when all results have been added for this particular test.(Add the check in New Web Portal Codeunit).
            DataClassification = ToBeClassified;
        }
        field(81; "Results Type"; Enum "Lab Result Types")
        {

        }
        field(82; "Staff No"; Code[30])
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
        field(83; "Staff Name"; Text[150])
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
