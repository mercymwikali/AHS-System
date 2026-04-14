namespace PTL.HMIS;

codeunit 85013 GenPatientForm
{
    var
        jObject: JsonObject;

    procedure GetHierarchyForm(EncounterNo: Code[30]): JsonObject
    begin
        Clear(jObject);
        BuildHierachy(EncounterNo, jObject);
        exit(jObject);
    end;

    local procedure BuildHierachy(EncounterNo: Code[30]; var jObject: JsonObject): JsonArray
    var
        FormCategory: Record "Form Category";
        JCategories: JsonArray;
    begin
        FormCategory.Reset();
        FormCategory.SetFilter("Parent Category ID", '=%1', '');
        if FormCategory.FindSet() then
            repeat
                AddCategoryToJson(FormCategory, EncounterNo, JCategories);
            until FormCategory.Next() = 0;

        jObject.Add('Categories', JCategories);
    end;

    local procedure AddCategoryToJson(var Category: Record "Form Category"; EncounterNo: Code[30]; var JCategories: JsonArray)
    var
        FormChildCategory: Record "Form Category";
        FormItems: Record "Form Items";
        JCategory: JsonObject;
        JChildren: JsonArray;
        JItems: JsonArray;
    begin
        Clear(JCategory);
        // Basic Cateogry Information
        JCategory.Add('Category ID', Category."Category ID");
        JCategory.Add('Category Name', Category."Category Name");
        JCategory.Add('Parent Category ID', Category."Parent Category ID");
        JCategory.Add('isleafCategory', Category."Is Leaf Category");

        // Now Handle Child Categories
        FormChildCategory.Reset();
        FormChildCategory.SetRange("Parent Category ID", Category."Category ID");
        if FormChildCategory.FindSet() then
            repeat
                AddCategoryToJson(FormChildCategory, EncounterNo, JChildren);
            until FormChildCategory.Next() = 0;

        JCategory.Add('Children', JChildren);

        // Now Handle Items in the Category
        // if Category."Is Leaf Category" then begin
        FormItems.SetRange("Category ID", Category."Category ID");
        if FormItems.FindSet() then
            repeat
                // Add the items to the Json Array
                addItemToJson(FormItems, EncounterNo, JItems);
            until FormItems.Next() = 0;
        // end;
        JCategory.Add('Items', JItems);
        // Add the Category to the Json Array
        JCategories.Add(JCategory);
    end;

    local procedure addItemToJson(var FormItems: Record "Form Items"; EncounterNo: Code[30]; var JItems: JsonArray)
    var
        FormResponse: Record "Consultation Notes Form";
        JItem: JsonObject;
        JResponses: JsonArray;
    begin
        Clear(JItem);
        // Basic Item Information
        JItem.Add('Item ID', FormItems."Item ID");
        JItem.Add('Item Name', FormItems."Item Name");

        // Now Handle Responses for the Item
        FormResponse.SetRange("Encounter No", EncounterNo);
        FormResponse.SetRange("Item ID", FormItems."Item ID");
        if FormResponse.FindSet() then
            repeat
                AddResponseToJson(FormResponse, EncounterNo, JResponses);
            until FormResponse.Next() = 0;
        JItem.Add('Responses', JResponses);
        // Add the Item to the Json Array
        JItems.Add(JItem);

    end;

    local procedure AddResponseToJson(var FormResponse: Record "Consultation Notes Form"; EncounterNo: Code[30]; var JResponses: JsonArray)
    var
        JResponse: JsonObject;
        systemID: Text;
    begin
        // Clear(JResponse);
        // Basic Item Information
        JResponse.Add('Item ID', FormResponse."Item ID");
        JResponse.Add('IsSelected', FormResponse.IsSelected);
        JResponse.Add('Other (Specify)', FormResponse."Other (Specify)");
        JResponse.Add('Section ID', FormResponse."Section ID");
        JResponse.Add('Category ID', FormResponse."Category ID");
        JResponse.Add('Form Type', FormResponse."Form Type");
        // systemID := FormResponse.SystemId;
        // systemID := FormResponse.SystemId.ToString();
        // JResponse.Add('System ID', systemID);
        // System ID is an object. write and add it to the Json Object in text format

        // Add the Item to the Json Array
        JResponses.Add(JResponse);
    end;
}
