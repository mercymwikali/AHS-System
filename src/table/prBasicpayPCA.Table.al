Table 85507 "prBasic pay PCA"
{
    fields
    {
        field(50000; "Employee Code"; Code[50])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                objEmp.Reset();
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    "Employee Name" := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                    if objEmp.Status <> objEmp.Status::Normal then
                        Error('This employee is not an ACTIVE employee contact HR');

                    objSalCard.Reset();
                    objSalCard.SetRange(objSalCard."Employee Code", objEmp."No.");
                    if objSalCard.Find('-') then begin
                        "Basic Pay" := objSalCard."Basic Pay";
                        "Pays NSSF" := objSalCard."Pays NSSF";
                        "Pays NHIF" := objSalCard."Pays NHIF";
                        "Pays PAYE" := objSalCard."Pays PAYE";

                        /*-------------
                          //----Insert from employee transactions----------------------------------------------
                          objPayrollPeriod.RESET;
                          objPayrollPeriod.SETRANGE(objPayrollPeriod.Closed,FALSE);
                          IF objPayrollPeriod.FIND('-') THEN BEGIN
                            empTransPCA.RESET;
                            empTransPCA.SETRANGE(empTransPCA."Change Advice Serial No.","Change Advice Serial No.");
                            IF empTransPCA.FIND('-') THEN empTransPCA.DELETEALL;

                           empTrans.RESET;
                           empTrans.SETRANGE(empTrans."Employee Code",objEmp."No.");
                           empTrans.SETRANGE(empTrans."Payroll Period",objPayrollPeriod."Date Opened");
                           IF empTrans.FIND('-') THEN REPEAT
                            empTransPCA.INIT;
                            empTransPCA."Change Advice Serial No.":="Change Advice Serial No.";
                            empTransPCA."Employee Code":=empTrans."Employee Code";
                            empTransPCA."Transaction Code":=empTrans."Transaction Code";
                            empTransPCA."Payroll Period":=empTrans."Payroll Period";
                            empTransPCA."Transaction Name":=empTrans."Transaction Name";
                            empTransPCA.Amount:=empTrans.Amount;
                            empTransPCA.Balance:=empTrans.Balance;
                            empTransPCA.INSERT;
                           UNTIL empTrans.NEXT=0;
                          //-----------------------------------------------------------------------------------
                          END;
                        ------------------*/
                    end;
                end;
            end;
        }
        field(50001; "Employee Name"; Text[100])
        {
        }
        field(50002; "Basic Pay"; Decimal)
        {
        }
        field(50003; Comments; Text[200])
        {
        }
        field(50004; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Posted;
        }
        field(50005; "Period Month"; Integer)
        {
        }
        field(50006; "Period Year"; Integer)
        {
        }
        field(50007; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened" where(Closed = const(false));
        }
        field(50008; "Change Advice Serial No."; Code[50])
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
        field(50009; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50010; Effected; Boolean)
        {
        }
        field(50011; "Currency Code"; Code[10])
        {
        }
        field(50012; "User ID"; Code[50])
        {
        }
        field(50013; "Pays NSSF"; Boolean)
        {
        }
        field(50014; "Pays NHIF"; Boolean)
        {
        }
        field(50015; "Pays PAYE"; Boolean)
        {
        }
        field(50016; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(50017; PAyrollCode; Code[50])
        {
            TableRelation = "prPayroll Type";
        }
        field(50018; "Campus Code"; Code[50])
        {
            CalcFormula = lookup("HR-Employee"."Shortcut Dimension 1 Code" where("No." = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50019; "Department Code"; Code[50])
        {
            CalcFormula = lookup("HR-Employee"."Shortcut Dimension 2 Code" where("No." = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50020; "School Code"; Code[50])
        {
            CalcFormula = lookup("HR-Employee".Schools where("No." = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50021; "Section Code"; Code[50])
        {
            CalcFormula = lookup("HR-Employee".Section where("No." = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50022; Multipay; Boolean)
        {
        }
        field(50023; "Transfer/Appointment No"; Code[50])
        {
        }
        field(50024; "Campus Name"; Text[250])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Campus Code")));
            FieldClass = FlowField;
        }
        field(50025; "Department Name"; Text[250])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Department Code")));
            FieldClass = FlowField;
        }
        field(50026; "School Name"; Text[250])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("School Code")));
            FieldClass = FlowField;
        }
        field(50027; "Section Name"; Text[250])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Section Code")));
            FieldClass = FlowField;
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
            // HrSetup.TestField("Pay-change No.");
            NoSeriesMgt.InitSeries(HrSetup."Pay-change No.", xRec."No. Series", 0D, "Change Advice Serial No.", "No. Series");
        end;
        "User ID" := UserId;

        Usetup.Reset();
        Usetup.SetRange(Usetup."User ID", UserId);
        if Usetup.Find('-') then begin
            // PAyrollCode:=Usetup."Payroll Code";
        end else
            Error('Please contact your admin to be setup to raise PCAs');

        fnCheckEmployeeStatus();
    end;

    var
        objEmp: Record "HR-Employee";
        HrSetup: Record "HR Setup";
        objSalCard: Record "prSalary Card";
        Usetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure fnCheckEmployeeStatus()
    var
        objEmp: Record "HR-Employee";
    begin
        objEmp.Reset();
        objEmp.SetRange(objEmp."No.", "Employee Code");
        objEmp.SetFilter(objEmp.Status, '<>%1', objEmp.Status::Normal);
        if objEmp.Find('-') then begin
            Error('You cannot raise a PCA for someone who is not Active');
            "Employee Code" := '';
            Modify();
        end;
    end;
}
