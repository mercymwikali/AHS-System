page 52202924 "HMS Patient Student Card"
{
    PageType = Card;
    SourceTable = "HMS Patient";

    layout
    {
        area(content)
        {
            group("Personal details")
            {
                Caption = 'Personal details';
                Editable = true;
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Patient Type field.';
                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Relative No."; Rec."Relative No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the First/English Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" <> 0D then
                            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
                    end;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Adm No."; Rec."Adm No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Adm No. field.';
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Membership No"; Rec."Membership No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
            }
            group("Medical details")
            {
                Caption = 'Medical details';
                Editable = true;
                field("Examining Officer"; Rec."Examining Officer")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Examining Officer field.';
                }
                field("Medical Exam Date"; Rec."Medical Exam Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Medical Exam Date field.';
                }
                field("Medical Details Not Covered"; Rec."Medical Details Not Covered")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Medical Details Not Covered field.';
                }
                field(Height; Rec.Height)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Height field.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field("Physical Impairment Details"; Rec."Physical Impairment Details")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Physical Impairment Details field.';
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Blood Group field.';
                }
                field("Without Glasses R.6"; Rec."Without Glasses R.6")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Without Glasses R.6 field.';
                }
                field("Without Glasses L.6"; Rec."Without Glasses L.6")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Without Glasses L.6 field.';
                }
                field("With Glasses R.6"; Rec."With Glasses R.6")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the With Glasses R.6 field.';
                }
                field("With Glasses L.6"; Rec."With Glasses L.6")
                {
                    ToolTip = 'Specifies the value of the With Glasses L.6 field.';
                }
                field("Hearing Right Ear"; Rec."Hearing Right Ear")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Hearing Right Ear field.';
                }
                field("Hearing Left Ear"; Rec."Hearing Left Ear")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Hearing Left Ear field.';
                }
                field("Condition Of Teeth"; Rec."Condition Of Teeth")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Condition Of Teeth field.';
                }
                field("Condition Of Throat"; Rec."Condition Of Throat")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Condition Of Throat field.';
                }
                field("Condition Of Ears"; Rec."Condition Of Ears")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Condition Of Ears field.';
                }
                field("Condition Of Lymphatic Glands"; Rec."Condition Of Lymphatic Glands")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Condition Of Lymphatic Glands field.';
                }
                field("Condition Of Nose"; Rec."Condition Of Nose")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Condition Of Nose field.';
                }
                field("Circulatory System Pulse"; Rec."Circulatory System Pulse")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Circulatory System Pulse field.';
                }
            }
            group("Historical Medical Conditions")
            {
                Caption = 'Historical Medical Conditions';
                Editable = true;
                part(Control1102760127; "HMS Patient Medical Condition")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                }
            }
            group("Historical Immunizations")
            {
                Caption = 'Historical Immunizations';
                Editable = true;
                part(Control1102760126; "HMS Patient Immunization")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                }
            }
            group("Spouse details (If Married)")
            {
                Caption = 'Spouse details (If Married)';
                Editable = true;
                field("Spouse Name"; Rec."Spouse Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Name field.';
                }
                field("Spouse Address 1"; Rec."Spouse Address 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Address 1 field.';
                }
                field("Spouse Address 2"; Rec."Spouse Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Address 2 field.';
                }
                field("Spouse Address 3"; Rec."Spouse Address 3")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Address 3 field.';
                }
                field("Spouse Telephone No. 1"; Rec."Spouse Telephone No. 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Telephone No. 1 field.';
                }
                field("Spouse Telephone No. 2"; Rec."Spouse Telephone No. 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Telephone No. 2 field.';
                }
                field("Spouse Email"; Rec."Spouse Email")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Email field.';
                }
                field("Spouse Fax"; Rec."Spouse Fax")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spouse Fax field.';
                }
            }
            group("Correspondence Address")
            {
                Caption = 'Correspondence Address';
                Editable = true;
                field("Place of Birth Village"; Rec."Place of Birth Village")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Place of Birth Village field.';
                }
                field("Place of Birth Location"; Rec."Place of Birth Location")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Place of Birth Location field.';
                }
                field("Place of Birth District"; Rec."Place of Birth District")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Place of Birth District field.';
                }
                field("Name of Chief"; Rec."Name of Chief")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Name of Chief field.';
                }
                field("Nearest Police Station"; Rec."Nearest Police Station")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Nearest Police Station field.';
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Correspondence Address 1 field.';
                }
                field("Correspondence Address 2"; Rec."Correspondence Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Correspondence Address 2 field.';
                }
                field("Correspondence Address 3"; Rec."Correspondence Address 3")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Correspondence Address 3 field.';
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telephone No. 2 field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
            }
            group("Parent Details")
            {
                Caption = 'Parent Details';
                Editable = true;
                field("Mother Alive or Dead"; Rec."Mother Alive or Dead")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Mother Alive or Dead field.';
                }
                field("Mother Full Name"; Rec."Mother Full Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Mother Full Name field.';
                }
                field("Mother Occupation"; Rec."Mother Occupation")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Mother Occupation field.';
                }
                field("Father Alive or Dead"; Rec."Father Alive or Dead")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Father Alive or Dead field.';
                }
                field("Father Full Name"; Rec."Father Full Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Father Full Name field.';
                }
                field("Father Occupation"; Rec."Father Occupation")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Father Occupation field.';
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Guardian Name field.';
                }
                field("Guardian Occupation"; Rec."Guardian Occupation")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Guardian Occupation field.';
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
            action(Statistics)
            {
                Caption = 'Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Patient Card";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Statistics action.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        "Relative No.Enable" := true;
        "Employee No.Enable" := true;
        "Student No.Enable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."Patient Type2"::Student;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
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
        if Rec."Patient Type" = Rec."Patient Type2"::Private then begin
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

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        if Rec."Date Of Birth" <> 0D then
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
    end;
}
