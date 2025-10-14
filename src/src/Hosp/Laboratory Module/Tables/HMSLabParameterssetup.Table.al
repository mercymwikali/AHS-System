Table 52202687 "HMS Lab Parameters setup"
{
    DrillDownPageID = "HMS Lab Parameters Setup List";
    LookupPageID = "HMS Lab Parameters Setup List";

    fields
    {
        field(1; "Laboratory Test Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;

            trigger OnValidate()
            begin
                LabTest.Get("Laboratory Test Code");
                "Laboratory Test Name" := LabTest.Description;
            end;
        }
        field(2; "Laboratory Test Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(3; "Specimen Code"; Code[20])
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
        field(4; "Specimen Name"; Text[100])
        {
            FieldClass = Normal;
        }
        field(5; "Measuring Unit Code"; Text[30])
        {
            FieldClass = Normal;
        }
        field(6; "Measuring Unit Name"; Text[30])
        {
            FieldClass = Normal;
        }
        field(7; "Test Normal Ranges"; Text[100])
        {
            FieldClass = Normal;
        }
        field(8; "Min Range"; Decimal)
        {            
        }
        field(9; "Max Range"; Decimal)
        {           

            trigger OnValidate()
            begin
                "Test Normal Ranges" := Format("Min Range") + ' - ' + Format("Max Range");
                "Test Normal Ranges2" := Format("Min Range") + ' - ' + Format("Max Range");
            end;
        }
        field(10; "Test Normal Ranges2"; Text[100])
        {
            FieldClass = Normal;
        }
        field(11; Arrangement; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Critical Value Low"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Critical Value High"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Critical Ranges"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Category; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Min 0 Years-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Max 0 Years-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Min 6 Years - 18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Max 6 Years - 18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Min Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Max Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Min Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Max Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Min 6 Years - 18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Max 6 Years - 18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "C LOW 0-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "C HIGH 0-5 Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "C LOW 6-18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "C HIGH 6-18 Years Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "C LOW 6-18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "C HIGH 6-18 Years Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "C LOW Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "C HIGH Adult Female"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "C LOW Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "C HIGH Adult Male"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Measuring unit 2"; Code[20])
        {            
        }
        field(38; "Result Type"; Enum "Lab Result Types")
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
