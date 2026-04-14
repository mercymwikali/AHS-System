Query 85103 "Observation Results"
{
    elements
    {
        dataitem(HMS_Observation_Form_Line_Proc; "HMS Observation Form Line Proc")
        {
            column(Observation_No; "Observation No.")
            {
            }
            column(Type; Type)
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column(Patient_Name; "Patient Name")
            {
            }
            column(Pain; Pain)
            {
            }
            column(Pulse_Rate; "Pulse Rate")
            {
            }
            column(Blood_Pressure; "Blood Pressure")
            {
            }
            column(Temperature; Temperature)
            {
            }
            column(Height; Height)
            {
            }
            column(Weight; Weight)
            {
            }
            column(BMI; BMI)
            {
            }
            column(SP02; SP02)
            {
            }
            column(UniqueId; UniqueId)
            {
            }
            column(Date_Created; "Date Created")
            {
            }
            column(Date_Taken; "Date Taken")
            {
            }
            column(Time; Time)
            {
            }
            column(Line_No; "Line No")
            {
            }
            column(Respiration_Rate; "Respiration Rate")
            {
            }
            dataitem(HMS_Setup_Blood_Group; "HMS Observation Form Header")
            {
                DataItemLink = "Observation No." = HMS_Observation_Form_Line_Proc."Observation No.";
                column(Link_No; "Link No.")
                {
                }
            }
        }
    }
}
