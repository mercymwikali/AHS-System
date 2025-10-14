Table 52202486 "HMS Patient Visit Nos"
{
    fields
    {
        field(1; "Patient No"; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(2; "Visit No"; Code[20])
        {
        }
        field(3; Balance; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No"),
                                                                          "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(4; "Doctor Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Visit No" = field("Visit No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            "Posting Document No" = field("Charge Posting No"),
                                                                             "Posted to Doctor" = filter(false),
                                                                             Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(406; "Doctor Amount Posted"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Visit No" = field("Visit No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            Claimed = filter(true), Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(408; "Doctor Amount All"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Visit No" = field("Visit No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(438; "Doctor Amount Posting"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Doctors Posting No" = field("Posting No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            "Visit No" = field("Visit No"),
                                                                            Posted = filter(true),
                                                                            Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(5; "Doctor ID"; Code[20])
        {
            // TableRelation = Vendor."No." where("Vendor Posting Group" = filter('DOCTORS'));
        }
        field(6; "User ID"; Code[50])
        {
        }
        field(7; Posted; Boolean)
        {
            Editable = true;
        }
        field(8; Date; Date)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment Date" where("Appointment No." = field("Visit No"),
                                                                                         "Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(9; "Invoice No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient Charges"."Invoice Number" where("Patient No." = field("Patient No"),
                                                                               "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(10; "Insurance No"; Code[20])
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Insurance No" where("Appointment No." = field("Visit No")));
            FieldClass = FlowField;
            TableRelation = Customer."No.";
        }
        field(11; Show; Boolean)
        {
            trigger OnValidate()
            begin
                TestField(Posted, true);
                CheckifPaid("Visit No", "Patient No");
                TestField("Fully Paid", true);
            end;
        }
        field(12; Names; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(13; "Corp Balance"; Decimal)
        {
        }
        field(14; "Doctor%"; Decimal)
        {
            CalcFormula = lookup("HMS Setup Doctor"."Commission Perc" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(15; Completed; Boolean)
        {
        }
        field(16; "Completion Date"; Date)
        {
        }
        field(17; "Completion Time"; Time)
        {
        }
        field(18; "Completed By"; Code[50])
        {
        }
        field(19; "Batch No"; Code[20])
        {
        }
        field(219; "Posting No"; Code[20])
        {
        }
        field(2109; "Charge Posting No"; Code[20])
        {
        }
        field(20; "Ins WHT"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".WHT where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(21; "Ins HDF"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".HDF where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(22; "Ins Gross"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Gross Amount" where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(23; "Ins NET"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Net Amount" where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(24; "Total WHT"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".WHT);
            FieldClass = FlowField;
        }
        field(25; "Total HDF"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".HDF);
            FieldClass = FlowField;
        }
        field(26; "Total Gross"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Gross Amount");
            FieldClass = FlowField;
        }
        field(27; "Total NET"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Net Amount");
            FieldClass = FlowField;
        }
        field(28; Amount; Decimal)
        {
            Description = 'DoctorGross>23999';
        }
        field(39; Quantity; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Quantity where("Patient No." = field("Patient No"),
                                                                    "Visit No" = field("Visit No"),
                                                                    "Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(40; "Total Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No"),
                                                                          "Visit No" = field("Visit No"),
                                                                          "Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(41; "Posted Count"; Integer)
        {
            CalcFormula = count("Vendor Ledger Entry" where("Vendor No." = field("Doctor ID"),
                                                             "Document No." = field("Visit No"),
                                                             "External Document No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(42; "Vendor Exists"; Integer)
        {
            CalcFormula = count(Vendor where("No." = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(43; "Doctor Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(44; "Fully Paid"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckifPaid("Visit No", "Patient No");
            end;
        }
        field(45; "Insurance Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Insurance No")));
            FieldClass = FlowField;
            TableRelation = Customer.Name;
        }
        field(46; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Patient Type" where("Appointment No." = field("Visit No")));
            FieldClass = FlowField;
            OptionMembers = " ",Corporate,Cash;
        }
        field(47; "Charge Date"; Date)
        {
            CalcFormula = lookup("HMS Patient Charges".Date where("Patient No." = field("Patient No"), "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(48; "Batch Total Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Visit Nos".Amount where("Batch No" = field("Batch No"),
                                                                          "Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Patient No", "Visit No", "Doctor ID", "Posting No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure CheckifPaid(VisitNo: Code[20]; PatNo: Code[20]): Boolean
    var
        CustL2: Record "Cust. Ledger Entry";
        PatCharges: Record "HMS Patient Charges";
        IsPaid: Boolean;
    begin
        IsPaid := false;
        PatCharges.Reset();
        PatCharges.SetRange(PatCharges."Visit No", VisitNo);
        PatCharges.SetRange(PatCharges."Patient No.", PatNo);
        if PatCharges.Find('-') then begin
            PatCharges.CalcFields(PatCharges."Invoice Entry No");
            PatCharges.CalcFields(PatCharges."Insurance Paid Amount");
            PatCharges.CalcFields(PatCharges."Visit Balance");
            if PatCharges."Insurance Paid Amount" + PatCharges."Visit Balance" < 1 then
                IsPaid := true
            else begin // Check if Invoice is fully applied (NHIF)
                CustL2.Reset();
                CustL2.SetRange(CustL2."Document No.", PatCharges."Invoice Number");
                if CustL2.Find('-') then begin
                    CustL2.CalcFields(CustL2."Remaining Amount");
                    if CustL2."Remaining Amount" < 1 then
                        IsPaid := true;
                end;
            end;
        end;
        "Fully Paid" := IsPaid;
        if IsPaid = false then
            "Corp Balance" := PatCharges."Insurance Paid Amount" + PatCharges."Visit Balance";
        Modify();
    end;
}
