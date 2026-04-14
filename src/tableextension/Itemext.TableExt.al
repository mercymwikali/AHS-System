tableextension 85014 "Item_ext" extends Item
{
    DrillDownPageId = "Item List.";
    LookupPageId = "Item List.";

    fields
    {
        modify("Description 2")
        {
            Width = 100;
        }
        field(50102; "Item G/L Budget Account"; Code[20])
        {
            TableRelation = "G/L Account"."No." where("Budget Controlled" = const(true));
        }
        field(50103; Take; decimal)
        {
        }
        field(50104; Route; Option)
        {
            OptionMembers = Oral,IV,Rectal,Vaginal,Subcutaneuos,Nasal,Intrathical,Intradermal,Intramuscular,"I.M",Topical;
        }
        field(50105; Frequency; integer)
        {
        }
        field(50106; Dosage; code[20])
        {
        }
        field(50107; "Number of Days"; Integer)
        {
        }
        field(50108; "NHIF Covered"; Boolean)
        {
        }
        field(50109; "Unit Price Insurance"; Decimal)
        {
        }
        field(50110; "Sales Account"; code[20])
        {
            CalcFormula = lookup("General Posting Setup"."Sales Account" where("Gen. Prod. Posting Group" = field("Gen. Prod. Posting Group")));
            FieldClass = FlowField;
        }
        field(50111; "Description 3"; text[100])
        {
        }
        field(50112; "Minimum Unit Price"; Decimal)
        {
        }
        field(50113; "Maximum Unit Price"; Decimal)
        {
        }
        field(50100; "Generic Name Code"; Code[30])
        {
            TableRelation = "Drug Generic Names"."Generic Code";
        }
        field(50101; "Generic Name"; Text[250])
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