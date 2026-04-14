Table 85108 "Legal Management"
{
    fields
    {
        field(50000; No; Code[20])
        {
            trigger OnValidate()
            begin
                /*
                IF "Visitor Number" <> xRec."Visitor Number" THEN BEGIN
                  GenSetu.GET;
                  NoSeriesMgt.TestManual(GenSetu."Visitor Number");
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
            TableRelation = if ("Visitor Category" = const(Employee)) "HR Employee Vehicle"."Vehicle Reg No" where("Employee No" = field("Visitor Number"));
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
            OptionCaption = ' ,Student,Employee,High School,Primary,KABU';
            OptionMembers = " ",Student,Employee,"High School",Primary,KABU;
        }
        field(50020; "Visitor Number"; Code[20])
        {
            TableRelation = if ("Visitor Category" = const(Student)) Customer."No." where("Customer Posting Group" = const('STUDENT'))
            else
            if ("Visitor Category" = const(Employee)) "HR-Employee"."No." where(Status = const(Normal));

            trigger OnValidate()
            begin
                if Cust.Get("Visitor Number") then
                    "Visitor Name" := Cust.Name;
                if Emp.Get("Visitor Number") then
                    "Visitor Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50021; "Visitor Car Reg Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Comments; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; Feedback; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Opinions; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Litigation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Arrived,Entered,Received,Cleared,Approved,Posted,Cancelled,New';
            OptionMembers = Arrived,Entered,Received,Cleared,Approved,Posted,Cancelled,New;
        }
        field(50026; "Concerned Department Notified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Documents Attached?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Request date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Required Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Global Dimension 1 Code"; Code[20])
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
        field(50031; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimval.Reset();
                Dimval.SetRange(Dimval."Global Dimension No.", 2);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 2 Code");
                if Dimval.Find('-') then
                    "Budget Center Name" := Dimval.Name
            end;
        }
        field(50032; "Function Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the name of the function in the database';
        }
        field(50033; "Budget Center Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the name of the budget center in the database';
        }
        field(50034; "Shortcut Dimension 3 Code"; Code[20])
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
        field(50035; "Shortcut Dimension 4 Code"; Code[20])
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
        field(50036; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Status, Status::New);
                if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter());
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
            end;
        }
        field(50037; "Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Department Name"; Text[250])
        {
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = filter('DEPARTMENT'),
                                                               Code = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50039; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; Dim3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; Dim4; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Meeting Held?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Meeting Schedule Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Litigation Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Case Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Court Negotiations"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Settlement Out of Court"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Settlement Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Next Court Schedule"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Settlement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Court Settlement Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Proceedings Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Send to Litigation"; Boolean)
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
            GenSetu.Get();
            GenSetu.TestField(GenSetu."Legal Nos");
            NoSeriesMgt.InitSeries(GenSetu."Legal Nos", xRec."No. Series", 0D, No, "No. Series");
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
        RespCenter: Record "Responsibility Center BR";
        GenSetu: Record "Security Setups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserMgt: Codeunit "User Setup Management BR";
        Text001: label 'Your identification is set up to process from %1 %2 only.';
}
