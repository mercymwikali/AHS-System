Table 85165 "Employee Beneficiaries"
{
    Caption = 'Employee Relative';
    // DrillDownPageID = UnknownPage70135478;
    // LookupPageID = UnknownPage70135478;

    fields
    {
        field(50000; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative.Code;

            trigger OnValidate()
            begin
                Clear(counts);
                benf.Reset();
                benf.SetRange(benf."Employee Code", "Employee Code");
                benf.SetFilter(benf."Entry No", '<>%1', '');
                if benf.Find('-') then begin
                    counts := benf.Count;
                    "Entry No" := Format(counts + 1);
                end else begin
                    counts := 0;
                    "Entry No" := Format(counts + 1);
                end;
            end;
        }
        field(50002; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(50003; "Other Names"; Text[50])
        {
            NotBlank = true;
        }
        field(50004; "ID No/Passport No"; Text[30])
        {
        }
        field(50005; "Date Of Birth"; Date)
        {
        }
        field(50006; Occupation; Text[100])
        {
        }
        field(50007; Address; Text[100])
        {
        }
        field(50008; "Office Tel No"; Text[100])
        {
        }
        field(50009; "Home Tel No"; Text[50])
        {
        }
        field(50010; Remarks; Text[250])
        {
        }
        field(50011; "Entry No"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", "Employee Code")
        {
        }
        key(Key2; "Employee Code", SurName, "Other Names")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."table name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll();
    end;

    var
        benf: Record "Employee Beneficiaries";
        counts: Integer;
}
