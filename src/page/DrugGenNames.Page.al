namespace PTL.HMISBC;

page 85023 "Drug Gen Names"
{
    APIGroup = 'hmis';
    APIPublisher = 'ptl';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'generics';
    DelayedInsert = true;
    EntityName = 'generic';
    EntitySetName = 'generics';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = "Drug Generic Names";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(genericCode; Rec."Generic Code")
                {
                }
                field(name; Rec."Generic Name")
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
            }
        }
    }
}
