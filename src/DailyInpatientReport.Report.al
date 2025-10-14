namespace PTL.HMIS;
using Microsoft.Foundation.Company;

report 52202711 "Daily Inpatient Report"
{
    ApplicationArea = All;
    Caption = 'Daily Inpatient Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Finance/DailyInpatientReport.rdl';
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = where("Transaction Type" = filter('BED'));
            CalcFields = "Admitting Doctor";
            column(PatientNo; "Patient No.")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(Code; "Code")
            {
            }
            column(Date; "Date")
            {
            }
            column(AdmittingDoctor; AdmittingDoctor)
            {

            }
            column(PatientName;PatientName)
            {

            }
            column(InsuranceScheme;InsuranceScheme){}
            column(InterimBill;InterimBill)
            {

            }
            column(DateFilter;DateFilter)
            {

            }
            trigger OnPreDataItem()
            begin
                if DateFilter = 0D then Error('Please Specify the Report Date');
                HMSPatientCharges.SetFilter(Date, '%1', DateFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                if HMSPatient.Get("Patient No.") then begin
                    PatientName := HMSPatient."Search Name";
                    InsuranceScheme := HMSPatient."Scheme Name";
                end;

                // REFACTOR: When change Visit number in patient charges get the admission number form appointment from header and scheme too

                // Get the patient interim Bill as of the date
                HMSPatientChrgs.Reset();
                HMSPatientChrgs.SetRange("Visit No", HMSPatientCharges."Visit No");
                HMSPatientChrgs.SetRange(Date, 0D, DateFilter);
                if HMSPatientChrgs.Find('-') then begin
                    HMSPatientChrgs.CalcSums("Total Amount");
                    InterimBill := HMSPatientChrgs."Total Amount";
                end;
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
                    field("Date Filter"; DateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Date Filter';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Date Filter field.';
                    }
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
        HMSPatient: Record "HMS Patient";
        HMSPatientChrgs: Record "HMS Patient Charges";
        CompanyInformation: Record "Company Information";
        PatientName: Text[250];
        AdmittingDoctor: Text[250];
        InsuranceScheme: Text[250];
        InterimBill: Decimal;
        DateFilter: Date;
}
