Page 52202829 "Bank Transactions Buffer List"
{
    PageType = List;
    SourceTable = "Bank Transactions Buffer";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(ReceiptNo; Rec."Receipt No")
                {
                    ToolTip = 'Specifies the value of the Receipt No field.';
                }
                field(StudentNo; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(Unallocated; Rec.Unallocated)
                {
                    ToolTip = 'Specifies the value of the Unallocated field.';
                }
                field(ChequeNo; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field.';
                }
                field(StudExist; Rec."Stud Exist")
                {
                    ToolTip = 'Specifies the value of the Stud Exist field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(IDNo; Rec.IDNo)
                {
                    ToolTip = 'Specifies the value of the IDNo field.';
                }
                field(TranscationDate; Rec."Transcation Date")
                {
                    ToolTip = 'Specifies the value of the Transcation Date field.';
                }
                field(BankCode; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(BatchReceiptNo; Rec."Batch Receipt No")
                {
                    ToolTip = 'Specifies the value of the Batch Receipt No field.';
                }
                field(UnidentifiedType; Rec."Unidentified Type")
                {
                    ToolTip = 'Specifies the value of the Unidentified Type field.';
                }
                field(MiscGLAccount; Rec."Misc G/L Account")
                {
                    ToolTip = 'Specifies the value of the Misc G/L Account field.';
                }
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.';
                }
                field(ReceiptedBank; Rec."Receipted Bank")
                {
                    ToolTip = 'Specifies the value of the Receipted Bank field.';
                }
                field(AdmissionNo; Rec."Admission No")
                {
                    ToolTip = 'Specifies the value of the Admission No field.';
                }
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(PostedCount; Rec."Posted Count")
                {
                    ToolTip = 'Specifies the value of the Posted Count field.';
                }
                field(PostedReceiptNo; Rec."Posted Receipt No")
                {
                    ToolTip = 'Specifies the value of the Posted Receipt No field.';
                }
            }
        }
    }

    actions
    {
    }
}
