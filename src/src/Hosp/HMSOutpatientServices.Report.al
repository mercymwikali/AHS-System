Report 52202523 "HMS Outpatient Services"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSOutpatientServices.rdl';

    dataset
    {
        dataitem("HMS Cue"; "HMS Cue")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(OPattless5Male_HMSCue; "HMS Cue"."O/P att < 5 Male New")
            {
            }
            column(OPattless5Female_HMSCue; "HMS Cue"."O/P att < 5 Female New")
            {
            }
            column(OPatt5Male_HMSCue; "HMS Cue"."O/P att > 5 Male New")
            {
            }
            column(OPatt5Female_HMSCue; "HMS Cue"."O/P att > 5 Female New")
            {
            }
            column(OPattCasualty_HMSCue; "HMS Cue"."O/P att Casualty New")
            {
            }
            column(PrimaryKey_HMSCue; "HMS Cue"."Primary Key")
            {
            }
            column(REVOPattless5MaleRevisit_HMSCue; "HMS Cue"."O/P att < 5 Male Revisit")
            {
            }
            column(REVOPattless5FemaleRevisit_HMSCue; "HMS Cue"."O/P att < 5 Female Revisit")
            {
            }
            column(REVOPattover5MaleRevisit_HMSCue; "HMS Cue"."O/P att > 5 Male Revisit")
            {
            }
            column(REVOPattover5FemaleRevisit_HMSCue; "HMS Cue"."O/P att > 5 Female Revisit")
            {
            }
            column(REVOPattCasualtyRevisit_HMSCue; "HMS Cue"."O/P att Casualty Revisit")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //SETFILTER(CurrentDate,'%1..%2',DMY2DATE(1,DATE2DMY(WORKDATE,2)),WORKDATE);
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
}
