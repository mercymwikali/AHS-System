Table 52202605 prMassPCAHD
{
    DrillDownPageID = "prMassPCA Card";
    LookupPageID = "prMassPCA Card";

    fields
    {
        field(1; "Change Advice Serial No."; Code[50])
        {
            trigger OnValidate()
            begin
                if "Change Advice Serial No." <> xRec."Change Advice Serial No." then begin
                    HrSetup.Get();
                    NoSeriesMgt.TestManual(HrSetup."Pay-change No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Posted;
        }
        field(3; "Period Month"; Integer)
        {
        }
        field(4; "Period Year"; Integer)
        {
        }
        field(5; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened" where(Closed = const(false));
        }
        field(6; Comments; Text[200])
        {
        }
        field(7; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; Effected; Boolean)
        {
        }
        field(9; "User ID"; Code[50])
        {
        }
        field(10; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(11; PAyrollCode; Code[50])
        {
            TableRelation = "prPayroll Type";
        }
        field(12; "Transaction Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                if objTransCodes.Get("Transaction Code") then
                    "Transaction Name" := objTransCodes."Transaction Name";
                //"Payroll Period":=SelectedPeriod;
                //"Period Month":=PeriodMonth;
                //"Period Year":=PeriodYear;
                //  IF objTransCodes."Special Transactions"=8 THEN blnIsLoan:=TRUE;
            end;
        }
        field(13; "Transaction Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Change Advice Serial No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Change Advice Serial No." = '' then begin
            HrSetup.Get();

            NoSeriesMgt.InitSeries(HrSetup."Pay-change No.", xRec."No. Series", 0D, "Change Advice Serial No.", "No. Series");
        end;
        "User ID" := UserId;

        "Transaction Code" := 'E0025';

        Validate("Transaction Code");

        objPayrollPeriod.Reset();
        objPayrollPeriod.SetRange(objPayrollPeriod.Closed, false);
        if objPayrollPeriod.Find('-') then begin
            "Period Month" := objPayrollPeriod."Period Month";
            "Period Year" := objPayrollPeriod."Period Year";
            "Payroll Period" := objPayrollPeriod."Date Opened";
        end;
    end;

    var
        HrSetup: Record "HR Setup";
        objPayrollPeriod: Record "prPayroll Periods";
        objTransCodes: Record "PR Transaction Codes";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure fnCheckEmployeeStatus()
    begin
        /*objEmp.RESET;
        objEmp.SETRANGE(objEmp."No.","Employee Code");
        objEmp.SETFILTER(objEmp.Status,'<>%1',objEmp.Status::Normal);
        IF objEmp.FIND('-') THEN BEGIN
         ERROR('You cannot raise a PCA for someone who is not Active');
         "Employee Code":='';
         MODIFY;
        END;
        */
    end;
}
