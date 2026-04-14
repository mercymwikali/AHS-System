Table 85217 "HMS Patients Drugs Profit"
{
    DrillDownPageID = Grades;
    LookupPageID = Grades;

    fields
    {
        field(50000; "Patients Type"; Option)
        {
            OptionCaption = ' ,Private,Student,Employee,Dependant,High School Student,High School Staff,Primary School Student,Primary School Staff,Roses Staff,Relative,Sun&Shield School';
            OptionMembers = " ",Private,Student,Employee,Dependant,"High School Student","High School Staff","Primary School Student","Primary School Staff","Roses Staff",Relative,"Sun&Shield School";
        }
        field(50001; "Drugs Profit Perc."; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Patients Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
