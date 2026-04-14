table 85219 "HMS Pharmacy Header"
{
    DrillDownPageID = "HMS Pharmacy List";
    LookupPageID = "HMS Pharmacy List";

    fields
    {
        field(50000; "Pharmacy No."; Code[20])
        {
        }
        field(50001; "Pharmacy Date"; Date)
        {
        }
        field(50002; "Pharmacy Time"; Time)
        {
        }
        field(50003; "Request Area"; Option)
        {
            OptionCaption = 'Doctor,Admissions,Walkin';
            OptionMembers = Doctor,Admissions,Walkin;
        }
        field(50004; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50005; "Student No."; Code[20])
        {
        }
        field(50006; "Employee No."; Code[20])
        {
        }
        field(50007; "Relative No."; Integer)
        {
        }
        field(50008; "Bill To Customer No."; Code[20])
        {
        }
        field(50009; "Issued By"; Code[50])
        {
            trigger OnValidate()
            begin
                // REFACTOR: Not using User setup to differentiate users. Modify to use Hr-Employee No.
                // "Issued By" := UserId;
                // "User Id" := UserId;
            end;
        }
        field(50010; "Link Type"; Code[20])
        {
        }
        field(50011; "Link No."; Code[20])
        {

        }
        field(50012; Status; Option)
        {
            OptionMembers = New,Completed,Cancelled,Paid,Forwarded;
        }
        field(50013; "No. Series"; Code[20])
        {
        }
        field(50014; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50015; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50016; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50017; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50018; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50019; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50020; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50021; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50022; "Total Price"; Decimal)
        {
            CalcFormula = sum("HMS Pharmacy Line"."Total Price" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(50023; "Insurance No"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50048; "Insurance No1"; Code[20])
        {
            CalcFormula = Lookup("HMS Patient"."Insurance No." where("Patient No." = field("Patient No."), "Patient Type" = filter(Corporate)));
            FieldClass = FlowField;
        }
        field(50024; "Ref No"; Code[20])
        {
        }
        field(50025; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ',Corporate,Cash';
            OptionMembers = ,Corporate,Cash;

            trigger OnValidate()
            begin
                /* "Patient Ref. No.":='';
                 "Depandant Principle Member":='';
                 "Student No.":='';
                 "Employee No.":='';
                 "Relative No.":=0;
                 Title:='';
                 Surname:='';
                 "Middle Name":='';
                 "Last Name":='';
                 Gender:=Gender::" ";
                 "Date Of Birth":=0D;
                // "Marital Status":="Marital Status"::"";
                 "ID Number":='';
                 "Correspondence Address 1":='';
                 "Correspondence Address 2":='';
                 "Correspondence Address 3":='';
                 "Telephone No. 1":='';
                 "Telephone No. 2":='';
                 Email:='';
                 "Fax No.":='';
                        */
            end;
        }
        field(50026; "Cash Sale"; Boolean)
        {
        }
        field(50027; "Receipt Count"; Integer)
        {
            CalcFormula = Count("Receipts Header" where("Patient No." = field("Patient No."),
                                                         Posted = const(true)));
            FieldClass = FlowField;
        }
        field(50028; "ADM No"; Code[20])
        {
            // CalcFormula = lookup("HMS Patient"."Adm No." where("Patient No." = field("Patient No.")));
            // FieldClass = FlowField;
        }
        field(50029; "Search Name"; Text[200])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50030; "Treatment No."; Code[20])
        {
        }
        field(50031; "Transaction Type"; Code[20])
        {
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(50032; "Issuing Location"; Code[20])
        {
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                if "Issuing Location" <> '' then begin
                    Pharmline.Reset();
                    Pharmline.SetRange(Pharmline."Pharmacy No.", "Pharmacy No.");
                    if Pharmline.Find('-') then
                        repeat
                            Pharmline.Validate(Quantity);

                            Pharmline.Location := "Issuing Location";
                            Pharmline.Validate(Location);
                            Pharmline.Modify();
                        until Pharmline.Next() = 0;
                end;
            end;
        }
        field(50033; Remarks; Text[200])
        {
        }
        field(50034; "Insurance Amount"; Decimal)
        {
            CalcFormula = sum("HMS Pharmacy Line"."Insurance Total Amount" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(50035; "User Id"; Code[100])
        {
        }
        field(50036; "Doctor Name"; Text[50])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(50037; "Doctor ID"; Code[50])
        {
            /* CalcFormula = lookup("HMS Treatment Form Header"."Doctor ID" where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField; */
        }
        field(50038; Age; Integer)
        {
            CalcFormula = lookup("HMS Patient"."Age in Years" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50039; "Visit Total"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                  "Visit No" = field("Link No."),
                                                                  "Transaction Type" = filter(<> 'ZRECEIPT')));
            FieldClass = FlowField;
        }
        field(50040; "Total Receipts"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                  "Visit No" = field("Link No."),
                                                                  "Transaction Type" = filter('ZRECEIPT')));
            FieldClass = FlowField;
        }
        field(50041; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50042; "Membership No"; Code[30])
        {
            CalcFormula = lookup("HMS Patient"."Membership No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50043; "Global Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if "Global Dimension 1 Code" <> '' then begin
                    DimensionValue.Reset();
                    DimensionValue.SetRange(Code, "Global Dimension 1 Code");
                    if DimensionValue.FindFirst() then begin
                        "Issuing Location" := DimensionValue."Default Pharmacy Location";
                        Validate("Issuing Location");
                    end
                end;
            end;
        }
        field(50044; Receptionist; Code[40])
        {
            CalcFormula = lookup("HMS Appointment Form Header"."User ID" where("Appointment No." = field("Link No.")));
            FieldClass = FlowField;
        }
        field(50045; "Pharmacy Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Outpatient,Inpatient,Discharge';
            OptionMembers = ,Outpatient,Inpatient,Discharge;
        }
        field(50046; "InPatient"; Boolean)
        {
            // CalcFormula = lookup("HMS Patient".Inpatient where("Patient No." = field("Patient No.")));
            // FieldClass = FlowField;
        }
        field(50047; "Walkin"; Boolean)
        {
            CalcFormula = lookup("HMS Patient"."Walk-in" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField; // TODO: Get More Info on how to handle walk in patient
        }
        field(50049; "pharm count Walkin Cash"; Integer)
        {
            CalcFormula = Count("HMS Pharmacy Header" where("Pharmacy Date" = field("Date Filter"), "Cash Sale" = filter(true), "Patient Type" = filter(Cash), Walkin = filter(true)));
            FieldClass = FlowField;
        }
        field(50050; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50051; "Insurance code"; Code[20])
        {
            CalcFormula = Lookup("HMS Patient"."Insurance No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50052; "pharm count Walkin Normal"; Integer)
        {
            CalcFormula = Count("HMS Pharmacy Header" where("Pharmacy Date" = field("Date Filter"), "Cash Sale" = filter(true), "Patient Type" = filter(Cash), Walkin = filter(true)));
            FieldClass = FlowField;
        }
        field(50053; "Capitation Amount"; Decimal)
        {
            CalcFormula = Sum("HMS Pharmacy Line"."Capitation Amount" where("Pharmacy No." = field("Pharmacy No.")));
            FieldClass = FlowField;
        }
        field(50054; "Charged"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Pharmacy No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Issued By" = '' then begin
            "Issued By" := UserId();
            "User Id" := UserId();
        end;
        UserRec.Reset();
        UserRec.SetRange(UserRec."User ID", "User Id");
        if UserRec.Find('-') then begin

            if UserRec."Can Delete Pharmacy" = false then
                Error('Please note that you do not have the rights to delete pharmacy window')
        end else
            Error('Please note that you do not have the rights to delete pharmacy window');
    end;

    trigger OnInsert()
    begin
        if "Pharmacy No." = '' then begin
            HMSSetup.Reset();
            HMSSetup.Get();
            "Pharmacy No." := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);
        end;

        if "Issued By" = '' then begin
            "Issued By" := UserId();
            "User Id" := UserId();
        end;

        if "Issuing Location" = '' then
            "Issuing Location" := 'WESTLANDS';
    end;

    trigger OnModify()
    begin
        if "Issued By" = '' then begin
            "Issued By" := UserId();
            "User Id" := UserId();
        end;
    end;

    var
        Pharmline: Record "HMS Pharmacy Line";
        HMSSetup: Record "HMS Setup";
        UserRec: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    var
        PatientName: Text[100];
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
        PharmHeader: Record "HMS Pharmacy Header";
        Patient: Record "HMS Patient";
        TreatmentLine: Record "HMS Treatment Form Drug";
        ValueEntry: Record "Value Entry";
        HMSPatientsCharges: Record "HMS Patient Charges";
        objItem: Record Item;
        AppH: Record "HMS Appointment Form Header";
        PatientCharge: Record "HMS Patient Charges";
        HMSCU: Codeunit "HMS Patient-integration";
        InventorySetup: Record "Inventory Setup";
        HMSPat: Record "HMS Patient";
        "Total Bill": Decimal;
        ObjTracking: Record "HMS Item Tracking Buffer";
        LNNO: Integer;
    //
    procedure CheckSuffientStock()
    var
        ok: Boolean;
    begin

        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", "Pharmacy No.");
        if PharmLine.Find('-') then
            repeat
                if PharmLine."No." <> '' then
                    // PharmLine.CALCFIELDS("Actual Qty");
                    if PharmLine.Quantity > PharmLine."Actual Qty" then begin
                        InventorySetup.Get();
                        if InventorySetup."Prevent Negative Inventory" = true then
                            Error('Item %1 is out of stock', PharmLine."No.");
                    end;
            until PharmLine.Next() = 0;
    end;

    procedure CheckLotSizeallocation();
    var
        qtotal: Decimal;
    begin
        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", "Pharmacy No.");
        if PharmLine.Find('-') then begin
            repeat
                if objItem.Get(PharmLine."No.") then
                    if objItem."Item Tracking Code" <> '' then begin
                        qtotal := 0;
                        ObjTracking.Reset();
                        ObjTracking.SetRange(ObjTracking."Pharmacy No", PharmLine."Pharmacy No.");
                        ObjTracking.SetRange(ObjTracking."Item No", PharmLine."No.");
                        ObjTracking.SetRange(ObjTracking."Location Code", PharmLine.Location);
                        if ObjTracking.Find('-') then begin
                            repeat
                                if ObjTracking."Lot No" = '' THEN ObjTracking.Delete(); // ERROR('Item ' + ObjTracking.Description + '  does not have a lot no in one of the tracking lines');
                                if ObjTracking.Quantity <= 0 then Error('Item ' + ObjTracking.Description + '  does not have a quantity in one of the tracking lines');
                                qtotal := qtotal + ObjTracking.Quantity;
                                if qtotal > PharmLine.Quantity then Error('Total Quantity in the tracking lines cannot be more than the quantity issued for drug' + ObjTracking.Description);
                            until ObjTracking.Next = 0;
                        end;
                        if qtotal <> PharmLine.Quantity then Error('Total Quantity in the tracking lines must be equal to the quantity issued for drug' + PharmLine."Drug Name");

                    end;

            until PharmLine.Next = 0;
        end;
    end;
    //
    procedure PostItems(PharmacyNo: Code[20])
    var
        Cust: Record Customer;
    begin

        PharmHeader.Get("Pharmacy No.");
        Patient.Get(PharmHeader."Patient No.");
        if "Cash Sale" = true then begin
            Patient.CalcFields(Patient."Bill Balance");
            PharmHeader.CalcFields("Receipt Count");

            // if Patient."Bill Balance" > 0 then Error('Please note that the selected Record has not been receipted');
        end;

        HMSSetup.Reset();
        HMSSetup.Get();



        if Cust.Get(Patient."Insurance No.") then;

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then ItemJnlLine.DeleteAll();

        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", PharmHeader."Pharmacy No.");
        //PharmLine.SetRange(PharmLine."Item Journal", false);
        if PharmLine.Find('-') then begin
            repeat
                Pharmline.TestField("Unit Price");
                PharmLine.TestField(PharmLine.Location);
                objItem.Reset();
                objItem.SetRange(objItem."No.", PharmLine."No.");
                //objItem.SetRange(objItem."Item Tracking Code", '');
                if objItem.Find('-') then begin

                    LineNo := LineNo + 1000;
                    ItemJnlLine.Init();
                    ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                    ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                    ItemJnlLine."Line No." := LineNo;
                    ItemJnlLine."Posting Date" := Today;
                    ItemJnlLine."Document No." := "Pharmacy No.";
                    ItemJnlLine."Item No." := PharmLine."No.";
                    ItemJnlLine.Validate(ItemJnlLine."Item No.");
                  //  ItemJnlLine."Location Code" := PharmLine.Location;
                 //   ItemJnlLine.Validate(ItemJnlLine."Location Code");
                    ItemJnlLine.Quantity := PharmLine.Quantity;
                    ItemJnlLine.Validate(ItemJnlLine.Quantity);
                    ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                    ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                    ItemJnlLine."Gen. Prod. Posting Group" := objItem."Gen. Prod. Posting Group";
                    // ItemJnlLine."Gen. Bus. Posting Group" := 
                    if (Cust."NHIF Capitation" = true) then begin
                        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                        ItemJnlLine."Unit Amount" := PharmLine."Unit Cost";
                    end else begin
                        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Sale;
                        ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                    end;
                    ItemJnlLine.Validate("Unit Amount");
                    ItemJnlLine."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                //    ItemJnlLine."Shortcut Dimension 2 Code" := 'PHARMACY';
                    ItemJnlLine.Validate(ItemJnlLine."Unit Amount");
               //     ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                 //   ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                    ItemJnlLine."External Document No." := "Pharmacy No.";
                    ItemJnlLine."Source No." := Patient."Patient No.";
                    ItemJnlLine.Insert();

                    LineNo := ItemJnlLine."Line No.";

                end else begin

                    ObjTracking.Reset();
                    ObjTracking.SetRange(ObjTracking."Pharmacy No", PharmLine."Pharmacy No.");
                    ObjTracking.SetRange(ObjTracking."Item No", PharmLine."No.");
                    ObjTracking.SetRange(ObjTracking."Location Code", PharmLine.Location);
                    if ObjTracking.Find('-') then
                        repeat
                            ItemJnlLine.Reset();
                            if ItemJnlLine.FindLast() then begin
                                LNNO := LNNO + 1000;
                                LineNo := ItemJnlLine."Line No.";
                            end;

                            ItemJnlLine.Init();
                            ItemJnlLine."Line No." := LineNo + 1000;
                            ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                            ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                            ItemJnlLine."Posting Date" := TODAY;
                            // ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Sale;
                            ItemJnlLine."Document No." := "Pharmacy No.";
                            ItemJnlLine."Item No." := PharmLine."No.";
                            ItemJnlLine.Validate(ItemJnlLine."Item No.");
                            ItemJnlLine."Location Code" := PharmLine.Location;
                         //   ItemJnlLine.Validate(ItemJnlLine."Location Code");
                            ItemJnlLine.Quantity := ObjTracking.Quantity;
                            ItemJnlLine.Validate(Quantity);
                            ItemJnlLine."Lot No." := ObjTracking."Lot No";
                            ItemJnlLine."Expiration Date" := ObjTracking."Expiration Date";
                            ItemJnlLine."Serial No." := ObjTracking."Serial No";
                            ItemJnlLine."Job No." := PharmLine."No." + Format(ObjTracking."Line No");
                            ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                            ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                            if (Cust."NHIF Capitation" = true) then begin
                                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                                ItemJnlLine."Unit Amount" := PharmLine."Unit Cost";
                            end else begin
                                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Sale;
                                ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                            end;
                            ItemJnlLine."External Document No." := PharmLine."Pharmacy No.";
                            ItemJnlLine."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                            ItemJnlLine."Source No." := Patient."Patient No.";
                        //    ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                        //    ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                            // ItemJnlLine."Pharmacy No" := PharmLine."Pharmacy No.";
                            ItemJnlLine.Insert();
                            ItemJnlLine."Line No." := LineNo;
                        until ObjTracking.Next() = 0;
                end;




                PharmLine.Remaining := PharmLine.Remaining - PharmLine.Quantity;
                PharmLine."Item Journal" := true;
                PharmLine.Modify();
                LineNo := LineNo + 1000;
                /*Update the treatment lines*/
                TreatmentLine.Reset();
                TreatmentLine.SetRange(TreatmentLine."Treatment No.", PharmHeader."Treatment No.");
                TreatmentLine.SetRange(TreatmentLine."Drug No.", PharmLine."No.");
                if TreatmentLine.Find('-') then begin
                    TreatmentLine.Issued := true;
                    TreatmentLine.Status := TreatmentLine.Status::Completed;
                    TreatmentLine.Modify();
                end;

                //---------------------------------------
                objItem.Reset();
                objItem.SetRange(objItem."No.", PharmLine."No.");
                if objItem.Find('-') then begin
                    // objItem."Unit Price" := PharmLine."Unit Price";

                    objItem.Dosage := TreatmentLine.Dosage;
                    objItem.Take := TreatmentLine.Take;
                    objItem."Number of Days" := TreatmentLine."Number of Days";
                    objItem.Frequency := TreatmentLine.Frequency;
                    objItem.Modify();


                end;
            until PharmLine.Next() = 0;
            ItemJnlLine.Reset();
            ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            ItemJnlLine.SetRange(ItemJnlLine."Document No.", "Pharmacy No.");
            if ItemJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
            // PharmHeader.Get("Pharmacy No.");
            // PharmHeader.Status := Status::Completed;
            // PharmHeader.Modify();

        end;
    end;
    //
    procedure ChargePatient()
    begin
        //IF "Cash Sale"=FALSE THEN  BEGIN
        HMSPatientsCharges.Reset();
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", "Patient No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Link No", "Pharmacy No.");
        HMSPatientsCharges.SetRange(Posted, false);
        if HMSPatientsCharges.Find('-') then HMSPatientsCharges.DeleteAll();

        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", "Pharmacy No.");
        // PharmLine.SetRange(Posted, false);
        if PharmLine.Find('-') then
            repeat
                Patient.SetRange(Patient."Patient No.", "Patient No.");
                if Patient.Find('-') then
                    // BEGIN
                    if HMSPatientsCharges.InPatient then
                        HMSPatientsCharges."Admission No" := Patient."Current Adm No";

                HMSPatientsCharges."Visit No" := Patient."Active Visit No";
                // END;
                PharmHeader.Get("Pharmacy No.");
                HMSPatientsCharges.Init();
                HMSPatientsCharges."Line No" := PharmLine."line no";
                HMSPatientsCharges."Patient No." := "Patient No.";
                HMSPatientsCharges."Transaction Type" := "Transaction Type";
                HMSPatientsCharges.Validate("Transaction Type");
                HMSPatientsCharges."Link No" := "Pharmacy No.";
                HMSPatientsCharges."Treatment No." := "Link No.";
                HMSPatientsCharges."Appointment No." := "Link No.";
                HMSPatientsCharges.Code := PharmLine."No.";
                HMSPatientsCharges."Charge Type" := HMSPatientsCharges."Charge Type"::Item;
                HMSPatientsCharges.Validate(Code);
                PharmLine.CalcFields(PharmLine."Drug Name");
                HMSPatientsCharges.Description := PharmLine."Drug Name";
                if PharmLine."Unit Price" = 0 then Error('Kindly enter the issued price');
                HMSPatientsCharges.Amount := PharmLine."Unit Price";
                HMSPatientsCharges.Validate(Amount);
                HMSPatientsCharges.Quantity := PharmLine.Quantity;
                HMSPatientsCharges.Validate(Quantity);
                HMSPatientsCharges.Date := PharmHeader."Pharmacy Date";
                HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Pharmacy;
                HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                HMSPatientsCharges."Pharmacy No" := "Pharmacy No.";
                HMSPatientsCharges."Location Code" := PharmHeader."Issuing Location";
                if Patient.Inpatient then
                    HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY'
                else
                    HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY';
                HMSPatientsCharges.Closed := false;
                HMSPatientsCharges.Insert();
                PharmLine.Posted := true;
                PharmLine.Modify();
            until PharmLine.Next = 0;
        Status := Status::Completed;
        Modify();
    end;
}
