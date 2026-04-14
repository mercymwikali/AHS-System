Table 85552 "Responsibility Center BR"
{
    Caption = 'Responsibility Center';
    DrillDownPageId = "Responsibility Center List BR";
    LookupPageId = "Responsibility Center List BR";

    fields
    {
        field(50000; "Code"; Code[15])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(50001; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(50002; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(50003; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(50004; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(50005; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(50006; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50007; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50008; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50009; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(50010; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(50011; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(50012; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50013; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(50014; County; Text[30])
        {
            Caption = 'County';
        }
        field(50015; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50016; "Home Page"; Text[90])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(50017; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50018; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Contract Gain/Loss Entry".Amount where("Responsibility Center" = field(Code),
                                                                       "Change Date" = field("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Payment User(s) - E-Mail"; Text[250])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50020; "Notify Payment User(s)"; Boolean)
        {
        }
        field(50021; "HOD User ID"; Code[50])
        {
            TableRelation = User."User Name";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DimMgt.DeleteDefaultDim(Database::"Responsibility Center BR", Code);

        //Prevent deletion once entries exist
        TestNoEntriesExist(FieldCaption(Code));
    end;

    var
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::"Responsibility Center BR", Code, FieldNumber, ShortcutDimCode);
        Modify();
    end;

    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var

    begin
        //To prevent change of field
        /*
                ItemLedgEntry.SetCurrentkey(ItemLedgEntry."Responsibility Center");
                ItemLedgEntry.SetRange("Responsibility Center", Code);
                if ItemLedgEntry.Find('-') then
                    Error(
                      Text001,
                      CurrentFieldName);
                       */
    end;
}
