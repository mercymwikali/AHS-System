Table 52202808 "HR Human Resource Comments"
{
    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionMembers = Employee,Relative,"Relation Management","Correspondence History",Images,"Absence and Holiday","Cost to Company","Pay History","Bank Details",Maternity,"SAQA Training History","Absence Information","Incident Report","Emp History","Medical History","Career History",Appraisal,Disciplinary,"Exit Interviews",Grievances,"Existing Qualifications","Proffesional Membership","Education Assistance","Learning Intervention","NOSA or other Training","Company Skills Plan","Development Plan","Skills Plan","Emp Salary",Unions;
        }
        field(2; "No."; Code[20])
        {
            TableRelation = if ("Table Name" = const(Employee)) "HR Employee SIC Numbers"."Employee No."
            else
            if ("Table Name" = const(Relative)) "HR Employee Attachments"."Employee No"
            else
            if ("Table Name" = const("Relation Management")) "HR Applicant Qualifications"."Application No"
            else
            if ("Table Name" = const("Correspondence History")) "HR Applicant Hobbies"."Job Application No"
            else
            if ("Table Name" = const(Images)) "HR Document Content Source".Code
            else
            if ("Table Name" = const("Absence and Holiday")) "HR Absence and Holiday"."Employee No."
            else
            if ("Table Name" = const("Cost to Company")) "HR Appraisal Evaluation Areas".Code
            else
            if ("Table Name" = const("Bank Details")) "HR Appraisal Ratings".Code
            else
            if ("Table Name" = const(Maternity)) "Additional Group Approvers"."Approval Code"
            else

            if ("Table Name" = const("Absence Information")) "HR Committees".Code;
        }
        field(3; "Table Line No."; Code[10])
        {
        }
        field(4; "Key Date"; Date)
        {
        }
        field(5; Tear; Integer)
        {
        }
        field(6; "Line No."; Integer)
        {
        }
        field(7; Date; Date)
        {
        }
        field(8; "Code"; Code[10])
        {
        }
        field(9; Comment; Text[80])
        {
        }
        field(10; User; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Table Name", "Table Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate();
    end;

    trigger OnModify()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate();
    end;

    procedure SetUpNewLine()
    var
        HumanResCommentLine: Record "HR Human Resource Comments";
    begin
        HumanResCommentLine := Rec;
        HumanResCommentLine.SetRecfilter();
        HumanResCommentLine.SetRange("Line No.");
        if not HumanResCommentLine.Find('-') then
            Date := WorkDate();
    end;
}
