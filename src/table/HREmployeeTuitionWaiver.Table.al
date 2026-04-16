Table 85282 "HR Employee Tuition Waiver"
{
    //  DrillDownPageID = UnknownPage50204;
    //  LookupPageID = UnknownPage50204;

    fields
    {
        field(50000; "No."; Code[20])
        {
        }
        field(50001; "Employee No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50002; "Employee Name"; Text[100])
        {
        }
        field(50003; Department; Text[100])
        {
        }
        field(50004; Designation; Text[100])
        {
        }
        field(50005; "Date of Appointment"; Text[30])
        {
        }
        field(50006; "Contract Type"; Text[50])
        {
        }
        field(50007; From; Text[20])
        {
        }
        field(50008; "To"; Text[20])
        {
        }
        field(50009; Beneficiary; Option)
        {
            OptionCaption = ',Self,Dependant';
            OptionMembers = ,Self,Dependant;
        }
        field(50010; "Beneficiary RegNo"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Beneficiary RegNo") then
                    "Name of Beneficiary" := Cust.Name;
            end;
        }
        field(50011; "Name of Beneficiary"; Text[50])
        {
        }
        field(50012; Relationship; Text[15])
        {
        }
        field(50013; "Beneficiary BOB"; Text[20])
        {
        }
        field(50014; "Beneficiary Age"; Text[20])
        {
        }
        field(50015; "Name of Programme"; Text[100])
        {
        }
        field(50016; "School Offering"; Text[100])
        {
        }
        field(50017; "Duration of Study"; Text[50])
        {
        }
        field(50018; "Current Year"; Text[20])
        {
        }
        field(50019; "Current Semester"; Text[50])
        {
        }
        field(50020; "Campus Offering"; Text[30])
        {
        }
        field(50021; "Total Tuition"; Decimal)
        {
        }
        field(50022; "Amount of Waiver"; Decimal)
        {
        }
        field(50023; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50024; "Application Date"; Date)
        {
        }
        field(50025; "No. Series"; Code[20])
        {
        }
        field(50026; "User ID"; Code[30])
        {
        }
        field(50027; "Responsibility Center"; Code[20])
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
            NoSeriesMgt.GetNextNo(GenLedgerSetup."Tuition Waiver Nos.");
        end;
    end;

    var
        Cust: Record Customer;
        GenLedgerSetup: Record "General Set-Up";
        NoSeriesMgt: Codeunit "No. Series";
}
