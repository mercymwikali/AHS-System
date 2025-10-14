Report 52202471 "Laboratory Detailed Report2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LaboratoryDetailedReport2.rdl';

    dataset
    {
        dataitem("HMS Laboratory Test Line"; "HMS Laboratory Test Line")
        {
            CalcFields = "Lab Date";
            DataItemTableView = where(Completed = filter(true));
            RequestFilterFields = "Insurance Code", "Lab Date";
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
            column(Printed_On; Pdate)
            {
            }
            column(Printed_Time; ptime)
            {
            }
            column(Printed_By; Puser)
            {
            }
            column(Code_HMSPatientCharges; "HMS Laboratory Test Line"."Laboratory Test Code")
            {
            }
            column(Description_HMSPatientCharges; Pname)
            {
            }
            column(Amount_HMSPatientCharges; "HMS Laboratory Test Line".Amount)
            {
            }
            column(Quantity_HMSPatientCharges; Quanty)
            {
            }
            column(Ext_Price; Extprice)
            {
            }
            column(Patient_Name; Pname)
            {
            }
            column(First_Name; Fname)
            {
            }
            column(Middle_Name; Mname)
            {
            }
            column(Last_Name; Lname)
            {
            }
            column(Patient_ID; PatientID)
            {
            }
            column(From; startdate)
            {
            }
            column("To"; EndDate)
            {
            }
            column(Total_Amount; TotalAmount)
            {
            }
            column(InsuranceName_HMSLaboratoryTestLine; "HMS Laboratory Test Line"."Insurance Name")
            {
            }
            column(InsuranceCode_HMSLaboratoryTestLine; "HMS Laboratory Test Line"."Insurance Code")
            {
            }
            column(TotalAmt; Extprice * Quanty)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Quanty := 0;
                GetPatientName();
                Pform.Reset();
                Pform.SetRange(Pform.Code, "HMS Laboratory Test Line"."Laboratory Test Code");
                Pform.SetRange(Pform."Transaction Type", 'LABORATORY');
                if Pform.Find('-') then begin
                    //REPEAT
                    Extprice := "HMS Laboratory Test Line".Amount;
                    Pname := Pform.Description;

                    TotalAmount := Quanty * "HMS Laboratory Test Line".Amount;
                    Lform.Reset();
                    Lform.SetRange(Lform."Laboratory Test Code", "HMS Laboratory Test Line"."Laboratory Test Code");
                    if Lform.Find('-') then
                        Quanty := Quanty + 1;
                end;
                startdate := CopyStr(GetFilter("HMS Laboratory Test Line"."Lab Date"), 1, 8);
                EndDate := CopyStr(GetFilter("HMS Laboratory Test Line"."Lab Date"), 11, 8);
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
        Lform: Record "HMS Laboratory Test Line";
        Pform: Record "HMS Patient Charges";
        PatientID: Code[10];
        InsuranceCode: Code[30];
        Puser: Code[50];
        DateD: Date;
        Pdate: Date;
        Extprice: Decimal;
        TotalAmount: Decimal;
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
        "HMS Laboratory Test Line".DateFilter := "HMS Laboratory Test Line"."Lab Date";
        "HMS Laboratory Test Line".Modify();
    end;
}
