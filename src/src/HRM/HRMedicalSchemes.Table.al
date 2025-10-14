Table 52202753 "HR Medical Schemes"
{
    // DrillDownPageID = UnknownPage70135037;
    //  LookupPageID = UnknownPage70135037;

    fields
    {
        field(1; "Scheme No"; Code[10])
        {
        }
        field(2; "Medical Insurer"; Code[10])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin

                Insurer.Reset();
                Insurer.SetRange(Insurer."No.", "Medical Insurer");
                if Insurer.Find('-') then
                    "Insurer Name" := Insurer.Name;
            end;
        }
        field(3; "Scheme Name"; Text[250])
        {
        }
        field(4; "In-patient limit"; Decimal)
        {
        }
        field(5; "Out-patient limit"; Decimal)
        {
        }
        field(6; "Area Covered"; Text[30])
        {
        }
        field(7; "Dependants Included"; Boolean)
        {
        }
        field(8; Comments; Text[100])
        {
        }
        field(9; "Insurer Name"; Text[250])
        {
        }
        field(10; "Scheme Type"; Option)
        {
            OptionCaption = 'Both,Inpatient,Outpatient';
            OptionMembers = Both,Inpatient,Outpatient;
        }
        field(11; "Maximum No of Dependants"; Integer)
        {
        }
        field(12; "Start Date"; Date)
        {
        }
        field(13; "End Date"; Date)
        {
        }
        field(14; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Renewed,Closed';
            OptionMembers = Open,Renewed,Closed;
        }
        field(15; "Scheme Members"; Integer)
        {
            CalcFormula = count("HR Medical Scheme Members" where("Scheme No" = field("Scheme No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*IF "Scheme Members" > "Maximum No of Dependants" THEN
                BEGIN
                    ERROR('Nominated memebrs cannot exceed the required number');
                END;

                IF "Required Positions" <= 0 THEN
                BEGIN
                    ERROR('Required positions cannot be Less Than or Equal to Zero');
                END;
                */
            end;
        }
        field(16; Period; Code[20])
        {
            // TableRelation = "HR Calendar".Year;
        }
        field(17; Currency; Code[10])
        {
            TableRelation = Currency;
        }
        field(18; "No. Series"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Scheme No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Scheme No", "Scheme Name", "Scheme Type")
        {
        }
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Scheme No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Medical Scheme Nos");
            NoSeriesMgt.InitSeries(HRSetup."Medical Scheme Nos", xRec."No. Series", 0D, "Scheme No", "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        Insurer: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
