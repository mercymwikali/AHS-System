table 85270 "HMS Treatment Form Review"
{
    Caption = 'HMS Treatment Form Review';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Treatment No."; Code[30])
        {
            Caption = 'Treatment No.';
        }
        field(50001; Clinic; Code[30])
        {
            Caption = 'Clinic';
            TableRelation = "HMS Clinics Setup".No;
        }
        field(50002; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50003; "Doctor No."; Code[30])
        {
            Caption = 'Doctor No.';
            TableRelation = "HMS Setup Doctor"."Doctor ID" where(Specialization = field(Clinic),
                                                                    "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(50004; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(50005; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",New,Accepted,Cancelled,Completed;
            OptionCaption = ' ,New,Accepted,Cancelled,Completed';
        }
        field(50006; "Request Reason"; Text[1000])
        {
            Caption = 'Request Reason';
        }

    }
    keys
    {
        key(PK; "Treatment No.","Doctor No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Request Date" = 0D then
            "Request Date" := WORKDATE();        
    end;
}
