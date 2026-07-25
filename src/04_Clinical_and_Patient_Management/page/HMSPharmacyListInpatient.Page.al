Page 85402 "HMS Pharmacy List Inpatient"
{
    CardPageID = "HMS Pharmacy Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "HMS Pharmacy Header";
    SourceTableView = sorting("Pharmacy No.")
                      order(descending)
                      where(Status = filter('New'),
                            InPatient = filter(true));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Branch; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field(PharmacyNo; Rec."Pharmacy No.")
                {
                    ToolTip = 'Specifies the value of the Pharmacy No. field.';
                }
                field(PharmacyDate; Rec."Pharmacy Date")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Date field.';
                }
                field(PharmacyTime; Rec."Pharmacy Time")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Time field.';
                }
                field(MembershipNo; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(Names; Names)
                {
                    Caption = 'Patient Names';
                    ToolTip = 'Specifies the value of the Patient Names field.';
                }
                field(InsuranceNo; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field(IssuedBy; Rec."Issued By")
                {
                    ToolTip = 'Specifies the value of the Issued By field.';
                }
                field(DoctorName; Rec."Doctor Name")
                {
                    ToolTip = 'Specifies the value of the Doctor Name field.';
                }
                field(TotalPrice; Rec."Total Price")
                {
                    ToolTip = 'Specifies the value of the Total Price field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Receptionist; Rec.Receptionist)
                {
                    ToolTip = 'Specifies the value of the Receptionist field.';
                }
                field(ADMNo; Rec."ADM No")
                {
                    ToolTip = 'Specifies the value of the ADM No field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(IssuingLocation; Rec."Issuing Location")
                {
                    ToolTip = 'Specifies the value of the Issuing Location field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PrintInterimInvoice)
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Interim Invoice action.';

                trigger OnAction()
                begin
                    HMSPat.Reset();
                    HMSPat.SetRange(HMSPat."Patient No.", Rec."Patient No.");
                    if HMSPat.Find('-') then begin
                        HMSPatientsCharges.Reset();
                        HMSPatientsCharges.SetFilter(HMSPatientsCharges."Patient No.", Rec."Patient No.");
                        HMSPatientsCharges.SetFilter(HMSPatientsCharges."Visit No", HMSPat."Active Visit No");
                        if HMSPatientsCharges.Find('-') then
                            Report.Run(70135521, true, true, HMSPatientsCharges);
                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    begin
        ReUser.SetRange(ReUser."User ID", UserId);
        if ReUser.Find('-') then
            Rec.SetFilter("Global Dimension 1 Code", ReUser."Branch Code");
    end;

    trigger OnAfterGetRecord()
    var
        PatRec: Record "HMS Patient";
    begin
        if PatRec.get(Rec."Patient No.") then
            Names := PatRec."Search Name";
    end;

    var
        HMSPat: Record "HMS Patient";

        HMSPatientsCharges: Record "HMS Patient Charges";
        ReUser: Record "User Setup";
        Names: Text[200];
}
