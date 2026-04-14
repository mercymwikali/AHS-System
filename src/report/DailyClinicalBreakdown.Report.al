namespace PTL.HMISBC;
using Microsoft.Sales.Customer;

report 85004 "Daily Clinical Breakdown"
{
    ApplicationArea = All;
    Caption = 'Daily Clinical Breakdown';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DailyReports/ClinicalBreakdown.rdl';
    dataset
    {
        dataitem(DailyClinicalReportsHeader; "Daily Clinical Reports Header")
        {
            column(Date; "Date")
            {
            }
            column(TotalBedOccupancy; "Total Bed Occupancy")
            {
            }
            column(TotalAdmissions; "Total Admissions")
            {
            }
            column(TotalMAKLOccupancy; "Total MAKL Occupancy")
            {
            }
            column(TotalMAKL; "Total MAKL %")
            {
            }
            column(TotalSHAOccupancy; "Total SHA Occupancy")
            {
            }
            column(TotalSHA; "Total SHA %")
            {
            }
            column(TotalAcute; "Total Acute")
            {
            }
            column(TotalIPCP; "Total IP C.P")
            {
            }
            column(TotalIPCPPerc; "Total IP C.P %")
            {
            }
            column(TotalOPVisits; "Total OP Visits")
            {
            }
            column(TotalOPCP; "Total OP C.P")
            {
            }
            column(TotalOPCPPerc; "Total OP C.P %")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemTableView = where("In Daily Clinical Report" = filter(true));
                CalcFields = "Day IP Count", "Day OP Count";             
                column(No_Customer; "No.")
                {
                }
                column(Name_Customer; Name)
                {
                }
                column(DayOPCount_Customer; "Day OP Count")
                {
                }
                column(DayIPCount_Customer; "Day IP Count")
                {
                }
            }
            dataitem("HMS Setup Doctor";"HMS Setup Doctor")
            {
                DataItemTableView = where(Resident = filter(true));
                column(DoctorID_HMSSetupDoctor; "Doctor ID")
                {
                }
                column(DoctorsName_HMSSetupDoctor; "Doctors Name")
                {
                }
                column(TotalOP_HMSSetupDoctor; "Total OP")
                {
                }
                column(TotalIP_HMSSetupDoctor; "Total IP")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                Customer.SetFilter("Date Filter", '=%1', Date);
                "HMS Setup Doctor".SetFilter("Date Filter", '=%1', Date);

                // Build the Message here
                // Bed Occupancy - Header
                // - Total Occupancy
                // - Total MAKL %
                // - Total SHA %
                // Breakdown per branch
                // BreakDown Per Doctor CP
                // Cp %
                // Total Admissions
                // Total Breakdown Per Doctor

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
    
}
