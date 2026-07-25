page 85636 "HR Document Downloads"
{
    ApplicationArea = All;
    Caption = 'HR Document Downloads';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Hr Documents";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")                
                {

                }
                field("Reference No";"Reference No")
                {
                    
                }

                field("Document Type";"Document Type")
                {

                }
                field(Description;Description)
                {

                }
                field("Uploaded By";"Uploaded By")
                {

                }
                field("Total Downloads";"Total Downloads")
                {

                }
                field(IsVisible;IsVisible)
                {

                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Hr Documents"),
                              "No." = field("Document No");
            }
        }
    }
}
