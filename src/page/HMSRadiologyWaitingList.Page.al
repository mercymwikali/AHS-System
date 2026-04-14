page 85424 "HMS Radiology Waiting List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "HMS Appointment Form Header";
    SourceTableView = where(Status = filter(Dispatched), "Waiting At" = filter("Dispatch Areas"::Radiology)); //FIXME hardcoded vlaues will be inconvinent when functionality is changed to setup
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
                field("Imaging Time In"; DT2TIME("Imaging Time In"))
                {
                    ApplicationArea = All;

                }
                field("Imaging Time Out"; DT2TIME("Imaging Time Out"))
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
        Dur := DT2TIME(System.CurrentDateTime) - DT2TIME("Imaging Time In");
    end;

    var
        Dur: Integer;

}