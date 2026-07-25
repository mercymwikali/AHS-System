namespace PTL.HMIS;
using Microsoft.Foundation.Company;
using Microsoft.Finance.Dimension;

report 85148 "Patient Distribution Report"
{
    ApplicationArea = All;
    Caption = 'Patient Distribution Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Patients/PatientDistributionReport.rdl';
    Description = 'This report provides a distribution of patients based on Doctors, and payment types';
    dataset
    {
        dataitem("HMS Setup Doctor"; "HMS Setup Doctor")
        {
            
            column(DoctorID_HMSSetupDoctor; "Doctor ID")
            {
            }
            column(DoctorsName_HMSSetupDoctor; "Doctors Name")
            {
            }
            column(Specialization_HMSSetupDoctor; Specialization)
            {
            }
            column(Title_HMSSetupDoctor; Title)
            {
            }
            column(TotalVisits;TotalVisits){}
            column(NewVisits;NewVisits){}
            column(ReviewVisits;ReviewVisits){}
            column(CompanyInfo_name;CompanyInfo.Name){}
            column(CompanyInfo_address;CompanyInfo.Address){}
            column(CompanyInfo_picture;CompanyInfo.Picture){}
            column(CompanyInfo_phone;CompanyInfo."Phone No."){}
            column(CompanyInfo_email;CompanyInfo."E-Mail"){}
            trigger OnPreDataItem()
            begin
                // Check if request page filters have been set
                if (StartDate = 0D) or (EndDate = 0D) or (Branch = '') then
                    Error('Please set the Start Date, End Date, and Branch on the request page.');
            end;

            trigger OnAfterGetRecord()
            begin
                NewVisits := 0;
                ReviewVisits := 0;
                TotalVisits := 0;

                    HMSTreatmentFormHeader.Reset();
                    HMSTreatmentFormHeader.SetRange(HMSTreatmentFormHeader.Branch, Branch);
                    HMSTreatmentFormHeader.SetRange("Doctor ID", "HMS Setup Doctor"."Doctor ID");
                    HMSTreatmentFormHeader.SetRange("Treatment Date", StartDate, EndDate);
                    HMSTreatmentFormHeader.SetRange("Status", TreatmentStatus::Completed);
                    if HMSTreatmentFormHeader.FindSet() then
                        repeat
                            // Add logic to process the records as needed
                            HMSAppointmentFormHeader.Reset();
                            HMSAppointmentFormHeader.SetRange("Patient No.", HMSTreatmentFormHeader."Patient No.");
                            HMSAppointmentFormHeader.SetRange("Appointment Date", HMSTreatmentFormHeader."Treatment Date");
                            if HMSAppointmentFormHeader.FindFirst() then
                                if HMSAppointmentFormHeader.visitType = HMSAppointmentFormHeader.visitType::New then
                                    NewVisits := NewVisits + 1
                                else 
                                if HMSAppointmentFormHeader.visitType = HMSAppointmentFormHeader.visitType::Revisit then
                                    ReviewVisits := ReviewVisits + 1;
                        until HMSTreatmentFormHeader.Next() = 0;

                    TotalVisits := NewVisits + ReviewVisits;
                    if TotalVisits = 0 then CurrReport.Skip();
                end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Branch&DateFilter")
                {
                    Caption = 'Branch & Date Filter';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the start date for the report.';
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the end date for the report.';
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
                    field(Branch; Branch)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the branch for which you want to generate the report.';
                        Caption = 'Branch';
                        ShowMandatory = true;
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
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
    trigger OnPreReport()
    begin
        // Initialize the CompanyInfo record
        CompanyInfo.Get();
        // Set the report's caption to include the company name
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        HMSPatient: Record "HMS Patient";
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        Branch: Code[20];
        StartDate: Date;
        EndDate: Date;
        TotalVisits: Integer;
        NewVisits: Integer;
        ReviewVisits: Integer;
}
