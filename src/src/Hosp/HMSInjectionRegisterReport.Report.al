Report 52202460 "HMS Injection Register Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSInjectionRegisterReport.rdl';

    dataset
    {
        dataitem("HMS Treatment Form Injection"; "HMS Treatment Form Injection")
        {
            column(ReportForNavId_3772; 3772)
            {
            }
            column(Injection_18_; Injection[18])
            {
            }
            column(Injection_15_; Injection[15])
            {
            }
            column(Injection_16_; Injection[16])
            {
            }
            column(Injection_17_; Injection[17])
            {
            }
            column(Injection_14_; Injection[14])
            {
            }
            column(Injection_13_; Injection[13])
            {
            }
            column(Injection_12_; Injection[12])
            {
            }
            column(Injection_11_; Injection[11])
            {
            }
            column(Injection_10_; Injection[10])
            {
            }
            column(Injection_9_; Injection[9])
            {
            }
            column(Injection_8_; Injection[8])
            {
            }
            column(Injection_7_; Injection[7])
            {
            }
            column(Injection_6_; Injection[6])
            {
            }
            column(Injection_5_; Injection[5])
            {
            }
            column(Injection_4_; Injection[4])
            {
            }
            column(Injection_3_; Injection[3])
            {
            }
            column(Injection_2_; Injection[2])
            {
            }
            column(Injection_1_; Injection[1])
            {
            }
            column(UPPERCASE_COMPANYNAME_; UpperCase(COMPANYNAME))
            {
            }
            column(Drug_1_; Drug[1])
            {
            }
            column(PFNo_1_; PFNo[1])
            {
            }
            column(PatientName_1_; PatientName[1])
            {
            }
            column(Dose_1_; Dose[1])
            {
            }
            column(PFNo_2_; PFNo[2])
            {
            }
            column(PatientName_2_; PatientName[2])
            {
            }
            column(Drug_2_; Drug[2])
            {
            }
            column(Dose_2_; Dose[2])
            {
            }
            column(SIGNATURECaption; SIGNATURECaptionLbl)
            {
            }
            column(DOSECaption; DOSECaptionLbl)
            {
            }
            column(DRUGCaption; DRUGCaptionLbl)
            {
            }
            column(NAMECaption; NAMECaptionLbl)
            {
            }
            column(OP_IP_NO_Caption; OP_IP_NO_CaptionLbl)
            {
            }
            column(SIGNATURECaption_Control1102760076; SIGNATURECaption_Control1102760076Lbl)
            {
            }
            column(DOSECaption_Control1102760093; DOSECaption_Control1102760093Lbl)
            {
            }
            column(DRUGCaption_Control1102760100; DRUGCaption_Control1102760100Lbl)
            {
            }
            column(NAMECaption_Control1102760112; NAMECaption_Control1102760112Lbl)
            {
            }
            column(DATE__________________________________________________Caption; DATE__________________________________________________CaptionLbl)
            {
            }
            column(OP_IP_NO_Caption_Control1102760119; OP_IP_NO_Caption_Control1102760119Lbl)
            {
            }
            column(UNIVERSITY_HEALTH_SERVICESCaption; UNIVERSITY_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(INJECTION_REGISTERCaption; INJECTION_REGISTERCaptionLbl)
            {
            }
            column(HMS_Treatment_Form_Injection_Treatment_No_; "Treatment No.")
            {
            }
            column(HMS_Treatment_Form_Injection_Injection_No_; "Injection No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if FirstRecordPrinted then
                    Next(-1);
                for IntD := 1 to 2 do begin
                    Treatment.Reset();
                    Treatment.Get("Treatment No.");
                    Patient.Reset();
                    Patient.Get(Treatment."Patient No.");
                    PatientName[IntD] := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    if Patient."Patient Type" = Patient."patient type"::Corporate then
                        PFNo[IntD] := Patient.Test
                    else if Patient."Patient Type" = Patient."patient type"::" " then
                        PFNo[IntD] := Patient."Patient No."
                    else
                        PFNo[IntD] := Patient."Employee No.";
                    Drug[IntD] := "Injection No.";
                    Dose[IntD] := Format("Injection Quantity") + ' ' + "Injection Unit of Measure";
                    Next();
                end;
                FirstRecordPrinted := true;
            end;

            trigger OnPreDataItem()
            begin
                //LastFieldNo := FIELDNO(Code);
                IntC := 1;
                InjectionRec.Reset();
                if InjectionRec.Find('-') then
                    repeat
                    begin
                        Injection[IntC] := InjectionRec.Description;
                        IntC := IntC + 1;
                        Next(1);
                    end;
                    until InjectionRec.Next() = 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IntD := 1;
    end;

    var
        Patient: Record "HMS Patient";
        InjectionRec: Record "HMS Setup Injection";
        Treatment: Record "HMS Treatment Form Header";
        FirstRecordPrinted: Boolean;
        Drug: array[2] of Code[10];
        PFNo: array[2] of Code[20];
        Dose: array[2] of Code[30];
        IntC: Integer;
        IntD: Integer;
        DATE__________________________________________________CaptionLbl: label 'DATE _________________________________________________';
        DOSECaption_Control1102760093Lbl: label 'DOSE';
        DOSECaptionLbl: label 'DOSE';
        DRUGCaption_Control1102760100Lbl: label 'DRUG';
        DRUGCaptionLbl: label 'DRUG';
        INJECTION_REGISTERCaptionLbl: label 'INJECTION REGISTER';
        NAMECaption_Control1102760112Lbl: label 'NAME';
        NAMECaptionLbl: label 'NAME';
        OP_IP_NO_Caption_Control1102760119Lbl: label 'OP/IP NO.';
        OP_IP_NO_CaptionLbl: label 'OP/IP NO.';
        SIGNATURECaption_Control1102760076Lbl: label 'SIGNATURE';
        SIGNATURECaptionLbl: label 'SIGNATURE';
        UNIVERSITY_HEALTH_SERVICESCaptionLbl: label 'UNIVERSITY HEALTH SERVICES';
        Injection: array[18] of Text[100];
        PatientName: array[2] of Text[200];
}
