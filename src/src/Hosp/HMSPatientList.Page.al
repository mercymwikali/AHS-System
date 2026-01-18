Page 52202550 "HMS Patient List2"
{
    CardPageID = "HMS Patients";
    PageType = List;
    SourceTable = "HMS Patient";
    //  SourceTableView = where(Blocked = filter(false));
    ApplicationArea = Basic, Suite;
    Editable = true;

   
    
    layout
    {
        area(content)
        {
            repeater(Personaldetails)
            {
                Caption = 'Personal details';
                Editable = true;
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(DateRegistered; Rec."Date Registered")
                {
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Patient Type field.';

                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;
                }
                field(CurrentAdmNo; Rec."Current Adm No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Current Adm No field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch Code';
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(Names; Rec."Search Name")
                {
                    Caption = 'Names';
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    // Editable = false;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(OldFileNo; Rec."File No")
                {
                    Caption = 'Old File No';
                    ToolTip = 'Specifies the value of the Old File No field.';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the First/English Name field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';

                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" <> 0D then
                            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
                    end;
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field(ActiveVisitNo; Rec."Active Visit No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Active Visit No field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(Inpatient; Rec.Inpatient)
                {
                    ToolTip = 'Specifies the value of the Inpatient field.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("No. of Insurance List"; Rec."No. of Insurance List")
                {
                    ToolTip = 'Specifies the value of the No. of Insurance List field.';

                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                    Visible = false;
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                    Visible = false;
                }
                field("Open Insurance Amount"; Rec."Open Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the Open Insurance Amount field.', Comment = '%';
                    Visible = false;
                }
                field("Next Of kin Address 1"; Rec."Next Of kin Address 1")
                {
                    ToolTip = 'Specifies the value of the Next Of kin Address 1 field.';
                    Visible = false;
                }
                field("Next Of kin Address 2"; Rec."Next Of kin Address 2")
                {
                    ToolTip = 'Specifies the value of the Next of Kin Address 2 field.';
                    Visible = false;
                }
                field("Next Of kin Address 3"; Rec."Next Of kin Address 3")
                {
                    ToolTip = 'Specifies the value of the Next of Kin Address 3 field.';
                    Visible = false;
                }
                field("Next Of kin Full Name"; Rec."Next Of kin Full Name")
                {
                    ToolTip = 'Specifies the value of the Next Of kin Full Name field.';
                    Visible = false;
                }
                field("Next Of Kin ID Card No."; Rec."Next Of Kin ID Card No.")
                {
                    ToolTip = 'Specifies the value of the Next of Kin National ID Card No. field.';
                    Visible = false;
                }
                field("Next of kin Relationship"; Rec."Next of kin Relationship")
                {
                    ToolTip = 'Specifies the value of the Next of Kin Relationship field.';
                    Visible = false;
                }
                field("Next Of kin Date of Consent"; Rec."Next Of kin Date of Consent")
                {
                    ToolTip = 'Specifies the value of the Next Of kin Date of Consent field.', Comment = '%';
                    Visible = false;
                }
                field(Activated; Rec.Activated)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Activated field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            separator(Action8)
            {
            }
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
                    if HMSPatientCharges.Find('-') then
                        Report.Run(70135521, true, true, HMSPatientCharges);
                end;
            }
            separator(Action11)
            {
            }
            action(Charges)
            {
                Caption = 'Charges';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Charges action.';
            }
            action("Posted Charges")
            {
                Caption = 'Posted Charges';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient ClosedCharges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Posted Charges action.';
            }

            separator(Action14)
            {
            }
            action("Update Patient Visits Nos")
            {
                Image = AdjustEntries;
                ToolTip = 'Executes the Update Patient Visits Nos action.';

                trigger OnAction()
                begin

                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    if HMSPatientCharges.Find('-') then
                        Report.Run(39006071, true, true, HMSPatientCharges);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Relative No.Enable" := true;
        "Employee No.Enable" := true;
        "Student No.Enable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."patient type"::Cash;
    end;

    var
        HMSPatientCharges: Record "HMS Patient Charges";
        HRDates: Codeunit "HR Dates";
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;
        [InDataSet]
        "Student No.Enable": Boolean;
        Age: Text[100];

    procedure CheckPatientType()
    begin
        if Rec."Patient Type" = Rec."patient type"::Corporate then begin
            "Student No.Enable" := true;
            "Employee No.Enable" := false;
            "Relative No.Enable" := false;
        end
        else begin
            "Student No.Enable" := false;
            "Employee No.Enable" := true;
            "Relative No.Enable" := true;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        if Rec."Date Of Birth" <> 0D then
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
    end;
}
