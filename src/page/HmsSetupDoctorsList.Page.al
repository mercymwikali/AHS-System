Page 85448 "Hms Setup Doctors List"
{
    CardPageID = "HMS Setup Doctor Card";
    PageType = List;
    SourceTable = "HMS Setup Doctor";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DoctorsName; Rec."Doctors Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ConsultationCode; Rec."Consultation Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ApplicationArea = All;


                }
                field(CommissionPerc; Rec."Commission Perc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ProffesionalRegistrationNo; Rec."Proffesional Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Resident; Rec.Resident)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(HDF; Rec."HDF%")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(PINNo; Rec."PIN No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Clinic; Rec.Clinic)
                {
                    ApplicationArea = All;
                }
                field(Category;Category)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension Code 1"; Rec."Global Dimension Code 1")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

