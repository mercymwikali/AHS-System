Report 85144 "Laboratory Insurance Count"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LaboratoryInsuranceCount.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("No." = filter(<> 'C-00078'), "Customer Type" = filter(Customer));
            RequestFilterFields = "Date Filter";
            column(ReportForNavId_5; 5)
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
            column(insurancecode; Customer."No.")
            {
            }
            column(insuranceName; Customer.Name)
            {
            }
            column(countsx; countsx)
            {
            }
            column(From; startdate)
            {
            }
            column("To"; EndDate)
            {
            }
            column(Printed_By; Puser)
            {
            }

            trigger OnAfterGetRecord()
            begin
                countsx := 0;

                startdate := CopyStr(GetFilter(Customer."Date Filter"), 1, 8);
                EndDate := CopyStr(GetFilter(Customer."Date Filter"), 11, 8);

                "HMSForm Header".Reset();
                "HMSForm Header".SetFilter("HMSForm Header"."Lab Date", '%1..%2', dtStart, dtEnd);
                if "HMSForm Header".Find('-') then
                    repeat
                        "HMSForm Header".CalcFields("Insurance Code");
                        if "HMSForm Header"."Insurance Code" = Customer."No." then
                            countsx := countsx + 1;
                    until "HMSForm Header".Next() = 0;

                // END;

                if countsx = 0 then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                Extprice := 0;
                Pname := '';
                CompInfor.Get();
                CompInfor.CalcFields(Picture);
                Pdate := Today;
                ptime := Time;
                Puser := UserId;
                Fname := '';
                Mname := '';
                Lname := '';
                countsx := 0;
                DateD := 0D;
                counts := 0;
                Quanty := 0;
                InsuranceCode := '';
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(dtStart; dtStart)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(dtEnd; dtEnd)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
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
        "HMSForm Header": Record "HMS Laboratory Test Line";
        InsuranceCode: Code[30];
        Puser: Code[50];
        DateD: Date;
        dtEnd: Date;
        dtStart: Date;
        Pdate: Date;
        Extprice: Decimal;
        counts: Integer;
        countsx: Integer;
        Quanty: Integer;
        EndDate: Text;
        Fname: Text;
        Lname: Text;
        Mname: Text;
        Pname: Text;
        startdate: Text;
        ptime: Time;

    local procedure GetPatientName()
    begin
    end;
}
