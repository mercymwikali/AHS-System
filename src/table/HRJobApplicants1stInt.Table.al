Table 85283 "HR Job Applicants - 1st Int."
{
    Caption = 'HR Job Applications';
    // DrillDownPageID = UnknownPage70134738;
    // LookupPageID = UnknownPage70134738;

    fields
    {
        field(50000; "Aptitude Test Description"; Text[100])
        {
        }
        field(50001; "Date of Test"; Date)
        {
        }
        field(50002; Venue; Text[30])
        {
        }
        field(50003; FromTime; Time)
        {
        }
        field(50004; "To time"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Aptitude Test Description")
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
