namespace PTL.HMIS;

using Microsoft.Inventory.Item;
using PTL.HMISBC;

page 85025 "Item List API"
{
    APIGroup = 'hmis';
    APIPublisher = 'ptl';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'itemListAPI';
    DelayedInsert = true;
    EntityName = 'inventoryService';
    EntitySetName = 'inventoryServices';
    PageType = API;
    SourceTable = Item;
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group';
                }
                field(route; Rec.Route)
                {
                    Caption = 'Route';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(lastDirectCost; Rec."Last Direct Cost")
                {
                    Caption = 'Last Direct Cost';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(genericNameCode; Rec."Generic Name Code")
                {
                    Caption = 'Generic Name Code';
                }
                field(genericName; Rec."Generic Name")
                {
                    Caption = 'Generic Name';
                }
                field(inventory; Rec.Inventory)
                {
                    Caption = 'Inventory';
                }
                field(locationFilter; Rec."Location Filter")
                {
                    Caption = 'Location Filter';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }

                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(freightType; Rec."Freight Type")
                {
                    Caption = 'Freight Type';
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(salesUnitOfMeasure; Rec."Sales Unit of Measure")
                {
                    Caption = 'Sales Unit of Measure';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                part(genericNameList; "Drug Gen Names")
                {
                    EntityName = 'generic';
                    EntitySetName = 'generics';
                    Multiplicity = ZeroOrOne;
                    SubPageLink = "Generic Code" = field("Generic Name Code");
                }
            }
        }
    }
}
