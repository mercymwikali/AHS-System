table 52202428 "CEO Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "All Out-Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE(Inpatient = filter(false), "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(3; "All In-Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE(Inpatient = filter(true), "Walk-in" = filter(false), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(4; "Corporate Out Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Corporate), Inpatient = filter(false), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(5; "Corporate In Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Corporate), Inpatient = filter(true), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(6; "Cash Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Cash), "Walk-in" = filter(false), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(7; "Walk-In Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Cash), "Walk-in" = filter(true)));
            FieldClass = FlowField;
        }
        field(8; CurrentDate; Date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "Today's Open Visits"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), Status = filter(New)));
            FieldClass = FlowField;
        }
        field(10; "Today's closed Visits"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), Status = filter(<> New)));
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
        field(52; "Aged Acc Receivable"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Document Type" = filter(Invoice), Reversed = filter(false), "Customer No." = filter(<> ''), "Document No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(53; "Aged Acc Payable"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Document Type" = filter(Invoice), "Vendor No." = filter(<> ''), "Document No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(54; "Inventory Pharmaceutical Amnt"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Inventory Posting Group" = filter('DRUGS'), "Item No." = filter(<> ''), "Document No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(55; "InventoryNonPharma amount"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("Inventory Posting Group" = filter('NON-PHARM'), "Document No." = filter(<> ''), "Item No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(56; "Pharmacitical Inventory"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Valued Quantity" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('PHARMACY')));
            FieldClass = FlowField;
        }
        field(57; "Non Pharm Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Cash Out Patients"; Integer)
        {
            // CalcFormula = count("HMS Patient" where("Patient Type" = filter(Cash), Activated = filter(true)));
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), "Patient Type" = filter(Cash)));
            FieldClass = FlowField;
        }
        field(59; "Corporate Patients"; Integer)
        {
            // CalcFormula = count("HMS Patient" where("Patient Type" = filter(Corporate), Activated = filter(true)));
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), "Patient Type" = filter(Corporate)));
            FieldClass = FlowField;
        }
        field(60; "Psychiatry Visits"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" where(Date = field(CurrentDate), "Shortcut Dimension 3 Code" = filter('OP'), "Transaction Type" = filter('Consultation')));
            FieldClass = FlowField;
        }
        field(61; "Psychology Visits"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" where(Date = field(CurrentDate), "Shortcut Dimension 3 Code" = filter('OP'), "Transaction Type" = filter('Counselling')));
            FieldClass = FlowField;
        }
        field(62; Main; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MAIN')));
            FieldClass = FlowField;
        }
        field(63; Maternity; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MATERNITY')));
            FieldClass = FlowField;
        }
        field(64; Medsurg; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MEDSURG')));
            FieldClass = FlowField;
        }
        field(65; "Op stiore"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('OP STORE')));
            FieldClass = FlowField;
        }
        field(67; Radiology; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('RAD')));
            FieldClass = FlowField;
        }
        field(68; Theatre; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('THEATRE')));
            FieldClass = FlowField;
        }
        field(69; Cash; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; Coperates; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "KCB Bank"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('B010')));
            Caption = 'petty Cash-Bustan';
            FieldClass = FlowField;
        }
        field(72; "Cash Control A/c ELD"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('B020')));
            Caption = 'Petty Cash Nyali';
            FieldClass = FlowField;
        }
        field(73; "Petty Cash ELD"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00001')));
            Caption = 'Cash Account';
            FieldClass = FlowField;
        }
        field(74; "SBM/Mpesa"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00002')));
            Caption = 'Barclays Bank of Kenya';
            FieldClass = FlowField;
        }
        field(75; "Stanbic Bank ELD"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00005')));
            Caption = 'Paybill Account ';
            FieldClass = FlowField;
        }
        field(76; "Cash Book Bungoma"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00008')));
            Caption = 'Petty Cash HQ';
            FieldClass = FlowField;
        }
        field(77; "SBM -FIXED ACCOUNT"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00007')));
            Caption = 'Petty Cash Muthithi-94';
            FieldClass = FlowField;
        }
        field(78; "Bank of Africa-Bungoma"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount);
            Caption = 'All Banks';
            FieldClass = FlowField;
        }
        field(79; "New Patients"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" WHERE("Appointment Type" = FILTER('NORMAL')));
            FieldClass = FlowField;
        }
        field(80; "Revisit Patients"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" WHERE("Appointment Type" = FILTER('REVIEW')));
            FieldClass = FlowField;
        }
        field(81; "Cashbook-Nairobi"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00006')));
            FieldClass = FlowField;
        }
        field(82; "KMA Sacco"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK010')));
            FieldClass = FlowField;
        }
        field(83; "Petty Cash Bungoma"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK012')));
            FieldClass = FlowField;
        }
        field(84; "Petty cash Nrb"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK013')));
            FieldClass = FlowField;
        }
        field(85; "Stanbic Bank Nrb"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK014')));
            FieldClass = FlowField;
        }
        field(86; "STANBIC BNK FOUNTAIN RADIOLOGY"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK017')));
            FieldClass = FlowField;
        }
        field(87; "KMA Sacco 2"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK018')));
            FieldClass = FlowField;
        }
        field(93; "Main Store BUNGOMA"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('BRAESIDE')));
            Caption = 'Braeside Pharmacy';
            FieldClass = FlowField;
        }
        field(94; "Pharmacy Bungoma"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('BUSTANI')));
            Caption = 'Bustani Pharmacy';
            FieldClass = FlowField;
        }
        field(95; "Bungoma Procurement"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('WESTLANDS')));
            Caption = 'Westlands Pharmacy';
            FieldClass = FlowField;
        }
        field(96; "Borrowing Store"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('UPPER-HILL')));
            Caption = 'Upper-Hill Pharmacy';
            FieldClass = FlowField;
        }
        field(97; "Expiry Store"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('NYALI')));
            Caption = 'Nyali Pharmacy';
            FieldClass = FlowField;
        }
        field(98; "ICU ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MUTHITHI')));
            Caption = 'Muthithi Pharmacy';
            FieldClass = FlowField;
        }
        field(99; "COUNSELLING1"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C005')));
            FieldClass = FlowField;
            Caption = 'Physical Group Therapy';
        }
        field(100; "COUNSELLING2"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C006')));
            FieldClass = FlowField;
            Caption = 'Group Discussion Therapy';
        }
        field(101; "COUNSELLING3"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C015')));
            FieldClass = FlowField;
            Caption = 'First Individual Counselling';
        }
        field(102; "COUNSELLING4"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C018')));
            FieldClass = FlowField;
            Caption = 'Art Therapy';
        }
        field(103; "COUNSELLING5"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C019')));
            FieldClass = FlowField;
            Caption = 'Family Therapy';
        }
        field(104; "COUNSELLING6"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C020')));
            FieldClass = FlowField;
            Caption = 'Couple Therapy';
        }
        field(105; "COUNSELLING7"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C021')));
            FieldClass = FlowField;
            Caption = 'Occupational Therapy';
        }
        field(106; "COUNSELLING8"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C025')));
            FieldClass = FlowField;
            Caption = 'IP Individual Counselling';
        }
        field(107; "Pharmacy ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('PHARM IP')));
            FieldClass = FlowField;
        }
        field(108; "Procurement ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('PROC')));
            FieldClass = FlowField;
        }
        field(109; "Radiology ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('RAD')));
            FieldClass = FlowField;
        }
        field(110; "Theatre ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('THEATRE')));
            FieldClass = FlowField;
        }
        field(111; "RIP Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Status" = filter(Dead)));
            FieldClass = FlowField;
        }
        field(112; "Transferred Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Status" = filter(Transfer)));
            FieldClass = FlowField;
        }
        field(113; "Therapy Patients"; Integer)
        {
            CalcFormula = Count("HMS Therapy Form Header" WHERE("Therapy Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(114; "Scheduled Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient Appointmnt Bookng" WHERE("Appointment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(115; "Procedure Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" WHERE("Transaction Type" = filter('PROCEDURES')));
            FieldClass = FlowField;
        }
        field(116; "Temporary Catheter Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" WHERE("Code" = filter('PRC0003')));
            FieldClass = FlowField;
        }
        field(117; "Permanent Catheter Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" WHERE("Code" = filter('PRC0006')));
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
