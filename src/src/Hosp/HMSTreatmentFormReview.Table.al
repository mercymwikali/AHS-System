table 52202969 "HMS Treatment Form Review"
{
    Caption = 'HMS Treatment Form Review';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Treatment No."; Code[30])
        {
            Caption = 'Treatment No.';
        }
        field(2; Clinic; Code[30])
        {
            Caption = 'Clinic';
            TableRelation = "HMS Clinics Setup".No;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(4; "Doctor No."; Code[30])
        {
            Caption = 'Doctor No.';
            TableRelation = "HMS Setup Doctor"."Doctor ID" where(Specialization = field(Clinic),
                                                                    "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(5; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",New,Accepted,Cancelled,Completed;
            OptionCaption = ' ,New,Accepted,Cancelled,Completed';
        }
        field(7; "Request Reason"; Text[1000])
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
