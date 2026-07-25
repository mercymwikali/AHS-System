XmlPort 85005 "Casual Employee payment"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Casual Payment Lines"; "Casual Payment Lines")
            {
                XmlName = 'FA';
                fieldelement(A; "Casual Payment Lines"."Document No.")
                {
                }
                fieldelement(aa; "Casual Payment Lines"."Payroll Period")
                {
                }
                fieldelement(b; "Casual Payment Lines"."Line No.")
                {
                }
                fieldelement(c; "Casual Payment Lines"."ID Number")
                {
                }
                fieldelement(k; "Casual Payment Lines"."Basic Amount")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    CasualEmployees.Reset();
                    CasualEmployees.SetRange(CasualEmployees."ID Number", "Casual Payment Lines"."ID Number");
                    if CasualEmployees.FindSet() then begin //REPEAT
                                                            // MESSAGE('%1..',"Casual Payment Lines"."ID Number");
                        "Casual Payment Lines"."Employee No" := CasualEmployees."Casual No";
                        "Casual Payment Lines"."Employee Name" := CasualEmployees."Full  Name";
                        "Casual Payment Lines"."Bank Code" := CasualEmployees."Bank Code";
                        "Casual Payment Lines"."Bank Name" := CasualEmployees."Bank Name";
                        "Casual Payment Lines"."Bank Account No" := CasualEmployees."Bank Account Number";
                        "Casual Payment Lines".Occupation := CasualEmployees."Task Code";
                        "Casual Payment Lines"."No of Days" := CasualEmployees."No of Days value";
                        "Casual Payment Lines"."Shortcut Dimension 1 Code" := CasualEmployees."Revenue Division";
                        "Casual Payment Lines"."Shortcut Dimension 2 Code" := CasualEmployees.Department;

                        // UNTIL CasualEmployees.NEXT=0;
                    end;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    var
        CasualEmployees: Record "Casual Employees";
}
