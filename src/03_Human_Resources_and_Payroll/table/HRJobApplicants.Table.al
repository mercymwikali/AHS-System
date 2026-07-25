Table 85292 "HR Job Applicants"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "User Name"; Code[50])
        {
        }
        field(50001; "First Name"; Text[100])
        {
        }
        field(50002; "Middle Name"; Text[50])
        {
        }
        field(50003; "Last Name"; Text[50])
        {

            trigger OnValidate()
            begin
            end;
        }
        field(50004; Initials; Text[30])
        {
        }
        field(50005; "Search Name"; Code[50])
        {
        }
        field(50006; "Postal Address"; Text[80])
        {
        }
        field(50007; "Residential Address"; Text[80])
        {
        }
        field(50008; City; Text[30])
        {
        }
        field(50009; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50010; County; Text[30])
        {
        }
        field(50011; "Home Phone Number"; Text[30])
        {
        }
        field(50012; "Cell Phone Number"; Text[30])
        {
        }
        field(50013; "Work Phone Number"; Text[30])
        {
        }
        field(50014; "Ext."; Text[7])
        {
        }
        field(50015; "E-Mail"; Text[80])
        {
        }
        field(50016; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(50017; "ID Number"; Text[30])
        {
        }
        field(50018; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(50019; "Country Code"; Code[30])
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
        field(50020; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(50021; Comment; Boolean)
        {
            Editable = false;
        }
        field(50022; "Fax Number"; Text[30])
        {
        }
        field(50023; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50024; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(50025; "First Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(50026; "Driving Licence"; Code[10])
        {
        }
        field(50027; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(50028; "Health Assesment?"; Boolean)
        {
        }
        field(50029; "Health Assesment Date"; Date)
        {
        }
        field(50030; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            begin
                /*IF "Date Of Birth" >=TODAY THEN BEGIN
                    ERROR('Date of Birth cannot be after %1',TODAY);
                END; */
            end;
        }
        field(50031; Age; Text[80])
        {
        }
        field(50032; "Second Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(50033; "Additional Language"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(50034; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50035; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(50036; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            begin
            end;
        }
        field(50037; "Postal Address2"; Text[30])
        {
        }
        field(50038; "Postal Address3"; Text[20])
        {
        }
        field(50039; "Residential Address2"; Text[30])
        {
        }
        field(50040; "Residential Address3"; Text[20])
        {
        }
        field(50041; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(50042; Citizenship; Text[50])
        {
        }
        field(50043; "Disabling Details"; Text[50])
        {
        }
        field(50044; "Disability Grade"; Text[30])
        {
        }
        field(50045; "Passport Number"; Text[30])
        {
        }
        field(50046; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50047; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50048; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50049; "First Language Read"; Boolean)
        {
        }
        field(50050; "First Language Write"; Boolean)
        {
        }
        field(50051; "First Language Speak"; Boolean)
        {
        }
        field(50052; "Second Language Read"; Boolean)
        {
        }
        field(50053; "Second Language Write"; Boolean)
        {
        }
        field(50054; "Second Language Speak"; Boolean)
        {
        }
        field(50055; "County Code"; Code[20])
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
