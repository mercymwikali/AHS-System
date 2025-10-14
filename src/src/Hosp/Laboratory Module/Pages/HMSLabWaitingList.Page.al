page 52202754 "HMS Lab Waiting List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "HMS Appointment Form Header";
    SourceTableView = where(Status = filter(Dispatched), "Waiting At" = filter("Dispatch Areas"::Laboratory));
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
                field("Doctors Name"; "Doctors Name")
                {
                    ApplicationArea = All;

                }
                field("Lab Time In"; DT2TIME("Lab Time In"))
                {
                    ApplicationArea = All;

                }
                field("Lab Time Out"; DT2TIME("Lab Time Out"))
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
                setfilter(Branch, Userec."Branch Code");

    end;

    trigger OnAfterGetRecord()
    begin
        Dur := DT2TIME(System.CurrentDateTime) - DT2TIME("Lab Time In");
    end;

    var
        Dur: Integer;

}