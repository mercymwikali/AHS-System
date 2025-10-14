Table 52202712 "Employee Responsibility"
{
    fields
    {
        field(1; "Job ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Responsibility Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Responsibility Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Position; Code[50])
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
