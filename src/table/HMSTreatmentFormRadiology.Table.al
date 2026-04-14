Table 85269 "HMS Treatment Form Radiology"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Radiology Type Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Radiology Type".Code;

            trigger OnValidate()
            begin
                /* if HMSTreatH.Get("Treatment No.") then
                    RadRec.Get("Radiology Type Code"); */
                    /*
                  HMSPatientCharges.INIT;
                  HMSPatientCharges."Line No":=1;
                  HMSPatientCharges."Patient No.":=HMSTreatH."Patient No.";
                  HMSPatientCharges."Link No":=HMSTreatH."Link No.";
                  HMSPatientCharges."Treatment No.":="Treatment No.";
                  //HMSPatientCharges."Shortcut Dimension 1 Code":=
                  HMSPatientCharges."Transaction Type":='RADIOLOGY';
                  HMSPatientCharges.VALIDATE("Transaction Type");
                  HMSPatientCharges.Code:="Radiology Type Code";
                  HMSPatientCharges.VALIDATE(Code);
                  // IF RadSec.GET(RadRec."Radiology Section") THEN
                  // HMSPatientCharges.Description:=RadSec.Code
                  // ELSE
                  HMSPatientCharges.Description:=RadRec.Description;
                  HMSPatientCharges."G/L Account No":=RadRec."G/L Account";
                  HMSPatientCharges.Amount:=RadRec.Amount;
                  HMSPatientCharges.VALIDATE(Amount);
                  HMSPatientCharges.Date:=TODAY;
                  HMSPatientCharges."User ID":=USERID;
                  HMSPatientCharges."Creation Time":=TIME;
                  HMSPatientCharges."Creation Date":=TODAY;
                  HMSPatientCharges."Doctor ID":=HMSTreatH."Doctor ID";
                  HMSPatientCharges.VALIDATE("Doctor ID");
                  HMSPatientCharges.INSERT;*/
            end;
        }
        field(50002; "Radiology Type Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Radiology Type".Description where(Code = field("Radiology Type Code")));
            FieldClass = FlowField;
        }
        field(50003; "Date Due"; Date)
        {
        }
        field(50004; "Clinical Summary &  Diagnosis"; Text[250])
        {
        }
        field(50005; Status; Option)
        {
            FieldClass = Normal;
            OptionCaption = 'New,Cancelled,Completed,Forwarded';
            OptionMembers = New,Cancelled,Completed,Forwarded;
        }
        field(50006; "Required Investigation"; Text[250])
        {
        }
        field(50007; "Previous Investigation"; Text[250])
        {
        }
        field(50008; "Request Type"; Option)
        {
            OptionCaption = ' ,Non Urgent,Urgent';
            OptionMembers = " ","Non Urgent",Urgent;
        }
        field(50009; LMP; Text[30])
        {
        }
        field(50010; "Date Taken"; Date)
        {
        }
        field(50011; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Radiology Type Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HMSTreatH: Record "HMS Appointment Form Header";
        RadRec: Record "HMS Setup Lab Test";
    //RadSec: Record UnknownRecord70135130;
}
