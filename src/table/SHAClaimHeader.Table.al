table 85587 "SHA Claim Header"
{Caption = 'SHA Claim Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Claim No."; Code[20])
        {
            Caption = 'Claim No.';
            DataClassification = ToBeClassified;
        }

        field(2; "Appointment No."; Code[20])
        {
            Caption = 'Appointment No.';
            DataClassification = ToBeClassified;
            TableRelation = "HMS Appointment Form Header";
        }

        field(3; "Patient No."; Code[20])
        {
            Caption = 'Patient No.';
            DataClassification = ToBeClassified;
        }

        field(4; "Patient Name"; Text[250])
        {
            Caption = 'Patient Name';
            DataClassification = ToBeClassified;
        }

        field(5; "Patient CR ID"; Text[100])
        {
            Caption = 'Patient CR ID';
            DataClassification = ToBeClassified;
        }

        field(6; "Consent Request ID"; Text[100])
        {
            Caption = 'Consent Request ID';
            DataClassification = ToBeClassified;
        }

        field(7; "Authorization ID"; Text[100])
        {
            Caption = 'Authorization ID';
            DataClassification = ToBeClassified;
        }

        field(8; "Authorization Code"; Text[100])
        {
            Caption = 'Authorization Code';
            DataClassification = ToBeClassified;
        }

        field(9; "Authorization GUID"; Text[100])
        {
            Caption = 'Authorization GUID';
            DataClassification = ToBeClassified;
        }

        field(10; "Authorization Status"; Text[50])
        {
            Caption = 'Authorization Status';
            DataClassification = ToBeClassified;
        }

        field(11; "Visit ID"; Text[100])
        {
            Caption = 'Visit ID';
            DataClassification = ToBeClassified;
        }

        field(12; "Visit Number"; Text[100])
        {
            Caption = 'Visit Number';
            DataClassification = ToBeClassified;
        }

        field(13; "Visit Start"; DateTime)
        {
            Caption = 'Visit Start';
            DataClassification = ToBeClassified;
        }

        field(14; "Service Type"; Text[50])
        {
            Caption = 'Service Type';
            DataClassification = ToBeClassified;
        }

        field(15; "Scheme Code"; Text[50])
        {
            Caption = 'Scheme Code';
            DataClassification = ToBeClassified;
        }

        field(16; "Scheme Name"; Text[250])
        {
            Caption = 'Scheme Name';
            DataClassification = ToBeClassified;
        }

        field(17; "Provider Claim No."; Text[100])
        {
            Caption = 'Provider Claim No.';
            DataClassification = ToBeClassified;
        }

        field(18; "SHA Claim ID"; Text[100])
        {
            Caption = 'SHA Claim ID';
            DataClassification = ToBeClassified;
        }

        field(19; "SHA Claim GUID"; Text[100])
        {
            Caption = 'SHA Claim GUID';
            DataClassification = ToBeClassified;
        }

        field(20; "Subject GUID"; Text[100])
        {
            Caption = 'Subject GUID';
            DataClassification = ToBeClassified;
        }

        field(21; "Claim Status"; Text[50])
        {
            Caption = 'Claim Status';
            DataClassification = ToBeClassified;
        }

        field(22; "Processing Status"; Option)
        {
            Caption = 'Processing Status';
            DataClassification = ToBeClassified;
            OptionMembers = Draft,Ready,Submitted,Processing,Completed,Rejected,Cancelled;
            OptionCaption = 'Draft,Ready,Submitted,Processing,Completed,Rejected,Cancelled';
        }

        field(23; "Claim Amount"; Decimal)
        {
            Caption = 'Claim Amount';
            DataClassification = ToBeClassified;
        }

        field(24; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
        }

        field(25; "Rejected Amount"; Decimal)
        {
            Caption = 'Rejected Amount';
            DataClassification = ToBeClassified;
        }

        field(26; "Status Message"; Text[250])
        {
            Caption = 'Status Message';
            DataClassification = ToBeClassified;
        }

        field(27; "Invoice ID"; Text[100])
        {
            Caption = 'Invoice ID';
            DataClassification = ToBeClassified;
        }

        field(28; "Invoice Number"; Text[100])
        {
            Caption = 'Invoice Number';
            DataClassification = ToBeClassified;
        }

        field(29; "Submitted At"; DateTime)
        {
            Caption = 'Submitted At';
            DataClassification = ToBeClassified;
        }

        field(30; "Last Status Update"; DateTime)
        {
            Caption = 'Last Status Update';
            DataClassification = ToBeClassified;
        }

        field(31; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = ToBeClassified;
        }

        field(32; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }

        field(33; "Last Updated At"; DateTime)
        {
            Caption = 'Last Updated At';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Claim No.")
        {
            Clustered = true;
        }

        key(Appointment; "Appointment No.")
        {
        }

        key(ProviderClaim; "Provider Claim No.")
        {
        }

        key(SubjectGuid; "Subject GUID")
        {
        }

        key(SHAClaimGuid; "SHA Claim GUID")
        {
        }

        key(Status; "Claim Status")
        {
        }
    }
}
