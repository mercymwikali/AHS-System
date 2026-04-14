namespace PTL.HMISBC;

report 85156 "Pharmacy Sales Summary"
{
    ApplicationArea = All;
    Caption = 'Pharmacy Sales Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/SalesSummary.rdl';
    dataset
    {
        dataitem("HMS Pharmacy Header"; "HMS Pharmacy Header")
        {
            RequestFilterFields = "Pharmacy Date", "Patient No.","Pharmacy Type";
            DataItemTableView = where(Status = filter('Completed'));
            column(PharmacyDate_HMSPharmacyHeader; "Pharmacy Date")
            {
            }
            column(PharmacyNo_HMSPharmacyHeader; "Pharmacy No.")
            {
            }
            column(PatientNo_HMSPharmacyHeader; "Patient No.")
            {
            }
            column(SearchName_HMSPharmacyHeader; "Search Name")
            {
            }
            column(InPatient_HMSPharmacyHeader; InPatient)
            {
            }
            column(IssuingLocation_HMSPharmacyHeader; "Issuing Location")
            {
            }
            column(PrescriptionItems; PrescriptionItems) 
            {
            }
            column(IssuedQty; IssuedQty) 
            {
            }
            column(IssuedAmount; IssuedAmount) 
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrescriptionItems := 0;
                IssuedQty := 0;
                IssuedAmount := 0;

                PharmacyLine.Reset();
                PharmacyLine.SetRange("Pharmacy No.", "HMS Pharmacy Header"."Pharmacy No.");
                PrescriptionItems := PharmacyLine.Count();
                IssuedQty := PharmacyLine.Count();
                if PharmacyLine.FindSet() then
                    repeat
                        IssuedAmount := IssuedAmount + PharmacyLine."Issued Price";
                    until PharmacyLine.Next() = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        PharmacyLine: Record "HMS Pharmacy Line";
        PrescriptionItems: Integer;
        IssuedQty: Decimal;
        IssuedAmount: Decimal;
}
