Table 52202550 "Casual Employees.Dsl"
{
    DrillDownPageID = "Casual Employees";
    LookupPageID = "Casual Employees";

    fields
    {
        field(1; "Casual No"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Employee.Get("Casual No") then begin
                    "Full  Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Start Date" := Employee."Date Of Join";
                    "D O B" := Employee."Date Of Birth";
                    "ID Number" := Employee."ID Number";
                    "NSSF NO" := Employee."NSSF No.";
                    "NHIF NO" := Employee."NHIF No.";
                    "Bank Account Number" := Employee."Bank Account Number";
                    "Bank Branch Name" := Employee."Branch Bank Name";
                end;
            end;
        }
        field(2; "Full  Name"; Text[100])
        {
        }
        field(3; Gender; Option)
        {
            OptionCaption = ',Male,Female';
            OptionMembers = ,male,Female;
        }
        field(4; "D O B"; Date)
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
        field(5; "ID Number"; Code[20])
        {
            trigger OnValidate()
            begin
                CasualEmployees.Reset();
                CasualEmployees.SetRange(CasualEmployees."ID Number", "ID Number");
                if CasualEmployees.FindFirst() then
                    Error('This ID Number already register under %1', CasualEmployees."Full  Name");
            end;
        }
        field(6; "Revenue Division"; Code[30])
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
        field(7; Department; Code[30])
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
        field(8; "Task  Description"; Text[30])
        {
        }
        field(9; "No of Hours"; Integer)
        {
        }
        field(10; "No of Days"; DateFormula)
        {
            trigger OnValidate()
            begin
                "End Date" := CalcDate("No of Days", "Start Date");
                "No of Days value" := "End Date" - "Start Date";
            end;
        }
        field(11; "Bank Code"; Code[20])
        {
            TableRelation = "Pr Bank Branches"."Bank Code";

            trigger OnValidate()
            begin
                if prBankStructure.Get("Bank Code") then
                    "Bank Name" := prBankStructure."Bank Name";
            end;
        }
        field(12; "Bank Name"; Text[50])
        {
        }
        field(13; "Bank Account Number"; Code[30])
        {
        }
        field(14; "Start Date"; Date)
        {
            trigger OnValidate()
            begin

                "End Date" := CalcDate("No of Days", "Start Date");
                "No of Days value" := "End Date" - "Start Date";
            end;
        }
        field(16; "End Date"; Date)
        {
            Editable = false;
        }
        field(17; "Rate per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Rate Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Rate Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Department Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field(Department)));
            FieldClass = FlowField;
        }
        field(23; "Division Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Revenue Division")));
            FieldClass = FlowField;
        }
        field(24; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(25; "Task Code"; Code[50])
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
        field(26; "Rate Per Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "No of Days value"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "PIN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "NSSF NO"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "NHIF NO"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Bank Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(33; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Casual,Part-Timer';
            OptionMembers = Casual,"Part-Timer";
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
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Casual Nos");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Casual Nos", xRec."No. Series", 0D, "Casual No", "No. Series");
        end;
    end;

    var
        GenLedgerSetup: Record "Cash Office Setup";
        CasualEmployees: Record "Casual Employees";
        CasualTiers: Record "Casual Tiers";
        DimensionValue: Record "Dimension Value";
        Employee: Record "HR-Employee";
        prBankStructure: Record "Pr Bank Branches";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        age: Integer;
}
