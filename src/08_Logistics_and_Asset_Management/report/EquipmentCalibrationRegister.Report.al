report 85025 "Equipment Calibration Register"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/EquipmentCalibration.rdl';
    UsageCategory = Administration;

    dataset
    {
        dataitem("Equipment Maint Register"; "Equipment Maint Register")
        {
            column(Asset_No_; "Asset No.")
            {
            }
            column(Serial_No_; "Serial No.")
            {
                Caption = 'Serail No.';
            }
            column(Date_of_Calibration; "Date of Calibration")
            {
            }
            column(Date_due_for_Calibration; "Date due for Calibration")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(CompInfName; CompInf.Name)
            {
            }
            column(CompInfLogo; CompInf.Picture)
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
