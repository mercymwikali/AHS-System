Table 85007 "Flt Driver"
{
    DrillDownPageID = "Flt Driver List";
    LookupPageID = "Flt Driver List";

    fields
    {
        field(50000; Driver; Code[10])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                Emp.Reset();
                Emp.Get(Driver);
                "Driver Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50001; "Driver Name"; Text[100])
        {
        }
        field(50002; "Driver License Number"; Code[20])
        {
        }
        field(50003; "Last License Renewal"; Date)
        {
        }
        field(50004; "Renewal Interval"; Option)
        {
            OptionMembers = " ",Days,Weeks,Months,Quarterly,Years;
        }
        field(50005; "Renewal Interval Value"; Integer)
        {
            trigger OnValidate()
            begin
                StrValue := 'D';

                if "Renewal Interval" = "renewal interval"::Days then
                    StrValue := 'D'
                else
                    if "Renewal Interval" = "renewal interval"::Weeks then
                        StrValue := 'W'
                    else
                        if "Renewal Interval" = "renewal interval"::Months then
                            StrValue := 'M'
                        else
                            if "Renewal Interval" = "renewal interval"::Quarterly then
                                StrValue := 'Q'
                            else
                                if "Renewal Interval" = "renewal interval"::Years then
                                    StrValue := 'Y';

                "Next License Renewal" := CalcDate(Format("Renewal Interval Value") + StrValue, "Last License Renewal");
            end;
        }
        field(50006; "Next License Renewal"; Date)
        {
        }
        field(50007; "Year Of Experience"; Decimal)
        {
        }
        field(50008; Grade; Code[20])
        {
        }
        field(50009; Active; Boolean)
        {
        }
        field(50010; "License Class"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Driver)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record "HR-Employee";
        StrValue: Text[1];
}
