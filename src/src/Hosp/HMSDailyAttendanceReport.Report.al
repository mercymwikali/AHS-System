Report 52202459 "HMS Daily Attendance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Patients/HMSDailyAttendanceReport.rdl';

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 .. 31));
            RequestFilterFields = Number;
            column(ReportForNavId_5444; 5444)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Records_of_daily_attendance_for_the_month_of____FORMAT_Month_; 'Records of daily attendance for the month of ' + Format(Month))
            {
            }
            column(stfMsn; stfMsn)
            {
            }
            column(dtDate; dtDate)
            {
            }
            column(dpnMsn; dpnMsn)
            {
            }
            column(stfKsm; stfKsm)
            {
            }
            column(stuMsn; stuMsn)
            {
            }
            column(dpnKsm; dpnKsm)
            {
            }
            column(othMsn; othMsn)
            {
            }
            column(stuKsm; stuKsm)
            {
            }
            column(stfMsn___dpnMsn___stuMsn___othMsn; stfMsn + dpnMsn + stuMsn + othMsn)
            {
            }
            column(othKsm; othKsm)
            {
            }
            column(stfKsm___dpnKsm___stuKsm___othKsm; stfKsm + dpnKsm + stuKsm + othKsm)
            {
            }
            column(GstfMsn; GstfMsn)
            {
            }
            column(GstfKsm; GstfKsm)
            {
            }
            column(GdpnMsn; GdpnMsn)
            {
            }
            column(GdpnKsm; GdpnKsm)
            {
            }
            column(GstuMsn; GstuMsn)
            {
            }
            column(GstuKsm; GstuKsm)
            {
            }
            column(GothMsn; GothMsn)
            {
            }
            column(GstuKsm_Control1102760067; GstuKsm)
            {
            }
            column(GstfMsn___GdpnMsn___GstuMsn___GothMsn; GstfMsn + GdpnMsn + GstuMsn + GothMsn)
            {
            }
            column(GstfKsm___GdpnKsm___GstuKsm___GothKsm; GstfKsm + GdpnKsm + GstuKsm + GothKsm)
            {
            }
            column(UserId; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(GstfMsn___GdpnMsn___GstuMsn___GothMsn__UpperLimit; (GstfMsn + GdpnMsn + GstuMsn + GothMsn) / UpperLimit)
            {
            }
            column(GstfKsm___GdpnKsm___GstuKsm___GothKsm__UpperLimit; (GstfKsm + GdpnKsm + GstuKsm + GothKsm) / UpperLimit)
            {
            }
            column(GstfMsn___GdpnMsn___GstuMsn___GothMsn__GstfKsm___GdpnKsm___GstuKsm___GothKsm__UpperLimit; (GstfMsn + GdpnMsn + GstuMsn + GothMsn + GstfKsm + GdpnKsm + GstuKsm + GothKsm) / UpperLimit)
            {
            }
            column(HEALTH_SERVICESCaption; HEALTH_SERVICESCaptionLbl)
            {
            }
            column(DATECaption; DATECaptionLbl)
            {
            }
            column(MAINCaption; MAINCaptionLbl)
            {
            }
            column(OTHERCaption; OTHERCaptionLbl)
            {
            }
            column(MAINCaption_Control1102760007; MAINCaption_Control1102760007Lbl)
            {
            }
            column(OTHERCaption_Control1102760008; OTHERCaption_Control1102760008Lbl)
            {
            }
            column(MAINCaption_Control1102760009; MAINCaption_Control1102760009Lbl)
            {
            }
            column(OTHERCaption_Control1102760010; OTHERCaption_Control1102760010Lbl)
            {
            }
            column(MAINCaption_Control1102760011; MAINCaption_Control1102760011Lbl)
            {
            }
            column(OTHERCaption_Control1102760012; OTHERCaption_Control1102760012Lbl)
            {
            }
            column(MAINCaption_Control1102760013; MAINCaption_Control1102760013Lbl)
            {
            }
            column(MAINCaption_Control1102760014; MAINCaption_Control1102760014Lbl)
            {
            }
            column(STAFFCaption; STAFFCaptionLbl)
            {
            }
            column(DEPENDANTCaption; DEPENDANTCaptionLbl)
            {
            }
            column(STUDENTCaption; STUDENTCaptionLbl)
            {
            }
            column(OTHERSCaption; OTHERSCaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(TOTALCaption_Control1102760059; TOTALCaption_Control1102760059Lbl)
            {
            }
            column(Source__OP_Registers__OTHER___MAIN_Caption; Source__OP_Registers__OTHER___MAIN_CaptionLbl)
            {
            }
            column(Compiled_by_Caption; Compiled_by_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Av__Daily_Attendance_OTHER_Caption; Av__Daily_Attendance_OTHER_CaptionLbl)
            {
            }
            column(Av__Daily_Attendance_MAIN_Caption; Av__Daily_Attendance_MAIN_CaptionLbl)
            {
            }
            column(Av__Daily_Attendance__OTHER___MAIN__Caption; Av__Daily_Attendance__OTHER___MAIN__CaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
            dataitem("HMS Appointment Form Header"; "HMS Appointment Form Header")
            {
                column(ReportForNavId_1; 1)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                /*Reset the values as required*/
                /*Check if the upper limit has been reached*/
                if UpperLimit < Number then
                    exit;
                dtDate := Dmy2date(Number, IntMonth, Year);

                /*Get the number of staff members in maseno*/
                Treatment.Reset();
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                Treatment.SetRange(Treatment."Treatment Type", Treatment."treatment type"::Outpatient);
                Treatment.SetRange(Treatment."Treatment Date", dtDate);
                Treatment.SetRange(Treatment."Patient Type", Treatment."patient type"::Cash);
                Treatment.SetRange(Treatment.Status, Treatment.Status::Completed);
                stfMsn := Treatment.Count;
                GstfMsn := GstfMsn + stfMsn;

                Treatment.Reset();
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                Treatment.SetRange(Treatment."Treatment Type", Treatment."treatment type"::Outpatient);
                Treatment.SetRange(Treatment."Treatment Date", dtDate);
                Treatment.SetRange(Treatment."Patient Type", Treatment."patient type"::" ");
                Treatment.SetRange(Treatment.Status, Treatment.Status::Completed);
                dpnMsn := Treatment.Count;
                GdpnMsn := GdpnMsn + dpnMsn;

                Treatment.Reset();
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                //Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
                Treatment.SetRange(Treatment."Treatment Date", dtDate);
                Treatment.SetRange(Treatment."Patient Type", Treatment."patient type"::Corporate);
                Treatment.SetRange(Treatment.Status, Treatment.Status::Completed);
                stuMsn := Treatment.Count;
                GstuMsn := GstuMsn + stuMsn;

                Treatment.Reset();
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                Treatment.SetRange(Treatment."Treatment Type", Treatment."treatment type"::Outpatient);
                Treatment.SetRange(Treatment."Treatment Date", dtDate);
                Treatment.SetRange(Treatment."Patient Type", Treatment."patient type"::" ");
                Treatment.SetRange(Treatment.Status, Treatment.Status::Completed);
                othMsn := Treatment.Count;
                GothMsn := GothMsn + othMsn;
                /*
               {Get the details for kisumu}
               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Employee);
               stfKsm:=Treatment.COUNT;
               GstfKsm :=GstfKsm + stfKsm;

               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Relative);
               dpnKsm:=Treatment.COUNT;
               GdpnKsm:=GdpnKsm + dpnKsm;

               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Student);
               stuKsm:=Treatment.COUNT;
               GstuKsm:=GstuKsm + stuKsm;

               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Others);
               othKsm:=Treatment.COUNT;
               GothKsm:=GothKsm + othKsm;
                */
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Number);
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

    trigger OnInitReport()
    begin
        Year := Date2dmy(Today, 3);
    end;

    trigger OnPreReport()
    begin
        /*Check the month that the user has selected*/
        if Month = Month::January then
            IntMonth := 1
        else
            if Month = Month::February then
                IntMonth := 2
            else
                if Month = Month::March then
                    IntMonth := 3
                else
                    if Month = Month::April then
                        IntMonth := 4
                    else
                        if Month = Month::May then
                            IntMonth := 5
                        else
                            if Month = Month::June then
                                IntMonth := 6
                            else
                                if Month = Month::July then
                                    IntMonth := 7
                                else
                                    if Month = Month::August then
                                        IntMonth := 8
                                    else
                                        if Month = Month::September then
                                            IntMonth := 9
                                        else
                                            if Month = Month::October then
                                                IntMonth := 10
                                            else
                                                if Month = Month::November then
                                                    IntMonth := 11
                                                else
                                                    if Month = Month::December then
                                                        IntMonth := 12;
        /*Determine the upper limit*/
        UpperLimit := HRDates.DetermineDaysInMonth(IntMonth, Year);
    end;

    var
        Treatment: Record "HMS Treatment Form Header";
        HRDates: Codeunit "HR Dates";
        dtDate: Date;
        dpnKsm: Integer;
        dpnMsn: Integer;
        GdpnKsm: Integer;
        GdpnMsn: Integer;
        GothKsm: Integer;
        GothMsn: Integer;
        GstfKsm: Integer;
        GstfMsn: Integer;
        GstuKsm: Integer;
        GstuMsn: Integer;
        IntMonth: Integer;
        LastFieldNo: Integer;
        othKsm: Integer;
        othMsn: Integer;
        stfKsm: Integer;
        stfMsn: Integer;
        stuKsm: Integer;
        stuMsn: Integer;
        UpperLimit: Integer;
        Year: Integer;
        Av__Daily_Attendance__OTHER___MAIN__CaptionLbl: label 'Av. Daily Attendance (OTHER + MAIN)=';
        Av__Daily_Attendance_MAIN_CaptionLbl: label 'Av. Daily Attendance MAIN=';
        Av__Daily_Attendance_OTHER_CaptionLbl: label 'Av. Daily Attendance OTHER=';
        Compiled_by_CaptionLbl: label 'Compiled by:';
        Date_CaptionLbl: label 'Date:';
        DATECaptionLbl: label 'DATE';
        DEPENDANTCaptionLbl: label 'DEPENDANT';
        HEALTH_SERVICESCaptionLbl: label 'HEALTH SERVICES';
        MAINCaption_Control1102760007Lbl: label 'MAIN';
        MAINCaption_Control1102760009Lbl: label 'MAIN';
        MAINCaption_Control1102760011Lbl: label 'MAIN';
        MAINCaption_Control1102760013Lbl: label 'MAIN';
        MAINCaption_Control1102760014Lbl: label 'MAIN';
        MAINCaptionLbl: label 'MAIN';
        OTHERCaption_Control1102760008Lbl: label 'OTHER';
        OTHERCaption_Control1102760010Lbl: label 'OTHER';
        OTHERCaption_Control1102760012Lbl: label 'OTHER';
        OTHERCaptionLbl: label 'OTHER';
        OTHERSCaptionLbl: label 'OTHERS';
        Source__OP_Registers__OTHER___MAIN_CaptionLbl: label 'Source: OP Registers (OTHER + MAIN)';
        STAFFCaptionLbl: label 'STAFF';
        STUDENTCaptionLbl: label 'STUDENT';
        TOTALCaption_Control1102760059Lbl: label 'TOTAL';
        TOTALCaptionLbl: label 'TOTAL';
        Month: Option January,February,March,April,May,June,July,August,September,October,November,December;
}
