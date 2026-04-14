Table 85359 "Applicant Register"
{
    fields
    {
        field(50000; No; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; UserName; Text[100])
        {
        }
        field(50002; Password; Text[30])
        {
        }
        field(50003; EmailAddress; Text[30])
        {
        }
        field(50004; Verified; Boolean)
        {
        }
        field(50005; MyRecId; RecordID)
        {
        }
        field(50006; "First Name"; Text[100])
        {
        }
        field(50007; "Middle Name"; Text[100])
        {
        }
        field(50008; "Last Name"; Text[100])
        {
        }
        field(50009; "ID Number"; Code[50])
        {
        }
        field(50010; "Passport Number"; Code[50])
        {
        }
        field(50011; "Activation Code"; Code[50])
        {
        }
        field(50012; "Postal Address"; Code[30])
        {
        }
        field(50013; "Cell Phone Number"; Code[30])
        {
        }
        field(50014; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er)';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)";
        }
        field(50015; "Date of Birth"; Date)
        {
        }
        field(50016; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50017; RememberMe; Boolean)
        {
        }
        field(50018; "Activate Account"; Boolean)
        {
        }
        field(50019; "Random User Number"; Code[50])
        {
        }
        field(50020; "Random Value"; Text[200])
        {
        }
        field(50021; Disability; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Citizenship; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; Ethnicity; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Title; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Postal Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; Town; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; County; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; SubCounty; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; Telephone; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; AltContact; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; AltTelephone; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; DisabilityDetails; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; Conviction; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Conviction Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; Dismissal; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; DismissalDetails; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; DismissalDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; Interviewed; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; InterviewDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; InterviewDetails; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; Languages; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
