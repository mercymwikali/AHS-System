namespace PTL.HMISBC;
using Microsoft.Foundation.Company;

report 85126 "HMS Sickoff IP"
{
    ApplicationArea = All;
    Caption = 'HMS Sickoff IP';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSIPSickoff.rdl';
    dataset
    {
        dataitem(HMSAdmissionFormHeader; "HMS Admission Form Header")
        {
            column(Sick_Off_Start_Date;"Sick Off Start Date"){}
            column(Sick_Off_End_Date;"Sick Off End Date") {}
            column(Off_Duty_Comments;"Off Duty Comments") {}
            column(Off_Duty_Days;"Off Duty Days"){}
            column(logos; CompanyInfo.Picture)
            {
            }
            column(Next_Appointment_Date;"Next Appointment Date"){}
            column(Doctor;Doctor){}
            column(PatientNames; PatientNames)
            {
            }
            trigger OnAfterGetRecord()
            begin
                PatientNames := '';

                objPat.Reset();
                objPat.SetRange(objPat."Patient No.", HMSAdmissionFormHeader."Patient No.");
                if objPat.Find('-') then
                    PatientNames := objPat.Surname + ' ' + objPat."Middle Name" + ' ' + objPat."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        CompanyInfo: Record "Company Information";
        objPat: Record "HMS Patient";
        PatientNames: Text;
}

