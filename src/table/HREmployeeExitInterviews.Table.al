Table 85410 "HR Employee Exit Interviews"
{
    // DrillDownPageID = UnknownPage50035;
    // LookupPageID = UnknownPage50035;

    fields
    {
        field(50000; "Exit Clearance No"; Code[20])
        {
        }
        field(50001; "Date Of Clearance"; Date)
        {
            trigger OnValidate()
            begin

                /* IF ("Date Of Interview" <> 0D) AND ("Date Of Interview" <> xRec."Date Of Interview") THEN BEGIN
                   CareerEvent.SetMessage('Exit Interview Conducted');
                   CareerEvent.RUNMODAL;
                   OK:= CareerEvent.ReturnResult;
                   IF OK THEN BEGIN
                       CareerHistory.INIT;
                       CareerHistory."Employee No.":= "Employee No.";
                       CareerHistory."Date Of Event":= "Date Of Interview";
                       CareerHistory."Career Event":= 'Exit Interview Conducted';
                       CareerHistory."Exit Interview":= TRUE;
                        OK:= Employee.GET("Employee No.");
                        IF OK THEN BEGIN
                         CareerHistory."Employee First Name":= Employee."Known As";
                         CareerHistory."Employee Last Name":= Employee."Last Name";
                        END;
                       CareerHistory.INSERT;
                    END;
                 END;
                   */
            end;
        }
        field(50002; "Clearance Requester"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset();
                HREmp.SetRange(HREmp."No.", "Clearance Requester");
                if HREmp.Find('-') then begin
                    IntFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Clearer Name" := IntFullName;
                end;
            end;
        }
        field(50003; "Re Employ In Future"; Option)
        {
            OptionCaption = ' ,Yes,No,Not Applicable';
            OptionMembers = " ",Yes,No,"Not Applicable";
        }
        field(50004; "Nature Of Separation"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;
        }
        field(50005; "Reason For Leaving (Other)"; Text[150])
        {
        }
        field(50006; "Date Of Leaving"; Date)
        {
        }
        field(50007; "Directorate Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin

                Dimn.SetRange(Dimn.Code, "Directorate Code");
                if Dimn.Find('-') then
                    "Directorate Name" := Dimn.Name;
            end;
        }
        field(50008; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin

                Dimn.SetRange(Dimn.Code, "Department Code");
                if Dimn.Find('-') then
                    "Department Name" := Dimn.Name;
            end;
        }
        field(50009; Comment; Boolean)
        {
            CalcFormula = exist("HR Human Resource Comments" where("Table Name" = const("Exit Interviews"),
                                                                    "No." = field("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee"."No." where(Status = const(Normal));

            trigger OnValidate()
            begin
                HREmp.Reset();
                HREmp.SetRange(HREmp."No.", "Employee No.");
                if HREmp.Find('-') then begin
                    EmpFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name" := EmpFullName;
                end;
            end;
        }
        field(50011; "No Series"; Code[10])
        {
        }
        field(50012; "Form Submitted"; Boolean)
        {
            trigger OnValidate()
            begin
                HREmp.Reset();
                HREmp.SetRange("No.", "Employee No.");
                OK := HREmp.Find('-');

                if "Form Submitted" = true then
                    if OK then begin
                        HREmp.Status := HREmp.Status::Normal;
                        HREmp."Date Of Leaving" := "Date Of Leaving";
                        // HREmp."Nature Of Separation":= "Nature Of Separation";
                        HREmp."Exit Interview Done by" := "Clearance Requester";
                        HREmp.Modify();
                    end;

                if "Form Submitted" = false then
                    if OK then begin
                        HREmp.Status := HREmp.Status::Normal;
                        HREmp."Date Of Leaving" := 0D;
                        HREmp."Termination Category" := HREmp."termination category"::" ";
                        HREmp."Exit Interview Done by" := '';
                        HREmp.Modify();
                    end;
            end;
        }
        field(50013; "Employee Name"; Text[50])
        {
        }
        field(50014; "Clearer Name"; Text[50])
        {
        }
        field(50015; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50016; "Responsibility Center"; Code[30])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(50017; "Station Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin

                Dimn.SetRange(Dimn.Code, "Station Code");
                if Dimn.Find('-') then
                    "Station Name" := Dimn.Name;
            end;
        }
        field(50018; "Station Name"; Text[100])
        {
            Editable = false;
        }
        field(50019; "Directorate Name"; Text[100])
        {
            Editable = false;
        }
        field(50020; "Department Name"; Text[100])
        {
            Editable = false;
        }
        field(50021; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50022; "Station Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50023; "Directorate Filter"; Code[20])
        {
        }
        field(50024; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Casuals,Contract';
            OptionMembers = Permanent,Casuals,Contract;
        }
        field(50025; "Appointment Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Exit Clearance No")
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
        if "Exit Clearance No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Exit Interview Nos");
            NoSeriesMgt.GetNextNo(HRSetup."Exit Interview Nos");
        end;

        "Clearance Requester" := UserId;
    end;

    var
        HREmp: Record "HR-Employee";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        //  CareerEvent: Page UnknownPage70135475;
        OK: Boolean;
        EmpFullName: Text;
        IntFullName: Text;
}
