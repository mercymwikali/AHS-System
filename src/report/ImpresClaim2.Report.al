report 85177 "Impres/Claim2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ImpresClaim2.rdl';

    dataset
    {
        dataitem("Payments Header"; "Imprest Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Payments_Header__No__; "No.")
            {
            }
            column(Payments_Header_Payee; Payee)
            {
            }
            column(Payments_Header__Payments_Header__Date; Date)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Account_No; "Account No.")
            {
            }
            column(Payments_Header_Purpose; Purpose)
            {
            }
            column(DptName; DptName)
            {
            }
            column(USERID; USERID)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(PrebBy; PrebBy)
            {
            }
            column(PrebDate; PrebDate)
            {
            }
            column(TTotal; TTotal)
            {
                DecimalPlaces = 2 : 2;
            }
            column(ApproversName1; ApproversName[1])
            {
            }
            column(ApproversName2; ApproversName[2])
            {
            }
            column(ApproversName3; ApproversName[3])
            {
            }
            column(ApproversName4; ApproversName[4])
            {
            }
            column(ApproversName5; ApproversName[5])
            {
            }
            column(ApprovalDate1; ApprovalDate[1])
            {
            }
            column(ApprovalDate2; ApprovalDate[2])
            {
            }
            column(ApprovalDate3; ApprovalDate[3])
            {
            }
            column(ApprovalDate4; ApprovalDate[4])
            {
            }
            column(ApprovalDate5; ApprovalDate[5])
            {
            }
            column(Sign1; UserRec1[1].Signature)
            {
            }
            column(Sign2; UserRec1[2].Signature)
            {
            }
            column(Sign3; UserRec1[3].Signature)
            {
            }
            column(Sign4; UserRec1[4].Signature)
            {
            }
            column(Sign0; UserRec0.Signature)
            {
            }
            column(log; company.Picture)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(CompInfoPostCode; CompInfo."Post Code")
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode; CurrCode)
            {
            }
            column(STAFF_IMPREST_REQUESTCaption; STAFF_IMPREST_REQUESTCaptionLbl)
            {
            }
            column(MULTIMEDIA_UNIVERSITYCaption; MULTIMEDIA_UNIVERSITYCaptionLbl)
            {
            }
            column(PAYEMENT_DETAILSCaption; PAYEMENT_DETAILSCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Document_No__Caption; Document_No__CaptionLbl)
            {
            }
            column(Applicant_Caption; Applicant_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
            {
            }
            column(Department_NameCaption; Department_NameCaptionLbl)
            {
            }
            column(Payee_Caption; Payee_CaptionLbl)
            {
            }
            column(Purpose_Caption; Purpose_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Date_______________________________________Caption; Date_______________________________________CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755003; EmptyStringCaption_Control1102755003Lbl)
            {
            }
            column(Signature_of_the_ApplicantCaption; Signature_of_the_ApplicantCaptionLbl)
            {
            }
            column(Date_______________________________________Caption_Control1102755005; Date_______________________________________Caption_Control1102755005Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755009; EmptyStringCaption_Control1102755009Lbl)
            {
            }
            column(Head_of_Dept_Vote_HolderCaption; Head_of_Dept_Vote_HolderCaptionLbl)
            {
            }
            column(Date_______________________________________Caption_Control1102755012; Date_______________________________________Caption_Control1102755012Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755013; EmptyStringCaption_Control1102755013Lbl)
            {
            }
            column(Accountant__in__Charge___DebtorsCaption; Accountant__in__Charge___DebtorsCaptionLbl)
            {
            }
            column(Date_______________________________________Caption_Control1102755016; Date_______________________________________Caption_Control1102755016Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755017; EmptyStringCaption_Control1102755017Lbl)
            {
            }
            column(Accountant_in_Charge_Vote_Book_ControlCaption; Accountant_in_Charge_Vote_Book_ControlCaptionLbl)
            {
            }
            column(Date_______________________________________Caption_Control1102755021; Date_______________________________________Caption_Control1102755021Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755026; EmptyStringCaption_Control1102755026Lbl)
            {
            }
            column(Vice_Chancellor_DVCCaption; Vice_Chancellor_DVCCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755033; EmptyStringCaption_Control1102755033Lbl)
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(ApprovalsCaption; ApprovalsCaptionLbl)
            {
            }
            dataitem("Payment Line"; "Imprest Lines")
            {
                DataItemLink = No = FIELD("No.");
                column(Payment_Line_Amount; Amount)
                {
                }
                column(Account_No________Account_Name_; "Account No:" + ':' + "Account Name")
                {
                }
                column(Payment_Line_No; No)
                {
                }
                column(Payment_Line_Account_No_; "Account No:")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DimVal.RESET();
                    DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                    DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    IF DimVal.FINDFIRST() THEN
                        DimValName := DimVal.Name;
                    "Payments Header".CALCFIELDS("Total Net Amount");
                    TTotal := "Payments Header"."Total Net Amount";
                    ;
                    CheckReport.InitTextVariable();
                    CheckReport.FormatNoText(NumberText, TTotal, '');
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }

                trigger OnPreDataItem()
                begin
                    // "Approval Entry".SETRANGE("Approval Entry".Status,"Approval Entry".Status::Approved)
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);

                StrCopyText := '';
                IF "No. Printed" >= 1 THEN
                    StrCopyText := 'DUPLICATE';
                TTotal := 0;

                //Set currcode to Default if blank
                GLSetup.GET();
                IF "Payments Header"."Currency Code" = '' THEN
                    CurrCode := GLSetup."LCY Code"
                ELSE
                    CurrCode := "Payments Header"."Currency Code";

                //For Inv Curr Code
                IF "Payments Header"."Invoice Currency Code" = '' THEN
                    InvoiceCurrCode := GLSetup."LCY Code"
                ELSE
                    InvoiceCurrCode := "Payments Header"."Invoice Currency Code";

                //End;
                DimVal.RESET();
                DimVal.SETRANGE(DimVal.Code, "Payments Header"."Shortcut Dimension 2 Code");
                IF DimVal.FIND('-') THEN
                    DptName := DimVal.Name;

                //Get Approvers
                ApprovalEntry.RESET();
                ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", "Payments Header"."No.");
                ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FIND('-') THEN BEGIN
                    UserRec0.GET(ApprovalEntry."Sender ID");
                    PrebBy := UserRec0.UserName;
                    PrebDate := ApprovalEntry."Last Date-Time Modified";
                    UserRec0.CALCFIELDS(UserRec0.Signature);
                    REPEAT
                        UserRec.GET(ApprovalEntry."Approver ID");
                        ApproversName[ApprovalEntry."Sequence No."] := UserRec.UserName;
                        ApprovalDate[ApprovalEntry."Sequence No."] := ApprovalEntry."Last Date-Time Modified";
                        UserRec1[ApprovalEntry."Sequence No."].GET(ApprovalEntry."Approver ID");
                        UserRec1[ApprovalEntry."Sequence No."].CALCFIELDS(UserRec1[ApprovalEntry."Sequence No."].Signature);
                    UNTIL ApprovalEntry.NEXT() = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                IF CurrReport.PREVIEW = FALSE THEN BEGIN
                    "No. Printed" := "No. Printed" + 1;
                    MODIFY();
                END;

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, TTotal, '');
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("No.");

                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
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
        ApprovalEntry: Record "Approval Entry";
        company: Record "Company Information";
        CompInfo: Record "Company Information";
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        UserRec: Record "User Setup";
        UserRec0: Record "User Setup";
        UserRec1: array[10] of Record "User Setup";
        CheckReport: Report "Check";
        CurrCode: Code[40];
        InvoiceCurrCode: Code[40];
        DptName: Code[250];
        ApprovalDate: array[10] of DateTime;
        PrebDate: DateTime;
        TTotal: Decimal;
        LastFieldNo: Integer;
        Accountant__in__Charge___DebtorsCaptionLbl: Label 'Accountant- in- Charge - Debtors';
        Accountant_in_Charge_Vote_Book_ControlCaptionLbl: Label 'Accountant-in-Charge-Vote Book Control';
        Amount_in_wordsCaptionLbl: Label 'Amount in words';
        AmountCaptionLbl: Label 'Amount';
        Applicant_CaptionLbl: Label 'Applicant:';
        ApprovalsCaptionLbl: Label 'Approvals';
        Date_______________________________________Caption_Control1102755005Lbl: Label 'Date:______________________________________';
        Date_______________________________________Caption_Control1102755012Lbl: Label 'Date:______________________________________';
        Date_______________________________________Caption_Control1102755016Lbl: Label 'Date:______________________________________';
        Date_______________________________________Caption_Control1102755021Lbl: Label 'Date:______________________________________';
        Date_______________________________________CaptionLbl: Label 'Date:______________________________________';
        Department_NameCaptionLbl: Label 'Department Name';
        Document_Date_CaptionLbl: Label 'Document Date:';
        Document_No__CaptionLbl: Label 'Document No.:';
        EmptyStringCaption_Control1102755003Lbl: Label '______________________________________________';
        EmptyStringCaption_Control1102755009Lbl: Label '______________________________________________';
        EmptyStringCaption_Control1102755013Lbl: Label '______________________________________________';
        EmptyStringCaption_Control1102755017Lbl: Label '______________________________________________';
        EmptyStringCaption_Control1102755026Lbl: Label '______________________________________________';
        EmptyStringCaption_Control1102755033Lbl: Label '______________________';
        Head_of_Dept_Vote_HolderCaptionLbl: Label 'Head of Dept/Vote Holder';
        MULTIMEDIA_UNIVERSITYCaptionLbl: Label 'MULTIMEDIA UNIVERSITY';
        Payee_CaptionLbl: Label 'Payee:';
        PAYEMENT_DETAILSCaptionLbl: Label 'PAYEMENT DETAILS';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Purpose_CaptionLbl: Label 'Purpose:';
        Signature_of_the_ApplicantCaptionLbl: Label 'Signature of the Applicant';
        SignatureCaptionLbl: Label 'Signature';
        STAFF_IMPREST_REQUESTCaptionLbl: Label 'STAFF IMPREST REQUEST';
        TotalCaptionLbl: Label 'Total';
        Vice_Chancellor_DVCCaptionLbl: Label 'Vice Chancellor/DVC';
        ApproversName: array[10] of Text[100];
        PrebBy: Text[100];
        DimValName: Text[250];
        NumberText: array[2] of Text[250];
        StrCopyText: Text[250];
        EmptyStringCaptionLbl: TextConst ENU = '================================================================================================================================================================================================';
}
