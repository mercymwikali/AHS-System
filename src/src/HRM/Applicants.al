page 52203118 "Applicants Card"
{
    PageType = Card;
    SourceTable = Applicants;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No"; Rec."Application No")
                {
                    ToolTip = 'Specifies the value of the Application No field.';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the value of the Initials field.';
                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    Caption = '1st Language (R/W/S)';
                    ToolTip = 'Specifies the value of the 1st Language (R/W/S) field.';
                }
                field("First Language Read"; Rec."First Language Read")
                {
                    Caption = 'R';
                    ToolTip = 'Specifies the value of the R field.';
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    Caption = 'W';
                    ToolTip = 'Specifies the value of the W field.';
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    Caption = '2nd Language (R/W/S)';
                    ToolTip = 'Specifies the value of the 2nd Language (R/W/S) field.';
                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                    ToolTip = 'Specifies the value of the Second Language Read field.';
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    ToolTip = 'Specifies the value of the Second Language Write field.';
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ToolTip = 'Specifies the value of the Additional Language field.';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Applicant Type field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Internal';
                    Editable = true;
                    ToolTip = 'Specifies the value of the Internal field.';
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    Caption = 'S';
                    ToolTip = 'Specifies the value of the S field.';
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    ToolTip = 'Specifies the value of the Second Language Speak field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field.';
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    Caption = 'Position Application Reff No.';
                    ToolTip = 'Specifies the value of the Position Application Reff No. field.';
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    Caption = 'Position Applied For';
                    ToolTip = 'Specifies the value of the Position Applied For field.';
                }
                field(Qualified; Rec.Qualified)
                {
                    Caption = 'Employed';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employed field.';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    ToolTip = 'Specifies the value of the Ethnic Origin field.';
                }
                field(Disabled; Rec.Disabled)
                {
                    ToolTip = 'Specifies the value of the Disabled field.';
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    ToolTip = 'Specifies the value of the Health Assesment? field.';
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    ToolTip = 'Specifies the value of the Health Assesment Date field.';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ToolTip = 'Specifies the value of the Home Phone Number field.';
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ToolTip = 'Specifies the value of the Postal Address field.';
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                    ToolTip = 'Specifies the value of the Postal Address2 field.';
                }
                field("Postal Address3"; Rec."Postal Address3")
                {
                    ToolTip = 'Specifies the value of the Postal Address3 field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ToolTip = 'Specifies the value of the Residential Address field.';
                }
                field("Residential Address2"; Rec."Residential Address2")
                {
                    ToolTip = 'Specifies the value of the Residential Address2 field.';
                }
                field("Residential Address3"; Rec."Residential Address3")
                {
                    ToolTip = 'Specifies the value of the Residential Address3 field.';
                }
                field("Post Code2"; Rec."Post Code2")
                {
                    ToolTip = 'Specifies the value of the Post Code2 field.';
                }
                field("Cellular Phone Number"; Rec."Cell Phone Number")
                {
                    ToolTip = 'Specifies the value of the Cell Phone Number field.';
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ToolTip = 'Specifies the value of the Work Phone Number field.';
                }
                field("Ext."; Rec."Ext.")
                {
                    ToolTip = 'Specifies the value of the Ext. field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ToolTip = 'Specifies the value of the Fax Number field.';
                }
            }
            group(Qualifications)
            {
                // Caption = 'Qualifications';
                // part(Control1000000020; "HR Applicant Qualifications")
                // {
                //     SubPageLink = "Email Address" = FIELD("E-Mail");
                // }
            }
            group(EmplomentH)
            {
                Caption = 'Employment History';
                part(Control10000000221; "Applicants Employment History")
                {
                    SubPageLink = "Email Address" = FIELD("E-Mail");
                }
            }
            group(CurrEmp)
            {
                Caption = 'Current Employment';
                part(Control10000000223; "Applicant Employment Details")
                {
                    SubPageLink = "Email Address" = FIELD("E-Mail");
                }
            }
            group(Referees)
            {
                Caption = 'Referees';
                part(Control1000000085; "HR Applicant Referees")
                {
                    SubPageLink = "Employee No" = FIELD("Application No");
                }
            }
            group(Hobbies)
            {
                Caption = 'Hobbies';
                part(Control1000000089; Hobbies)
                {
                    SubPageLink = No = FIELD("Application No");
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                part(Control1000000093; "Applicants Document Link")
                {
                    SubPageLink = "Applicant No" = FIELD("Application No");
                }
            }
            group("Medical Info")
            {
                Caption = 'Medical Info';
                part(Control1000000094; "Applicants Medical Info")
                {
                    SubPageLink = "Applicant No" = FIELD("Application No");
                }
            }
            group("View/Comments")
            {
                Caption = 'View/Comments';
                part(Control1000000095; "Applicants Comments/Views")
                {
                    SubPageLink = "Applicant No" = FIELD("Application No");
                }
            }
        }
    }

    actions
    {
    }
}
