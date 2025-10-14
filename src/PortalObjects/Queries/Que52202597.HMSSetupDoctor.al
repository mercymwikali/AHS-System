namespace HMISBC.HMISBC;

query 52202597 "HMS Setup Doctor"
{
    Caption = 'HMS Setup Doctor';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSetupDoctor; "HMS Setup Doctor")
        {
            column(Category; Category)
            {
            }
            column(Clinic; Clinic)
            {
            }
            column(CommissionPerc; "Commission Perc")
            {
            }
            column(ConsultationCashFirstTimer; "Consultation Cash FirstTimer")
            {
            }
            column(ConsultationCashReview; "Consultation Cash Review")
            {
            }
            column(ConsultationCode; "Consultation Code")
            {
            }
            column(ConsultationCodeCash; "Consultation Code Cash")
            {
            }
            column(DoctorID; "Doctor ID")
            {
            }
            column(DoctorsName; "Doctors Name")
            {
            }
            column(Email; Email)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimensionCode1; "Global Dimension Code 1")
            {
            }
            column(HDF; "HDF%")
            {
            }
            column(IPRate; "IP Rate")
            {
            }
            column(OpenCharges; "Open Charges")
            {
            }
            column(PINNo; "PIN No")
            {
            }
            column(PendingAmount; "Pending Amount")
            {
            }
            column(ProffesionalRegistrationNo; "Proffesional Registration No.")
            {
            }
            column(Resident; Resident)
            {
            }
            column(Specialization; Specialization)
            {
            }
            column(SurgicalRate; "Surgical Rate")
            {
            }
            column(Telephone; Telephone)
            {
            }
            column(Title; Title)
            {
            }
            column(UserID; "User ID")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
