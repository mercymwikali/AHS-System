Table 52202700 "HMS Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "All Out-Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where(Inpatient = filter(false),
                                                     "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(3; "All In-Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where(Inpatient = filter(true),
                                                     "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(4; "Corporate Out Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Corporate),
                                                     Inpatient = filter(false)));
            FieldClass = FlowField;
        }
        field(5; "Corporate In Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Corporate),
                                                     Inpatient = filter(true)));
            FieldClass = FlowField;
        }
        field(6; "Cash Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Cash),
                                                     "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(7; "Walk-In Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Cash),
                                                     "Walk-in" = filter(true)));
            FieldClass = FlowField;
        }
        field(8; CurrentDate; Date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "Today's New Visits"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Status = filter(New)));
            FieldClass = FlowField;
        }
        field(10; "Today's Visits"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(11; "Appointments (Reviews)"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     "Appointment Type" = filter('REVIEW')));
            FieldClass = FlowField;
        }
        field(12; "Appointments (Normal)"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     "Appointment Type" = filter('NORMAL')));
            FieldClass = FlowField;
        }
        field(13; Triages; Integer)
        {
            CalcFormula = count("HMS Observation Form Header" where("Observation Date" = field(CurrentDate)));
            Caption = 'Observations Done Today';
            FieldClass = FlowField;
        }
        field(14; "Today's New-Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Walk-in" = filter(false),
                                                     "Date Registered" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(15; "Today's New-Walk-in Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Walk-in" = filter(true),
                                                     "Date Registered" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(16; "Todays Triage New"; Integer)
        {
            CalcFormula = count("HMS Observation Form Header" where("Observation Date" = field(CurrentDate),
                                                                     Closed = filter(false)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(17; "Todays Triage Closed"; Integer)
        {
            CalcFormula = count("HMS Observation Form Header" where("Observation Date" = field(CurrentDate),
                                                                     Closed = filter(true)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(18; "Pending Treatment"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New)));
            FieldClass = FlowField;
        }
        field(19; "Today's Pending"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            Description = 'HMS Treatment Form Header';
            FieldClass = FlowField;
        }
        field(20; "Today's Completed"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(Completed),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(21; "Completed Treatment"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(22; "Pending Lab Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(New)));
            FieldClass = FlowField;
        }
        field(23; "Today's Pending Lab Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(New),
                                                                    "Laboratory Date" = field(CurrentDate)));
            Description = 'HMS Treatment Form Header';
            FieldClass = FlowField;
        }
        field(24; "Today's Completed Lab Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(Completed),
                                                                    "Laboratory Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(25; "Completed Lab Request"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(26; "Pending Theater Request"; Integer)
        {
            CalcFormula = count("HMS Theatre Form Header" where(Status = filter(New)));
            FieldClass = FlowField;
        }
        field(27; "Today's Pending Theate Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(New),
                                                                    "Laboratory Date" = field(CurrentDate)));
            Description = 'HMS Theatre Form Header';
            FieldClass = FlowField;
        }
        field(28; "Today's Completed Thea Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(Completed),
                                                                    "Laboratory Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(29; "Completed Theater Request"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(30; "Todays ICU New"; Integer)
        {
            CalcFormula = count("HMS ICU Form Header" where(Status = filter(New | Pending)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(31; "Todays ICU Closed"; Integer)
        {
            CalcFormula = count("HMS ICU Form Header" where(Status = filter(Closed)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(32; "Daily Registered Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Date Registered" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(33; "O/P att < 5 Male New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(34; "O/P att < 5 Female New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Female),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(35; "O/P att > 5 Male New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(> 5),
                                                                     Gender = filter(Male),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(36; "O/P att > 5 Female New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(>= 5),
                                                                     Gender = filter(Female),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(37; "O/P att Casualty New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Emergency = filter(true),
                                                                     visitType = filter(New)));
            FieldClass = FlowField;
        }
        field(38; "O/P att < 5 Male Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(39; "O/P att < 5 Female Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Female)));
            FieldClass = FlowField;
        }
        field(40; "O/P att > 5 Male Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(> 5),
                                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(41; "O/P att > 5 Female Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(>= 5),
                                                                     Gender = filter(Female)));
            FieldClass = FlowField;
        }
        field(42; "O/P att Casualty Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Emergency = filter(true),
                                                                     visitType = filter(Revisit)));
            FieldClass = FlowField;
        }
        field(43; ThisMonth; Date)
        {
            FieldClass = FlowFilter;
        }
        field(44; "Orthopaedic Patients"; Integer)
        {
            CalcFormula = count("HMS Theatre Form Header" where("Theatre Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(45; "Physiotherapy Patients"; Integer)
        {
            CalcFormula = count("HMS Physiotheraphy Form Header" where("Physio Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(46; "Medical Patients"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where("Treatment Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(47; "Psychatrist Patients"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where("Treatment Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(48; "Inpatient Discharge Patients"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Discharge Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(49; "Inpatient Death Patients"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Discharge Date" = field(CurrentDate),
                                                                        "Discharge Type" = filter(Deceased)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50; "Inpatient NHIF Patients"; Integer)
        {
            CalcFormula = count("HMS Admission Form Header" where(NHIF = filter(true),
                                                                   "Admission Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
