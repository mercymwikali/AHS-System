report 85059 "HMS Visits Per User"
{
    ApplicationArea = All;
    UsageCategory = Administration;

    dataset
    {
        dataitem("HMS Appointment Form Header"; "HMS Appointment Form Header")
        {
            DataItemTableView = where("User ID" = filter(<> ''));
            RequestFilterFields = "Appointment Date";
            column(Appointment_Date; "Appointment Date")
            {
            }
            column(Appointment_No_; "Appointment No.")
            {
            }
            column(Appointment_Type; "Appointment Type")
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(Global_Dimension_1; "Global Dimension 1")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(Dispatch_To; "Dispatch To")
            {
            }
            column(CompInf; CompInf.Name)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            trigger OnPreDataItem()
            begin
                CompInf.get();
                CompInf.CalcFields(Picture);
            end;
        }
    }

    var
        CompInf: Record "Company Information";
}