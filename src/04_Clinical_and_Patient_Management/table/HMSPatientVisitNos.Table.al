Table 85218 "HMS Patient Visit Nos"
{
    fields
    {
        field(50000; "Patient No"; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50001; "Visit No"; Code[20])
        {
        }
        field(50002; Balance; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No"),
                                                                          "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(50003; "Doctor Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Visit No" = field("Visit No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            "Posting Document No" = field("Charge Posting No"),
                                                                             "Posted to Doctor" = filter(false),
                                                                             Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(50039; "Doctor Amount Posted"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Visit No" = field("Visit No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            Claimed = filter(true), Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(50040; "Doctor Amount All"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Visit No" = field("Visit No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(50041; "Doctor Amount Posting"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Doctors Amount" where("Patient No." = field("Patient No"),
                                                                            "Doctors Posting No" = field("Posting No"),
                                                                            "Doctor ID" = field("Doctor ID"),
                                                                            "Visit No" = field("Visit No"),
                                                                            Posted = filter(true),
                                                                            Weived = filter(false)));
            FieldClass = FlowField;
        }
        field(50004; "Doctor ID"; Code[20])
        {
            // TableRelation = Vendor."No." where("Vendor Posting Group" = filter('DOCTORS'));
        }
        field(50005; "User ID"; Code[50])
        {
        }
        field(50006; Posted; Boolean)
        {
            Editable = true;
        }
        field(50007; Date; Date)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment Date" where("Appointment No." = field("Visit No"),
                                                                                         "Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50008; "Invoice No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient Charges"."Invoice Number" where("Patient No." = field("Patient No"),
                                                                               "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(50009; "Insurance No"; Code[20])
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Insurance No" where("Appointment No." = field("Visit No")));
            FieldClass = FlowField;
            TableRelation = Customer."No.";
        }
        field(50010; Show; Boolean)
        {
            trigger OnValidate()
            begin
                TestField(Posted, true);
                CheckifPaid("Visit No", "Patient No");
                TestField("Fully Paid", true);
            end;
        }
        field(50011; Names; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50012; "Corp Balance"; Decimal)
        {
        }
        field(50013; "Doctor%"; Decimal)
        {
            CalcFormula = lookup("HMS Setup Doctor"."Commission Perc" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(50014; Completed; Boolean)
        {
        }
        field(50015; "Completion Date"; Date)
        {
        }
        field(50016; "Completion Time"; Time)
        {
        }
        field(50017; "Completed By"; Code[50])
        {
        }
        field(50018; "Batch No"; Code[20])
        {
        }
        field(50038; "Posting No"; Code[20])
        {
        }
        field(50042; "Charge Posting No"; Code[20])
        {
        }
        field(50019; "Ins WHT"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".WHT where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(50020; "Ins HDF"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".HDF where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(50021; "Ins Gross"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Gross Amount" where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(50022; "Ins NET"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Net Amount" where("Ins No" = field("Insurance No")));
            FieldClass = FlowField;
        }
        field(50023; "Total WHT"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".WHT);
            FieldClass = FlowField;
        }
        field(50024; "Total HDF"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp".HDF);
            FieldClass = FlowField;
        }
        field(50025; "Total Gross"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Gross Amount");
            FieldClass = FlowField;
        }
        field(50026; "Total NET"; Decimal)
        {
            CalcFormula = sum("HMS Doctors Payment Temp"."Net Amount");
            FieldClass = FlowField;
        }
        field(50027; Amount; Decimal)
        {
            Description = 'DoctorGross>23999';
        }
        field(50028; Quantity; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Quantity where("Patient No." = field("Patient No"),
                                                                    "Visit No" = field("Visit No"),
                                                                    "Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(50029; "Total Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No"),
                                                                          "Visit No" = field("Visit No"),
                                                                          "Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(50030; "Posted Count"; Integer)
        {
            CalcFormula = count("Vendor Ledger Entry" where("Vendor No." = field("Doctor ID"),
                                                             "Document No." = field("Visit No"),
                                                             "External Document No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50031; "Vendor Exists"; Integer)
        {
            CalcFormula = count(Vendor where("No." = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(50032; "Doctor Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(50033; "Fully Paid"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckifPaid("Visit No", "Patient No");
            end;
        }
        field(50034; "Insurance Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Insurance No")));
            FieldClass = FlowField;
            TableRelation = Customer.Name;
        }
        field(50035; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Patient Type" where("Appointment No." = field("Visit No")));
            FieldClass = FlowField;
            OptionMembers = " ",Corporate,Cash;
        }
        field(50036; "Charge Date"; Date)
        {
            CalcFormula = lookup("HMS Patient Charges".Date where("Patient No." = field("Patient No"), "Visit No" = field("Visit No")));
            FieldClass = FlowField;
        }
        field(50037; "Batch Total Amount"; Decimal)
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
