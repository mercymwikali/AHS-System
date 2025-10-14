Table 52202474 "Audit Meetings"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Audit Code"; Code[20])
        {
        }
        field(3; "Description 1"; Text[250])
        {
        }
        field(4; "Description 2"; Text[250])
        {
        }
        field(5; Category; Option)
        {
            OptionCaption = ',Opening Meeting, Progress meeting, Closing Meeting';
            OptionMembers = ,"Opening Meeting"," Progress meeting"," Closing Meeting";
        }
        field(6; "Audit Programme"; Code[20])
        {
        }
        field(7; "Audit No."; Option)
        {
            OptionCaption = ',1st Internal Audit,1st Surveillance Audit,6th Internal Audit,3rd Surveillance Audit,7th Internal Audit,4th Surveillance Audit';
            OptionMembers = ,"1st Internal Audit","1st Surveillance Audit","6th Internal Audit","3rd Surveillance Audit","7th Internal Audit","4th Surveillance Audit";
        }
        field(8; "Date Created"; Date)
        {
        }
        field(9; "Created By"; Code[30])
        {
        }
        field(10; "Meeting Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
