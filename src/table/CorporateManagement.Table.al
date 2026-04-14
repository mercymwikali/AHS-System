Table 85084 "Corporate Management"
{
    fields
    {
        field(50000; No; Code[20])
        {
            trigger OnValidate()
            begin
                /*
                IF "Visitor Number" <> xRec."Visitor Number" THEN BEGIN
                  SecuritySetups.GET;
                  NoSeriesMgt.TestManual(SecuritySetups."Visitor Number");
                  "No. Series" := '';
                END;
                */
            end;
        }
        field(50001; "Visitor Name"; Text[150])
        {
        }
        field(50002; "ID Number"; Code[10])
        {
        }
        field(50003; "Phone Number"; Code[10])
        {
        }
        field(50004; "Car Reg. Number"; Code[8])
        {
        }
        field(50005; "Person To See"; Text[150])
        {
        }
        field(50006; "Purpose of Visit"; Text[150])
        {
        }
        field(50007; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(50008; "Visitor Pass No."; Code[10])
        {
        }
        field(50009; Status; Option)
        {
            OptionCaption = 'New,Arrived,Entered,Received,Cleared,Approved,Posted,Cancelled,Open,Released';
            OptionMembers = New,Arrived,Entered,Received,Cleared,Approved,Posted,Cancelled,Open,Released;
        }
        field(50010; "Initiated By"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50011; "Initiated By Time"; Time)
        {
        }
        field(50012; "Cleared By"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50013; "Cleared By Time"; Time)
        {
        }
        field(50014; "No. Series"; Code[20])
        {
        }
        field(50015; "Created Date"; Date)
        {
        }
        field(50016; "Created Time"; Time)
        {
        }
        field(50017; "Initiated Date"; Date)
        {
        }
        field(50018; "Cleared Date"; Date)
        {
        }
        field(50019; "Visitor Category"; Option)
        {
            OptionCaption = 'Employee,High School,Primary,KABU ,Student';
            OptionMembers = Employee,"High School",Primary,"KABU ",Student;
        }
        field(50020; "Requisitioning Officer"; Code[20])
        {
            TableRelation = if ("Visitor Category" = const(Student)) Customer."No." where("Customer Posting Group" = const('STUDENT'))
            else
            if ("Visitor Category" = const(Employee)) "HR-Employee"."No." where(Status = const(Normal));

            trigger OnValidate()
            begin
                if Cust.Get("Requisitioning Officer") then
                    "Visitor Name" := Cust.Name;
                if Emp.Get("Requisitioning Officer") then
                    "Visitor Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50021; "Reason(s)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Feedback; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; Opinions; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Request date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Required Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                Dimval.Reset();
                Dimval.SetRange(Dimval."Global Dimension No.", 1);
                Dimval.SetRange(Dimval.Code, "Global Dimension 1 Code");
                if Dimval.Find('-') then
                    "Function Name" := Dimval.Name
            end;
        }
        field(50027; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50028; "Function Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the name of the function in the database';
        }
        field(50029; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                Dimval.Reset();
                //Dimval.SETRANGE(Dimval."Global Dimension No.",3);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 3 Code");
                if Dimval.Find('-') then
                    Dim3 := Dimval.Name
            end;
        }
        field(50030; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                Dimval.Reset();
                //Dimval.SETRANGE(Dimval."Global Dimension No.",4);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 4 Code");
                if Dimval.Find('-') then
                    Dim4 := Dimval.Name
            end;
        }
        field(50031; "Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Department Name"; Text[250])
        {
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = filter('DEPARTMENT'),
                                                               Code = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50033; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; Dim3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; Dim4; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Meeting Held?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Meeting Schedule Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Nature of Meeting"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Number  Of Participants"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Estimated Duration Of Meeting"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Room Availability"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; Reason; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50044; Designation; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Recommend Stnt ID Replacement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Permission Granted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Reasons For Replacement?"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50048; SDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; LDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "LID HELD?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; SIDHELD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Student,Department,Staff';
            OptionMembers = ,Student,Department,Staff;
        }
        field(50053; "Student Picture"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; Complaints; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Action Taken?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Action Recommended"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Corrective Action"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Email Addresss"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Received By"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Customer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            SecuritySetups.Get();
            SecuritySetups.TestField(SecuritySetups."Corporate No.");
            NoSeriesMgt.InitSeries(SecuritySetups."Corporate No.", xRec."No. Series", 0D, No, "No. Series");
        end;

        Status := Status::Open;
        "Request date" := Today;
        "Created Time" := Time;
        "Created Date" := Today;
    end;

    var
        Cust: Record Customer;
        Dimval: Record "Dimension Value";
        Emp: Record "HR-Employee";
        SecuritySetups: Record "Security Setups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
