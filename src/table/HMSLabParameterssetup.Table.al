Table 85315 "HMS Lab Parameters setup"
{
    DrillDownPageID = "HMS Lab Parameters Setup List";
    LookupPageID = "HMS Lab Parameters Setup List";

    fields
    {
        field(50000; "Laboratory Test Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;

            trigger OnValidate()
            begin
                LabTest.Get("Laboratory Test Code");
                "Laboratory Test Name" := LabTest.Description;
            end;
        }
        field(50001; "Laboratory Test Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(50002; "Specimen Code"; Code[20])
        {
            TableRelation = "HMS Setup Specimen".Code;

            trigger OnValidate()
            begin
                if HmsSpecimen.Get("Specimen Code") then begin
                    "Specimen Name" := HmsSpecimen.Description;
                    "Measuring Unit Code" := HmsSpecimen.Units;
                    "Measuring Unit Name" := HmsSpecimen.Units;
                    "Test Normal Ranges" := Format(HmsSpecimen."Min Range") + ' - ' + Format(HmsSpecimen."Max Range");
                    "Test Normal Ranges2" := Format(HmsSpecimen."Min Range") + ' - ' + Format(HmsSpecimen."Max Range");
                    "Min Range" := HmsSpecimen."Min Range";
                    "Max Range" := HmsSpecimen."Max Range";
                end;
            end;
        }
        field(50003; "Specimen Name"; Text[100])
        {
            FieldClass = Normal;
        }
        field(50004; "Measuring Unit Code"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50005; "Measuring Unit Name"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50006; "Test Normal Ranges"; Text[100])
        {
            FieldClass = Normal;
        }
        field(50007; "Min Range"; Decimal)
        {            
        }
        field(50008; "Max Range"; Decimal)
        {           

            trigger OnValidate()
            begin
                "Test Normal Ranges" := Format("Min Range") + ' - ' + Format("Max Range");
                "Test Normal Ranges2" := Format("Min Range") + ' - ' + Format("Max Range");
            end;
        }
        field(50009; "Test Normal Ranges2"; Text[100])
        {
            FieldClass = Normal;
        }
        field(50010; Arrangement; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50012; "Critical Value Low"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Critical Value High"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Critical Ranges"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Category; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Min 0 Years-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Max 0 Years-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Min 6 Years - 18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Max 6 Years - 18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Min Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Max Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Min Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Max Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Min 6 Years - 18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Max 6 Years - 18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "C LOW 0-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "C HIGH 0-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "C LOW 6-18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "C HIGH 6-18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "C LOW 6-18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "C HIGH 6-18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "C LOW Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "C HIGH Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "C LOW Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "C HIGH Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Measuring unit 2"; Code[20])
        {            
        }
        field(50037; "Result Type"; Enum "Lab Result Types")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Specimen"."Result Type" where(Code = field("Specimen Code")));
        }
    }

    keys
    {
        key(Key1; "Laboratory Test Code", "Specimen Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LabTest: Record "HMS Setup Lab Test";
        HmsSpecimen: Record "HMS Setup Specimen";
}
