Page 85331 "HMS Current InPatients List"
{
    // CardPageID = hms admiss;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = where(Status = const(Admitted));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AdmissionDate; Rec."Admission Date")
                {
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field(AdmittingDoctorName; DoctRec."Doctors Name")
                {
                    Caption = 'Admitting Doctor Name';
                    ToolTip = 'Specifies the value of the Admitting Doctor Name field.';
                }
                field(AdmissionType; Rec."Admission Type")
                {
                    ToolTip = 'Specifies the value of the Admission Type field.';
                }
                field(InsName; InsName)
                {
                    Caption = 'Insurance Name';
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'Patient Names';
                    ToolTip = 'Specifies the value of the Patient Names field.';
                }
                field("Global Dimension1"; Rec."Global Dimension1")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date OF Birth field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Charges)
            {
                Caption = 'Charges';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Charges action.';
            }
            action(PrintInvoive)
            {
                Caption = '&Print Invoive';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Invoive action.';
            }
            action(BedTransfer)
            {
                Caption = 'Post Charges';
                Image = PostedPayment;
                Promoted = true;
                ToolTip = 'Executes the Post Charges action.';
            }

            separator(Action28)
            {
            }
            action("Calculate Reccuring Charges")
            {
                Image = Calculate;
                ToolTip = 'Executes the Calculate Reccuring Charges action.';

                trigger OnAction()
                begin

                    HMS.CalculateReccuringCharges(Rec."Patient No.");

                    Message('Completed Successfully');
                end;
            }
            action("Post Consumables")
            {
                Caption = 'Post Consumable';
                Image = Calculate;
                RunObject = page "HMS Admission Form Drug";
                RunPageLink = "Admission No." = field("Admission No.");
                ToolTip = 'Executes the Post Consumable action.';
            }
            action("Posted Consumables")
            {
                Caption = 'Posted Consumables';
                Image = Calculate;
                RunObject = page "HMS Posted Admission Form Drug";
                RunPageLink = "Admission No." = field("Admission No.");
                ToolTip = 'Executes the Posted Consumables action.';
            }
            separator(Action30)
            {
            }
        }
        area(reporting)
        {
            action(PrintInterimInvoice)
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ToolTip = 'Executes the &Print Interim Invoice action.';

                trigger OnAction()
                begin

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", Rec."Link No.");
                    if HMSPatientCharges.Find('-') then
                        Report.Run(70135521, true, true, HMSPatientCharges);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if DoctRec.Get(Rec.Doctor) then;

        if Patients.get(Rec."Patient No.") then
            PatientName := Patients."Search Name";
        if Patients."Patient Type" = Patients."patient type"::Corporate then
            InsName := Patients."Insurance Name"
        else
            InsName := 'Cash';
    end;

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if UserRec.get(Database.UserId) then
            if UserRec."Branch Code" <> '' then
                Rec.setfilter("Global Dimension1", UserRec."Branch Code");
    end;

    var
        Patients: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        DoctRec: Record "HMS Setup Doctor";
        HMS: Codeunit "HMS Patient-integration";
        InsName: Text[100];
        PatientName: Text[200];
}
