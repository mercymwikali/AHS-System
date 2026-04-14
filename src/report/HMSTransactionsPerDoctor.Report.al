report 85129 "HMS Transactions Per Doctor"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSReports/TransactionPerDoctor.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            DataItemTableView = where("Doctor ID" = filter(<> ''), Weived = filter(false));
            RequestFilterFields = Date, "Doctor ID", "Shortcut Dimension 4 Code";
            column(Date; Date)
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Doctors_Posting_No; "Doctors Posting No")
            {
            }
            column(Posted_to_Doctor; "Posted to Doctor")
            {
            }
            column(Visit_Amount; "Visit Amount")
            {
            }
            column(Doctors_Amount; "Doctors Amount")
            {
            }
            column(Total_Amount;"Total Amount")
            {             
            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Shortcut_Dimension_3_Code; "Shortcut Dimension 3 Code")
            {
            }
            column(Shortcut_Dimension_4_Code; "Shortcut Dimension 4 Code")
            {
            }
            column(Insurance_No; "Insurance No")
            {
            }
            column(Insurance_Name; "Insurance Name")
            {
            }
            column(Patient_No_; "Patient No.")
            {
            }
            column(patientNames; PatNames)
            {
            }
            column(InPatient; InPatient)
            {
            }
            column(Visit_No; "Visit No")
            {
            }
            column(CompInf; CompInf.Name)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(DocName; DocName)
            {
            }
            column(Weived; Weived)
            {
            }
            trigger OnAfterGetRecord()
            begin
                DocName := '';
                if DocRec.get("Doctor ID") then
                    DocName := DocRec."Doctors Name";

                if PatRec.get("Patient No.") then
                    PatNames := PatRec."Search Name";
            end;

            trigger OnPreDataItem()
            begin
                CompInf.get();
                CompInf.CalcFields(Picture);
            end;
        }
    }

    var
        CompInf: Record "Company Information";
        PatRec: Record "HMS Patient";
        DocRec: Record "HMS Setup Doctor";
        DocName: text[200];
        PatNames: Text[200];
}