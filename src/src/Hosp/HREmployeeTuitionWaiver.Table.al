Table 52202817 "HR Employee Tuition Waiver"
{
    //  DrillDownPageID = UnknownPage50204;
    //  LookupPageID = UnknownPage50204;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; Department; Text[100])
        {
        }
        field(5; Designation; Text[100])
        {
        }
        field(6; "Date of Appointment"; Text[30])
        {
        }
        field(7; "Contract Type"; Text[50])
        {
        }
        field(8; From; Text[20])
        {
        }
        field(9; "To"; Text[20])
        {
        }
        field(10; Beneficiary; Option)
        {
            OptionCaption = ',Self,Dependant';
            OptionMembers = ,Self,Dependant;
        }
        field(11; "Beneficiary RegNo"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Beneficiary RegNo") then
                    "Name of Beneficiary" := Cust.Name;
            end;
        }
        field(12; "Name of Beneficiary"; Text[50])
        {
        }
        field(13; Relationship; Text[15])
        {
        }
        field(14; "Beneficiary BOB"; Text[20])
        {
        }
        field(15; "Beneficiary Age"; Text[20])
        {
        }
        field(16; "Name of Programme"; Text[100])
        {
        }
        field(17; "School Offering"; Text[100])
        {
        }
        field(18; "Duration of Study"; Text[50])
        {
        }
        field(19; "Current Year"; Text[20])
        {
        }
        field(20; "Current Semester"; Text[50])
        {
        }
        field(21; "Campus Offering"; Text[30])
        {
        }
        field(22; "Total Tuition"; Decimal)
        {
        }
        field(23; "Amount of Waiver"; Decimal)
        {
        }
        field(24; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(25; "Application Date"; Date)
        {
        }
        field(26; "No. Series"; Code[20])
        {
        }
        field(27; "User ID"; Code[30])
        {
        }
        field(28; "Responsibility Center"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "To", "School Offering", "Duration of Study")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Tuition Waiver Nos.");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Tuition Waiver Nos.", xRec."No.", 0D, "No.", Rec."No.");
        end;
    end;

    var
        Cust: Record Customer;
        GenLedgerSetup: Record "General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
