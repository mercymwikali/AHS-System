Table 85425 "HR Medical Schemes"
{
    // DrillDownPageID = UnknownPage70135037;
    //  LookupPageID = UnknownPage70135037;

    fields
    {
        field(50000; "Scheme No"; Code[10])
        {
        }
        field(50001; "Medical Insurer"; Code[10])
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
        field(50002; "Scheme Name"; Text[250])
        {
        }
        field(50003; "In-patient limit"; Decimal)
        {
        }
        field(50004; "Out-patient limit"; Decimal)
        {
        }
        field(50005; "Area Covered"; Text[30])
        {
        }
        field(50006; "Dependants Included"; Boolean)
        {
        }
        field(50007; Comments; Text[100])
        {
        }
        field(50008; "Insurer Name"; Text[250])
        {
        }
        field(50009; "Scheme Type"; Option)
        {
            OptionCaption = 'Both,Inpatient,Outpatient';
            OptionMembers = Both,Inpatient,Outpatient;
        }
        field(50010; "Maximum No of Dependants"; Integer)
        {
        }
        field(50011; "Start Date"; Date)
        {
        }
        field(50012; "End Date"; Date)
        {
        }
        field(50013; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Renewed,Closed';
            OptionMembers = Open,Renewed,Closed;
        }
        field(50014; "Scheme Members"; Integer)
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
        field(50015; Period; Code[20])
        {
            // TableRelation = "HR Calendar".Year;
        }
        field(50016; Currency; Code[10])
        {
            TableRelation = Currency;
        }
        field(50017; "No. Series"; Code[20])
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
