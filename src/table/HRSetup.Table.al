Table 85497 "HR Setup"
{
    Caption = 'Human Resources Setup';

    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(50001; "Employee Nos."; Code[10])
        {
            Caption = 'Employee Nos.';
            TableRelation = "No. Series";
        }
        field(50002; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Human Resource Unit of Measure";

            trigger OnValidate()
            var
                ResUnitOfMeasure: Record "Resource Unit of Measure";
            begin
                if "Base Unit of Measure" <> xRec."Base Unit of Measure" then
                    if EmployeeAbsence.Find('-') then
                        Error(Text001, FieldCaption("Base Unit of Measure"), EmployeeAbsence.TableCaption);

                HumanResUnitOfMeasure.Get("Base Unit of Measure");
                ResUnitOfMeasure.TestField("Qty. per Unit of Measure", 1);
                ResUnitOfMeasure.TestField("Related to Base Unit of Meas.");
            end;
        }
        field(50003; "Leave Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50004; "Recruitment Needs Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50005; "Disciplinary Cases Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50006; "Applicants Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50007; "Tax Table"; Code[10])
        {
        }
        field(50008; "Corporation Tax"; Decimal)
        {
        }
        field(50009; "Housing Earned Limit"; Decimal)
        {
        }
        field(50010; "Pension Limit Percentage"; Decimal)
        {
        }
        field(50011; "Pension Limit Amount"; Decimal)
        {
        }
        field(50012; "Round Down"; Boolean)
        {
        }
        field(50013; "Working Hours"; Decimal)
        {
        }
        field(50014; "Payroll Rounding Precision"; Decimal)
        {
        }
        field(50015; "Payroll Rounding Type"; Option)
        {
            OptionMembers = Nearest,Up,Down;
        }
        field(50016; "Special Duty Table"; Code[10])
        {
        }
        field(50017; "CFW Round Deduction code"; Code[20])
        {
        }
        field(50018; "BFW Round Earning code"; Code[20])
        {
        }
        field(50019; "Company overtime hours"; Decimal)
        {
        }
        field(50020; "Tax Relief Amount"; Decimal)
        {
        }
        field(50021; "Posting Group"; Code[20])
        {
        }
        field(50022; "General Payslip Message"; Text[100])
        {
        }
        field(50023; "Overtime Indicator"; Decimal)
        {
        }
        field(50024; "Bank Charges"; Decimal)
        {
        }
        field(50025; "Batch File Path"; Text[250])
        {
        }
        field(50026; "Incoming Mail Server"; Text[30])
        {
        }
        field(50027; "Outgoing Mail Server"; Text[30])
        {
        }
        field(50028; "Email Text"; Text[250])
        {
        }
        field(50029; "Sender User ID"; Text[30])
        {
        }
        field(50030; "Sender Address"; Text[100])
        {
        }
        field(50031; "Email Subject"; Text[100])
        {
        }
        field(50032; "Template Location"; Text[100])
        {
        }
        field(50033; CopyTo; Text[100])
        {
        }
        field(50034; "Delay Time"; Integer)
        {
        }
        field(50035; BatchNo; Code[10])
        {
            Caption = 'Employee Nos.';
            TableRelation = "No. Series";
        }
        field(50036; "HR Admin Address"; Text[150])
        {
        }
        field(50037; "Base Calendar"; Code[10])
        {
            TableRelation = "Base Calendar".Code;
        }
        field(50038; "Normal Leave Aprroval Levels"; Integer)
        {
        }
        field(50039; "Manager Leave Approval Levels"; Integer)
        {
        }
        field(50040; "Job ID"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50041; "Last Application No"; Integer)
        {
        }
        field(50042; "Active Loans Manager"; Code[30])
        {
        }
        field(50043; "Active Loans Director"; Code[30])
        {
        }
        field(50044; "Appraisal Manager"; Code[30])
        {
        }
        field(50045; "Low Intrest Loan Rate"; Decimal)
        {
        }
        field(50046; "First Payroll Aprroval"; Code[30])
        {
        }
        field(50047; "Second Payroll Aprroval"; Code[30])
        {
            TableRelation = User."User Name";
        }
        field(50048; "Payroll Approved"; Boolean)
        {
        }
        field(50049; "Payroll Control Accont"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50050; "Payroll Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50051; "Payroll Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payroll Journal Template"));
        }
        field(50052; "Sal.Increament"; Decimal)
        {
        }
        field(50053; "Training Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50054; "Transport Req Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50055; "Employee Requisition Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50056; "Leave Posting Period[FROM]"; Date)
        {
        }
        field(50057; "Leave Posting Period[TO]"; Date)
        {
        }
        field(50058; "Job Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50059; "Exit Interview Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50060; "Appraisal Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50061; "Company Activities"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50062; "Induction Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(50063; "Medical Claims Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50064; "Medical Scheme Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50065; "Days To Retirement"; DateFormula)
        {
        }
        field(50066; "Retirement Age"; Decimal)
        {
        }
        field(50067; "Back To Office Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50068; "TNA Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50069; "Pension Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50070; "Disabled Retirement Age"; Decimal)
        {
        }
        field(50071; "Pay-change No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50072; "Staff Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50073; "HR Admin Signature"; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50074; "Staff Appraisal No."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(50075; "Close Leave Application"; Boolean)
        {
        }
        field(50076; "Attachees Nos"; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(50077; "Casual No."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(50078; "Departments Casual Payments"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Attendance Nos"; Code[20])
        {            
            TableRelation = "No. Series".Code;
        }        
        field(50080; "PrEmployer NSSF Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50081; "PrEmployee NSSF Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        
        field(50082; "Annual Leave Rate"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        
        field(50083; "Leave Planner Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50084; "Interns Nos."; Code[10])
        {
            Caption = 'Interns Nos.';
            TableRelation = "No. Series";
        }
        field(50085; "Allocation Cutoff Day"; Integer)
        {
            Caption = 'Allocation Cutoff Day in Month';
        }
        field(50086; "WIBA Claim Nos."; Code[30])
        {
            Caption = 'WIBA Claim Nos.';
            TableRelation = "No. Series";
        }
        field(50087; "HR Stamp"; Blob)
        {
            Caption = 'HR Stamp';
            SubType = Bitmap;
        }
        field(50088; "Probation Duration"; DateFormula)
        {
        }
        field(50089; "End of Prob. Notification"; DateFormula)
        {            
        }
        field(50090; "Portal Reports File Path"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "Link Portal URL"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        
        field(50092; "ICT Email"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50093; "Enable Emails"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "Used For Approval"; Option)
        {
            OptionMembers = " ",Department,"Responsibility Center";
        }        
        field(50095; "Recruitment Clause"; Text[1000])
        {
            
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeAbsence: Record "Employee Absence";
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        Text001: label 'You cannot change %1 because there are %2.';
}
