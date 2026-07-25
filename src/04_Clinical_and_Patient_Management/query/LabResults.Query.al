Query 85098 "Lab Results"
{
    OrderBy = ascending(Laboratory_Test_Code), ascending(Arrangement);

    elements
    {
        dataitem(HMS_Lab_Parameters_setup; "HMS Lab Parameters setup")
        {
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
            column(Measuring_Unit_Code; "Measuring Unit Code")
            {
            }
            column(Measuring_Unit_Name; "Measuring Unit Name")
            {
            }
            column(Test_Normal_Ranges; "Test Normal Ranges")
            {
            }
            column(Min_Range; "Min Range")
            {
            }
            column(Max_Range; "Max Range")
            {
            }
            column(Test_Normal_Ranges2; "Test Normal Ranges2")
            {
            }
            column(Arrangement; Arrangement)
            {
            }
            dataitem(HMS_Laboratory_Test_Line; "HMS Laboratory Test Line")
            {
                DataItemLink = "Laboratory Test Code" = HMS_Lab_Parameters_setup."Laboratory Test Code";
                column(Laboratory_No; "Laboratory No.")
                {
                }
                column(Assigned_User_ID; "Assigned User ID")
                {
                }

                column(Staff_No; "Staff No")
                {

                }
                column(Staff_Name; "Staff Name")
                {

                }
                column(Collection_Date; "Collection Date")
                {
                }
                column(Collection_Time; "Collection Time")
                {
                }
                column(Count_Value; "Count Value")
                {
                }
                column(Patient_No; "Patient No")
                {
                }
                column(Treatment_No; "Treatment No")
                {
                }
                column(Review_Time; "Review Time")
                {
                }
                column(Color_Code; "Color Code")
                {
                }
                column(Reviewed_By; "Reviewed By")
                {
                }
                column(Reveiw_Date; "Reveiw Date")
                {
                }
                column(User_ID; "User ID_")
                {
                }
                column(Unique_No; "Unique No")
                {
                }
            }
        }
    }
}
