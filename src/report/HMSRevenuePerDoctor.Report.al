report 85122 "HMS Revenue Per Doctor"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSReports/RevenuePerDoctor.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            DataItemTableView = where("Doctor ID" = filter(<> ''));
            RequestFilterFields = "Date";
            column(Date; Date)
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Visit_Amount; "Visit Amount")
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
            trigger OnAfterGetRecord()
            begin
                DocName := '';
                if DocRec.get("Doctor ID") then
                    DocName := DocRec."Doctors Name";
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
        DocRec: Record "HMS Setup Doctor";
        DocName: text[200];
}