namespace PTL.HMISBC;
using Microsoft.Foundation.Company;

report 52202699 "HMS Doctor Charges"
{
    ApplicationArea = All;
    Caption = 'HMS Doctor Charges';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSReports/ChargesPerDoctor.rdl';
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = where("Shortcut Dimension 1 Code" = filter(= 'WESTLANDS'), Posted = filter(true), "Doctor ID" = filter(<> ''));

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
            column(Total_Amount; "Total Amount")
            {

            }
            column(patientNames;patientNames)
            {

            }
            column(Insurance_No; "Insurance No")
            {
            }
            column(Insurance_Name; "Insurance Name")
            {
            }
            dataitem("HMS Patient";"HMS Patient")
            {
                DataItemLink = "Patient No." = field("Patient No.");
                
                column(SearchName_HMSPatient; "Search Name")
                {
                }
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
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CompInf: Record "Company Information";
        DocRec: Record "HMS Setup Doctor";
        DocName: text[200];
}
