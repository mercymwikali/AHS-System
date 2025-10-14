Table 52202424 "HR Job Applicants"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "User Name"; Code[50])
        {
        }
        field(2; "First Name"; Text[100])
        {
        }
        field(3; "Middle Name"; Text[50])
        {
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            begin
            end;
        }
        field(5; Initials; Text[30])
        {
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[80])
        {
        }
        field(10; City; Text[30])
        {
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Home Phone Number"; Text[30])
        {
        }
        field(14; "Cell Phone Number"; Text[30])
        {
        }
        field(15; "Work Phone Number"; Text[30])
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
        }
        field(19; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(20; "ID Number"; Text[30])
        {
        }
        field(21; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(22; "Country Code"; Code[30])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                /*Country.RESET;
                Country.SETRANGE(Country.Code,"Country Code");
                IF Country.FIND('-') THEN
                BEGIN
                    Citizenship:=Country.Name;
                END;*/
            end;
        }
        field(23; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(24; Comment; Boolean)
        {
            Editable = false;
        }
        field(25; "Fax Number"; Text[30])
        {
        }
        field(26; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(27; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(28; "First Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(29; "Driving Licence"; Code[10])
        {
        }
        field(30; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(31; "Health Assesment?"; Boolean)
        {
        }
        field(32; "Health Assesment Date"; Date)
        {
        }
        field(33; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            begin
                /*IF "Date Of Birth" >=TODAY THEN BEGIN
                    ERROR('Date of Birth cannot be after %1',TODAY);
                END; */
            end;
        }
        field(34; Age; Text[80])
        {
        }
        field(35; "Second Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(36; "Additional Language"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(37; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(38; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            begin
            end;
        }
        field(40; "Postal Address2"; Text[30])
        {
        }
        field(41; "Postal Address3"; Text[20])
        {
        }
        field(42; "Residential Address2"; Text[30])
        {
        }
        field(43; "Residential Address3"; Text[20])
        {
        }
        field(44; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(45; Citizenship; Text[50])
        {
        }
        field(46; "Disabling Details"; Text[50])
        {
        }
        field(47; "Disability Grade"; Text[30])
        {
        }
        field(48; "Passport Number"; Text[30])
        {
        }
        field(49; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(51; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(52; "First Language Read"; Boolean)
        {
        }
        field(53; "First Language Write"; Boolean)
        {
        }
        field(54; "First Language Speak"; Boolean)
        {
        }
        field(55; "Second Language Read"; Boolean)
        {
        }
        field(56; "Second Language Write"; Boolean)
        {
        }
        field(57; "Second Language Speak"; Boolean)
        {
        }
        field(58; "County Code"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const(County));

            trigger OnValidate()
            begin
                /*HRLookUpValues.RESET;
                HRLookUpValues.SETRANGE(HRLookUpValues.Code,"County Code");
                IF HRLookUpValues.FIND('-') THEN
                 County := HRLookUpValues.Description;*/
            end;
        }
    }

    keys
    {
        key(Key1; "User Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
