Table 85098 "FLT-Safari Notice"
{
    fields
    {
        field(50000; "Safari No."; Code[10])
        {
        }
        field(50001; "Proposed By"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                hrman2.Reset();
                hrman2.SetRange(hrman2."No.", "Proposed By");
                if hrman2.Find('-') then
                    "Proposer Name" := hrman2."First Name" + ' ' + hrman2."Middle Name" + ' ' + hrman2."Last Name";
            end;
        }
        field(50002; "Proposer Name"; Text[50])
        {
        }
        field(50003; "Proposer Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(50004; "Proposed Date"; Date)
        {
        }
        field(50005; "Officer Going"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                hrman.Reset();
                hrman.SetRange(hrman."No.", "Officer Going");
                if hrman.Find('-') then begin
                    "Officer Designation" := hrman.Initials;
                    "Officer Going Name" := hrman."First Name" + ' ' + hrman."Middle Name" + ' ' + hrman."Last Name";
                    "Officer Going PIF No" := hrman."No.";
                end;
                usersetup.Reset();
                usersetup.SetRange(usersetup."Employee No.", "Officer Going");
                if usersetup.Find('-') then
                    "Officer On Safari ID" := usersetup."User ID"
                else
                    Error('The officer ' + hrman."First Name" + ' ' + hrman."Middle Name" + ' ' + hrman."Last Name"
           + ' has not been setup as a system user.Consult the system Administrator.');
                Modify();
            end;
        }
        field(50006; "Officer Going Name"; Text[50])
        {
        }
        field(50007; "Officer Designation"; Code[20])
        {
        }
        field(50008; "Purpose Of Visit"; Text[250])
        {
        }
        field(50009; "Place to Visit"; Text[50])
        {
        }
        field(50010; "Departure Date"; Date)
        {
        }
        field(50011; "Return Date"; Date)
        {
        }
        field(50012; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Submitted;
        }
        field(50013; "Departure Mileage"; Decimal)
        {
        }
        field(50014; "Reg. No"; Text[30])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(50015; Make; Text[30])
        {
        }
        field(50016; Type; Text[30])
        {
        }
        field(50017; "Estimated Cost of Safari"; Decimal)
        {
        }
        field(50018; Dept; Code[10])
        {
        }
        field(50019; "T.O. Name"; Text[30])
        {
        }
        field(50020; "T.O. Approval Date"; Date)
        {
        }
        field(50021; "HRM Name"; Text[30])
        {
        }
        field(50022; "HRM Approval Date"; Date)
        {
        }
        field(50023; "Finance Officer Name"; Text[30])
        {
        }
        field(50024; "Finance Officer Approval Date"; Date)
        {
        }
        field(50025; "Director Name"; Text[30])
        {
        }
        field(50026; "Director Approval Date"; Date)
        {
        }
        field(50027; "Dep. Director"; Text[150])
        {
        }
        field(50028; "Dep. Director Approval Date"; Date)
        {
        }
        field(50029; "No. Series"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50030; "Finance Funds Availability"; Text[250])
        {
        }
        field(50031; "User Id"; Code[20])
        {
        }
        field(50032; "TO ID"; Code[20])
        {
        }
        field(50033; "Department Name"; Text[100])
        {
        }
        field(50034; "Officer On Safari ID"; Code[20])
        {
        }
        field(50035; "Officer Going PIF No"; Code[20])
        {
        }
        field(50036; "HRM ID"; Code[20])
        {
        }
        field(50037; "FO ID"; Code[20])
        {
        }
        field(50038; "Director ID"; Code[20])
        {
        }
        field(50039; Makes; Code[10])
        {
            CalcFormula = lookup("FLT-Vehicle Header".Make where("Registration No." = field("Reg. No")));
            FieldClass = FlowField;
            TableRelation = "Flt Make".Code;
        }
        field(50040; Model; Code[10])
        {
            CalcFormula = lookup("FLT-Vehicle Header".Model where("Registration No." = field("Reg. No")));
            FieldClass = FlowField;
            TableRelation = "FLT-Flt Model".Code;
        }
        field(50041; "Dep. Director ID"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Safari No.", "Reg. No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Safari No." = '' then begin
            NoSeries.Get();
            NoSeries.TestField(NoSeries."Safari Notice No.");
            NoSeriesMgt.GetNextNo(NoSeries."Safari Notice No.");
        end;
        "User Id" := UserId;
    end;

    var
        NoSeries: Record "FLT-Fleet Mgt Setup";
        hrman: Record "HR-Employee";
        hrman2: Record "HR-Employee";
        usersetup: Record "User Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
