Table 85476 "Casual Employees"
{
    DrillDownPageID = "Casual Employees";
    LookupPageID = "Casual Employees";

    fields
    {
        field(50000; "Casual No"; Code[30])
        {
            // Editable = true;
        }
        field(50001; "Full  Name"; Text[100])
        {
        }
        field(50002; Gender; Option)
        {
            OptionCaption = ',Male,Female';
            OptionMembers = ,male,Female;
        }
        field(50003; "D O B"; Date)
        {
            trigger OnValidate()
            begin
                age := Date2dmy(Today, 3) - Date2dmy("D O B", 3);
                if age < 18 then
                    Error('This employee is under age by %1', (18 - age))
                else
                    if age > 65 then
                        Error('This employee is over age by %1', (65 - age));
            end;
        }
        field(50004; "ID Number"; Code[20])
        {
            trigger OnValidate()
            begin
                CasualEmployees.Reset();
                CasualEmployees.SetRange(CasualEmployees."ID Number", "ID Number");
                if CasualEmployees.FindFirst() then
                    //ERROR('This ID Number already register under %1',CasualEmployees."Full  Name");
                    ///*******************Populate Information*******************
                    if Type = Type::Casual then begin
                        Employee.Reset();
                        Employee.SetRange(Employee."ID Number", "ID Number");
                        if Employee.Find('-') then begin
                            "Full  Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            "Start Date" := Employee."Date Of Join";
                            "D O B" := Employee."Date Of Birth";
                            "NSSF NO" := Employee."NSSF No.";
                            "NHIF NO" := Employee."NHIF No.";
                            "Bank Account Number" := Employee."Bank Account Number";
                            "Bank Branch Name" := Employee."Branch Bank Name";
                            "PIN No" := Employee."PIN Number";
                            "Bank Code" := Employee."Main Bank";
                            "Employee Code" := Employee."No.";
                        end
                    end else
                        if Type = Type::"Part-Timer" then begin
                            HREmployeeC.Reset();
                            HREmployeeC.SetRange(HREmployeeC."ID Number", "ID Number");
                            if HREmployeeC.Find('-') then begin
                                "Full  Name" := HREmployeeC."First Name" + ' ' + HREmployeeC."Middle Name" + ' ' + HREmployeeC."Last Name";
                                "Start Date" := HREmployeeC."Date Of Join";
                                "D O B" := HREmployeeC."Date Of Birth";
                                "NSSF NO" := HREmployeeC."NSSF No.";
                                "NHIF NO" := HREmployeeC."NHIF No.";
                                "Bank Account Number" := HREmployeeC."Bank Account Number";
                                "Bank Branch Name" := HREmployeeC."Branch Bank Name";
                                "PIN No" := HREmployeeC."PIN Number";
                                "Bank Code" := HREmployeeC."Branch Bank";
                                "Employee Code" := HREmployeeC."No.";
                            end
                        end;
            end;
        }
        field(50005; "Revenue Division"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange(DimensionValue.Code, 'CAMPUS');
                DimensionValue.SetRange(DimensionValue."Dimension Code", "Revenue Division");
                if DimensionValue.FindFirst() then
                    "Division Name" := DimensionValue.Name;
            end;
        }
        field(50006; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange(DimensionValue.Code, 'DEPARTMENT');
                DimensionValue.SetRange(DimensionValue."Dimension Code", Department);
                if DimensionValue.FindFirst() then
                    "Department Name" := DimensionValue.Name;
            end;
        }
        field(50007; "Task  Description"; Text[30])
        {
        }
        field(50008; "No of Hours"; Integer)
        {
        }
        field(50009; "No of Days"; DateFormula)
        {
            trigger OnValidate()
            begin
                "End Date" := CalcDate("No of Days", "Start Date");
                "No of Days value" := "End Date" - "Start Date";
            end;
        }
        field(50010; "Bank Code"; Code[20])
        {
            TableRelation = "Pr Bank Branches"."Bank Code";

            trigger OnValidate()
            begin
                if prBankStructure.Get("Bank Code") then
                    "Bank Name" := prBankStructure."Bank Name";
            end;
        }
        field(50011; "Bank Name"; Text[50])
        {
        }
        field(50012; "Bank Account Number"; Code[30])
        {
        }
        field(50013; "Start Date"; Date)
        {
            trigger OnValidate()
            begin

                "End Date" := CalcDate("No of Days", "Start Date");
                "No of Days value" := "End Date" - "Start Date";
            end;
        }
        field(50014; "End Date"; Date)
        {
            Editable = false;
        }
        field(50015; "Rate per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Rate Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Rate Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Department Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field(Department)));
            FieldClass = FlowField;
        }
        field(50021; "Division Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Revenue Division")));
            FieldClass = FlowField;
        }
        field(50022; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50023; "Task Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Casual Tiers"."Occupation Code";

            trigger OnValidate()
            begin
                CasualTiers.Reset();
                CasualTiers.SetRange(CasualTiers."Occupation Code", "Task Code");
                if CasualTiers.Find('-') then begin
                    "Task  Description" := CasualTiers."Occupation Description";
                    "Rate per Day" := CasualTiers."Rate per Day";
                    "Rate Per Month" := CasualTiers."Rate Per Month";
                end;
            end;
        }
        field(50024; "Rate Per Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "No of Days value"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "PIN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "NSSF NO"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "NHIF NO"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Bank Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50031; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Casual,Part-Timer';
            OptionMembers = Casual,"Part-Timer";
        }
        field(50032; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR-Employee"."No.";
        }
        field(50033; Email; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Casual No", "ID Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Casual No" = '' then begin
            Choice := StrMenu('Casual,PartTimer', 1, 'Select Employee Type');
            if Choice = 1 then
                Type := Type::Casual;
            if Choice = 2 then
                Type := Type::"Part-Timer";
            if Type = Type::Casual then begin
                GenLedgerSetup.Get();
                GenLedgerSetup.TestField(GenLedgerSetup."Casual Nos");
                NoSeriesMgt.GetNextNo(GenLedgerSetup."Casual Nos");
            end else
                if Type = Type::"Part-Timer" then begin
                    GenLedgerSetup.Get();
                    GenLedgerSetup.TestField(GenLedgerSetup."Parttimers Nos");
                    NoSeriesMgt.GetNextNo(GenLedgerSetup."Parttimers Nos");
                end;
        end;
    end;

    var
        GenLedgerSetup: Record "Cash Office Setup";
        CasualEmployees: Record "Casual Employees";
        CasualTiers: Record "Casual Tiers";
        DimensionValue: Record "Dimension Value";
        Employee: Record "HR-Employee";
        HREmployeeC: Record "HR-Employee";
        prBankStructure: Record "Pr Bank Branches";
        NoSeriesMgt: Codeunit "No. Series";
        age: Integer;
        Choice: Integer;
}
