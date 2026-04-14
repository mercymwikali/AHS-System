Table 85103 "Funds Management Cue"
{
    Caption = 'Finance Cue';

    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(50001; "Interbank Pending Approval"; Integer)
        {
            CalcFormula = count("InterBank Transfers" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(50002; "Interbank Not Posted"; Integer)
        {
            CalcFormula = count("InterBank Transfers" where(Status = filter(Approved),
                                                             Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(50003; "PV Pending Approval"; Integer)
        {
            CalcFormula = count("Payments Header" where("Payment Type" = filter(Normal),
                                                         Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(50004; "PV Not Posted"; Integer)
        {
            CalcFormula = count("Payments Header" where("Payment Type" = filter(Normal),
                                                         Status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(50005; "PCV Pending Approval"; Integer)
        {
            CalcFormula = count("Payments Header" where("Payment Type" = filter("Petty Cash"),
                                                         Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(50006; "PCV Not Posted"; Integer)
        {
            CalcFormula = count("Payments Header" where("Payment Type" = filter("Petty Cash"),
                                                         Status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(50007; "Staff Travel Pending Approval"; Integer)
        {
            CalcFormula = count("Imprest Header" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(50008; "Staff Travel Not Posted"; Integer)
        {
            CalcFormula = count("Imprest Header" where(Status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(50009; "Staff TA Pending Approval"; Integer)
        {
            CalcFormula = count("Imprest Surrender Header" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(50010; "Staff TA Not Posted"; Integer)
        {
            CalcFormula = count("Imprest Surrender Header" where(Status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(50011; "Other Advance Pending Approval"; Integer)
        {
        }
        field(50012; "Other Advance Not Posted"; Integer)
        {
        }
        field(50013; "Staff Claim Pending Approval"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(50014; "Staff Claim Not Posted"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(50015; "Requisitions Pending Approval"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Quote),
                                                         DocApprovalType = filter(Requisition),
                                                         Status = filter('Pending Approval')));
            FieldClass = FlowField;
        }
        field(50016; "Requisitions Not Posted"; Integer)
        {
        }
        field(50017; "Store Req. Pending Approval"; Integer)
        {
            CalcFormula = count("Store Requistion Header" where(Status = filter(Released)));
            FieldClass = FlowField;
        }
        field(50018; "Store Req. Not Posted"; Integer)
        {
            CalcFormula = count("Store Requistion Header" where(Status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(50019; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50020; "Overdue Date Filter"; Date)
        {
            Caption = 'Overdue Date Filter';
            FieldClass = FlowFilter;
        }
        field(50021; "Approval Entries"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
