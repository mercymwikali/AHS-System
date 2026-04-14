report 85173 "HMS Pharmacy Issues Report T"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/HMS Pharmacy Issues Report T.rdl';

    dataset
    {
        dataitem("HMS Pharmacy Line"; "HMS Pharmacy Line")
        {
            RequestFilterFields = "Date";
            column(Date_Printed_____FORMAT_TODAY_0_4_; 'Date Printed:' + FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Printed_By______USERID; 'Printed By: ' + USERID)
            {
            }
            column(Saletype_HMSPharmacyLine; "HMS Pharmacy Line"."Sale type")
            {
            }
            column(InsuranceTotalAmount_HMSPharmacyLine; "HMS Pharmacy Line"."Insurance Total Amount")
            {
            }
            column(Names_HMSPharmacyLine; "HMS Pharmacy Line".Names)
            {
            }
            column(PharmacyNo_HMSPharmacyLine; "HMS Pharmacy Line"."Pharmacy No.")
            {
            }
            column(DrugName_HMSPharmacyLine; "HMS Pharmacy Line"."Drug Name")
            {
            }
            column(No_HMSPharmacyLine; "HMS Pharmacy Line"."No.")
            {
            }
            column(Quantity_HMSPharmacyLine; "HMS Pharmacy Line".Quantity)
            {
            }
            column(SalesType; SalesType)
            {
            }
            column(Date_HMSPharmacyLine; "HMS Pharmacy Line".GETFILTER(Date))
            {
            }
            column(Walkin_HMSPharmacyLine; CashType)
            {
            }
            column(PHarmCount; "pharm count Walkin Cash")
            {
            }
            column(walkingNormal; PharmacyHeader."pharm count Walkin Normal")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CashType := '';
                Patient.RESET();
                PatientName := '';
                PharmacyHeader.RESET();
                PharmacyHeader.GET("Pharmacy No.");
                if Patient.GET(PharmacyHeader."Patient No.") then begin
                    PatientName := Patient."Search Name";

                    if "HMS Pharmacy Line"."Sale type" = true then
                        SalesType := 'CASH';

                    if "HMS Pharmacy Line"."Sale type" = false then
                        SalesType := 'CREDIT';
                end;

                PharmacyHeader.CALCFIELDS("pharm count Walkin Cash");
                PharmacyHeader.CALCFIELDS(Walkin);

                if PharmacyHeader.Walkin = true then
                    CashType := 'Walk-IN'
                else
                    CashType := 'Cash';
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Pharmacy No.");
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Patient: Record "HMS Patient";
        PharmacyHeader: Record "HMS Pharmacy Header";
        PFNo: Code[20];
        LastFieldNo: Integer;
        CashType: Text[30];
        SalesType: Text[30];
        PatientName: Text[250];
}
