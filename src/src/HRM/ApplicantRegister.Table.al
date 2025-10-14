Table 52202519 "Applicant Register"
{
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; UserName; Text[100])
        {
        }
        field(3; Password; Text[30])
        {
        }
        field(4; EmailAddress; Text[30])
        {
        }
        field(5; Verified; Boolean)
        {
        }
        field(6; MyRecId; RecordID)
        {
        }
        field(7; "First Name"; Text[100])
        {
        }
        field(8; "Middle Name"; Text[100])
        {
        }
        field(9; "Last Name"; Text[100])
        {
        }
        field(10; "ID Number"; Code[50])
        {
        }
        field(11; "Passport Number"; Code[50])
        {
        }
        field(12; "Activation Code"; Code[50])
        {
        }
        field(13; "Postal Address"; Code[30])
        {
        }
        field(14; "Cell Phone Number"; Code[30])
        {
        }
        field(15; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er)';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)";
        }
        field(16; "Date of Birth"; Date)
        {
        }
        field(17; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(18; RememberMe; Boolean)
        {
        }
        field(19; "Activate Account"; Boolean)
        {
        }
        field(20; "Random User Number"; Code[50])
        {
        }
        field(21; "Random Value"; Text[200])
        {
        }
        field(22; Disability; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Citizenship; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Ethnicity; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Title; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Postal Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Town; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; County; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; SubCounty; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Telephone; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; AltContact; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; AltTelephone; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; DisabilityDetails; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(34; Conviction; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Conviction Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Dismissal; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(37; DismissalDetails; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(38; DismissalDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39; Interviewed; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(40; InterviewDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(41; InterviewDetails; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(42; Languages; Text[250])
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
