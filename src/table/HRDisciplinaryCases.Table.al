Table 85405 "HR Disciplinary Cases"
{
    // LookupPageID = "Petty Cash";

    fields
    {
        field(50000; "Case Number"; Code[20])
        {
        }
        field(50001; "Date of Complaint"; Date)
        {
        }
        field(50002; "Type Complaint"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where(Type = const("Disciplinary Case"));
        }
        field(50003; "Recommended Action"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Disciplinary Action"));
        }
        field(50004; "Description of Complaint"; Text[250])
        {
        }
        field(50005; Accuser; Code[10])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if "Accused Employee" = Accuser then
                    Error('An employee cannot accuse his/her self');

                Emp.Reset();
                Emp.SetRange(Emp."No.", Accuser);
                if Emp.Find('-') then
                    "Accuser Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50006; "Witness #1"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                Emp.Reset();
                Emp.SetRange(Emp."No.", "Witness #1");
                if Emp.Find('-') then
                    "Witness #1 Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50007; "Witness #2"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                Emp.Reset();
                Emp.SetRange(Emp."No.", "Witness #2");
                if Emp.Find('-') then
                    "Witness #2  Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50008; "Action Taken"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Disciplinary Action"));
        }
        field(50009; "Date To Discuss Case"; Date)
        {
        }
        field(50010; "Document Link"; Text[200])
        {
        }
        field(50011; "Disciplinary Remarks"; Code[50])
        {
        }
        field(50012; Comments; Text[250])
        {
        }
        field(50013; "Case Discussion"; Boolean)
        {
        }
        field(50014; "Body Handling The Complaint"; Code[100])
        {
            TableRelation = "HR Committees".Code;
        }
        field(50015; Recomendations; Code[10])
        {
        }
        field(50016; "HR/Payroll Implications"; Integer)
        {
        }
        field(50017; "Support Documents"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(50018; "Policy Guidlines In Effect"; Code[10])
        {
            TableRelation = "HR Policies".Code;
        }
        field(50019; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50020; "Mode of Lodging the Complaint"; Text[30])
        {
        }
        field(50021; "No. Series"; Code[20])
        {
        }
        field(50022; "Accused Employee"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                Emp.Reset();
                Emp.SetRange(Emp."No.", "Accused Employee");
                if Emp.Find('-') then
                    "Accused Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50023; Selected; Boolean)
        {
        }
        field(50024; "Closed By"; Code[20])
        {
        }
        field(50025; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR";
        }
        field(50026; "Accuser Name"; Text[40])
        {
        }
        field(50027; "Witness #1 Name"; Text[50])
        {
        }
        field(50028; "Witness #2  Name"; Text[50])
        {
        }
        field(50029; "Disciplinary Stage Status"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Reported,Investigation ,Inprogress,Closed,Under review';
            OptionMembers = " ",Reported,"Investigation ",Inprogress,Closed,"Under review";
        }
        field(50030; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Store Requisition,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval,Disciplinary Approvals,Activity Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval";
        }
        field(50031; "User ID"; Code[50])
        {
        }
        field(50032; "Accused Employee Name"; Text[100])
        {
        }
        field(50033; "Accussed By"; Option)
        {
            OptionMembers = Employee,"Non-Employee";
        }
        field(50034; "Non Employee Name"; Text[100])
        {
            trigger OnValidate()
            begin
                if "Accussed By" = "accussed by"::Employee then
                    Error('You are not allowed to Type Name if accused is an employee');
            end;
        }
        field(50035; Appealed; Boolean)
        {
        }
        field(50036; "Date of Complaint was Reported"; Date)
        {
        }
        field(50037; "Severity Of the Complain"; Option)
        {
            OptionMembers = Major,Minor;
        }
    }

    keys
    {
        key(Key1; "Accused Employee", "Case Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Case Number" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Disciplinary Cases Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.", xRec."No. Series", 0D, "Case Number", "No. Series");
        end;

        "User ID" := UserId;
        "Date of Complaint" := Today;
    end;

    trigger OnModify()
    begin
        /*IF Status=Status::"" THEN
        ERROR('You cannot modify a case Under Investigation');
         */
    end;

    var
        Emp: Record "HR-Employee";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
