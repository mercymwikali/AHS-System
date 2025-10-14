table 52202983 "Drug Generic Names"
{
    Caption = 'Drug Generic Names';
    DataClassification = ToBeClassified;
    LookupPageId = "Drug Generic Names Setup";

    fields
    {
        field(1; "Generic Code"; Code[30])
        {

        }
        field(2; "Generic Name"; Text[250])
        {
            Caption = 'Generic Name';
        }
        field(3; "No. of Drugs"; Integer)
        {
            Caption = 'No. of Drugs';
            FieldClass = FlowField;
            CalcFormula = count(Item where("Generic Name" = field("Generic Name")));
        }
    }
    keys
    {
        key(PK; "Generic Code")
        {
            Clustered = true;
        }
                
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Generic Code")
        {
             
        }
    }
    trigger OnInsert()
    var
    GenericNames: Record "Drug Generic Names";
    begin
        if "Generic Code" = '' then begin
            GenericNames.Reset();
            if GenericNames.FindLast() then 
                "Generic Code" := IncStr(GenericNames."Generic Code")
                else    
                "Generic Code" := 'GEN00001';
        end;
    end;
}
