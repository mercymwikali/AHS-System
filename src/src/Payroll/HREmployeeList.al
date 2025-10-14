Page 52203079 "HR Employee List"
{
    CardPageId = Employee;
    Editable = true;
    PageType = List;
    SourceTable = "HR-Employee";
    SourceTableView = where(Status = filter(Normal), Exclude = filter(false));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Department Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status Reasons field.';
                }
                field("Status 1"; Rec."Status 1")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

                field(Exclude; Rec.Exclude)
                {
                    ToolTip = 'Specifies the value of the Exclude field.', Comment = '%';
                    Visible = false;
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }
    local procedure NormalgOptNormalOnPush()
    begin
        "Filter Employees"(0); //Normal Employees
    end;

    local procedure NormalgOptNormalOnValidate()
    begin
        NormalgOptNormalOnPush();
    end;

    local procedure ArchivegOptNormalOnPush()
    begin
        "Filter Employees"(1); //Archived Employees
    end;

    local procedure AllgOptNormalOnPush()
    begin
        "Filter Employees"(2); //  Show All Employees
    end;

    local procedure ArchivegOptNormalOnValidate()
    begin
        ArchivegOptNormalOnPush();
    end;

    local procedure AllgOptNormalOnValidate()
    begin
        AllgOptNormalOnPush();
    end;

    procedure "Filter Employees"(Type: Option Normal,Archive,All)
    begin
        if Type = Type::Normal then begin
            Rec.Reset();
            Rec.SetFilter("Termination Category", '=%1', Rec."Termination Category"::" ");
        end
        else
            if Type = Type::Archive then begin
                Rec.Reset();
                Rec.SetFilter("Termination Category", '<>%1', Rec."Termination Category"::" ");
            end
            else
                if Type = Type::All then
                    Rec.Reset();

        CurrPage.Update(false);
        Rec.FilterGroup(20);
    end;
}
