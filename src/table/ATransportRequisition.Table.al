table 85066 "A-Transport Requisition"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
        }
        field(50001; "Request Date"; Date)
        {
        }
        field(50002; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50003; "Station Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50004; "Officer No."; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Emp.Get("Officer No.") then begin
                    "Officer Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    Designation := Emp."Job Title";
                end;
            end;
        }
        field(50005; "Officer Name"; Text[50])
        {
        }
        field(50006; Designation; Code[20])
        {
        }
        field(50007; "Type of Vehicle"; Code[20])
        {
            TableRelation = "A-Vehicle Types".Code;
        }
        field(50008; "Local Running"; Boolean)
        {
        }
        field(50009; Places; Code[200])
        {
        }
        field(50010; "Estimated Period (Days)"; Integer)
        {
        }
        field(50011; "Journey Purpose"; Text[200])
        {
        }
        field(50012; Status; Option)
        {
            OptionCaption = 'New,1st Approval,2nd Approval,3rd Approval,4th Approval';
            OptionMembers = New,"1st Approval","2nd Approval","3rd Approval","4th Approval";
        }
        field(50013; "Requested By"; Code[20])
        {
        }
        field(50014; "HOD Approved By"; Code[20])
        {
        }
        field(50015; "HOD Approval date"; Date)
        {
        }
        field(50016; "HOD Approval Status"; Option)
        {
            OptionCaption = ' ,Approve,Reject';
            OptionMembers = " ",Approve,Reject;
        }
        field(50017; "Transport Approved By"; Code[20])
        {
        }
        field(50018; "Transport Approval Date"; Date)
        {
        }
        field(50019; "Transport Approval Status"; Option)
        {
            OptionCaption = ' ,Approve,Reject';
            OptionMembers = " ",Approve,Reject;
        }
        field(50020; "MD Approved By"; Code[20])
        {
        }
        field(50021; "MD Approval Status"; Option)
        {
            OptionCaption = ' ,Approve,Reject';
            OptionMembers = " ",Approve,Reject;
        }
        field(50022; "MD Approval Date"; Date)
        {
        }
        field(50023; "User Remarks"; Text[200])
        {
        }
        field(50024; "HOD Remarks"; Text[200])
        {
        }
        field(50025; "Transport Remarks"; Text[200])
        {
        }
        field(50026; "MD Remarks"; Text[200])
        {
        }
        field(50027; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50028; "Requisition Type"; Option)
        {
            OptionCaption = 'Normal,Commercial';
            OptionMembers = Normal,Commercial;
        }
        field(50029; "Client No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Client No.") then
                    "Client Name" := Cust.Name;
            end;
        }
        field(50030; "Client Name"; Text[100])
        {
        }
        field(50031; "Approver ID"; Code[20])
        {
        }
        field(50032; Distance; Decimal)
        {
            trigger OnValidate()
            begin
                /*
                OPSetUp.GET(0);
                "Estimated Cost":=(Distance*OPSetUp."Est. Driver Cost Per Km.")+(Distance*OPSetUp."Est. Running Cost Per Km")+
                (Distance*OPSetUp."Est. Fuel Cost Per km");
                */
            end;
        }
        field(50033; "Estimated Cost"; Decimal)
        {
        }
        field(50034; "Actual Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        IF "No." = '' THEN BEGIN
          OPSetUp.GET(0);
          OPSetUp.TESTFIELD(OPSetUp.Description);
          NoSeriesMgt.InitSeries(OPSetUp.Description,xRec."No. Series",0D,"No.","No. Series");
        END;
        */
    end;

    var
        Cust: Record Customer;
        Emp: Record Employee;
}
