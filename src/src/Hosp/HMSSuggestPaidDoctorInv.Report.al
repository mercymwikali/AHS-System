Report 52202465 "HMS Suggest Paid Doctor Inv"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HMS Patient Visit Nos"; "HMS Patient Visit Nos")
        {
            DataItemTableView = where("Doctor Amount" = filter(> 0), "Doctor ID" = filter(<> ''), Posted = const(true), "Vendor Exists" = filter(> 0), Show = const(False));
            RequestFilterFields = "Doctor ID";
            column(ReportForNavId_1; 1)
            {
            }
            column(PatientNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Patient No")
            {
            }
            column(VisitNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Visit No")
            {
            }
            column(Balance_HMSPatientVisitNos; "HMS Patient Visit Nos".Balance)
            {
            }
            column(DoctorAmount_HMSPatientVisitNos; "HMS Patient Visit Nos"."Doctor Amount")
            {
            }
            column(Names; "HMS Patient".Names)
            {
            }
            column(SearchName_HMSPatientSearchName; "HMS Patient"."Search Name")
            {
            }
            column(nDate; dtVDate)
            {
            }
            column(InsuranceNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Insurance No")
            {
            }
            column(InsuranceNM; InsuranceNM)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HMS Patient Visit Nos".Validate("Fully Paid");
                if "HMS Patient Visit Nos"."Fully Paid" = true then begin
                    "HMS Patient Visit Nos".Show := true;
                    "HMS Patient Visit Nos".Modify();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PostInv; PostInv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Invoice';
                    ToolTip = 'Specifies the value of the Post Invoice field.';
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
        "HMS Patient": Record "HMS Patient";
        PostInv: Boolean;
        dtVDate: Date;
        InsuranceNM: Text;
}
