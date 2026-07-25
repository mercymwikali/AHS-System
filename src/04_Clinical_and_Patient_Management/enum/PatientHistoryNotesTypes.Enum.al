namespace PTL.HMIS;

enum 85017 "Patient History Notes Types"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Chief Complaints")
    {
        Caption = 'Chief Complaints';
    }
    value(2; Allegations)
    {
        Caption = 'Allegations';
    }
    value(3; "History of Presenting Complaint")
    {
        Caption = 'History of Presenting Complaint';
    }
    value(4; "Risk History")
    {
        Caption = 'Risk History';
    }
    value(5; "Past Psychiatric and Medical History")
    {
        Caption = 'Past Psychiatric and Medical History';
    }
    value(6; "Family History")
    {
        Caption = 'Family History';
    }
    value(7; "Personal History")
    {
        Caption = 'Personal History';
    }
    value(8; "Forensic History")
    {
        Caption = 'Forensic History';
    }
    value(9; "Premorbid Personality")
    {
        Caption = 'Premorbid Personality';
    }
    value(10; "General Examination")
    {
        Caption = 'General Examination';
    }
    value(11; "Diagnostic Formulation")
    {
        Caption = 'Diagnostic Formulation';
    }
    value(12; "Predisposing Factors")
    {
        Caption = 'Predisposing Factors';
    }
    value(13; "Precipitating Factors")
    {
        Caption = 'Precipitating Factors';
    }
    value(14; "Perpetuating Factors") // TODO: Create a new table with diagnosis code then a factor then its description
    {
        Caption = 'Perpetuating Factors';
    }
    value(15; "Protective Factors")
    {
        Caption = 'Protective Factors';
    }
    value(16; "Central Nervous system")
    {
        Caption = 'Central Nervous system';
    }
    value(17; "Cardiovascular system")
    {
        Caption = 'Cardiovascular system';
    }
    value(18; "Respiratory system")
    {
        Caption = 'Respiratory system';
    }
    value(19; "Abdomen")
    {
        Caption = 'Abdomen';
    }
    value(20; "Medical")
    {
        Caption = 'Medical';
    }
    value(21; "Surgical")
    {
        Caption = 'Surgical';
    }
    value(22; "Obstetric")
    {
        Caption = 'Obstetric';
    }
    value(23; "Gynecology")
    {
        Caption = 'Gynecology';
    }

}
