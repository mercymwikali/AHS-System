Table 85089 "CshMgt PV Steps Users"
{
    //  DrillDownPageID = UnknownPage70135123;
    // LookupPageID = UnknownPage70135123;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            Description = 'Stores the code reference to the step in the database';
            TableRelation = "CshMgt PV Steps".Code;
        }
        field(50001; Description; Text[30])
        {
            Description = 'Stores the description of teh step in the database';
        }
        field(50002; UserID; Code[20])
        {
            trigger OnLookup()
            begin
                // LoginMgt.LookupUserID(UserID);

                Validate(UserID);
            end;

            trigger OnValidate()
            begin
                //  LoginMgt.ValidateUserID(UserID);
                User.Reset();
                User.Get(Rec.UserID);
                Rec."User name" := User."User Name";
            end;
        }
        field(50003; "User name"; Text[30])
        {
        }
        field(50004; Email; Text[30])
        {
        }
        field(50005; "Email Alert ?"; Boolean)
        {
        }
        field(50006; "No."; Boolean)
        {
        }
        field(50007; Date; Boolean)
        {
        }
        field(50008; "Global Dimension 1 Code"; Boolean)
        {
            CaptionClass = '1,2,1';
        }
        field(50009; "Global Dimension 2 Code"; Boolean)
        {
            CaptionClass = '1,2,2';
        }
        field(50010; "Paying Bank Account"; Boolean)
        {
        }
        field(50011; "Payment To"; Boolean)
        {
        }
        field(50012; "On Behalf Of"; Boolean)
        {
        }
        field(50013; PVLines; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code", UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        User: Record User;
}
