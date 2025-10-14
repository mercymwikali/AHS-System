Report 52202519 "HMS Fluid Balance Fluid Chart"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSFluidBalanceFluidChart.rdl';

    dataset
    {
        dataitem("HMS Fluid Balance Chart"; "HMS Fluid Balance Chart")
        {
            RequestFilterFields = "Patient No", "Admission No";
            column(ReportForNavId_1; 1)
            {
            }
            column(IntakeType_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."IV Intake Type")
            {
            }
            column(IntakeAmount_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."IV Intake Amount")
            {
            }
            column(Infused_HMSFluidBalanceChart; "HMS Fluid Balance Chart".Infused)
            {
            }
            column(AlimentaryIntakeAmount_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Alimentary Intake Amount")
            {
            }
            column(AlimentaryIntakeType_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Alimentary Intake Type")
            {
            }
            column(VomitAmount_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Vomit Amount")
            {
            }
            column(StoolAmount_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Stool Amount")
            {
            }
            column(NGastAmount_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."N\Gast Amount")
            {
            }
            column(UrineAmount_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Urine Amount")
            {
            }
            column(OthersAmount_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Others Amount")
            {
            }
            column(Weight_HMSFluidBalanceChart; "HMS Fluid Balance Chart".Weight)
            {
            }
            column(PatientNo_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Patient No")
            {
            }
            column(AdmissionNo_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Admission No")
            {
            }
            column(FluidBalance_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Fluid Balance")
            {
            }
            column(IntakeDate_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Intake Date")
            {
            }
            column(Timings_HMSFluidBalanceChart; "HMS Fluid Balance Chart".Timings)
            {
            }
            column(TimePeriod_HMSFluidBalanceChart; "HMS Fluid Balance Chart"."Time Period")
            {
            }
            column(tWeight; tWeight)
            {
            }
            column(Age; PatRec."Age in Years")
            {
            }
            column(PatName; PatRec.Surname + ' ' + PatRec."Last Name")
            {
            }
            column(Ward; AdmRec.Ward)
            {
            }
            column(Bed; AdmRec.Bed)
            {
            }
            column(Doctors; Doctors)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if PatRec.Get("HMS Fluid Balance Chart"."Patient No") then;
                if AdmRec.Get("HMS Fluid Balance Chart"."Admission No") then;
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
        AdmRec: Record "HMS Admission Form Header";
        PatRec: Record "HMS Patient";
        tWeight: Decimal;
        Doctors: Text;
}
