Table 85286 "HR Job Applicants - Appt. List"
{
    Caption = 'HR Job Applications';
    //DrillDownPageID = UnknownPage70134738;
    //LookupPageID = UnknownPage70134738;

    fields
    {
        field(50000; "Code"; Code[50])
        {
        }
        field(50001; "Aptitude Test Description"; Text[100])
        {
        }
        field(50002; "Date of Test"; Date)
        {
        }
        field(50003; Venue; Text[30])
        {
        }
        field(50004; FromTime; Time)
        {
        }
        field(50005; "To time"; Time)
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

    trigger OnInsert()
    begin
        /*//GENERATE NEW NUMBER FOR THE DOCUMENT
        IF  "Aptitude Test Description" = '' THEN BEGIN
          HRSetup.GET;
          HRSetup.TESTFIELD(HRSetup."Job Application Nos");
          NoSeriesMgt.GetNextNo(HRSetup."Job Application Nos",xRec."No. Series",0D,"Aptitude Test Description","No. Series");
        END;

        "Date Applied":=TODAY;
        */
    end;

    procedure FullName(): Text[100]
    begin
    end;
}
