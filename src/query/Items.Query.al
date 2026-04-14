namespace HMISBC.HMISBC;

using Microsoft.Inventory.Item;

query 85034 Items
{
    Caption = 'Items';
    QueryType = Normal;

    elements
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(BaseUnitofMeasure; "Base Unit of Measure")
            {
            }
            column(UnitCost; "Unit Cost")
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(FreightType; "Freight Type")
            {
            }
            column("Type"; "Type")
            {
            }
            column(Description_2;"Description 2")
            {                
            }
            column(Generic_Name;"Generic Name")
            {

            }
            column(Generic_Name_Code;"Generic Name Code"){}
            column(Sales_Unit_of_Measure;"Sales Unit of Measure")
            {
                
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
