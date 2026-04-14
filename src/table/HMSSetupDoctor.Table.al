table 85247 "HMS Setup Doctor"
{
    DataCaptionFields = "Doctor ID", "Doctors Name";
    LookupPageID = "HMS Setup Doctor Lists";

    fields
    {
        field(50000; "Doctor ID"; Code[20])
        {
            Description = 'Stores the reference to the user in the database';
            NotBlank = true;
            TableRelation = Vendor."No.";
        }
        field(50001; "Doctors Name"; Text[30])
        {
            Description = 'Stores the reference to the doctor''s name in the database';
            NotBlank = true;
        }
        field(50002; "Consultation Code"; Code[20])
        {
            TableRelation = "HMS Charges".Code;
        }
        field(50003; "Commission Perc"; Decimal)
        {
        }
        field(50004; Specialization; Code[20])

        {
            TableRelation = "HMS Clinics Setup".No;
        }
        field(50005; Telephone; Text[30])
        {
        }
        field(50006; "Proffesional Registration No."; Code[20])
        {
        }
        field(50007; Resident; Boolean)
        {
        }
        field(50008; "PIN No"; Text[30])
        {
        }
        field(50009; Email; Text[30])
        {
        }
        field(50010; Title; Text[30])
        {
        }
        field(50011; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50012; "HDF%"; Decimal)
        {
        }
        field(50013; "Insurance No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer."No.";
        }
        field(50014; "Pending Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50015; "Completed Filter"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(50016; "Open Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Doctor ID" = field("Doctor ID"),
                                                                          Claimed = const(false),
                                                                          Medicentre = const(false),
                                                                          Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50017; "Claimed Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Doctor ID" = field("Doctor ID"),
                                                                          Claimed = const(true),
                                                                          Medicentre = const(false),
                                                                          Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50018; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50019; "Consultation Code Cash"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50020; "IP Rate"; Decimal)
        {
        }
        field(50021; "Surgical Rate"; Decimal)
        {
        }
        field(50023; "Consultation Cash FirstTimer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }
        field(50022; "Clinic"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "HMS Clinics Setup".No;
        }
        field(50024; "Global Dimension Code 1"; Code[30])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50025; "Consultation Cash Review"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;
        }

        field(50026; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50027; "Category"; Code[30])
        {
            TableRelation = "Doctor Category Setup".Description where("Clinic Type" = field(Specialization));
        }
        field(50028; "Consultation Floor No"; Code[20])
        {
            TableRelation = "Building Floor Setup"."Floor No.";
        }
        field(50029; "Consultation Room No"; Code[20])
        {
            TableRelation = "Floor Room Setup"."Room No" where("Floor No" = field("Consultation Floor No"), Occupied = filter(false));
        }
        field(50030; "Total OP"; Integer)
        {
            FieldClass = FlowField;
            // CalcFormula = count("HMS Treatment Form Header" where("Treatment Date" = field("Date Filter"), "Doctor ID" = field("Doctor ID"), Status = filter(TreatmentStatus::Completed)));
            CalcFormula = count("HMS Patient Charges" where("Doctor ID" = field("Doctor ID"), "Shortcut Dimension 3 Code" = filter('OP'), Date = field("Date Filter"), Posted = filter(true)));
        }    
        field(50031; "Total IP"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Patient Charges" where(Date = field("Date Filter"),  "Transaction Type" = filter('BED'), "Admitting Doctor" = field("Doctor ID")));
        }
        field(50032; "IP Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50033; "Discharge Date Filter"; Date)
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
