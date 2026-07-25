report 85086 "HMS Insurance Patients Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Finance/HMSInsurancePatientsSummary.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(AppointmentsCount_Customer; Completepharmcount)
            {
            }
            column(CompleteLabcount_Customer; Customer."Complete Lab count")
            {
            }
            column(CompleteInpatientCount_Customer; Customer."Complete Inpatient Count")
            {
            }
            column(cName; CompInfor.Name)
            {
            }
            column(cphone; CompInfor."Phone No.")
            {
            }
            column(cpic; CompInfor.Picture)
            {
            }
            column(Date; Customer.GetFilter("Date Filter"))
            {
            }
            column(PharmWalkin; PharmWalkin)
            {
            }
            column(LabWalking; LabWalking)
            {
            }
            column(TriageWalking; TriageWalking)
            {
            }
            column(LabCorporate; LabCorporate)
            {
            }
            column(LAbCash; LAbCash)
            {
            }
            column(PharmCorp; PharmCorp)
            {
            }
            column(PHarmCash; PHarmCash)
            {
            }
            column(AppointmentsCount1_Customer; Customer."Complete pharm count")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Customer.CalcFields("Complete pharm count");
                Customer.CalcFields("Complete Lab count");
                Customer.CalcFields("Complete Inpatient Count");

                LAbCash := 0;
                LabCorporate := 0;
                Completepharmcount := 0;

                QryPharm.SetFilter(QryPharm.Insurance_Code, Customer."No.");
                QryPharm.SetFilter(QryPharm.Pharmacy_Date, Customer.GetFilter("Date Filter"));
                QryPharm.Open();
                while QryPharm.Read() do
                    Completepharmcount := Completepharmcount + 1;

                QryPharm.Close();

                LabFormHeader.Reset();
                LabFormHeader.SetFilter(LabFormHeader."Patient No.", 'W*');// TODO: Get Implementatin of getting Walkin Visits
                LabFormHeader.SetFilter(LabFormHeader."Laboratory Date", Customer.GetFilter("Date Filter"));
                LabFormHeader.SetRange(LabFormHeader.Status, LabFormHeader.Status::Completed);
                if LabFormHeader.Find('-') then
                    LabWalking := LabFormHeader.Count;

                LabFormHeader.Reset();
                LabFormHeader.SetFilter(LabFormHeader."Settlement Type", '%1', LabFormHeader."settlement type"::Cash);
                LabFormHeader.SetFilter(LabFormHeader."Laboratory Date", Customer.GetFilter("Date Filter"));
                LabFormHeader.SetRange(LabFormHeader.Status, LabFormHeader.Status::Completed);
                if LabFormHeader.Find('-') then
                    LabWalking := LabFormHeader.Count;

                LabTestLine.Reset();
                LabTestLine.SetFilter(LabTestLine."Lab Date", Customer.GetFilter("Date Filter"));
                LabTestLine.SetRange(LabTestLine.Completed, true);
                if LabTestLine.Find('-') then
                    repeat
                        LabTestLine.CalcFields("patient Type");
                        if LabTestLine."patient Type" = LabTestLine."patient type"::Corporate then
                            // LabTestLine.CalcFields(Amount);
                            LabCorporate := LabCorporate + LabTestLine.Amount
                        else
                            //LabTestLine.CalcFields(Amount);
                            LAbCash := LAbCash + LabTestLine.Amount;
                    until LabTestLine.Next() = 0;

                PharmacyHeader.Reset();
                PharmacyHeader.SetFilter(PharmacyHeader."Patient No.", 'W*'); // TODO: Get Implementatin of getting Walkin Visits
                PharmacyHeader.SetFilter(PharmacyHeader."Pharmacy Date", Customer.GetFilter("Date Filter"));
                PharmacyHeader.SetRange(PharmacyHeader.Status, PharmacyHeader.Status::Completed);
                if PharmacyHeader.Find('-') then
                    PharmWalkin := PharmacyHeader.Count;

                /*
                PatCharges.RESET;
                PatCharges.SETFILTER(PatCharges.Date,Customer.GETFILTER("Date Filter"));
                PatCharges.SETRANGE(PatCharges.Posted,TRUE);
                PatCharges.SETFILTER(PatCharges."Transaction Type",'PHARM|NON_PHARM');
                IF PatCharges.FIND('-') THEN BEGIN REPEAT
                  PatCharges.CALCFIELDS(PatCharges."Patient Type Lk");
                  IF PatCharges."Patient Type Lk" = PatCharges."Patient Type Lk"::Corporate THEN BEGIN
                    PharmCorp := PharmCorp + PatCharges."Insurance Amount";
                  END ELSE BEGIN
                   PHarmCash := PHarmCash + PatCharges.Amount;
                  END;
                UNTIL PatCharges.NEXT=0;
                END;
                */

                PharmLine.Reset();
                PharmLine.SetFilter(PharmLine.Date, Customer.GetFilter("Date Filter"));
                PharmLine.SetFilter(PharmLine."Insurance No1", '<>%1', 'C-0001');
                PharmLine.SetRange(PharmLine.Status, PharmLine.Status::Completed);

                if PharmLine.Find('-') then
                    repeat
                        PharmLine.CalcFields("Sale type");
                        if PharmLine."Sale type" = false then
                            //PharmLine.CALCFIELDS("Total Price");
                            PharmCorp := PharmCorp + PharmLine."Insurance Total Amount"
                        else
                            // PharmLine.CALCFIELDS("Total Price");
                            PHarmCash := PHarmCash + PharmLine."Insurance Total Amount";
                    until PharmLine.Next() = 0;

                if ("Complete pharm count" = 0) and ("Complete Lab count" = 0) and ("Complete Inpatient Count" = 0) then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                CompInfor.Get();
                CompInfor.CalcFields(Picture);
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
        CompInfor: Record "Company Information";
        LabFormHeader: Record "HMS Laboratory Form Header";
        LabTestLine: Record "HMS Laboratory Test Line";
        PharmacyHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        QryPharm: Query hmsPharm;
        LAbCash: Decimal;
        LabCorporate: Decimal;
        PHarmCash: Decimal;
        PharmCorp: Decimal;
        Completepharmcount: Integer;
        LabWalking: Integer;
        PharmWalkin: Integer;
        TriageWalking: Integer;
}
