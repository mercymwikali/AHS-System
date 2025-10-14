page 52203045 "HMS InPatient List"
{
    CardPageID = "HMSINPatients Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS Patient";
    SourceTableView = where(Inpatient = filter(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Patient Type field.';

                    trigger OnValidate()
                    begin
                        // CheckPatientType();
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" <> 0D then
                            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
                    end;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field("Adm No."; Rec."Adm No.")
                {
                    ToolTip = 'Specifies the value of the Adm No. field.';
                }
                field(Age; Age)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }

            }
        }
    }


    trigger OnInit()
    begin
        // "Relative No.Enable" := true;
        // "Employee No.Enable" := true;
        // "Student No.Enable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."Patient Type"::Cash;
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
        if Rec."Patient Type" = Rec."Patient Type"::Corporate then begin
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
        // CheckPatientType();
        if Rec."Date Of Birth" <> 0D then
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
    end;
}
