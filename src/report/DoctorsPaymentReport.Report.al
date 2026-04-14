namespace PTL.Hospital;

report 85001 "Doctors Payment Report"
{
    ApplicationArea = All;
    Caption = 'Doctors Payment Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")

        {
            DataItemTableView = where("Posted Invoice No." = filter(<> ''), "Insurance No" = filter(<> ''));
            RequestFilterFields = "Insurance No", Date;
            column(AdmissionNo; "Admission No")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AppointmentNoLk; "Appointment No Lk")
            {
            }
            column(AppointmentNo; "Appointment No.")
            {
            }
            column(BillSection; "Bill Section")
            {
            }
            column(BillingEndDate; "Billing End Date")
            {
            }
            column(BillingStartDate; "Billing Start Date")
            {
            }
            column(BillingType; "Billing Type")
            {
            }
            column(CalcDoctorFee; "Calc Doctor Fee")
            {
            }
            column(CashRebatesPosted; "Cash Rebates Posted")
            {
            }
            column(Charge; Charge)
            {
            }
            column(ChargeBalance; "Charge Balance")
            {
            }
            column(ChargeGender; "Charge Gender")
            {
            }
            column(ChargeType; "Charge Type")
            {
            }
            column(ClaimReceiptNo; "Claim Receipt No")
            {
            }
            column(Claimed; Claimed)
            {
            }
            column(ClaimedAmount; "Claimed Amount")
            {
            }
            column(ClaimedCount; "Claimed Count")
            {
            }
            column(Closed; Closed)
            {
            }
            column(Code; "Code")
            {
            }
            column(CorporateExcluded; "Corporate Excluded")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(CreationTime; "Creation Time")
            {
            }
            column(Currency; Currency)
            {
            }
            column(CurrentLOUAmount; "Current LOU Amount")
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(Date; "Date")
            {
            }
            column(DefaultInsurance; "Default Insurance")
            {
            }
            column(Description; Description)
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }
            column(Distribution; Distribution)
            {
            }
            column(DistributionAccount; "Distribution Account")
            {
            }
            column(DoctorComm; "Doctor Comm%")
            {
            }
            column(DoctorID; "Doctor ID")
            {
            }
            column(DoctorRate; "Doctor Rate")
            {
            }
            column(DoctorsAmount; "Doctors Amount")
            {
            }
            column(DoctorsName; "Doctors Name")
            {
            }
            column(DoctorsPostingNo; "Doctors Posting No")
            {
            }
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
