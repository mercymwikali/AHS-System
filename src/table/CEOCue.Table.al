table 85156 "CEO Cue"
{
    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
        }
        field(50001; "All Out-Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE(Inpatient = filter(false), "Walk-in" = filter(false)));
            FieldClass = FlowField;
        }
        field(50002; "All In-Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE(Inpatient = filter(true), "Walk-in" = filter(false), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(50003; "Corporate Out Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Corporate), Inpatient = filter(false), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(50004; "Corporate In Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Corporate), Inpatient = filter(true), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(50005; "Cash Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Cash), "Walk-in" = filter(false), Activated = filter(true)));
            FieldClass = FlowField;
        }
        field(50006; "Walk-In Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Type" = filter(Cash), "Walk-in" = filter(true)));
            FieldClass = FlowField;
        }
        field(50007; CurrentDate; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50008; "Today's Open Visits"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), Status = filter(New)));
            FieldClass = FlowField;
        }
        field(50009; "Today's closed Visits"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), Status = filter(<> New)));
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
        field(50050; "Aged Acc Receivable"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Document Type" = filter(Invoice), Reversed = filter(false), "Customer No." = filter(<> ''), "Document No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50051; "Aged Acc Payable"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Document Type" = filter(Invoice), "Vendor No." = filter(<> ''), "Document No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50052; "Inventory Pharmaceutical Amnt"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Inventory Posting Group" = filter('DRUGS'), "Item No." = filter(<> ''), "Document No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50053; "InventoryNonPharma amount"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("Inventory Posting Group" = filter('NON-PHARM'), "Document No." = filter(<> ''), "Item No." = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50054; "Pharmacitical Inventory"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Valued Quantity" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('PHARMACY')));
            FieldClass = FlowField;
        }
        field(50055; "Non Pharm Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Cash Out Patients"; Integer)
        {
            // CalcFormula = count("HMS Patient" where("Patient Type" = filter(Cash), Activated = filter(true)));
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), "Patient Type" = filter(Cash)));
            FieldClass = FlowField;
        }
        field(50057; "Corporate Patients"; Integer)
        {
            // CalcFormula = count("HMS Patient" where("Patient Type" = filter(Corporate), Activated = filter(true)));
            CalcFormula = Count("HMS Appointment Form Header" where("Appointment Date" = field(CurrentDate), "Patient Type" = filter(Corporate)));
            FieldClass = FlowField;
        }
        field(50058; "Psychiatry Visits"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" where(Date = field(CurrentDate), "Shortcut Dimension 3 Code" = filter('OP'), "Transaction Type" = filter('Consultation')));
            FieldClass = FlowField;
        }
        field(50059; "Psychology Visits"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" where(Date = field(CurrentDate), "Shortcut Dimension 3 Code" = filter('OP'), "Transaction Type" = filter('Counselling')));
            FieldClass = FlowField;
        }
        field(50060; Main; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MAIN')));
            FieldClass = FlowField;
        }
        field(50061; Maternity; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MATERNITY')));
            FieldClass = FlowField;
        }
        field(50062; Medsurg; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MEDSURG')));
            FieldClass = FlowField;
        }
        field(50063; "Op stiore"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('OP STORE')));
            FieldClass = FlowField;
        }
        field(50064; Radiology; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('RAD')));
            FieldClass = FlowField;
        }
        field(50065; Theatre; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('THEATRE')));
            FieldClass = FlowField;
        }
        field(50066; Cash; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; Coperates; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "KCB Bank"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('B010')));
            Caption = 'petty Cash-Bustan';
            FieldClass = FlowField;
        }
        field(50069; "Cash Control A/c ELD"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('B020')));
            Caption = 'Petty Cash Nyali';
            FieldClass = FlowField;
        }
        field(50070; "Petty Cash ELD"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00001')));
            Caption = 'Cash Account';
            FieldClass = FlowField;
        }
        field(50071; "SBM/Mpesa"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00002')));
            Caption = 'Barclays Bank of Kenya';
            FieldClass = FlowField;
        }
        field(50072; "Stanbic Bank ELD"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00005')));
            Caption = 'Paybill Account ';
            FieldClass = FlowField;
        }
        field(50073; "Cash Book Bungoma"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00008')));
            Caption = 'Petty Cash HQ';
            FieldClass = FlowField;
        }
        field(50074; "SBM -FIXED ACCOUNT"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00007')));
            Caption = 'Petty Cash Muthithi-94';
            FieldClass = FlowField;
        }
        field(50075; "Bank of Africa-Bungoma"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount);
            Caption = 'All Banks';
            FieldClass = FlowField;
        }
        field(50076; "New Patients"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" WHERE("Appointment Type" = FILTER('NORMAL')));
            FieldClass = FlowField;
        }
        field(50077; "Revisit Patients"; Integer)
        {
            CalcFormula = Count("HMS Appointment Form Header" WHERE("Appointment Type" = FILTER('REVIEW')));
            FieldClass = FlowField;
        }
        field(50078; "Cashbook-Nairobi"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BANK00006')));
            FieldClass = FlowField;
        }
        field(50079; "KMA Sacco"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK010')));
            FieldClass = FlowField;
        }
        field(50080; "Petty Cash Bungoma"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK012')));
            FieldClass = FlowField;
        }
        field(50081; "Petty cash Nrb"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK013')));
            FieldClass = FlowField;
        }
        field(50082; "Stanbic Bank Nrb"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK014')));
            FieldClass = FlowField;
        }
        field(50083; "STANBIC BNK FOUNTAIN RADIOLOGY"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK017')));
            FieldClass = FlowField;
        }
        field(50084; "KMA Sacco 2"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FILTER('BNK018')));
            FieldClass = FlowField;
        }
        field(50085; "Main Store BUNGOMA"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('BRAESIDE')));
            Caption = 'Braeside Pharmacy';
            FieldClass = FlowField;
        }
        field(50086; "Pharmacy Bungoma"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('BUSTANI')));
            Caption = 'Bustani Pharmacy';
            FieldClass = FlowField;
        }
        field(50087; "Bungoma Procurement"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('WESTLANDS')));
            Caption = 'Westlands Pharmacy';
            FieldClass = FlowField;
        }
        field(50088; "Borrowing Store"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('UPPER-HILL')));
            Caption = 'Upper-Hill Pharmacy';
            FieldClass = FlowField;
        }
        field(50089; "Expiry Store"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('NYALI')));
            Caption = 'Nyali Pharmacy';
            FieldClass = FlowField;
        }
        field(50090; "ICU ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('MUTHITHI')));
            Caption = 'Muthithi Pharmacy';
            FieldClass = FlowField;
        }
        field(50091; "COUNSELLING1"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C005')));
            FieldClass = FlowField;
            Caption = 'Physical Group Therapy';
        }
        field(50092; "COUNSELLING2"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C006')));
            FieldClass = FlowField;
            Caption = 'Group Discussion Therapy';
        }
        field(50093; "COUNSELLING3"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C015')));
            FieldClass = FlowField;
            Caption = 'First Individual Counselling';
        }
        field(50094; "COUNSELLING4"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C018')));
            FieldClass = FlowField;
            Caption = 'Art Therapy';
        }
        field(50095; "COUNSELLING5"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C019')));
            FieldClass = FlowField;
            Caption = 'Family Therapy';
        }
        field(50096; "COUNSELLING6"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C020')));
            FieldClass = FlowField;
            Caption = 'Couple Therapy';
        }
        field(50097; "COUNSELLING7"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C021')));
            FieldClass = FlowField;
            Caption = 'Occupational Therapy';
        }
        field(50098; "COUNSELLING8"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Transaction Type" = filter('COUNSELLING'), "Code" = filter('C025')));
            FieldClass = FlowField;
            Caption = 'IP Individual Counselling';
        }
        field(50099; "Pharmacy ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('PHARM IP')));
            FieldClass = FlowField;
        }
        field(50100; "Procurement ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('PROC')));
            FieldClass = FlowField;
        }
        field(50101; "Radiology ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('RAD')));
            FieldClass = FlowField;
        }
        field(50102; "Theatre ELD"; Decimal)
        {
            CalcFormula = sum("Value Entry"."Cost Posted to G/L" where("Item No." = filter(<> ''), "Document No." = filter(<> ''), "Location Code" = filter('THEATRE')));
            FieldClass = FlowField;
        }
        field(50103; "RIP Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Status" = filter(Dead)));
            FieldClass = FlowField;
        }
        field(50104; "Transferred Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient" WHERE("Patient Status" = filter(Transfer)));
            FieldClass = FlowField;
        }
        field(50105; "Therapy Patients"; Integer)
        {
            CalcFormula = Count("HMS Therapy Form Header" WHERE("Therapy Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50106; "Scheduled Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient Appointmnt Bookng" WHERE("Appointment Date" = field(CurrentDate)));
            FieldClass = FlowField;
        }
        field(50107; "Procedure Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" WHERE("Transaction Type" = filter('PROCEDURES')));
            FieldClass = FlowField;
        }
        field(50108; "Temporary Catheter Patients"; Integer)
        {
            CalcFormula = Count("HMS Patient Charges" WHERE("Code" = filter('PRC0003')));
            FieldClass = FlowField;
        }
        field(50109; "Permanent Catheter Patients"; Integer)
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
