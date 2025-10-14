page 52202457 "Ceo Cue"
{
    PageType = CardPart;
    SourceTable = "CEO Cue";

    layout
    {
        area(content)
        {
            cuegroup("Aged Accounts")
            {
                Visible = true;
                field("Aged Acc Receivable"; Rec."Aged Acc Receivable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Aged Acc Receivable field.';
                }
                field("Aged Acc Payable"; Rec."Aged Acc Payable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Aged Acc Payable field.';
                }
            }
            cuegroup("Bank Accounts")
            {
                Visible = true;
                field("KCB Bank"; Rec."KCB Bank")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mpesa Paybill field.';
                }
                field("SBM/Mpesa"; Rec."SBM/Mpesa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Agakhan field.';
                }
                field("Petty Cash ELD"; Rec."Petty Cash ELD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Buruburu field.';
                }
                field("Cash Control A/c ELD"; Rec."Cash Control A/c ELD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Pangani field.';
                }
                field("Cash Book Bungoma"; Rec."Cash Book Bungoma")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DTB Agakhan field.';
                }
                field("Stanbic Bank ELD"; Rec."Stanbic Bank ELD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Absa Bank field.';
                }
                field("SBM -FIXED ACCOUNT"; Rec."SBM -FIXED ACCOUNT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DTB Salary Account field.';
                }
                field("Bank of Africa-Bungoma"; Rec."Bank of Africa-Bungoma")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the All Banks field.';
                }
                // field("KMA Sacco"; "KMA Sacco")
                // {
                //     ApplicationArea = All;
                // }
                // field("Cashbook-Nairobi"; "Cashbook-Nairobi")
                // {
                //     ApplicationArea = All;
                // }
                // field("Petty Cash Bungoma"; "Petty Cash Bungoma")
                // {
                //     ApplicationArea = All;
                // }
                // field("Petty cash Nrb"; "Petty cash Nrb")
                // {
                //     ApplicationArea = All;
                // }
                // field("Stanbic Bank Nrb"; "Stanbic Bank Nrb")
                // {
                //     ApplicationArea = All;
                // }
                // field("STANBIC BNK FOUNTAIN RADIOLOGY"; "STANBIC BNK FOUNTAIN RADIOLOGY")
                // {
                //     ApplicationArea = All;
                // }
                // field("KMA Sacco 2"; "KMA Sacco 2")
                // {
                //     ApplicationArea = All;
                // }
            }

            cuegroup("Inventory Per Store")
            {
                field("Main Store BUNGOMA"; Rec."Main Store BUNGOMA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Main Store field.';
                }
                field("Pharmacy Bungoma"; Rec."Pharmacy Bungoma")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pangani Store field.';
                }
                field("Bungoma Procurement"; Rec."Bungoma Procurement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Buruburu Store field.';
                }
                field("Borrowing Store"; Rec."Borrowing Store")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agakhan Store field.';
                }
                field("Expiry Store"; Rec."Expiry Store")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiry Store field.';
                }

            }
            cuegroup("Therapy Sessions")
            {
                Visible = true;

                field(COUNSELLING1; Rec.COUNSELLING1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the All Out-Patients field.';
                }
                field(COUNSELLING2; Rec.COUNSELLING2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Patients field.';
                }
                field(COUNSELLING3; Rec.COUNSELLING3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procedure Patients field.';
                }
                field(COUNSELLING4; Rec.COUNSELLING4)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transferred Patients field.';
                }
                field(COUNSELLING5; Rec.COUNSELLING5)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the All In-Patients field.';
                }
                field(COUNSELLING6; Rec.COUNSELLING6)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Corporate Out Patients field.';
                }
                field(COUNSELLING7; Rec.COUNSELLING7)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Corporate In Patients field.';
                }
                field(COUNSELLING8; Rec.COUNSELLING8)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Walk-In Patients field.';
                }
            }
            cuegroup(Patients)
            {
                Visible = true;

                field("All Out-Patients"; Rec."All Out-Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the All Out-Patients field.';
                }
                field("Cash Patients"; Rec."Cash Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Patients field.';
                }
                field("Procedure Patients"; Rec."Procedure Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procedure Patients field.';
                }
                field("Transferred Patients"; Rec."Transferred Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transferred Patients field.';
                }
                field("All In-Patients"; Rec."All In-Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the All In-Patients field.';
                }
                field("Corporate Out Patients"; Rec."Corporate Out Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Corporate Out Patients field.';
                }
                field("Corporate In Patients"; Rec."Corporate In Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Corporate In Patients field.';
                }
                field("Walk-In Patients"; Rec."Walk-In Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Walk-In Patients field.';
                }
            }
            cuegroup(Visits)
            {
                Visible = true;
                field("Today's New Visits"; Rec."Today's Open Visits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Today''s New Visits field.';
                }
                field("Today's Visits"; Rec."Today's closed Visits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Today''s Visits field.';
                }
                field("Appointments (Reviews)"; Rec."Appointments (Reviews)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appointments (Reviews) field.';
                }
                field("Cash patiences"; Rec."Cash Out Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash patiences field.';
                }

                field("Cooperate Patients"; Rec."Corporate Patients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cooperate Patients field.';
                }
                field("Psychiatry Visits"; Rec."Psychiatry Visits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Psychiatry Visits field.', Comment = '%';
                }
                field("Psychology Visits"; Rec."Psychology Visits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Psychology Visits field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.RESET();
        if not Rec.get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.SetFilter(CurrentDate, '%1..', WorkDate());
    end;
}
