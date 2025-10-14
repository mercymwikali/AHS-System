page 52202756 "HMS Pharmacy Waiting List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable=false;
    DeleteAllowed=false;
    InsertAllowed=false;
    SourceTable = "HMS Appointment Form Header";
    SourceTableView = where(Status = filter(Dispatched), "Waiting At" = filter("Dispatch Areas"::Pharmacy));
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
                field("Pharmacy Time In"; DT2TIME("Pharmacy Time In"))
                {
                    ApplicationArea = All;

                }
                field("Pharmacy Time Out"; DT2TIME("Pharmacy Time Out"))
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
        Dur := DT2TIME(System.CurrentDateTime) - DT2TIME("Pharmacy Time in");
    end;

    var
        Dur: Integer;

}