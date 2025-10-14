Table 52202911 "HMS Laboratory Results Entry"
{
    DrillDownPageID = "HMS Cue";
    LookupPageID = "HMS Cue";

    fields
    {
        field(1; "Laboratory No."; Code[20])
        {
            NotBlank = true;
        }
        field(4; "Laboratory Test Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;

            trigger OnValidate()
            begin
                //hmsHospital.InsertPatientLabCharges("Laboratory No.","Laboratory Test Code");
            end;
        }
        field(5; "Laboratory Test Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(6; "Specimen Code"; Code[20])
        {
            TableRelation = "HMS Setup Specimen".Code;

            trigger OnValidate()
            begin
                LabParam.SetRange(LabParam."Laboratory Test Code", "Laboratory Test Code");
                LabParam.SetRange(LabParam."Specimen Code", "Specimen Code");
                if LabParam.Find('-') then
                    "Sort Test" := LabParam.Arrangement;
            end;
        }
        field(7; "Specimen Name"; Text[100])
        {
            CalcFormula = lookup("HMS Lab Parameters setup"."Specimen Name" where("Specimen Code" = field("Specimen Code")));
            FieldClass = FlowField;
        }
        field(8; "Assigned User ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(9; "Collection Date"; Date)
        {
        }
        field(10; "Collection Time"; Time)
        {
        }
        field(11; "Measuring Unit Code"; Text[30])
        {
            CalcFormula = lookup("HMS Lab Parameters setup"."Measuring Unit Code" where("Specimen Code" = field("Specimen Code"),
                                                                                         "Laboratory Test Code" = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(12; "Measuring Unit Name"; Text[30])
        {
            CalcFormula = lookup("HMS Lab Parameters setup"."Measuring Unit Name" where("Specimen Code" = field("Specimen Code"),
                                                                                         "Laboratory Test Code" = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(13; Results; Decimal)
        {
            

            trigger OnValidate()
            begin
                //  IF HMSPat.GET("Laboratory No.") THEN BEGIN
                //    IF HMSPat."Date Of Birth"<>0D THEN
                //    BEGIN
                //      Age:=HRDates.DetermineAge_Years(HMSPat."Date Of Birth",TODAY);
                //      IF(EVALUATE(AgeInt, Age)) THEN BEGIN
                //        //Flag Values
                //        LabParam.SETRANGE(LabParam."Laboratory Test Code","Laboratory Test Code");
                //        LabParam.SETRANGE(LabParam."Specimen Code" ,"Specimen Code");
                //        IF LabParam.FIND('-') THEN BEGIN
                //           IF((AgeInt>=0) AND (AgeInt<=5)) THEN BEGIN
                //             Flag:=Flag::Normal;
                //             IF Results<LabParam."Min 0 Years-5 Years" THEN Flag:=Flag::Low;
                //             IF Results>LabParam."Max 0 Years-5 Years" THEN Flag:=Flag::High;
                //
                //            //Critical values
                //             IF Results>0 THEN BEGIN
                //               IF (LabParam."C LOW 0-5 Years">0) AND (LabParam."C HIGH 0-5 Years">0) THEN BEGIN
                //                 IF Results<LabParam."C LOW 0-5 Years" THEN "Critical Value":="Critical Value"::"Critical Low";
                //                 IF Results>LabParam."C HIGH 0-5 Years" THEN "Critical Value":="Critical Value"::"Critical High";
                //
                //               IF (Results>=LabParam."C LOW 0-5 Years") AND (Results<LabParam."Min 0 Years-5 Years") THEN
                //               "Critical Value":="Critical Value"::"Critical Normal";
                //
                //               IF (Results>LabParam."Max 0 Years-5 Years") AND (Results<=LabParam."C HIGH 0-5 Years") THEN
                //               "Critical Value":="Critical Value"::"Critical Normal";
                //             END;
                //            END;
                //           END;//END Age 0-5
                //           IF((AgeInt>=6) AND (AgeInt<=18)) THEN BEGIN
                //
                //             Flag:=Flag::Normal;
                //             //------------MALE-----------------
                //             IF HMSPat.Gender=HMSPat.Gender::Male THEN BEGIN
                //                 IF Results<LabParam."Min 6 Years - 18 Years Male" THEN Flag:=Flag::Low;
                //                 IF Results>LabParam."Max 6 Years - 18 Years Female" THEN Flag:=Flag::High;
                //
                //                //Critical values Male 6 -18
                //                 IF Results>0 THEN BEGIN
                //                   IF (LabParam."C LOW 6-18 Years Male">0) AND (LabParam."C HIGH 6-18 Years Male">0) THEN BEGIN
                //                     IF Results<LabParam."C LOW 6-18 Years Male" THEN "Critical Value":="Critical Value"::"Critical Low";
                //                     IF Results>LabParam."C HIGH 6-18 Years Male" THEN "Critical Value":="Critical Value"::"Critical High";
                //
                //                   IF (Results>=LabParam."C LOW 6-18 Years Male") AND (Results<LabParam."Min 6 Years - 18 Years Male") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //
                //                   IF (Results>LabParam."Max 6 Years - 18 Years Male") AND (Results<=LabParam."C HIGH 6-18 Years Male") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //                 END;
                //              END;
                //            END;//End Male- 6-18
                //             //------------FEMALE-----------------
                //            IF HMSPat.Gender=HMSPat.Gender::Female THEN BEGIN
                //                 IF Results<LabParam."Min 6 Years - 18 Years Female" THEN Flag:=Flag::Low;
                //                 IF Results>LabParam."Max 6 Years - 18 Years Female" THEN Flag:=Flag::High;
                //
                //                //Critical values Female 6 -18
                //                 IF Results>0 THEN BEGIN
                //                   IF (LabParam."C LOW 6-18 Years Female">0) AND (LabParam."C HIGH 6-18 Years Female">0) THEN BEGIN
                //                     IF Results<LabParam."C LOW 6-18 Years Female" THEN "Critical Value":="Critical Value"::"Critical Low";
                //                     IF Results>LabParam."C HIGH 6-18 Years Female" THEN "Critical Value":="Critical Value"::"Critical High";
                //
                //                   IF (Results>=LabParam."C LOW 6-18 Years Female") AND (Results<LabParam."Min 6 Years - 18 Years Female") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //
                //                   IF (Results>LabParam."Max 6 Years - 18 Years Female") AND (Results<=LabParam."C HIGH 6-18 Years Female") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //                 END;
                //              END;
                //            END;//End Female- 6-18
                //          END;//EndAge 6-18
                //          IF(AgeInt>18) THEN BEGIN//Adults
                //
                //             Flag:=Flag::Normal;
                //             //------------MALE-----------------
                //             IF HMSPat.Gender=HMSPat.Gender::Male THEN BEGIN
                //                 IF Results<LabParam."Min Adult Male" THEN Flag:=Flag::Low;
                //                 IF Results>LabParam."Max Adult Male" THEN Flag:=Flag::High;
                //
                //                //Critical values Male Adult
                //                 IF Results>0 THEN BEGIN
                //                   IF (LabParam."C LOW Adult Male">0) AND (LabParam."C HIGH Adult Male">0) THEN BEGIN
                //                     IF Results<LabParam."C LOW Adult Male" THEN "Critical Value":="Critical Value"::"Critical Low";
                //                     IF Results>LabParam."C HIGH Adult Male" THEN "Critical Value":="Critical Value"::"Critical High";
                //
                //                   IF (Results>=LabParam."C LOW Adult Male") AND (Results<LabParam."Min Adult Male") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //
                //                   IF (Results>LabParam."Max Adult Male") AND (Results<=LabParam."C HIGH Adult Male") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //                 END;
                //              END;
                //            END;//End Male-Adults
                //             //------------FEMALE-----------------
                //            IF HMSPat.Gender=HMSPat.Gender::Female THEN BEGIN
                //                 IF Results<LabParam."Min Adult Female" THEN Flag:=Flag::Low;
                //                 IF Results>LabParam."Max Adult Female" THEN Flag:=Flag::High;
                //
                //                //Critical values Female 6 -18
                //                 IF Results>0 THEN BEGIN
                //                   IF (LabParam."C LOW Adult Female">0) AND (LabParam."C HIGH Adult Female">0) THEN BEGIN
                //                     IF Results<LabParam."C LOW Adult Female" THEN "Critical Value":="Critical Value"::"Critical Low";
                //                     IF Results>LabParam."C HIGH Adult Female" THEN "Critical Value":="Critical Value"::"Critical High";
                //
                //                   IF (Results>=LabParam."C LOW Adult Female") AND (Results<LabParam."Min Adult Female") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //
                //                   IF (Results>LabParam."Max Adult Female") AND (Results<=LabParam."C HIGH Adult Female") THEN
                //                   "Critical Value":="Critical Value"::"Critical Normal";
                //                 END;
                //              END;
                //            END;//End Female-Adults
                //          END;//End Age Adults
                //        END;//EndLab Params
                //      END;//EndEVALUATE Age
                //    END;//EndDOB
                //  END;//GET Patient

                LabParam.SetRange(LabParam."Laboratory Test Code", "Laboratory Test Code");
                LabParam.SetRange(LabParam."Specimen Code", "Specimen Code");
                if LabParam.Find('-') then begin

                    Flag := Flag::Normal;
                    if Results < LabParam."Min Range" then
                        Flag := Flag::Low;
                    if Results > LabParam."Max Range" then
                        Flag := Flag::High;

                    //Critical values
                    if Results > 0 then
                        if (LabParam."Critical Value Low" > 0) and (LabParam."Critical Value High" > 0) then begin
                            if Results < LabParam."Critical Value Low" then
                                "Critical Value" := "critical value"::"Critical Low";
                            if Results > LabParam."Critical Value High" then
                                "Critical Value" := "critical value"::"Critical High";
                        end;

                    /* LabParam.SetRange(LabParam."Laboratory Test Code", "Laboratory Test Code");
                    LabParam.SetRange(LabParam."Specimen Code", "Specimen Code");
                    if LabParam.Find('-') then
                        "Sort Test" := LabParam.Arrangement; */
                end;
            end;
        }
        field(14; Remarks; Text[2000]) //TODO: Add Remarks field Length?
        {
            /* trigger OnValidate()
            begin
                LabParam.SetRange(LabParam."Laboratory Test Code", "Laboratory Test Code");
                LabParam.SetRange(LabParam."Specimen Code", "Specimen Code");
                if LabParam.Find('-') then
                    "Sort Test" := LabParam.Arrangement;
            end; */
        }
        field(15; Completed; Boolean)
        {
        }
        field(16; Positive; Boolean)
        {
        }
        field(17; "Test Normal Ranges"; Text[100])
        {
            CalcFormula = lookup("HMS Lab Parameters setup"."Test Normal Ranges" where("Laboratory Test Code" = field("Laboratory Test Code"),
                                                                                        "Specimen Code" = field("Specimen Code")));
            FieldClass = FlowField;
        }
        field(18; "Test Units"; Text[100])
        {
            FieldClass = Normal;
        }
        field(19; Flag; Option)
        {
            OptionCaption = ' ,Normal,High,Low';
            OptionMembers = " ",Normal,High,Low;
        }
        field(20; Reactive; Option)
        {
            OptionCaption = ',Reactive,Non-Reactive';
            OptionMembers = ,Reactive,"Non-Reactive";
        }
        field(21; "Normal Range"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Sort Test"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Lab Test  Date"; Date)
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Laboratory Date" where("Laboratory No." = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(24; "Reviewed By"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(25; "Reveiw Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Review Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Critical Value"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Critical Low,Critical Normal,Critical High';
            OptionMembers = " ","Critical Low","Critical Normal","Critical High";
        }
        field(28; "Critical Ranges"; Text[50])
        {
            CalcFormula = lookup("HMS Lab Parameters setup"."Critical Ranges" where("Laboratory Test Code" = field("Laboratory Test Code"),
                                                                                     "Specimen Code" = field("Specimen Code")));
            FieldClass = FlowField;
        }
        field(29; "Lab Unique No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Result Type"; Enum "Lab Result Types")
        {
        }
        field(31; "Narration Results"; Blob)
        {
            
        }
        
        field(32; "Staff No"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
            trigger OnValidate()
            var
                HREmployee: Record "HR-Employee";
            begin
                "Staff Name" := HREmployee."First Name" + ' ' + HREmployee."Last Name";
            end;
        }
        field(33; "Staff Name"; Text[150])
        {
            
        }
        
        //Staff No
    }

    keys
    {
        key(Key1; "Laboratory No.", "Laboratory Test Code", "Specimen Code")
        {
            Clustered = true;
        }
        key(Key2; "Laboratory No.", "Laboratory Test Code", "Sort Test", "Specimen Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LabParam: Record "HMS Lab Parameters setup";
}
