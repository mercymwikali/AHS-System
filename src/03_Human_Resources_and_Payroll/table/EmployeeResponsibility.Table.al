Table 85487 "Employee Responsibility"
{
    fields
    {
        field(50000; "Job ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Responsibility Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Responsibility Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Position; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "HR Jobs"."Job ID";
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
