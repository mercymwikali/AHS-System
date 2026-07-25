Table 85378 "Current Employment Details"
{
    fields
    {
        field(50000; "From Date"; Date)
        {
        }
        field(50001; "To Date"; Date)
        {
        }
        field(50002; "Job Title"; Text[100])
        {
        }
        field(50003; Department; Text[100])
        {
        }
        field(50004; "Duties and Responsibility"; Text[250])
        {
        }
        field(50005; "Current Salary"; Code[50])
        {
        }
        field(50006; Position; Option)
        {
            OptionCaption = ' ,Junior,Intermediate,Management,Senior Management,Director,Board';
            OptionMembers = " ",Junior,Intermediate,Management,"Senior Management",Director,Board;
        }
        field(50007; "Major Achiements"; Text[200])
        {
        }
        field(50008; "Contract Type"; Option)
        {
            OptionCaption = ' ,Casual,Contract 1yr,Contract 2yr,Contract 3yr,Gratuity,Missionary,Pension,Short Term Contract,Permanent';
            OptionMembers = " ",Casual,"Contract 1yr","Contract 2yr","Contract 3yr",Gratuity,Missionary,Pension,"Short Term Contract",Permanent;
        }
        field(50009; Displinary; Option)
        {
            OptionCaption = 'Warning Letter,Suspension';
            OptionMembers = "Warning Letter",Suspension;
        }
        field(50010; "User Name"; Code[30])
        {
        }
        field(50011; "Email Address"; Code[30])
        {
        }
        field(50012; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50013; "Notice Period"; Option)
        {
            OptionCaption = ' ,Immediately,One Month,Two Months,Three Months,Four Months,Five Months,Six Months,Seven Months,Eight months,Nine Months,Ten Months,Eleven Months,Twelve months';
            OptionMembers = " ",Immediately,"One Month","Two Months","Three Months","Four Months","Five Months","Six Months","Seven Months","Eight months","Nine Months","Ten Months","Eleven Months","Twelve months";
        }
        field(50014; "Company Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Curr Supervisor"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Curr Supervisor Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No", "User Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "To Date" = 0D then
            "To Date" := Today;
    end;
}
