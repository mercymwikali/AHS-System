Table 85029 "HR Training Applications"
{
    // DrillDownPageID = UnknownPage70135489;
    //  LookupPageID = UnknownPage70135489;

    fields
    {
        field(50000; "Application No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Employee No." <> xRec."Employee No." then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Training Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(50001; "Course Title"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Training Courses"."Course Code" where(Closed = const(false),
                                                                       "Individual Course" = const(false));

            trigger OnValidate()
            begin

                HRTrainingNeeds.Reset;
                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Title");
                if HRTrainingNeeds.Find('-') then begin
                    "No of Required Participants" := HRTrainingNeeds."No of Required Participants";
                end;
                if HRTrainingNeeds.Get("Course Title") then
                    "Course Title" := HRTrainingNeeds.Code;
                Description := HRTrainingNeeds."Description";
                "From Date" := HRTrainingNeeds."Proposed Start Date";
                "To Date" := HRTrainingNeeds."Proposed End Date";
                "Duration Units" := HRTrainingNeeds."Duration Units";
                Duration := HRTrainingNeeds.Duration;
                "Cost Of Training" := HRTrainingNeeds."Cost Of Training";
                "No of Participants" := HRTrainingNeeds."No of Required Participants";
                // Location := HRTrainingNeeds.Location;
                // Trainer := HRTrainingNeeds.Provider;
                //"Training Institution" := HRTrainingNeeds."Provider Name";
                // "Training Status" := HRTrainingNeeds."Closing Status";

                //"No of Required Participants":=HRTrainingNeeds."No of Participants Required";

                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Title");
                if "No of Participants" > HRTrainingNeeds."No of Required Participants" then
                    Error('The No of participants exceed the required Number');
                //IFTraining category"<> "Training category"::Group THEN

                //  ERROR(mcontent3);
                // TrainingApp.Reset;
                // TrainingApp.SetRange(TrainingApp."Employee No.", "Employee No.");
                // TrainingApp.SetRange(TrainingApp."Course Title", "Course Title");

                // if TrainingApp.Find('-') then
                //     Error('You have applied for this Course before');
                //                     */
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
                /*
                                begin
                                    if (Duration <> 0) and ("From Date" <> 0D) then
                                        "To Date" := HRTrainApp.DetermineLeaveReturnDate("From Date", Duration);
                                    Modify;
                                end;
                                */
            end;
        }
        field(50006; "Cost Of Training"; Decimal)
        {
            CalcFormula = sum("HR Training Cost".Cost where("Training Id" = field("Application No")));
            DecimalPlaces = 0 : 0;
            Editable = true;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                if Posted then
                    if Duration <> xRec.Duration then begin
                        Message('%1', 'You cannot change the costs after posting');
                        Duration := xRec.Duration;
                    end
            end;
        }
        field(50007; Location; Option)
        {
            Editable = true;
            OptionMembers = "Local",International;
        }
        field(50008; Posted; Boolean)
        {
            Editable = true;
        }
        field(50009; Description; Text[250])
        {
            Editable = true;
        }
        field(50010; "Training Evaluation Results"; Option)
        {
            OptionMembers = "Not Evaluated",Passed,Failed;

            trigger OnValidate()
            begin
                if "Training Status" <> "training status"::"Completed Successfully" then
                    Error(mcontent4);
            end;
        }
        field(50011; Year; Integer)
        {
        }
        field(50012; Trainer; Code[10])
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
        field(50013; "Purpose of Training"; Text[100])
        {
        }
        field(50014; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50015; "Employee No."; Code[10])
        {
            NotBlank = false;
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if "Training Category" <> "training category"::Group then begin
                    HREmp.Get("Employee No.");
                    Directorate := HREmp."Shortcut Dimension 2 Code";
                    "Employee Name" := HREmp.FullName();
                end;
            end;
        }
        field(50016; "Application Date"; Date)
        {
            Editable = false;
        }
        field(50017; "No. Series"; Code[10])
        {
        }
        field(50018; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(50019; Recommendations; Code[20])
        {
        }
        field(50020; "User ID"; Code[50])
        {
        }
        field(50021; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR".Code;
        }
        field(50022; Directorate; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Directorate);
                if Dimn.Find('-') then
                    "Directorate Name" := Dimn.Name;
            end;
        }
        field(50023; "Employee Name"; Text[50])
        {
        }
        field(50024; "Training Institution"; Text[50])
        {
        }
        field(50025; "Training Category"; Option)
        {
            OptionCaption = 'Individual,Group';
            OptionMembers = Individual,Group;
        }
        field(50026; "Table ID"; Integer)
        {
        }
        field(50027; Supervisor; Code[50])
        {
        }
        field(50028; "Supervisor Name"; Text[100])
        {
        }
        field(50029; "Individual Course Code"; Code[50])
        {
            // TableRelation = "HR Training Courses"."Course Code" where("Individual Course" = const(Yes));
        }
        field(50030; "Individual Course Description"; Text[250])
        {
        }
        field(50031; "No of Participants"; Integer)
        {
            CalcFormula = count("HR Training Participants" where("Training Code" = field("Application No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("No of Participants");
                if "No of Participants" > "No of Required Participants" then
                    Error('Nominated Participants cannot exceed the Number of Participants Required 1111111 ');
                if "No of Participants" <= 0 then
                    Error('Required positions cannot be Less Than or Equal to Zero');
            end;
        }
        field(50032; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Department);
                if Dimn.Find('-') then
                    "Department Name" := Dimn.Name;

                /*
                HREmp.RESET;
                HREmp.SETRANGE(HREmp."No.","Employee No.");
                HREmp.SETRANGE(HREmp."Shortcut Dimension 2 Code",Directorate);
                HREmp.SETRANGE(HREmp.County,Department);
                IF HREmp.FIND() THEN BEGIN
                IF TranPart.GET("Application No")THEN BEGIN
                 TranPart.INIT;
                 TranPart."Employee Code":=HREmp."No.";
                 TranPart."Employee name":=HREmp."First Name"+'-'+HREmp."Middle Name"+'-'+HREmp."Last Name";
                 TranPart.INSERT;
                END;
                END;
                */
            end;
        }
        field(50033; "No of Required Participants"; Integer)
        {
            FieldClass = Normal;
        }
        field(50034; Station; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Station);
                if Dimn.Find('-') then
                    "Station Name" := Dimn.Name;
            end;
        }
        field(50035; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50036; "Quarter Offered"; Option)
        {
            OptionCaption = ' 1st Quarter,2nd Quarter,3rd Quarter';
            OptionMembers = " 1st Quarter","2nd Quarter","3rd Quarter";
        }
        field(50037; "Training Status"; Option)
        {
            OptionCaption = ' ,Suspended,Deferred,Cancelled,Completed Successfully';
            OptionMembers = " ",Suspended,Deferred,Cancelled,"Completed Successfully";

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error(mcontent5);
            end;
        }
        field(50038; "Department Name"; Text[50])
        {
        }
        field(50039; "Station Name"; Text[50])
        {
        }
        field(50040; "Directorate Name"; Text[50])
        {
        }
        field(50041; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50042; Sponsor; Option)
        {
            OptionMembers = Self,KNCHR,Donor,Other;
        }
        field(50043; Specify; Text[80])
        {
        }
        field(50044; Country; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(50045; County; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const(County));
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Course Title")
        {
        }
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error(mcontent);
    end;

    trigger OnInsert()
    begin
        if "Application No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Training Application Nos.");
            NoSeriesMgt.GetNextNo(HRSetup."Training Application Nos.");
        end;

        "User ID" := UserId;
        "Application Date" := Today;

        "Table ID" := Database::"HR-Employee";
        "User ID" := UserId;

        if "Training Category" <> "training category"::Group then
            //TESTFIELD("Employee No.");
            if userseups.Get(UserId) then begin
                if userseups."Employee No." = '' then
                    Error('Your Login is not associated with any employee. Consult the system Admin.');
                if HREmp.Get(userseups."Employee No.") then begin
                    "Employee No." := HREmp."No.";
                    "User ID" := UserId;
                end else
                    Error('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee');

            end else
                Error('You are not a legitimate user! Consult the system Admin.');

        if UserSetup.Get(UserId) then begin
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset();
            if UserSetup.Get(Supervisor) then
                "Supervisor Name" := UserSetup."E-Mail";
        end;

        CalcFields("No of Participants");
        /*
        IF "No of Participants" > "No of Required Participants" THEN
        BEGIN
            ERROR('Nominated Participants cannot exceed the Number of Participants Required 1111111 ');
        END;
        IF "No of Participants" <= 0 THEN
        BEGIN
            ERROR('Required positions cannot be Less Than or Equal to Zero');
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
        Dimn: Record "Dimension Value";
        HREmp: Record "HR-Employee";
        HRTrainingNeeds: Record "HR Training Needs Analysis";
        HRSetup: Record "HR Setup";
        UserSetup: Record "User Setup";
        userseups: Record "User Setup";
        Vend: Record Vendor;
        NoSeriesMgt: Codeunit "No. Series";
        mcontent: label 'Status must be new on Training Application No.';
        // HRTrainApp: Record UnknownRecord70135114;
        // TranPart: Record UnknownRecord70135172;
        mcontent4: label 'You cannot evaluate a training which is not successfully completed.';
        mcontent5: label 'You cannot change training status if the status is not approved';
}
