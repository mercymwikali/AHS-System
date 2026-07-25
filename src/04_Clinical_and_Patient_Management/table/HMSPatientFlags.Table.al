Table 85212 "HMS Patient Flags"
{
    //  DrillDownPageID = "HMS Setup Measuring Unit List";
    // LookupPageID = "HMS Setup Measuring Unit List";

    fields
    {
        field(50000; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50001; "Code"; Code[50])
        {
            Editable = true;
            TableRelation = "HMS Setup Flags".Code;

            trigger OnValidate()
            begin
                flags.Reset();
                flags.SetRange(flags.Code, Code);
                if flags.Find('-') then
                    Description := flags.Description;
            end;
        }
        field(50002; Type; Option)
        {
            OptionCaption = ' ,Allergy,Chronic Illness';
            OptionMembers = " ",Allergy,"Chronic Illness";
        }
        field(50003; Description; Text[250])
        {
        }
        field(50004; Remarks; Text[250])
        {
        }
        field(50005; Date; Date)
        {
            NotBlank = true;
        }
        field(50006; "User ID"; Code[20])
        {
        }
        field(50007; "Creation Time"; Time)
        {
        }
        field(50008; "Creation Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Patient No.", "Code", Type, Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        UserRec.Reset();
        UserRec.SetRange(UserRec."User ID", UserId);
        if UserRec.Find('-') then begin
            if UserRec."Can Edit Charges" = false then
                Error('Please note that you dont have the rights to edit the flags')
        end else
            Error('Please note that you dont have the rights to edit the flags');
    end;

    trigger OnInsert()
    begin
        "User ID" := UserId;
        "Creation Time" := Time;
        "Creation Date" := Today;
    end;

    var
        flags: Record "HMS Setup Flags";
        UserRec: Record "User Setup";
}
