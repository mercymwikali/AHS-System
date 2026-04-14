Table 85100 "FLT-Transport Requisition"
{
    DrillDownPageID = "FLT Transport Requisition List";
    LookupPageID = "FLT Transport Requisition List";

    fields
    {
        field(50000; "Transport Requisition No"; Code[20])
        {
        }
        field(50001; Commencement; Text[30])
        {
        }
        field(50002; Destination; Text[30])
        {
        }
        field(50003; "Vehicle Allocated"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(50004; "Driver Allocated"; Code[20])
        {
            TableRelation = "Flt Driver";

            trigger OnValidate()
            begin
                if HrEmployee.Get("Driver Allocated") then
                    "Driver Name" := HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                "Authorized  By" := UserId;

                userset.Reset();
                userset.SetRange(userset."User ID", UserId);
                if userset.Find('-') then begin
                    Emp.Reset();
                    Emp.SetRange(Emp."No.", userset."Employee No.");
                    if Emp.Find('-') then begin
                        "TO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        ;
                    end;
                end;
                Modify();
            end;
        }
        field(50005; "Requested By"; Code[20])
        {
        }
        field(50006; "Date of Request"; Date)
        {
        }
        field(50007; "Vehicle Allocated by"; Code[20])
        {
        }
        field(50008; "Opening Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50009; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Closed;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    fltman2.Reset();
                    fltman2.SetRange(fltman2."Finance Approver", true);
                    if fltman2.Find('-') then begin
                        "Checked By" := fltman2.UserID;
                        "Checked Designation" := 'FIN OFFICER';
                    end;
                end;
            end;
        }
        field(50010; "Date of Trip"; Date)
        {
        }
        field(50011; "Purpose of Trip"; Text[250])
        {
        }
        field(50012; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(50013; Comments; Text[250])
        {
        }
        field(50014; Department; Code[20])
        {
        }
        field(50015; "Driver Name"; Text[130])
        {
        }
        field(50016; "Responsibility Center"; Code[30])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                if not UserMgt.CheckRespCenter(1, Department) then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter());
            end;
        }
        field(50017; "Loaded to WorkTicket"; Boolean)
        {
        }
        field(50018; "Time out"; Time)
        {
        }
        field(50019; "Time In"; Time)
        {
        }
        field(50020; "Journey Route"; Text[250])
        {
        }
        field(50021; "Time Requested"; Time)
        {
        }
        field(50022; "Closing Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50023; "Work Ticket No"; Code[20])
        {
        }
        field(50024; "No of Days Requested"; Integer)
        {
        }
        field(50025; "Authorized  By"; Text[30])
        {
        }
        field(50026; Position; Text[30])
        {
        }
        field(50027; Name; Code[200])
        {
        }
        field(50028; Signature; Blob)
        {
        }
        field(50029; "Time of trip"; Time)
        {
        }
        field(50030; "Supervosor Recommendations"; Text[250])
        {
        }
        field(50031; "Date Requisition Received"; Date)
        {
        }
        field(50032; "Time Requisition Received"; Time)
        {
        }
        field(50033; "Transport Officer Remarks"; Text[250])
        {
            trigger OnValidate()
            begin
                "TO ID" := UserId;
                "TO Approval Date" := Today;
                userset.Reset();
                userset.SetRange(userset."User ID", UserId);
                if userset.Find('-') then begin
                    empno.Reset();
                    empno.SetRange(empno."No.", userset."Employee No.");
                    if empno.Find('-') then
                        "TO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
                Modify();
            end;
        }
        field(50034; "Checked By"; Code[50])
        {
        }
        field(50035; "Checked Designation"; Code[100])
        {
        }
        field(50036; "P/NO"; Code[20])
        {
        }
        field(50037; Designation; Code[30])
        {
        }
        field(50038; "No Of Passangers"; Integer)
        {
            CalcFormula = count("FLT-Travel Requisition Staff" where("Req No" = field("Transport Requisition No")));
            FieldClass = FlowField;
        }
        field(50039; "HOD Recommendations"; Text[100])
        {
            trigger OnValidate()
            begin
                "HOD ID" := UserId;
                "Checked By" := UserId;

                userset.Reset();
                userset.SetRange(userset."User ID", UserId);
                if userset.Find('-') then begin
                    empno.Reset();
                    empno.SetRange(empno."No.", userset."Employee No.");
                    if empno.Find('-') then begin
                        "HOD Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        "Checked Designation" := empno.Initials;
                    end;
                end;
                Modify();
            end;
        }
        field(50040; Make; Code[20])
        {
            CalcFormula = lookup("FLT-Vehicle Header".Make where("Registration No." = field("Vehicle Allocated")));
            FieldClass = FlowField;
        }
        field(50041; Model; Code[20])
        {
            CalcFormula = lookup("FLT-Vehicle Header".Model where("Registration No." = field("Vehicle Allocated")));
            FieldClass = FlowField;
        }
        field(50042; "Finance Officer Comments"; Text[250])
        {
            trigger OnValidate()
            begin
                "FO ID" := UserId;
                fltman5.Reset();
                fltman5.SetRange(fltman5.UserID, UserId);
                if fltman5.Find('-') then
                    if fltman5."Finance Approver" = true then begin
                        userset.Reset();
                        userset.SetRange(userset."User ID", UserId);
                        if userset.Find('-') then begin
                            empno.Reset();
                            empno.SetRange(empno."No.", userset."Employee No.");
                            if empno.Find('-') then
                                "FO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        end;
                    end;

                Modify();
            end;
        }
        field(50043; "TO Name"; Text[150])
        {
        }
        field(50044; "FO Name"; Text[150])
        {
        }
        field(50045; "HOD Name"; Text[150])
        {
        }
        field(50046; "HOD ID"; Code[20])
        {
        }
        field(50047; "Checked By Name"; Code[150])
        {
        }
        field(50048; "FO ID"; Code[20])
        {
        }
        field(50049; "TO ID"; Code[20])
        {
        }
        field(50050; "TO Approval Date"; Date)
        {
        }
        field(50051; "Opening ODO"; Decimal)
        {
        }
        field(50052; "Clossing ODO"; Decimal)
        {
        }
        field(50053; "Driver Allocated2"; Code[20])
        {
            TableRelation = "Flt Driver";

            trigger OnValidate()
            begin
                if HrEmployee.Get("Driver Allocated") then
                    "Driver Name" := HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                "Authorized  By" := UserId;

                userset.Reset();
                userset.SetRange(userset."User ID", UserId);
                if userset.Find('-') then begin
                    Emp.Reset();
                    Emp.SetRange(Emp."No.", userset."Employee No.");
                    if Emp.Find('-') then begin
                        "TO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        ;
                    end;
                end;
                Modify();
            end;
        }
        field(50054; "Driver Allocated3"; Code[20])
        {
            TableRelation = "Flt Driver";

            trigger OnValidate()
            begin
                if HrEmployee.Get("Driver Allocated") then
                    "Driver Name" := HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                "Authorized  By" := Format(UserId);

                userset.Reset();
                userset.SetRange(userset."User ID", UserId);
                if userset.Find('-') then begin
                    Emp.Reset();
                    Emp.SetRange(Emp."No.", userset."Employee No.");
                    if Emp.Find('-') then begin
                        "TO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        ;
                    end;
                end;
                Modify();
            end;
        }
    }

    keys
    {
        key(Key1; "Transport Requisition No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Transport Requisition No" = '' then begin
            FltMgtSetup.Get();
            FltMgtSetup.TestField("Transport Req No");
            NoSeriesMgt.InitSeries(FltMgtSetup."Transport Req No", xRec."No. Series", 0D, "Transport Requisition No", "No. Series");
        end;

        userset.Reset();
        userset.SetRange(userset."User ID", UserId);
        if userset.Find('-') then begin
            empno.Reset();
            empno.SetRange(empno."No.", userset."Employee No.");
            if empno.Find('-') then begin
                userset.CalcFields(userset."User Signature");
                Signature := userset."User Signature";
                Name := empno."First Name" + ' ' + empno."Middle Name" + ' ' + empno."Last Name";
                "P/NO" := empno."No.";
                Designation := empno.Initials;
            end;// ELSE ERROR('Please ensure that you have been setup by the System Administrator.')
        end;
    end;

    trigger OnModify()
    begin
        if (Status = Status::Approved) or (Status = Status::Approved) then
            Error(Text0001);

        if xRec."Vehicle Allocated" <> "Vehicle Allocated" then begin
            fltman5.Reset();
            fltman5.SetRange(fltman5."Transport Mger Approver", true);
            if fltman5.Find('-') then begin
                "Authorized  By" := fltman5.UserID;
                userset5.Reset();
                userset5.SetRange(userset5."User ID", fltman5.UserID);
                if userset5.Find('-') then begin
                    Emp1.Reset();
                    Emp1.SetRange(Emp1."No.", userset5."User ID");
                    if Emp1.Find('-') then
                        Position := Emp1.Initials;
                end;
            end;
            Modify();
        end;
    end;

    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        fltman2: Record "Flt Mgt Approval Setups";
        fltman5: Record "Flt Mgt Approval Setups";
        Emp: Record "HR-Employee";
        Emp1: Record "HR-Employee";
        empno: Record "HR-Employee";
        HrEmployee: Record "HR-Employee";
        RespCenter: Record "Responsibility Center";
        userset: Record "User Setup";
        userset5: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserMgt: Codeunit "User Setup Management";
        Text001: label 'Your identification is set up to process from %1 %2 only.';
        Text0001: label 'You cannot modify an Approved or Closed Record';
}
