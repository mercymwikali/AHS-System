Table 85498 "HR Staff Requisition"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Employee No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(50003; "Employee Name"; Text[100])
        {
        }
        field(50004; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50005; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50006; "Applied Days"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                CalcFields("Availlable Days");
                if (("Availlable Days" = 0) or ("Applied Days" > "Availlable Days")) then
                    Error('Applied days must not be more than leave balance.');
                if ("Applied Days" <> 0) and ("Starting Date" <> 0D) then
                    // "End Date":=CalcEndDate("Starting Date","Applied Days");
                    // "Return Date" :=CalcReturnDate("End Date");
                    Validate("Starting Date");
            end;
        }
        field(50007; "Starting Date"; Date)
        {
        }
        field(50008; "End Date"; Date)
        {
        }
        field(50009; Purpose; Text[200])
        {
        }
        field(50010; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Types".Code;

            trigger OnValidate()
            begin
                CalcFields("Availlable Days");
                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Leave Balance" := Emp."Leave Balance";
                end;
            end;
        }
        field(50011; "Leave Balance"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50012; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50013; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval,Approved,Cancelled,Posted';
            OptionMembers = Open,Released,"Pending Approval",Approved,Cancelled,Posted;

            trigger OnValidate()
            begin
                /*
                  IF Status = Status::Posted THEN BEGIN
                 leaveLedgers.RESET;
                 IF leaveLedgers.FIND('+') THEN
                 lastNo:=leaveLedgers."Entry No."+10
                 ELSE lastNo:=10;
                  // post the leave application to ledger entries with a negative adjustment
                  leaveLedgers.INIT;
                   leaveLedgers."Entry No.":=lastNo;
                   leaveLedgers."Employee No":="Employee No";
                   leaveLedgers."Document No":="No.";
                   leaveLedgers."Leave Type":="Leave Type";
                   leaveLedgers."Transaction Date":=TODAY;
                   leaveLedgers."Transaction Type":=leaveLedgers."Transaction Type"::Application;
                   leaveLedgers."No. of Days":=(("Applied Days")*(-1));
                   leaveLedgers."Transaction Description":='Leave Application';
                   leaveLedgers."Leave Period":=DATE2DWY(TODAY,3);
                  leaveLedgers.INSERT;
                  "Leave Balance":="Availlable Days";
                  MODIFY
                 END;
                 */
            end;
        }
        field(50014; "User ID"; Code[30])
        {
        }
        field(50015; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR".Code;

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                /*
                if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter);

               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
            end;
        }
        field(50016; Posted; Boolean)
        {
        }
        field(50017; "Posted By"; Code[20])
        {
        }
        field(50018; "Posting Date"; Date)
        {
        }
        field(50019; "Process Leave Allowance"; Boolean)
        {
        }
        field(50020; "Availlable Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("Employee No")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50021; "Return Date"; Date)
        {
        }
        field(50022; "Reliever No."; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Emp3.Get("Reliever No.") then
                    "Reliever Name" := Emp3."First Name" + ' ' + Emp3."Middle Name" + ' ' + Emp3."Last Name";
            end;
        }
        field(50023; "Reliever Name"; Text[250])
        {
        }
        field(50024; RequisitionType; Option)
        {
            OptionCaption = 'Academic Requisition,Medical Claims/General Claims,Tuition waiver,Leave Extension Requisition, Staff Update';
            OptionMembers = "Academic Requisition","Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition"," Staff Update";
        }
        field(50025; "Name of Beneficiary"; Text[30])
        {
        }
        field(50026; "Beneficiary Reg. No"; Code[50])
        {
        }
        field(50027; "Beneficary Relationship"; Code[10])
        {
        }
        field(50028; "Beneficiary Date of Birth"; Date)
        {
        }
        field(50029; "Name of Programme"; Code[20])
        {
        }
        field(50030; "School Code"; Code[20])
        {
        }
        field(50031; "Duration of Study"; Code[10])
        {
        }
        field(50032; "Current Year/Semester of Study"; Code[30])
        {
        }
        field(50033; "Campus offering Programme"; Code[30])
        {
        }
        field(50034; "Total Tuition Kshs"; Decimal)
        {
        }
        field(50035; "Amount of waiver applied Kshs"; Decimal)
        {
        }
        field(50036; "First Name"; Text[80])
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in First name',FORMAT(xRec."First Name"),FORMAT("First Name"));
            end;
        }
        field(50037; "Middle Name"; Text[50])
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in Middle name',FORMAT(xRec."Middle Name"),FORMAT("Middle Name"));
            end;
        }
        field(50038; "Last Name"; Text[50])
        {
            trigger OnValidate()
            begin
                //fnTrackChanges('Change in Last name',FORMAT(xRec."Last Name"),FORMAT("Last Name"));
            end;
        }
        field(50039; "Postal Address"; Text[80])
        {
        }
        field(50040; "Residential Address"; Text[80])
        {
        }
        field(50041; City; Text[30])
        {
        }
        field(50042; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50043; County; Text[30])
        {
        }
        field(50044; "Home Phone Number"; Text[30])
        {
        }
        field(50045; "Cellular Phone Number"; Text[30])
        {
        }
        field(50046; "Work Phone Number"; Text[30])
        {
        }
        field(50047; "E-Mail"; Text[80])
        {
        }
        field(50048; Title; Option)
        {
            OptionMembers = "MR.","MRS.","MISS.",MS,"DR."," ENG. ",DR,CC,"PROF.",PROF;
        }
        field(50049; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50050; Tribe; Code[20])
        {
        }
        field(50051; Religion; Code[20])
        {
        }
        field(50052; "Satisfaction Level"; Option)
        {
            OptionCaption = 'Very satisfying,Fairly satisfying,Unsatisfying,No comment';
            OptionMembers = "Very satisfying","Fairly satisfying",Unsatisfying,"No comment";
        }
        field(50053; Motivation; Option)
        {
            OptionCaption = 'Yes,No';
            OptionMembers = Yes,No;
        }
        field(50054; "Reason Motivated/Unmotivated"; Text[30])
        {
        }
        field(50055; "Reasons For Leaving"; Code[10])
        {
        }
        field(50056; "Suggest Enhancement Motivation"; Text[30])
        {
        }
        field(50057; "Recommend Somebody?"; Option)
        {
            OptionCaption = 'Yes,No';
            OptionMembers = Yes,No;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record "HR-Employee";
        Emp3: Record "HR-Employee";
}
