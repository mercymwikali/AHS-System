table 85012 "HR Attendance Ledger"
{
    Caption = 'HR Attendance Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(50001; "Staff No."; Code[30])
        {
            Caption = 'Staff No.';
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            var
                HREmployee: Record "HR-Employee";
            begin
                HREmployee.SetLoadFields("No.", "Search Name", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                HREmployee.SetRange("No.", "Staff No.");
                if HREmployee.FindFirst() then begin
                    "Staff Name" := HREmployee."Search Name";
                    "Shortcut Dimension 1 Code" := HREmployee."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := HREmployee."Shortcut Dimension 2 Code";
                end;
            end;
        }
        field(50002; "Staff Name"; Text[150])
        {
            Caption = 'Staff Name';
            Editable = false;
        }
        field(50003; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(50004; Email; Text[100])
        {
            Caption = 'Email';
        }
        field(50005; "Shortcut Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50006; "Shortcut Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50007; "Attendance Date"; Date)
        {
            Caption = 'Date';
        }
        field(50008; "Time In"; Time)
        {
            Caption = 'Time In';
        }
        field(50009; "Time out"; Time)
        {
            Caption = 'Time out';
            trigger OnValidate()
            begin
                if "Time out" <> 0T then
                    "Hours Worked" := (("Time out" - "Time In") / 3600000);
            end;
        }
        field(50010; "Hours Worked"; Decimal)
        {
            Caption = 'Hours Worked';
        }
        field(50011; "Location Coordinates"; Text[150])
        {
            Caption = 'Location Coordinates';
        }
        field(50012; "Location Name"; Text[150])
        {
            Caption = 'Location Name';
        }
        field(50013; "Checked In By"; Code[30])
        {
            Caption = 'Checked In By';
        }
        field(50014; "Checked Out By"; Code[30])
        {
            Caption = 'Checked Out By';
        }
        field(50015; "Checked Out"; Boolean)
        {
            Caption = 'is Checked Out?';
        }
        field(50016; "Sign in Comments"; Text[250])
        {
        }
        field(50017; "Sign out Comments"; Text[250])
        {
        }
        field(50018; "login date time"; DateTime)
        {
        }
        field(50019; "Signin Location"; Text[300])
        {
        }
        field(50020; "Signout Location"; Text[300])
        {
        }
        field(50021; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = ' ,Absence,Present,On Leave';
            OptionMembers = ,Absence,Present,"On Leave";
        }
        field(50022; "Signin Location Coordinates"; Text[150])
        {
            Caption = 'Location Coordinates';
        }
        field(50023; "Signout Location Coordinates"; Text[150])
        {
            Caption = 'Location Coordinates';
        }
        field(50024; "Swap No"; Code[30])
        {
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        NoseriesMgmt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";

    trigger OnInsert()
    var
        HRAttendanceLedger: Record "HR Attendance Ledger";
    begin
        if "No." = '' then begin
            HRSetup.Get();
            "No." := NoseriesMgmt.GetNextNo(HRSetup."Attendance Nos", 0D, true);
            // HRAttendanceLedger.RESET();
            // if HRAttendanceLedger.FINDLAST() then
            //     "No." := INCSTR(HRAttendanceLedger."No.")
            // else
            //     "No." := 'ATT00001';
        end;
    end;

    procedure GetNextNo(): Code[50]
    var
        HRAttendanceLedger: Record "HR Attendance Ledger";
        NewNo: Code[50];
    begin

        HRSetup.Get();
        NewNo := NoseriesMgmt.GetNextNo(HRSetup."Attendance Nos", 0D, true);
        exit(NewNo);

        /*  HRAttendanceLedger.RESET();
         if HRAttendanceLedger.FINDLAST() then
             exit(INCSTR(HRAttendanceLedger."No."))
         else
             exit('ATT_00001'); */
    end;
}
