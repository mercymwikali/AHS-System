Table 85322 "Lab Notes"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50001; "Laboratory No."; Code[20])
        {
            NotBlank = true;
        }
        field(50002; "Laboratory Test Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;

            trigger OnValidate()
            begin
                //hmsHospital.InsertPatientLabCharges("Laboratory No.","Laboratory Test Code");
            end;
        }
        field(50003; "Laboratory Test Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(50004; "Specimen Code"; Code[20])
        {
            TableRelation = "HMS Setup Specimen".Code;

            trigger OnValidate()
            begin
                // LabParam.SETRANGE(LabParam."Laboratory Test Code","Laboratory Test Code");
                // LabParam.SETRANGE(LabParam."Specimen Code" ,"Specimen Code");
                // IF LabParam.FIND('-') THEN BEGIN
                //  "Sort Test" :=LabParam.Arrangement;
                //  END;
            end;
        }
        field(50005; Remarks; Text[250])
        {
            trigger OnValidate()
            begin
                // LabParam.SETRANGE(LabParam."Laboratory Test Code","Laboratory Test Code");
                // LabParam.SETRANGE(LabParam."Specimen Code" ,"Specimen Code");
                // IF LabParam.FIND('-') THEN BEGIN
                //  "Sort Test" :=LabParam.Arrangement;
                //  END;
            end;
        }
        field(50006; "Modification Comments"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Unique Lab ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
