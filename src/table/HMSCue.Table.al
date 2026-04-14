Table 85182 "HMS Cue"
{
    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
        }
        field(50001; "All Out-Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where(Inpatient = filter(false),
                                                     "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(50002; "All In-Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where(Inpatient = filter(true),
                                                     "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(50003; "Corporate Out Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Corporate),
                                                     Inpatient = filter(false)));
            FieldClass = FlowField;
        }
        field(50004; "Corporate In Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Corporate),
                                                     Inpatient = filter(true)));
            FieldClass = FlowField;
        }
        field(50005; "Cash Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Cash),
                                                     "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(50006; "Walk-In Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Patient Type" = filter(Cash),
                                                     "Walk-in" = filter(true)));
            FieldClass = FlowField;
        }
        field(50007; CurrentDate; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50008; "Today's New Visits"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Status = filter(New)));
            FieldClass = FlowField;
        }
        field(50009; "Today's Visits"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(50010; "Appointments (Reviews)"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     "Appointment Type" = filter('REVIEW')));
            FieldClass = FlowField;
        }
        field(50011; "Appointments (Normal)"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     "Appointment Type" = filter('NORMAL')));
            FieldClass = FlowField;
        }
        field(50012; Triages; Integer)
        {
            CalcFormula = count("HMS Observation Form Header" where("Observation Date" = field(CurrentDate)));
            Caption = 'Observations Done Today';
            FieldClass = FlowField;
        }
        field(50013; "Today's New-Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Walk-in" = filter(false),
                                                     "Date Registered" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50014; "Today's New-Walk-in Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Walk-in" = filter(true),
                                                     "Date Registered" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50015; "Todays Triage New"; Integer)
        {
            CalcFormula = count("HMS Observation Form Header" where("Observation Date" = field(CurrentDate),
                                                                     Closed = filter(false)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(50016; "Todays Triage Closed"; Integer)
        {
            CalcFormula = count("HMS Observation Form Header" where("Observation Date" = field(CurrentDate),
                                                                     Closed = filter(true)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(50017; "Pending Treatment"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New)));
            FieldClass = FlowField;
        }
        field(50018; "Today's Pending"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            Description = 'HMS Treatment Form Header';
            FieldClass = FlowField;
        }
        field(50019; "Today's Completed"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(Completed),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50020; "Completed Treatment"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50021; "Pending Lab Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(New)));
            FieldClass = FlowField;
        }
        field(50022; "Today's Pending Lab Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(New),
                                                                    "Laboratory Date" = field(CurrentDate)));
            Description = 'HMS Treatment Form Header';
            FieldClass = FlowField;
        }
        field(50023; "Today's Completed Lab Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(Completed),
                                                                    "Laboratory Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50024; "Completed Lab Request"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50025; "Pending Theater Request"; Integer)
        {
            CalcFormula = count("HMS Theatre Form Header" where(Status = filter(New)));
            FieldClass = FlowField;
        }
        field(50026; "Today's Pending Theate Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(New),
                                                                    "Laboratory Date" = field(CurrentDate)));
            Description = 'HMS Theatre Form Header';
            FieldClass = FlowField;
        }
        field(50027; "Today's Completed Thea Request"; Integer)
        {
            CalcFormula = count("HMS Laboratory Form Header" where(Status = filter(Completed),
                                                                    "Laboratory Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50028; "Completed Theater Request"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where(Status = filter(New),
                                                                   "Treatment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50029; "Todays ICU New"; Integer)
        {
            CalcFormula = count("HMS ICU Form Header" where(Status = filter(New | Pending)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(50030; "Todays ICU Closed"; Integer)
        {
            CalcFormula = count("HMS ICU Form Header" where(Status = filter(Closed)));
            Description = 'Todays Triage New';
            FieldClass = FlowField;
        }
        field(50031; "Daily Registered Patients"; Integer)
        {
            CalcFormula = count("HMS Patient" where("Date Registered" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50032; "O/P att < 5 Male New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(50033; "O/P att < 5 Female New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Female),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(50034; "O/P att > 5 Male New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(> 5),
                                                                     Gender = filter(Male),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(50035; "O/P att > 5 Female New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(New),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(>= 5),
                                                                     Gender = filter(Female),
                                                                     Status = filter(<> New)));
            FieldClass = FlowField;
        }
        field(50036; "O/P att Casualty New"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Emergency = filter(true),
                                                                     visitType = filter(New)));
            FieldClass = FlowField;
        }
        field(50037; "O/P att < 5 Male Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(50038; "O/P att < 5 Female Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(< 5),
                                                                     Gender = filter(Female)));
            FieldClass = FlowField;
        }
        field(50039; "O/P att > 5 Male Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(> 5),
                                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(50040; "O/P att > 5 Female Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(visitType = filter(Revisit),
                                                                     "Appointment Date" = field(CurrentDate),
                                                                     "Age in Years" = filter(>= 5),
                                                                     Gender = filter(Female)));
            FieldClass = FlowField;
        }
        field(50041; "O/P att Casualty Revisit"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate),
                                                                     Emergency = filter(true),
                                                                     visitType = filter(Revisit)));
            FieldClass = FlowField;
        }
        field(50042; ThisMonth; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50043; "Orthopaedic Patients"; Integer)
        {
            CalcFormula = count("HMS Theatre Form Header" where("Theatre Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50044; "Physiotherapy Patients"; Integer)
        {
            CalcFormula = count("HMS Physiotheraphy Form Header" where("Physio Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50045; "Medical Patients"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where("Treatment Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50046; "Psychatrist Patients"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Header" where("Treatment Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50047; "Inpatient Discharge Patients"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Discharge Date" = field(CurrentDate)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50048; "Inpatient Death Patients"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Discharge Date" = field(CurrentDate),
                                                                        "Discharge Type" = filter(Deceased)));
            Description = 'Registry';
            FieldClass = FlowField;
        }
        field(50049; "Inpatient NHIF Patients"; Integer)
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
