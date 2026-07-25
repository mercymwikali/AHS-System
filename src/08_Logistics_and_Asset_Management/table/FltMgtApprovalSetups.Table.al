Table 85010 "Flt Mgt Approval Setups"
{
    fields
    {
        field(50000; UserID; Code[20])
        {
            TableRelation = User;
        }
        field(50001; "Fleet Management Area"; Option)
        {
            OptionMembers = " ","Vehicle Management",TransportReq,DailyWorksheet,FuelReq,MaintenanceReq;
        }
        field(50002; Create; Boolean)
        {
        }
        field(50003; "Line Manager Approver"; Boolean)
        {
        }
        field(50004; "Transport Mger Approver"; Boolean)
        {
        }
        field(50005; "View Only Department"; Boolean)
        {
        }
        field(50006; "User Department"; Code[20])
        {
        }
        field(50007; "Safari Notice Approver"; Boolean)
        {
        }
        field(50008; "Finance Approver"; Boolean)
        {
        }
        field(50009; "IS Director"; Boolean)
        {
        }
        field(50010; "IS HRM"; Boolean)
        {
        }
        field(50011; "Is Deputy Director"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
