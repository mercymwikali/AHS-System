namespace PTL.HMISBC;

query 52202628 FormItems //QyFormItems
{
    Caption = 'FormItems';
    QueryType = Normal;
    
    elements
    {
        dataitem(FormItems; "Form Items")
        {
            column(Item_ID; "Item ID")
            {
            }
            column(Category_ID; "Category ID")
            {
            }
            column(Item_Name; "Item Name")
            {
            }
            column(Is_Text_Item; "Is Text Item")
            {
            }
            column(Input_Type; "Input Type")
            {
            }
            column(Form_Type; "Form Type")
            {
            }
            column(Section_ID; "Section ID")
            {
            }
            column(Category_Name; "Category Name")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
