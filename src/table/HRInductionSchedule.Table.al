Table 85418 "HR Induction Schedule"
{
    fields
    {
        field(50000; "Induction Code"; Code[10])
        {
            trigger OnValidate()
            begin
                if "Induction Code" <> xRec."Induction Code" then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Induction Nos");
                    "No series" := '';
                end;
            end;
        }
        field(50001; "Staff Code"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                Staff.Reset();
                Staff.SetRange(Staff."No.", "Staff Code");
                if Staff.Find('-') then begin
                    "Staff Names" := Staff."First Name" + ' ' + Staff."Middle Name" + ' ' + Staff."Last Name";
                    "Date of Join" := Staff."Date Of Join";
                end;
            end;
        }
        field(50002; "Staff Names"; Text[100])
        {
        }
        field(50003; "Staff Department"; Text[100])
        {
        }
        field(50004; "Date of Join"; Date)
        {
        }
        field(50005; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Department.Reset();
                Department.SetRange(Department.Code, "Department Code");
                if Department.Find('-') then
                    "Department Name" := Department.Name;
            end;
        }
        field(50006; "Department Name"; Text[100])
        {
        }
        field(50007; "Induction Period"; Integer)
        {
        }
        field(50008; "Induction Start date"; Date)
        {
            trigger OnValidate()
            begin
                Induction.Reset();
                Induction.SetRange(Induction."Staff Code", "Staff Code");

                if Induction.Find('-') then begin
                    Evaluate(RLen, (Format(Induction."Induction Period") + 'D'));
                    Rdate := CalcDate(RLen, "Induction Start date");
                    "Induction End  date" := Rdate;
                end;
            end;
        }
        field(50009; "Induction End  date"; Date)
        {
        }
        field(50010; Comments; Text[100])
        {
        }
        field(50011; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50012; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Budget Transfer,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        }
        field(50013; "Table ID"; Integer)
        {
        }
        field(50014; "User ID"; Code[50])
        {
        }
        field(50015; Selected; Boolean)
        {
        }
        field(50016; "No series"; Code[10])
        {
        }
        field(50017; Supervisor; Code[10])
        {
        }
        field(50018; "Application Date"; Date)
        {
        }
        field(50019; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR";
        }
    }

    keys
    {
        key(Key1; "Induction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Induction Code" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Induction Nos");
            NoSeriesMgt.InitSeries(HRSetup."Induction Nos", xRec."No series", 0D, "Induction Code", xRec."No series");
        end;

        "Table ID" := Database::"HR-Employee";
        "User ID" := UserId;
        //IF "Training category"<>"Training category"::Group THEN BEGIN
        HREmp.Reset();
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Staff Code" := HREmp."No.";
            //"Job Title":=HREmp."Job Title";
            HREmp.Get(HREmp."No.");
            //HREmp.CALCFIELDS(HREmp.Picture);
            //Picture:=HREmp.Picture;
            "User ID" := UserId;
        end else
            Error('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee');
        //END;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then begin
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset();
            if UserSetup.Get(Supervisor) then
                //"Supervisor Name":=UserSetup."E-Mail";
                //END;

                //POPULATE FIELDS
                "Application Date" := Today;
        end;
    end;

    var
        Department: Record "Dimension Value";
        HREmp: Record "HR-Employee";
        Staff: Record "HR-Employee";
        Induction: Record "HR Induction Schedule";
        HRSetup: Record "HR Setup";
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RLen: DateFormula;
        Rdate: Date;
}
