Report 85077 "HMS Doctors Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSDoctorsPayments.rdl';

    dataset
    {
        dataitem("HMS Setup Doctor"; "HMS Setup Doctor")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Doctor ID", "Insurance No. Filter";
            column(ReportForNavId_24; 24)
            {
            }
            column(DoctorID_HMSSetupDoctor; "HMS Setup Doctor"."Doctor ID")
            {
            }
            column(DoctorsName_HMSSetupDoctor; "HMS Setup Doctor"."Doctors Name")
            {
            }
            column(PendingAmount_HMSSetupDoctor; "HMS Setup Doctor"."Pending Amount")
            {
            }
            dataitem("HMS Patient Visit Nos"; "HMS Patient Visit Nos")
            {
                DataItemLink = "Doctor ID" = field("Doctor ID"), "Insurance No" = field("Insurance No. Filter"), Completed = field("Completed Filter");
                DataItemTableView = where("Doctor Amount" = filter(> 0), Posted = filter(true), "Doctor%" = filter(> 0), Show = const(true));
                RequestFilterFields = "Patient No", "Doctor ID", "Insurance No";
                column(ReportForNavId_1; 1)
                {
                }
                column(totWHT; totalsWHT)
                {
                }
                column(totHDF; totHDF)
                {
                }
                column(totNet; totNet)
                {
                }
                column(PatientNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Patient No")
                {
                }
                column(SName; HMSPat."Search Name")
                {
                }
                column(VisitNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Visit No")
                {
                }
                column(Balance_HMSPatientVisitNos; "HMS Patient Visit Nos".Balance)
                {
                }
                column(DoctorAmount_HMSPatientVisitNos; "HMS Patient Visit Nos"."Total Amount")
                {
                }
                column(DoctorID_HMSPatientVisitNos; "HMS Patient Visit Nos"."Doctor ID")
                {
                }
                column(DocNames; HMSDocs."Doctors Name")
                {
                }
                column(WHT; WHT)
                {
                }
                column(InvoiceNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Invoice No")
                {
                }
                column(HDF; HDF)
                {
                }
                column(Net; Net)
                {
                }
                column(CompLogo; CompInf.Picture)
                {
                }
                column(CompName; CompInf.Name)
                {
                }
                column(VendName; InsuranceName)
                {
                }
                column(InsWHT; InsWHT)
                {
                }
                column(InsHDF; InsHDF)
                {
                }
                column(TotalWHT_HMSPatientVisitNos; "HMS Patient Visit Nos"."Total WHT")
                {
                }
                column(TotalHDF_HMSPatientVisitNos; "HMS Patient Visit Nos"."Total HDF")
                {
                }
                column(TotalGross_HMSPatientVisitNos; "HMS Patient Visit Nos"."Total Gross")
                {
                }
                column(TotalNET_HMSPatientVisitNos; "HMS Patient Visit Nos"."Total NET")
                {
                }
                column(DoctorGross; DoctorGross)
                {
                }
                column(totNett; totNett)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    intQuantity := 1;

                    InsuranceName := 'Cash Payment';
                    "HMS Patient Visit Nos".CalcFields("Insurance No");
                    if Cust.Get("HMS Patient Visit Nos"."Insurance No") then
                        InsuranceName := Cust.Name;

                    if HMSDocs.Get("HMS Patient Visit Nos"."Doctor ID") then;
                    if HMSPat.Get("HMS Patient Visit Nos"."Patient No") then;

                    InsWHT := 0;
                    InsHDF := 0;
                    DOCPAYTemp.Reset();
                    //DOCPAYTemp.SETRANGE(DOCPAYTemp."Ins No","HMS Patient Visit Nos"."Insurance No");
                    if DOCPAYTemp.Find('-') then
                        repeat
                            InsWHT := InsWHT + DOCPAYTemp.WHT;
                            InsHDF := InsHDF + DOCPAYTemp.HDF;
                        until DOCPAYTemp.Next() = 0;

                    Twht := Twht + DoctorGross;

                    /*
                    IF NOT DOCPAYTemp.GET("HMS Patient Visit Nos"."Doctor ID","HMS Patient Visit Nos"."Insurance No") THEN BEGIN
                    DOCPAYTemp.INIT;
                    DOCPAYTemp.No:="HMS Patient Visit Nos"."Doctor ID";
                    DOCPAYTemp."Ins No":="HMS Patient Visit Nos"."Insurance No";
                    DOCPAYTemp.WHT:=WHT;
                    DOCPAYTemp.HDF:=HDF;
                    DOCPAYTemp."Gross Amount":=DoctorGross;
                    DOCPAYTemp."Net Amount":=DoctorGross-WHT-HDF;
                    DOCPAYTemp.INSERT;
                    END;
                    */
                    "HMS Patient Visit Nos".CalcFields("HMS Patient Visit Nos"."Total WHT");
                    "HMS Patient Visit Nos".CalcFields("HMS Patient Visit Nos"."Total HDF");
                end;

                trigger OnPreDataItem()
                begin

                    //"HMS Patient Visit Nos".GETFILTER("HMS Patient Visit Nos"."Insurance Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Net := 0;
                WHT := 0;
                HDF := 0;
                // Doctors Summary
                DoctorGross := 0;
                PatVists.Reset();
                PatVists.SetRange(PatVists."Doctor ID", "HMS Setup Doctor"."Doctor ID");
                PatVists.SetFilter(PatVists."Insurance No", "HMS Setup Doctor".GetFilter("HMS Setup Doctor"."Insurance No. Filter"));
                PatVists.SetRange(PatVists.Posted, true);
                PatVists.SetRange(PatVists.Show, true);
                PatVists.SetFilter(PatVists.Completed, "HMS Setup Doctor".GetFilter("HMS Setup Doctor"."Completed Filter"));
                PatVists.SetFilter(PatVists."Doctor%", '>%1', 0);
                PatVists.SetFilter(PatVists."Batch No", "HMS Patient Visit Nos".GetFilter("Batch No"));
                if PatVists.Find('-') then begin
                    repeat
                        //PatVists.CALCFIELDS(PatVists."Doctor Amount");
                        PatVists.CalcFields(PatVists."Total Amount");
                        PatVists.CalcFields(PatVists.Quantity);
                        intQuantity := PatVists.Quantity;
                        //DoctorGross:=DoctorGross+PatVists."Doctor Amount";
                        DoctorGross := DoctorGross + PatVists."Total Amount";
                    // AllDocGross:=AllDocGross+PatVists."Doctor Amount";
                    until PatVists.Next() = 0;

                    if DoctorGross > 23999 then
                        WHT := DoctorGross * 0.05
                    else
                        WHT := 0;

                    if WHT > 0 then
                        totalsWHT := totalsWHT + WHT;

                    if HMSDocs.Get("HMS Setup Doctor"."Doctor ID") then
                        if HMSDocs.Resident = true then
                            if HMSDocs."HDF%" > 0 then begin
                                HDF := DoctorGross * (HMSDocs."HDF%" * 0.01);
                                totHDF := totHDF + HDF;
                            end
                            else begin
                                HDF := DoctorGross * 0.15;
                                totHDF := totHDF + HDF;
                            end;
                end;
                Net := DoctorGross - WHT - HDF;
                totWHT := totWHT + WHT;
                totNett := totNett + Net;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(CompInf.Picture);
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
        CompInf: Record "Company Information";
        Cust: Record Customer;
        DOCPAYTemp: Record "HMS Doctors Payment Temp";
        HMSPat: Record "HMS Patient";
        PatVists: Record "HMS Patient Visit Nos";
        HMSDocs: Record "HMS Setup Doctor";
        DoctorGross: Decimal;
        HDF: Decimal;
        InsHDF: Decimal;
        InsWHT: Decimal;
        Net: Decimal;
        totalsWHT: Decimal;
        totHDF: Decimal;
        totNet: Decimal;
        totNett: Decimal;
        totWHT: Decimal;
        Twht: Decimal;
        WHT: Decimal;
        intQuantity: Integer;
        InsuranceName: Text[100];
}
