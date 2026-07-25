Query 85091 "HMS Lab Results"
{
    elements
    {
        dataitem(HMS_Laboratory_Results_Entry; "HMS Laboratory Results Entry")
        {
            column(Laboratory_No; "Laboratory No.")
            {
            }
            column(Laboratory_Test_Code; "Laboratory Test Code")
            {
            }
            column(Laboratory_Test_Name; "Laboratory Test Name")
            {
            }
            column(Specimen_Code; "Specimen Code")
            {
            }
            column(Specimen_Name; "Specimen Name")
            {
            }
            column(Assigned_User_ID; "Assigned User ID")
            {
            }
            
            column(Staff_No;"Staff No")
            {

            }
            column(Staff_Name;"Staff Name")
            {
                
            }
            column(Collection_Date; "Collection Date")
            {
            }
            column(Collection_Time; "Collection Time")
            {
            }
            column(Measuring_Unit_Code; "Measuring Unit Code")
            {
            }
            column(Measuring_Unit_Name; "Measuring Unit Name")
            {
            }
            column(Results; Results)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Completed; Completed)
            {
            }
            column(Positive; Positive)
            {
            }
            column(Test_Normal_Ranges; "Test Normal Ranges")
            {
            }
            column(Test_Units; "Test Units")
            {
            }
            column(Flag; Flag)
            {
            }
            column(Reactive; Reactive)
            {
            }
            column(Normal_Range; "Normal Range")
            {
            }
            column(Sort_Test; "Sort Test")
            {
            }
            column(Lab_Unique_No; "Lab Unique No")
            {
            }
            column(Result_Type;"Result Type")
            {
                
            }
            dataitem(HMS_Laboratory_Form_Header; "HMS Laboratory Form Header")
            {
                DataItemLink = "Laboratory No." = HMS_Laboratory_Results_Entry."Laboratory No.";
                column(Link_No; "Link No.")
                {
                }
            }
        }
    }
}
