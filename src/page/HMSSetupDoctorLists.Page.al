Page 85447 "HMS Setup Doctor Lists"
{
    PageType = List;
    SourceTable = "HMS Setup Doctor";
    CardPageId = "HMS Setup Doctor Card";
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(DoctorID; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(DoctorsName; Rec."Doctors Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctors Name field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")

                {
                    Caption = 'Branch';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch field.';

                }
                field(ConsultationCode; Rec."Consultation Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Consultation Code field.';
                }
                field(ConsultationCodeCash; Rec."Consultation Code Cash")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Consultation Code Cash field.';
                }
                field("Consultation Cash FirstTimer"; Rec."Consultation Cash FirstTimer")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Consultation Cash FirstTimer field.';
                }
                field("Consultation Cash Review"; Rec."Consultation Cash Review")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Consultation Cash Review field.';
                }
                field(CommissionPerc; Rec."Commission Perc")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Commission Perc field.';
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Specialization field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telephone field.';
                }
                field(ProffesionalRegistrationNo; Rec."Proffesional Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Proffesional Registration No. field.';
                }
                field(Resident; Rec.Resident)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Resident field.';
                }
                field("Consultation Floor No"; Rec."Consultation Floor No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor No field.', Comment = '%';
                }
                field("Consultation Room No"; Rec."Consultation Room No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room No field.', Comment = '%';
                }

                field(PINNo; Rec."PIN No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PIN No field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(HDF; Rec."HDF%")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the HDF% field.';
                }
                field(InsuranceNoFilter; Rec."Insurance No. Filter")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No. Filter field.';
                }
                field(PendingAmount; Rec."Pending Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Pending Amount field.';
                }
                field(CompletedFilter; Rec."Completed Filter")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Completed Filter field.';
                }
                field(OpenCharges; Rec."Open Charges")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Open Charges field.';
                }
                field(ClaimedCharges; Rec."Claimed Charges")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Claimed Charges field.';
                }
                field(DateFilter; Rec."Date Filter")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Filter field.';
                }


            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

