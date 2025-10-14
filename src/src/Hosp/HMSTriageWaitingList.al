page 52202752 "HMS Triage Waiting List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable=false;
    DeleteAllowed=false;
    InsertAllowed=false;
    SourceTable = "HMS Appointment Form Header";
    SourceTableView = where(Status = filter(Dispatched), "Waiting At" = filter("Dispatch Areas"::Triage));// REFACTOR Filter is redundant as field type is changed
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Appointment No."; "Appointment No.")
                {
                    ApplicationArea = All;

                }
                field("Patient No."; "Patient No.")
                {
                    ApplicationArea = All;

                }
                field(SearchNames; SearchNames)
                {
                    Caption = 'Names';
                    ApplicationArea = All;

                }
                field("Triage Time In"; "Triage Time In")
                {
                    ApplicationArea = All;

                }
                field("Triage Time out"; "Triage Time out")
                {
                    ApplicationArea = All;
                }
                field("Waiting Duration"; Dur)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        Userec: Record "User Setup";
    begin
        SetFilter("Appointment Date", '%1', Today);
        if Userec.get(Database.UserId) then
            if Userec."Branch Code" <> '' then
                setfilter(Branch, Userec."Branch Code")
    end;

    trigger OnAfterGetRecord()
    begin
        Dur := DT2TIME(System.CurrentDateTime) - DT2TIME("Triage Time In");
    end;

    var
        Dur: Integer;
}




