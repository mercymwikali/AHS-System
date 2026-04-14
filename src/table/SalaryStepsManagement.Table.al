Table 85466 "Salary Steps Management"
{
    fields
    {
        field(50000; "Increament Month"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(50001; "Employment Month From"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(50002; "Employment Month To"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(50003; "Employee Category"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Category", "Increament Month")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
