Table 85440 "HR Training Courses"
{
    DrillDownPageID = "HR Course List";
    LookupPageID = "HR Course List";

    fields
    {
        field(50000; "Course Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Course Tittle"; Text[200])
        {
        }
        field(50002; "Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if (Duration <> 0) and ("Start Date" <> 0D) then
                    //"Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
                    //"End Date" := DeterminethisLeaveEndDate("Return Date");
                    "End Date" := HRLeaveApp.CalcEndDate("Start Date", Duration);
                Modify();
            end;
        }
        field(50003; "End Date"; Date)
        {
        }
        field(50004; "Duration Units"; Option)
        {
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(50005; Duration; Decimal)
        {
            trigger OnValidate()
            begin
                begin
                    if (Duration <> 0) and ("Start Date" <> 0D) then
                        //"Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
                        //"End Date" := DeterminethisLeaveEndDate("Return Date");
                        "End Date" := HRLeaveApp.CalcEndDate("Start Date", Duration);
                    Modify();
                end;
            end;
        }
        field(50006; "Cost Of Training"; Decimal)
        {
            trigger OnValidate()
            begin
                /*IF Posted THEN BEGIN
                IF Duration <> xRec.Duration THEN BEGIN
                MESSAGE('%1','You cannot change the costs after posting');
                Duration := xRec.Duration;
                END
                END
                */
            end;
        }
        field(50007; Location; Text[100])
        {
        }
        field(50008; "Re-Assessment Date"; Date)
        {
        }
        field(50009; "Need Source"; Option)
        {
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal,Succesion,Training,Employee,"Employee Skill Plan";
        }
        field(50010; Provider; Code[20])
        {
            Description = 'Stores Institutions for offering training';
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vend.Reset();
                Vend.SetRange(Vend."No.", Provider);
                if Vend.Find('-') then
                    "Provider Name" := Vend.Name;
            end;
        }
        field(50011; Posted; Boolean)
        {
            Editable = false;
        }
        field(50012; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Campus Code");
                if Dimn.Find('-') then
                    "Campus Name" := Dimn.Name;
            end;
        }
        field(50013; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Department);
                if Dimn.Find('-') then
                    "Department Name" := Dimn.Name;
            end;
        }
        field(50014; Closed; Boolean)
        {
            Editable = false;
        }
        field(50015; "Qualification Code"; Code[20])
        {
            TableRelation = "HR Qualifications".Code where("Qualification Type" = field("Qualification Type"));

            trigger OnValidate()
            begin
                HRQualifications.SetRange(HRQualifications.Code, "Qualification Code");
                if HRQualifications.Find('-') then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
        field(50016; "Qualification Type"; Code[30])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where(Type = const("Qualification Type"));
        }
        field(50017; "Qualification Description"; Text[80])
        {
        }
        field(50018; "Training Applicants"; Integer)
        {
            CalcFormula = count("HR Training Applications" where("Course Title" = field("Course Code")));
            FieldClass = FlowField;
        }
        field(50019; "Training Applicants (Passed)"; Integer)
        {
            CalcFormula = count("HR Training Applications" where("Course Title" = field("Course Code"),
                                                                  "Training Evaluation Results" = const(Passed)));
            FieldClass = FlowField;
        }
        field(50020; "Training Applicants (Failed)"; Integer)
        {
            CalcFormula = count("HR Training Applications" where("Course Title" = field("Course Code"),
                                                                  "Training Evaluation Results" = const(Failed)));
            FieldClass = FlowField;
        }
        field(50021; "Provider Name"; Text[50])
        {
        }
        field(50022; "No of Participants Required"; Integer)
        {
        }
        field(50023; "Nature of Training"; Option)
        {
            OptionCaption = ' ,Internal,External,Self,E-Learning';
            OptionMembers = " ",Internal,External,Self,"E-Learning";
        }
        field(50024; "Training Type"; Option)
        {
            OptionCaption = ',Long course,Short Course,Seminar,Workshop';
            OptionMembers = ,"Long course","Short Course",Seminar,Workshop;
        }
        field(50025; "Course Version"; Code[20])
        {
        }
        field(50026; "Course Version Description"; Text[200])
        {
        }
        field(50027; "Individual Course"; Boolean)
        {
        }
        field(50028; "Closing Status"; Option)
        {
            OptionCaption = ' ,Suspended,Deferred,Cancelled,Completed Successfully';
            OptionMembers = " ",Suspended,Deferred,Cancelled,"Completed Successfully";
        }
        field(50029; "Quarter Offered"; Option)
        {
            OptionCaption = ' 1st Quarter,2nd Quarter,3rd Quarter';
            OptionMembers = " 1st Quarter","2nd Quarter","3rd Quarter";
        }
        field(50030; "Campus Name"; Text[100])
        {
            Editable = false;
        }
        field(50031; "Department Name"; Text[100])
        {
            Editable = false;
        }
        field(50032; "Station Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin

                Dimn.SetRange(Dimn.Code, Department);
                if Dimn.Find('-') then
                    "Station Name" := Dimn.Name;
            end;
        }
        field(50033; "Station Name"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Course Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Course Code", "Course Tittle")
        {
        }
    }

    var
        Dimn: Record "Dimension Value";
        HRLeaveApp: Record "HR Leave Application";
        HRQualifications: Record "HR Qualifications";
        Vend: Record Vendor;
}
