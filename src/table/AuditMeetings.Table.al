Table 85558 "Audit Meetings"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Audit Code"; Code[20])
        {
        }
        field(50002; "Description 1"; Text[250])
        {
        }
        field(50003; "Description 2"; Text[250])
        {
        }
        field(50004; Category; Option)
        {
            OptionCaption = ',Opening Meeting, Progress meeting, Closing Meeting';
            OptionMembers = ,"Opening Meeting"," Progress meeting"," Closing Meeting";
        }
        field(50005; "Audit Programme"; Code[20])
        {
        }
        field(50006; "Audit No."; Option)
        {
            OptionCaption = ',1st Internal Audit,1st Surveillance Audit,6th Internal Audit,3rd Surveillance Audit,7th Internal Audit,4th Surveillance Audit';
            OptionMembers = ,"1st Internal Audit","1st Surveillance Audit","6th Internal Audit","3rd Surveillance Audit","7th Internal Audit","4th Surveillance Audit";
        }
        field(50007; "Date Created"; Date)
        {
        }
        field(50008; "Created By"; Code[30])
        {
        }
        field(50009; "Meeting Date"; Date)
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
