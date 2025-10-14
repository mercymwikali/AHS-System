Report 52202490 "Patients Capitition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PatientsCapitition.rdl';

    dataset
    {
        dataitem("Capitution Buffer Report"; "Capitution Buffer Report")
        {
            RequestFilterFields = Date;
            column(ReportForNavId_2; 2)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(cname; CompInfor.Name)
            {
            }
            column(Caddress; CompInfor.Address)
            {
            }
            column(ccity; CompInfor.City)
            {
            }
            column(cmobile; CompInfor."Phone No.")
            {
            }
            column(Cpic; CompInfor.Picture)
            {
            }
            column(Printed_On; Pdate)
            {
            }
            column(Printed_Time; ptime)
            {
            }
            column(Printed_By; Puser)
            {
            }
            column(From; startdate)
            {
            }
            column("To"; EndDate)
            {
            }
            column(TransactionType_HMSPatientCharges; "Capitution Buffer Report"."Dimension Code")
            {
            }
            column(No_Of_Patients; NoPatients)
            {
            }
            column(Amount_HMSPatientCharges; "Capitution Buffer Report".Cost)
            {
            }
            column(InsuranceNo_HMSPatientCharges; "Capitution Buffer Report"."Insurance Code")
            {
            }
            column(Date_CapitutionBufferReport; "Capitution Buffer Report".Date)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Buffer.Reset();
                Buffer.SetRange(Buffer."Pantient No", "Capitution Buffer Report"."Pantient No");
                Buffer.SetRange(Buffer.Date, "Capitution Buffer Report".Date);
                if Buffer.Find('-') = true then
                    NoPatients := 1;

                startdate := CopyStr(GetFilter("Capitution Buffer Report".Date), 1, 8);
                EndDate := CopyStr(GetFilter("Capitution Buffer Report".Date), 11, 8);
            end;

            trigger OnPreDataItem()
            begin
                CompInfor.Get();
                CompInfor.CalcFields(Picture);
                Pdate := WorkDate();
                ptime := Time;
                Puser := UserId;
                NoPatients := 0;
                TotalAmount := 0;
                Lab := 0;
                Report.Run(70134790, true, true);
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
        Buffer: Record "Capitution Buffer Report";
        CompInfor: Record "Company Information";
        Puser: Code[50];
        Pdate: Date;
        TotalAmount: Decimal;
        Lab: Integer;
        NoPatients: Integer;
        EndDate: Text;
        startdate: Text;
        ptime: Time;

    local procedure PHAMCY()
    begin
    end;
}
