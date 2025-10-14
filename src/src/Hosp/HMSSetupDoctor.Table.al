table 52202628 "HMS Setup Doctor"
{
    DataCaptionFields = "Doctor ID", "Doctors Name";
    LookupPageID = "HMS Setup Doctor Lists";

    fields
    {
        field(1; "Doctor ID"; Code[20])
        {
            Description = 'Stores the reference to the user in the database';
            NotBlank = true;
            TableRelation = Vendor."No.";
        }
        field(2; "Doctors Name"; Text[30])
        {
            Description = 'Stores the reference to the doctor''s name in the database';
            NotBlank = true;
        }
        field(3; "Consultation Code"; Code[20])
        {
            TableRelation = "HMS Charges".Code;
        }
        field(4; "Commission Perc"; Decimal)
        {
        }
        field(5; Specialization; Code[20])

        {
            TableRelation = "HMS Clinics Setup".No;
        }
        field(6; Telephone; Text[30])
        {
        }
        field(7; "Proffesional Registration No."; Code[20])
        {
        }
        field(8; Resident; Boolean)
        {
        }
        field(9; "PIN No"; Text[30])
        {
        }
        field(10; Email; Text[30])
        {
        }
        field(11; Title; Text[30])
        {
        }
        field(12; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(13; "HDF%"; Decimal)
        {
        }
        field(14; "Insurance No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer."No.";
        }
        field(15; "Pending Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(16; "Completed Filter"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(17; "Open Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Doctor ID" = field("Doctor ID"),
                                                                          Claimed = const(false),
                                                                          Medicentre = const(false),
                                                                          Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(18; "Claimed Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Doctor ID" = field("Doctor ID"),
                                                                          Claimed = const(true),
                                                                          Medicentre = const(false),
                                                                          Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Consultation Code Cash"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(21; "IP Rate"; Decimal)
        {
        }
        field(22; "Surgical Rate"; Decimal)
        {
        }
        field(24; "Consultation Cash FirstTimer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(23; "Clinic"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "HMS Clinics Setup".No;
        }
        field(25; "Global Dimension Code 1"; Code[30])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(124; "Consultation Cash Review"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }

        field(125; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(126; "Category"; Code[30])
        {
            TableRelation = "Doctor Category Setup".Description where("Clinic Type" = field(Specialization));
        }
        field(127; "Consultation Floor No"; Code[20])
        {
            TableRelation = "Building Floor Setup"."Floor No.";
        }
        field(128; "Consultation Room No"; Code[20])
        {
            TableRelation = "Floor Room Setup"."Room No" where("Floor No" = field("Consultation Floor No"), Occupied = filter(false));
        }
        field(129; "Total OP"; Integer)
        {
            FieldClass = FlowField;
            // CalcFormula = count("HMS Treatment Form Header" where("Treatment Date" = field("Date Filter"), "Doctor ID" = field("Doctor ID"), Status = filter(TreatmentStatus::Completed)));
            CalcFormula = count("HMS Patient Charges" where("Doctor ID" = field("Doctor ID"), "Shortcut Dimension 3 Code" = filter('OP'), Date = field("Date Filter"), Posted = filter(true)));
        }    
        field(130; "Total IP"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field("Date Filter"),  "Transaction Type" = filter('BED'), "Admitting Doctor" = field("Doctor ID")));
        }
        field(131; "IP Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(134; "Discharge Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }


    }

    keys
    {
        key(Key1; "Doctor ID")
        {
            Clustered = true;
        }
        key(Key2; "Doctors Name", "Global Dimension 1 Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Doctors Name", "Doctor ID")
        {
        }
        fieldgroup(Brick; "Doctors Name", "Doctor ID", "Consultation Code")
        {
        }
    }
    trigger OnModify()
    var
        UserRec: Record "User Setup";
    begin

        if UserRec.get(Database.UserId) then begin
            if UserRec."Can Edit HMS Setups" = false then
                error('Please note that you dont have the rights to edit setups');
        end else
            error('Please note that you dont have the rights to edit setups');
    end;
}
