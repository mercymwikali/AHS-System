pageextension 85017 "Item List Ext" extends "Item List"
{
    layout
    {
        addafter("Unit Cost")
        {
            field("Unit Price Insurance"; Rec."Unit Price Insurance")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Unit Price Insurance field.';
            }
        }
        // addafter(Description)
        // {
        //     field("Generic Name"; Rec."Generic Name")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         ToolTip = 'Specifies the value of the Generic Name field.';
        //     }
        // }
        modify("Description 2")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    /*   trigger OnOpenPage()
      var
          UserRec: Record "User Setup";
      begin
          if UserRec.get(Database.UserId) then
              if UserRec."Default Store Location" <> '' then setfilter("Location Filter", UserRec."Default Store Location");
      end; */
}