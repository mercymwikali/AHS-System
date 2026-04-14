Table 85401 "HRBack To Office Form"
{
    // DrillDownPageID = UnknownPage70135489;
    //  LookupPageID = UnknownPage70135489;

    fields
    {
        field(50000; "Document No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                HRSetup.Get();
                NoSeriesMgt.TestManual(HRSetup."Back To Office Nos.");
                "No. Series" := '';
            end;
        }
        field(50001; "Course Title"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Training Courses"."Course Code" where(Closed = const(false),
                                                                       "Individual Course" = const(false));

            trigger OnValidate()
            begin

                HRTrainingNeeds.Reset();
                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Title");
                if HRTrainingNeeds.Get("Course Title") then
                    //"Course Title":=HRTrainingNeeds.Code;
                    Description := HRTrainingNeeds."Course Tittle";
                "From Date" := HRTrainingNeeds."Start Date";
                "To Date" := HRTrainingNeeds."End Date";
                "Duration Units" := HRTrainingNeeds."Duration Units";
                Duration := HRTrainingNeeds.Duration;
                "Cost Of Training" := HRTrainingNeeds."Cost Of Training";
                Location := HRTrainingNeeds.Location;
                Trainer := HRTrainingNeeds.Provider;
                "Training Institution" := HRTrainingNeeds."Provider Name";
                "Training Status" := HRTrainingNeeds."Closing Status";

                //"No of Required Participants":=HRTrainingNeeds."No of Participants Required";

                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Title");
                //IFTraining category"<> "Training category"::Group THEN

                //  ERROR(mcontent3);
            end;
        }
        field(50002; "From Date"; Date)
        {
            Editable = true;
        }
        field(50003; "To Date"; Date)
        {
            Editable = true;
        }
        field(50004; "Duration Units"; Option)
        {
            Editable = true;
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(50005; Duration; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin

                begin
                    if (Duration <> 0) and ("From Date" <> 0D) then
                        "To Date" := HRTrainApp.DetermineLeaveReturnDate("From Date", Duration);
                    Modify();
                end;
            end;
        }
        field(50006; "Cost Of Training"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = true;
        }
        field(50007; Location; Text[30])
        {
            Editable = true;
        }
        field(50008; Description; Text[250])
        {
            Editable = true;
        }
        field(50009; "Training Evaluation Results"; Option)
        {
            OptionMembers = "Not Evaluated",Passed,Failed;

            trigger OnValidate()
            begin
                if "Training Status" <> "training status"::"Completed Successfully" then
                    Error(mcontent4);
            end;
        }
        field(50010; Trainer; Code[10])
        {
            Editable = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vend.Reset();
                Vend.SetRange(Vend."No.", Trainer);
                if Vend.Find('-') then
                    "Training Institution" := Vend.Name;
            end;
        }
        field(50011; "Purpose of Training"; Text[100])
        {
        }
        field(50012; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50013; "Employee No."; Code[10])
        {
            NotBlank = false;
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if "Training category" <> "training category"::Group then begin
                    HREmp.Get("Employee No.");
                    //Directorate:=HREmp."Department Name";
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                end;
            end;
        }
        field(50014; "No. Series"; Code[10])
        {
        }
        field(50015; "User ID"; Code[50])
        {
        }
        field(50016; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(50017; Campus; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50018; "Employee Name"; Text[50])
        {
        }
        field(50019; "Training Institution"; Text[50])
        {
        }
        field(50020; "Training category"; Option)
        {
            OptionCaption = 'Individual,Group';
            OptionMembers = Individual,Group;
        }
        field(50021; "Table ID"; Integer)
        {
        }
        field(50022; Supervisor; Code[50])
        {
        }
        field(50023; "Supervisor Name"; Text[100])
        {
        }
        field(50024; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                HREmp.Reset();
                HREmp.SetRange(HREmp."No.", "Employee No.");
                HREmp.SetRange(HREmp."Shortcut Dimension 1 Code", Campus);
                HREmp.SetRange(HREmp.County, Department);
                if HREmp.Find() then
                    if TranPart.Get("Document No") then begin
                        TranPart.Init();
                        TranPart."Employee Code" := HREmp."No.";
                        TranPart."Employee name" := HREmp."First Name" + '-' + HREmp."Middle Name" + '-' + HREmp."Last Name";
                        TranPart.Insert();
                    end;
            end;
        }
        field(50025; "School Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50026; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50027; "Training Status"; Option)
        {
            OptionCaption = ' ,Suspended,Deferred,Cancelled,Completed Successfully';
            OptionMembers = " ",Suspended,Deferred,Cancelled,"Completed Successfully";

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error(mcontent5);
            end;
        }
        field(50028; "Text 1"; Text[200])
        {
        }
        field(50029; "Text 2"; Text[200])
        {
        }
        field(50030; "Text 3"; Text[200])
        {
        }
        field(50031; "Text 4"; Text[200])
        {
        }
        field(50032; "Text 5"; Text[200])
        {
        }
        field(50033; "Text 6"; Text[200])
        {
        }
        field(50034; "Text 9"; Text[200])
        {
        }
        field(50035; "Text 10"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error(mcontent);
    end;

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Back To Office Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Back To Office Nos.", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "User ID" := UserId;

        "Table ID" := 39005627;
        "User ID" := UserId;
        /*
       IF "Training category"<>"Training category"::Group THEN BEGIN
       //TESTFIELD("Employee No.");
       IF UserSetup.GET(USERID) THEN BEGIN
       IF HREmp.GET(UserSetup."Employee No.") THEN BEGIN
       "Employee No.":=HREmp."No.";
       "Employee Name":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";

       "User ID":=USERID;
       END ELSE BEGIN
       ERROR('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
       END;
       END ELSE ERROR('You are not a valid system user!');
       END;

       UserSetup.RESET;
       IF UserSetup.GET(USERID)THEN BEGIN
       Supervisor:=UserSetup."Approver ID";
       UserSetup.RESET;
       IF UserSetup.GET(Supervisor) THEN
       "Supervisor Name":=UserSetup."E-Mail";
       END;
       */
    end;

    trigger OnModify()
    begin
        //CALCFIELDS("Occupied Positions");
        //IF "Occupied Positions">0 THEN
        //ERROR('Cannot modify job if it has occupants');
        //IF Status <> Status::New THEN
        //ERROR(mcontent2);
    end;

    var
        HREmp: Record "HR-Employee";
        HRTrainApp: Record "HR Leave Application";
        HRSetup: Record "HR Setup";
        HRTrainingNeeds: Record "HR Training Courses";
        TranPart: Record "HR Training Participants";
        Vend: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        mcontent: label 'Status must be new on Training Application No.';
        mcontent4: label 'You cannot evaluate a training which is not successfully completed.';
        mcontent5: label 'You cannot change training status if the status is not approved';
}
