page 52202940 "Smart Invoices"
{
    PageType = List;
    SourceTable = "Smart Invoices";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ToolTip = 'Specifies the value of the EntryNo field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                }
                field("Invoice Time"; Rec."Invoice Time")
                {
                    ToolTip = 'Specifies the value of the Invoice Time field.';
                }
                field(Stage; Rec.Stage)
                {
                    ToolTip = 'Specifies the value of the Stage field.';
                }
                field("Diagnosis Code Type"; Rec."Diagnosis Code Type")
                {
                    ToolTip = 'Specifies the value of the Diagnosis Code Type field.';
                }
                field("Diagnosis Code"; Rec."Diagnosis Code")
                {
                    ToolTip = 'Specifies the value of the Diagnosis Code field.';
                }
                field("Encounter Type"; Rec."Encounter Type")
                {
                    ToolTip = 'Specifies the value of the Encounter Type field.';
                }
                field("Code Type"; Rec."Code Type")
                {
                    ToolTip = 'Specifies the value of the Code Type field.';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Code Description"; Rec."Code Description")
                {
                    ToolTip = 'Specifies the value of the Code Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Total Services"; Rec."Total Services")
                {
                    ToolTip = 'Specifies the value of the Total Services field.';
                }
                field("Membership No"; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field("Membership Plan"; Rec."Membership Plan")
                {
                    ToolTip = 'Specifies the value of the Membership Plan field.';
                }
                field("Membership Code"; Rec."Membership Code")
                {
                    ToolTip = 'Specifies the value of the Membership Code field.';
                }
                field("Global ID"; Rec."Global ID")
                {
                    ToolTip = 'Specifies the value of the Global ID field.';
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
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DoB; Rec.DoB)
                {
                    ToolTip = 'Specifies the value of the DoB field.';
                }
                field("Pool ID"; Rec."Pool ID")
                {
                    ToolTip = 'Specifies the value of the Pool ID field.';
                }
                field(Principal; Rec.Principal)
                {
                    ToolTip = 'Specifies the value of the Principal field.';
                }
            }
        }
    }

    actions
    {
    }
}
