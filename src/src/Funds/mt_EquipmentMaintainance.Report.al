report 52202439 "Plant & Equipment Maint"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/EquipmentMaintainance.rdl';
    UsageCategory = Administration;

    dataset
    {
        dataitem("Equipment Maint Register"; "Equipment Maint Register")
        {
            column(Date_of_Calibration; "Date of Calibration")
            {
                Caption = 'Date';
            }
            column(Asset_No_; "Asset No.")
            {
            }
            column(Description_; "Description.")
            {
            }
            column(Correction_Measure; "Correction Measure")
            {
            }
            column(Time_Frame; "Time Frame")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(CompInfName; CompInf.Name)
            {
            }
            column(CompInflogo; CompInf.Picture)
            {
            }
        }
    }

    var
        CompInf: Record "Company Information";

    trigger OnPreReport()
    begin
        CompInf.get();
        CompInf.CalcFields(Picture);
    end;
}