Page 52202723 "HMS Walkin Patient List"
{
    CardPageID = "HMS Walkin Patient Card";
    PageType = List;
    SourceTable = "HMS Patient";
    SourceTableView = where(Blocked = filter(false),
                            "Walk-in" = filter(true));
    ApplicationArea = Basic, Suite;

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
                field(Branch; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(SearchName; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field.';
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
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(Age; Age)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Age field.';
                    Caption = 'Age';
                }
                field(Photo; Rec.Photo)
                {
                    ToolTip = 'Specifies the value of the Photo field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
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
                RunObject = Page "Admission Discharge List";
                RunPageLink = "Patient No." = field("Patient No.");
                ToolTip = 'Executes the Statistics action.';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        if Rec."Date Of Birth" <> 0D then
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
    end;

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
}
