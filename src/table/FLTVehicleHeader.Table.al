Table 85006 "FLT-Vehicle Header"
{
    DrillDownPageID = "Flt Vehicle Card List";
    LookupPageID = "Flt Vehicle Card List";

    fields
    {
        field(50000; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                /*
                IF "No." <> xRec."No." THEN BEGIN
                  FASetup.GET;
                  NoSeriesMgt.TestManual(FASetup."Fixed Asset Nos.");
                  "No. Series" := '';
                END;
                */
                CopyFields();
            end;
        }
        field(50001; Description; Text[30])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                /*
                IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
                  "Search Description" := Description;
                IF Description <> xRec.Description THEN BEGIN
                  FADeprBook.SETCURRENTKEY("FA No.");
                  FADeprBook.SETRANGE("FA No.","No.");
                  FADeprBook.MODIFYALL(Description,Description);
                END;
                MODIFY(TRUE);
                */
            end;
        }
        field(50002; "Search Description"; Code[30])
        {
            Caption = 'Search Description';
        }
        field(50003; "Description 2"; Text[30])
        {
            Caption = 'Description 2';
        }
        field(50004; "FA Class Code"; Code[10])
        {
            Caption = 'FA Class Code';
            TableRelation = "FA Class";
        }
        field(50005; "FA Subclass Code"; Code[10])
        {
            Caption = 'FA Subclass Code';
            TableRelation = "FA Subclass";
        }
        field(50006; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                /*
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                */
            end;
        }
        field(50007; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                /*
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
                */
            end;
        }
        field(50008; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(50009; "FA Location Code"; Code[10])
        {
            Caption = 'FA Location Code';
            TableRelation = "FA Location";
        }
        field(50010; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(50011; "Main Asset/Component"; Option)
        {
            Caption = 'Main Asset/Component';
            Editable = false;
            OptionCaption = ' ,Main Asset,Component';
            OptionMembers = " ","Main Asset",Component;
        }
        field(50012; "Component of Main Asset"; Code[20])
        {
            Caption = 'Component of Main Asset';
            Editable = false;
            TableRelation = "Fixed Asset";
        }
        field(50013; "Budgeted Asset"; Boolean)
        {
            Caption = 'Budgeted Asset';

            trigger OnValidate()
            begin
                /*
                FAMoveEntries.ChangeBudget(Rec);
                */
            end;
        }
        field(50014; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
        }
        field(50015; "Responsible Employee"; Code[20])
        {
            Caption = 'Responsible Employee';
            TableRelation = Employee;
        }
        field(50016; "Serial No."; Text[30])
        {
            Caption = 'Serial No.';

            trigger OnValidate()
            begin
                "Registration No." := "Serial No.";
                Modify();
            end;
        }
        field(50017; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50018; Insured; Boolean)
        {
            CalcFormula = exist("Ins. Coverage Ledger Entry" where("FA No." = field("No."),
                                                                    "Disposed FA" = const(false)));
            Caption = 'Insured';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; Comment; Boolean)
        {
            //  CalcFormula = exist("Comment Line" where ("Table Name"=const(Fixed field("No.")")";
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(50021; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50022; "Maintenance Vendor No."; Code[20])
        {
            Caption = 'Maintenance Vendor No.';
            TableRelation = Vendor;
        }
        field(50023; "Under Maintenance"; Boolean)
        {
            Caption = 'Under Maintenance';
        }
        field(50024; "Next Service Date"; Date)
        {
            Caption = 'Next Service Date';
        }
        field(50025; Inactive; Boolean)
        {
            Caption = 'Inactive';
        }
        field(50026; "FA Posting Date Filter"; Date)
        {
            Caption = 'FA Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(50027; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50028; "FA Posting Group"; Code[10])
        {
            Caption = 'FA Posting Group';
            TableRelation = "FA Posting Group";
        }
        field(50029; "Last Service Date"; Date)
        {
        }
        field(50030; "Service Interval"; Option)
        {
            OptionMembers = ,Hour,Day,Week,Month,Quarter,Year;
        }
        field(50031; "Service Interval Value"; Integer)
        {
        }
        field(50032; "Last Service No."; Code[10])
        {
        }
        field(50033; Type; Option)
        {
            OptionMembers = " ",Vehicle,Machinery;
        }
        field(50034; Make; Code[10])
        {
            TableRelation = "Flt Make".Code;
        }
        field(50035; Model; Code[10])
        {
            TableRelation = "FLT-Flt Model".Code;
        }
        field(50036; "Year Of Manufacture"; Integer)
        {
        }
        field(50037; "Country Of Origin"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(50038; "Start Reading"; Decimal)
        {
        }
        field(50039; Ownership; Option)
        {
            OptionMembers = " ","First Owner","Second Owner","Third Owner","Fourth Owner","Fifth Owner";
        }
        field(50040; "Chassis Serial No."; Code[50])
        {
        }
        field(50041; "Engine Serial No."; Code[50])
        {
        }
        field(50042; "Horse Power"; Integer)
        {
        }
        field(50043; "Ignition Key Code"; Code[10])
        {
        }
        field(50044; "Door Key Code"; Code[10])
        {
        }
        field(50045; "Body Color"; Code[10])
        {
        }
        field(50046; "Interior Color"; Code[10])
        {
        }
        field(50047; Cylinders; Integer)
        {
        }
        field(50048; "Wheel Size Rear"; Decimal)
        {
        }
        field(50049; "Wheel Size Front"; Decimal)
        {
        }
        field(50050; "Tire Size Rear"; Code[20])
        {
        }
        field(50051; "Tire Size Front"; Code[20])
        {
        }
        field(50052; "Fuel Type"; Option)
        {
            OptionMembers = " ",Petrol,Diesel,Hybrid;
        }
        field(50053; "Fuel Rating"; Decimal)
        {
        }
        field(50054; "Current Reading"; Decimal)
        {
        }
        field(50055; "Registration No."; Code[10])
        {
            NotBlank = true;
        }
        field(50056; "Readings Based On"; Option)
        {
            OptionMembers = " ",Hours,Mileage;
        }
        field(50057; "Total Consumption"; Decimal)
        {
            //  CalcFormula = sum("FA Ledger Entry".Amount where ("FA Posting Type"=filter(Custom field("No.")")";
            //   FieldClass = FlowField;
        }
        field(50058; "Tare Weight"; Decimal)
        {
        }
        field(50059; Available; Boolean)
        {
        }
        field(50060; "Gross Weight"; Decimal)
        {
        }
        field(50061; "Reason for Unavailability"; Option)
        {
            OptionMembers = " ",Maintenance,Out;
        }
        field(50062; Selected; Boolean)
        {
        }
        field(50063; "Selected By"; Code[20])
        {
        }
        field(50064; "Passenger Capacity"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Registration No.")
        {
            Clustered = true;
            SumIndexFields = "Start Reading", "Current Reading";
        }
    }

    fieldgroups
    {
    }

    var
        FA: Record "Fixed Asset";

    procedure CopyFields()
    begin
        /*
        FA.RESET;
        IF FA.GET("FA No.") THEN
          BEGIN
            "Maintenance Code":=FA.Description;
            Description:=FA."Search Description";
            "Last Service Date":=FA."Description 2";
            "Last Service Time":=FA."FA Class Code";
            "Service Interval Type":=FA."FA Subclass Code";
            "Service Interval Value":=FA."Global Dimension 1 Code";
            "Next Service Date":=FA."Global Dimension 2 Code";
            "Next Service Time":=FA."Location Code";
            Blocked:=FA."FA Location Code";
            "Vendor No.":=FA."Vendor No.";
            "Main Asset/Component":=FA."Main Asset/Component";
            "Component of Main Asset":=FA."Component of Main Asset";
            "Budgeted Asset":=FA."Budgeted Asset";
            "Responsible Employee":=FA."Responsible Employee";
            "Serial No.":=FA."Serial No.";
            "Last Date Modified":=FA."Last Date Modified";
            Blocked:=FA.Blocked;
            Picture:=FA.Picture;
            "Maintenance Vendor No.":=FA."Maintenance Vendor No.";
            "Under Maintenance":=FA."Under Maintenance";
            "Next Service Date":=FA."Next Service Date";
            Inactive:=FA.Inactive;
            "No. Series":=FA."No. Series";
            "FA Posting Group":=FA."FA Posting Group";
            "Last Service Date":=FA."Last Service Date";
            "Service Interval":=FA."Service Interval";
            "Service Interval Value":=FA."Service Interval Value";
            "Last Service No.":=FA."Last Service No.";
            Insured:=FA.Insured;
            Comment:=FA.Comment;
          END;
         */
        FA.Reset();
        FA.Get("No.");
        TransferFields(FA);
        //"Registration No.":=FA."Registration No";
    end;
}
