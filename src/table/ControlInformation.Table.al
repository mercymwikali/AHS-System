Table 85483 "Control-Information"
{
    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
        }
        field(50001; Name; Text[50])
        {
        }
        field(50002; "Name 2"; Text[50])
        {
        }
        field(50003; Address; Text[50])
        {
        }
        field(50004; "Address 2"; Text[50])
        {
        }
        field(50005; City; Text[50])
        {
        }
        field(50006; "Phone No."; Text[150])
        {
        }
        field(50007; "Phone No. 2"; Text[20])
        {
        }
        field(50008; "Telex No."; Text[20])
        {
        }
        field(50009; "Fax No."; Text[20])
        {
        }
        field(50010; "Giro No."; Text[20])
        {
        }
        field(50011; "Bank Name"; Text[30])
        {
        }
        field(50012; "Bank Branch No."; Text[20])
        {
        }
        field(50013; "Bank Account No."; Text[20])
        {
        }
        field(50014; "Payment Routing No."; Text[20])
        {
        }
        field(50015; "Customs Permit No."; Text[10])
        {
        }
        field(50016; "Customs Permit Date"; Date)
        {
        }
        field(50017; "VAT Registration No."; Text[20])
        {
        }
        field(50018; "Registration No."; Text[20])
        {
        }
        field(50019; "Telex Answer Back"; Text[20])
        {
        }
        field(50020; "Ship-to Name"; Text[30])
        {
        }
        field(50021; "Ship-to Name 2"; Text[30])
        {
        }
        field(50022; "Ship-to Address"; Text[30])
        {
        }
        field(50023; "Ship-to Address 2"; Text[30])
        {
        }
        field(50024; "Ship-to City"; Text[30])
        {
        }
        field(50025; "Ship-to Contact"; Text[30])
        {
        }
        field(50026; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(50027; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(50028; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code") then
                    City := PostCode.City;
            end;
        }
        field(50029; County; Text[30])
        {
        }
        field(50030; "Ship-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Ship-to Post Code") then
                    "Ship-to City" := PostCode.City;
            end;
        }
        field(50031; "Ship-to County"; Text[30])
        {
        }
        field(50032; "E-Mail"; Text[80])
        {
        }
        field(50033; "Home Page"; Text[80])
        {
        }
        field(50034; "Company P.I.N"; Code[30])
        {
        }
        field(50035; "N.S.S.F No."; Code[30])
        {
        }
        field(50036; "Company code"; Code[10])
        {
        }
        field(50037; "Working Days Per Year"; Integer)
        {
        }
        field(50038; "Working Hours Per Week"; Integer)
        {
        }
        field(50039; "Working Hours Per Day"; Integer)
        {
        }
        field(50040; Mission; Text[250])
        {
        }
        field(50041; "Mission/Vision Link"; Text[50])
        {
        }
        field(50042; Vision; Text[250])
        {
        }
        field(50043; "N.H.I.F No"; Text[100])
        {
        }
        field(50044; "Payslip Message"; Text[250])
        {
            Description = 'Dennis Added';
        }
        field(50045; "Multiple Payroll"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
}
