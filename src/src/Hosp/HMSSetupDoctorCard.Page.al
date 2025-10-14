Page 52202835 "HMS Setup Doctor Card"
{
    PageType = Card;
    SourceTable = "HMS Setup Doctor";

    layout
    {
        area(content)
        {
            group(Control1102760000)
            {
                field(DoctorID; "Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DoctorsName; "Doctors Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ConsultationCode; "Consultation Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ApplicationArea = All;


                }
                field("Consultation Code Cash"; "Consultation Code Cash")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Consultation Cash FirstTimer"; "Consultation Cash FirstTimer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Consultation Cash Review"; "Consultation Cash Review")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(CommissionPerc; "Commission Perc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Specialization; Specialization)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ProffesionalRegistrationNo; "Proffesional Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Resident; Resident)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(PINNo; "PIN No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Title; Title)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(UserID; "User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(HDF; "HDF%")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IP Rate"; "IP Rate")
                {
                    Caption = 'In Patient Rate';
                    ApplicationArea = Basic, Suite;
                }
                field("Surgical Rate"; "Surgical Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(InsuranceNoFilter; "Insurance No. Filter")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(PendingAmount; "Pending Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(CompletedFilter; "Completed Filter")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(OpenCharges; "Open Charges")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ClaimedCharges; "Claimed Charges")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DateFilter; "Date Filter")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ConsultationCodeCash; "Consultation Code Cash")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

