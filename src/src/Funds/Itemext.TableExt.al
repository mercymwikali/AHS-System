tableextension 52202437 "Item_ext" extends Item
{
    DrillDownPageId = "Item List.";
    LookupPageId = "Item List.";

    fields
    {
        modify("Description 2")
        {
            Width = 100;
        }
        field(70134680; "Item G/L Budget Account"; Code[20])
        {
            TableRelation = "G/L Account"."No." where("Budget Controlled" = const(true));
        }
        field(70134681; Take; decimal)
        {
        }
        field(70134682; Route; Option)
        {
            OptionMembers = Oral,IV,Rectal,Vaginal,Subcutaneuos,Nasal,Intrathical,Intradermal,Intramuscular,"I.M",Topical;
        }
        field(70134683; Frequency; integer)
        {
        }
        field(70134684; Dosage; code[20])
        {
        }
        field(70134685; "Number of Days"; Integer)
        {
        }
        field(70134686; "NHIF Covered"; Boolean)
        {
        }
        field(70134687; "Unit Price Insurance"; Decimal)
        {
        }
        field(70134688; "Sales Account"; code[20])
        {
            CalcFormula = lookup("General Posting Setup"."Sales Account" where("Gen. Prod. Posting Group" = field("Gen. Prod. Posting Group")));
            FieldClass = FlowField;
        }
        field(70134689; "Description 3"; text[100])
        {
        }
        field(70134690; "Minimum Unit Price"; Decimal)
        {
        }
        field(70134691; "Maximum Unit Price"; Decimal)
        {
        }
        field(52202423; "Generic Name Code"; Code[30])
        {
            TableRelation = "Drug Generic Names"."Generic Code";
        }
        field(52202424; "Generic Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Drug Generic Names"."Generic Name" where("Generic Code" = field("Generic Name Code")));
        }
        
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.get(Database.UserId) then begin
            if UserSetup."Can Create Items" = false then
                error('Please note that you dont have the rights to create items');
        end else
            error('Please note that you dont have the rights to create items');
    end;
}