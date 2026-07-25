Query 85222 "Ward Management"
{
    elements
    {
        dataitem(HMS_Beds; "HMS Beds")
        {
            column(Ward_No; "Ward No")
            {
            }
            column(Bed_No; "Bed No")
            {
            }
            column(Bed_Name; "Bed Name")
            {
            }
            column(Occupied; Occupied)
            {
            }
            dataitem(HMS_Admission_Form_Header; "HMS Admission Form Header")
            {
                DataItemLink = Ward = HMS_Beds."Ward No", Bed = HMS_Beds."Bed No";
                column(Admission_No; "Admission No.")
                {
                }
                column(Patient_No; "Patient No.")
                {
                }
                column(Search_Name; "Search Name")
                {
                }
                column(Status; Status)
                {
                }
                column(Surname; Surname)
                {
                }
                column(Middle_Name; "Middle Name")
                {
                }
                column(Last_Name; "Last Name")
                {
                }
                column(Admission_Date; "Admission Date")
                {
                }
                column(Branch; Branch)
                {
                }
                dataitem(HMS_Ward_Setup; "HMS Ward Setup")
                {
                    DataItemLink = "Ward Code" = HMS_Admission_Form_Header.Ward;
                    column(Ward_Name; "Ward Name")
                    {
                    }
                    column(Room_Charges; "Room Charges")
                    {
                    }
                    column(Branch_Code; "Branch Code")
                    {
                    }
                    dataitem(HMS_Rooms_Setup; "HMS Ward Rooms")
                    {
                        DataItemLink = "Room No." = HMS_Ward_Setup."Ward Code";


                        
                        column(NoofBeds; "No of Beds")
                        {
                        }
                        column(RoomName; "Room Name")
                        {
                        }
                        column(RoomNo; "Room No.")
                        {
                        }
                        column(SystemId; SystemId)
                        {
                        }
                        column(WardNo; "Ward No")
                        {
                        }

                    }

                }


            }
        }
    }
}
