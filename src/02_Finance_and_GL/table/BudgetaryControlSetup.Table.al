Table 85075 "Budgetary Control Setup"
{
    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
        }
        field(50001; "Current Budget Code"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50002; "Current Budget Start Date"; Date)
        {
        }
        field(50003; "Current Budget End Date"; Date)
        {
        }
        field(50004; "Budget Dimension 1 Code"; Code[20])
        {
            Caption = 'Budget Dimension 1 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 1 Code",9,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 1 Code",0);
                END;
                */
            end;
        }
        field(50005; "Budget Dimension 2 Code"; Code[20])
        {
            Caption = 'Budget Dimension 2 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 2 Code",10,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 2 Code",1);
                END;
                */
            end;
        }
        field(50006; "Budget Dimension 3 Code"; Code[20])
        {
            Caption = 'Budget Dimension 3 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 3 Code",11,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 3 Code",2);
                END;
                */
            end;
        }
        field(50007; "Budget Dimension 4 Code"; Code[20])
        {
            Caption = 'Budget Dimension 4 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 4 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 4 Code",3);
                END;
                */
            end;
        }
        field(50008; "Budget Dimension 5 Code"; Code[20])
        {
            Caption = 'Budget Dimension 5 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 4 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 4 Code",3);
                END;
                */
            end;
        }
        field(50009; "Budget Dimension 6 Code"; Code[20])
        {
            Caption = 'Budget Dimension 6 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 4 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 4 Code",3);
                END;
                */
            end;
        }
        field(50010; "Analysis View Code"; Code[20])
        {
            TableRelation = "Analysis View".Code;
        }
        field(50011; "Dimension 1 Code"; Code[20])
        {
            Caption = 'Dimension 1 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 1 Code",13,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 1 Code"),"Dimension 1 Code",xRec."Dimension 1 Code");
                MODIFY;
                */
            end;
        }
        field(50012; "Dimension 2 Code"; Code[20])
        {
            Caption = 'Dimension 2 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 2 Code",14,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 2 Code"),"Dimension 2 Code",xRec."Dimension 2 Code");
                MODIFY;
                */
            end;
        }
        field(50013; "Dimension 3 Code"; Code[20])
        {
            Caption = 'Dimension 3 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 3 Code",15,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 3 Code"),"Dimension 3 Code",xRec."Dimension 3 Code");
                MODIFY;
                */
            end;
        }
        field(50014; "Dimension 4 Code"; Code[20])
        {
            Caption = 'Dimension 4 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 4 Code",16,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 4 Code"),"Dimension 4 Code",xRec."Dimension 4 Code");
                MODIFY;
                */
            end;
        }
        field(50015; Mandatory; Boolean)
        {
        }
        field(50016; "Current Item Budget"; Code[20])
        {
            TableRelation = "Item Budget Name".Name;
        }
        field(50017; "Check Workplan Entries"; Boolean)
        {
        }
        field(50018; "Allow OverExpenditure"; Boolean)
        {
        }
        field(50019; "Budget Check Criteria"; Option)
        {
            OptionMembers = "Current Month","Whole Year";
        }
        field(50020; "Actual Source"; Option)
        {
            OptionMembers = "G/L Entry","Analysis View Entry";

            trigger OnValidate()
            begin
                if "Actual Source" = "actual source"::"G/L Entry" then begin
                    if not Confirm('Changing to Actual Source type G/L Entry will result in deletion of all Actuals Continue?', true, false) then
                        Error('Change to G/L Entry source cancelled');
                    "Analysis View Code" := '';
                    "Dimension 1 Code" := '';
                    "Dimension 2 Code" := '';
                    "Dimension 3 Code" := '';
                    "Dimension 4 Code" := '';
                    Modify();
                end;
            end;
        }
        field(50021; "Raise PV"; Boolean)
        {
        }
        field(50022; "Raise Claim"; Boolean)
        {
        }
        field(50023; "Raise Document"; Option)
        {
            OptionCaption = ' ,Raise PV,Raise Claim';
            OptionMembers = " ","Raise PV","Raise Claim";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
