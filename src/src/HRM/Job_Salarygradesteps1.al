page 52202430 "Job_Salary grade/steps1"
{
    Caption = 'Salary Grades';
    DataCaptionFields = "Employee Category", "Salary Grade code", "Grade Level";
    PageType = List;
    SourceTable = "Job_Salary grade/steps";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Salary Grade code"; Rec."Salary Grade code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Salary Grade code field.';
                }
                field("Grade Description"; Rec."Grade Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Grade Description field.';
                }
                field("Grade Level"; Rec."Grade Level")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Grade Level field.';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the House Allowance field.';
                }
                field("Leave Allowance"; Rec."Leave Allowance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Leave Allowance field.';
                }
                field("Medical Ceilling"; Rec."Medical Ceilling")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Medical Ceilling field.';
                }
                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Entitiled Leave Days';
                    ToolTip = 'Specifies the value of the Entitiled Leave Days field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Salsteps)
            {
                Caption = 'Salary Steps';
                Image = Suggest;
                Promoted = true;
                RunObject = Page "Auto. Inreament Salary Steps";
                RunPageLink = "Employee Category" = FIELD("Employee Category"),
                              "Salary Grade" = FIELD("Salary Grade code");
                ToolTip = 'Executes the Salary Steps action.';
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Imcreament';
                action(Increaments)
                {
                    Caption = 'Increment for Current Cat.';
                    Image = "Action";
                    Promoted = true;
                    ToolTip = 'Executes the Increment for Current Cat. action.';

                    trigger OnAction()
                    begin

                        if ((Rec."Employee Category" = '') or (Rec."Salary Grade code" = '')) then
                            Error('Specify the Salary category and Grade first');

                        if checkMonthValidity() = false then
                            Error('You can not carry out this process in this month.');

                        if Confirm('Run Salary increment for ' + Rec."Employee Category" + ' (' + Rec."Salary Grade code" + ')?', false) = false then
                            exit;

                        employees.Reset();
                        employees.SetRange(employees."Salary Category", Rec."Employee Category");
                        // employees.SETFILTER(employees."No.",'%1|%2','0093','0097');
                        if employees.Find('-') then     //1
                            repeat
                            begin //2
                                empSalaryCard.Reset();
                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                if empSalaryCard.Find('-') then //5;

                                    //5
                                Clear(EmplMonth);
                                EmplMonth := Date2DMY(employees."Date Of Join", 2);
                                // increment for January
                                if Date2DMY(Today, 2) = 1 then begin //4

                                    // Increase salary fro guys who were employed between January and July
                                    if EmplMonth in [1 .. 6] then   //38

                                        // Check whether the employee is eligible for the increment
                                        if ((Date2DMY(Today, 3)) > (Date2DMY(employees."Date Of Join", 3))) then begin  //37

                                            salaStepsAmount.Reset();
                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                            salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", employees."Salary Grade");
                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                            if salaStepsAmount.Find('-') then begin //35

                                                // Basic Payfound Hence Move to the next level in the steps table
                                                //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                                                salaStepsAmount2.Reset();
                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", employees."Salary Grade");
                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                    // At last! Insert into the Log and
                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                        salincregister.Reset();
                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                        if not salincregister.Find('-') then begin // 6
                                                                                                   // insert into the register
                                                            salincregister.Init();
                                                            salincregister."Employee No." := employees."No.";
                                                            salincregister."Increament Month" := 'January';
                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                            salincregister."User ID" := UserId;
                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                            salincregister."Job Category" := employees."Salary Category";
                                                            salincregister.Insert();
                                                            // Update Basic
                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                            //                      empSalaryCard.MODIFY;
                                                        end; // 6
                                                    end // 7
                                                    else begin  // 8
                                                                //the salary in the steps is zero hence cannot insert
                                                        unaffectedEmployees.Reset();
                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                        // insert into the unaffectedEmployees table
                                                            unaffectedEmployees.Init();
                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                            unaffectedEmployees."Increament Month" := 'January';
                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                            unaffectedEmployees.Insert();
                                                        end;   //9
                                                    end;  // 8
                                                end  // 10
                                                else begin  //11
                                                    salGrades.Reset();
                                                    salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                    salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                    if salGrades.Find('-') then begin //33
                                                                                      //////////////////////////////////////////////////////////////////////////////////////////
                                                        salGrades2.Reset();
                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                        //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                        if salGrades2.Find('-') then begin//23
                                                                                          //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                          // Change Basic pay and insert into the register
                                                                                          // Find the value of new salary from the steps.
                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                            if empSalaryCard.Find('-') then  //14;

                                                                //14
                                                            Clear(salcat);
                                                            Clear(salgrade);
                                                            Clear(salbasic);
                                                            salcat := employees."Salary Category";
                                                            salgrade := salGrades2."Salary Grade code";
                                                            salbasic := empSalaryCard."Basic Pay";

                                                            salaStepsAmount.Reset();
                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                            salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                     // select the new employee salary and
                                                                                                     // Update Basic Pay here
                                                                salaStepsAmount2.Reset();
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                    // At last! Insert into the Log and
                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                        salincregister.Reset();
                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                   // insert into the register
                                                                            salincregister.Init();
                                                                            salincregister."Employee No." := employees."No.";
                                                                            salincregister."Increament Month" := 'January';
                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                            salincregister."User ID" := UserId;
                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                            salincregister.Insert();
                                                                            // Update Basic
                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                            //                      empSalaryCard.MODIFY;
                                                                        end; // 6
                                                                    end // 7
                                                                    else begin  // 8
                                                                                //the salary in the steps is zero hence cannot insert
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                        // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                            unaffectedEmployees.Insert();
                                                                        end;   //9
                                                                    end;  // 8
                                                                end  // 10
                                                                else begin  //11
                                                                            // Dint update hence log
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                   // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                        unaffectedEmployees.Insert();
                                                                    end; //12
                                                                end;   //11

                                                                // empSalaryCard."Basic Pay":=;
                                                            end  //13
                                                            else begin //17
                                                                       // Dint update hence log
                                                                unaffectedEmployees.Reset();
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                // insert into the unaffectedEmployees table
                                                                    unaffectedEmployees.Init();
                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                    unaffectedEmployees.Insert();
                                                                end; //16
                                                            end; //17

                                                            empSalaryCard.Reset();
                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                            if empSalaryCard.Find('-') then; //18;

                                                            // Change Basic Pay
                                                            // empSalaryCard."Basic Pay":=;
                                                            //18
                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                        end //23
                                                        else begin  //42
                                                                    // check in the next scale again
                                                            salGrades.Reset();
                                                            salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                            salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                            if salGrades.Find('-') then begin //33
                                                                                              //////////////////////////////////////////////////////////////////////////////////////////
                                                                salGrades2.Reset();
                                                                salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                if salGrades2.Find('-') then begin//23
                                                                                                  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                  // Change Basic pay and insert into the register
                                                                                                  // Find the value of new salary from the steps.
                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                    if empSalaryCard.Find('-') then  //14;

                                                                        //14
                                                                    Clear(salcat);
                                                                    Clear(salgrade);
                                                                    Clear(salbasic);
                                                                    salcat := employees."Salary Category";
                                                                    salgrade := salGrades2."Salary Grade code";
                                                                    salbasic := empSalaryCard."Basic Pay";

                                                                    salaStepsAmount.Reset();
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                    if salaStepsAmount.Find('-') then begin  //13
                                                                                                             // select the new employee salary and
                                                                                                             // Update Basic Pay here
                                                                        salaStepsAmount2.Reset();
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                        if salaStepsAmount2.Find('-') then begin   // 10

                                                                            // At last! Insert into the Log and
                                                                            if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                salincregister.Reset();
                                                                                salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not salincregister.Find('-') then begin // 6
                                                                                                                           // insert into the register
                                                                                    salincregister.Init();
                                                                                    salincregister."Employee No." := employees."No.";
                                                                                    salincregister."Increament Month" := 'January';
                                                                                    salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                    salincregister."User ID" := UserId;
                                                                                    salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                    salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                    salincregister."Job Grade" := employees."Salary Grade";
                                                                                    salincregister."Job Category" := employees."Salary Category";
                                                                                    salincregister.Insert();
                                                                                    // Update Basic
                                                                                    empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                    //                      empSalaryCard.MODIFY;
                                                                                end; // 6
                                                                            end // 7
                                                                            else begin  // 8
                                                                                        //the salary in the steps is zero hence cannot insert
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                    unaffectedEmployees.Insert();
                                                                                end;   //9
                                                                            end;  // 8
                                                                        end  // 10
                                                                        else begin  //11
                                                                                    // Dint update hence log
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                           // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end; //12
                                                                        end;   //11

                                                                        // empSalaryCard."Basic Pay":=;
                                                                    end  //13
                                                                    else begin //17
                                                                               // Dint update hence log
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                        // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                            unaffectedEmployees.Insert();
                                                                        end; //16
                                                                    end; //17

                                                                    empSalaryCard.Reset();
                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                    if empSalaryCard.Find('-') then;  //18;

                                                                    // Change Basic Pay
                                                                    // empSalaryCard."Basic Pay":=;
                                                                    //18
                                                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                end //23
                                                                else begin  //42
                                                                            // check in the next scale again
                                                                    salGrades2.Reset();
                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                    // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                    if salGrades2.Find('-') then begin //22
                                                                                                       //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                       // Change Basic pay and insert into the register
                                                                                                       // Find the value of new salary from the steps.
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then  //14;

                                                                            //14

                                                                        salaStepsAmount.Reset();
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                        // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                 // select the new employee salary and
                                                                                                                 // Update Basic Pay here
                                                                            salaStepsAmount2.Reset();
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                // At last! Insert into the Log and
                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                    salincregister.Reset();
                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                    salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                               // insert into the register
                                                                                        salincregister.Init();
                                                                                        salincregister."Employee No." := employees."No.";
                                                                                        salincregister."Increament Month" := 'January';
                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                        salincregister."User ID" := UserId;
                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                        salincregister.Insert();
                                                                                        // Update Basic
                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                        //                     empSalaryCard.MODIFY;
                                                                                    end; // 6
                                                                                end // 7
                                                                                else begin  // 8
                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end;   //9
                                                                                end;  // 8
                                                                            end  // 10
                                                                            else begin  //11
                                                                                        // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                               // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //12
                                                                            end;   //11

                                                                            // empSalaryCard."Basic Pay":=;
                                                                        end  //13
                                                                        else begin //17
                                                                                   // Dint update hence log
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end; //16
                                                                        end; //17

                                                                        empSalaryCard.Reset();
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                        // Change Basic Pay
                                                                        // empSalaryCard."Basic Pay":=;
                                                                        //18
                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                    end //22
                                                                    else begin  //41                                                                                  //nnn
                                                                        salGrades2.Reset();
                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                        if salGrades2.Find('-') then begin //21
                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                           // Change Basic pay and insert into the register
                                                                                                           // Find the value of new salary from the steps.
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                //14

                                                                            salaStepsAmount.Reset();
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                     // select the new employee salary and
                                                                                                                     // Update Basic Pay here
                                                                                salaStepsAmount2.Reset();
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                    // At last! Insert into the Log and
                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                        salincregister.Reset();
                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                   // insert into the register
                                                                                            salincregister.Init();
                                                                                            salincregister."Employee No." := employees."No.";
                                                                                            salincregister."Increament Month" := 'January';
                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                            salincregister."User ID" := UserId;
                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                            salincregister.Insert();
                                                                                            // Update Basic
                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                            //                         empSalaryCard.MODIFY;
                                                                                        end; // 6
                                                                                    end // 7
                                                                                    else begin  // 8
                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end;   //9
                                                                                    end;  // 8
                                                                                end  // 10
                                                                                else begin  //11
                                                                                            // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //12
                                                                                end;   //11

                                                                                // empSalaryCard."Basic Pay":=;
                                                                            end  //13
                                                                            else begin //17
                                                                                       // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //16
                                                                            end; //17

                                                                            empSalaryCard.Reset();
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                            // Change Basic Pay
                                                                            // empSalaryCard."Basic Pay":=;
                                                                            //18
                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                        end //21
                                                                        else begin //20
                                                                                   //error into logs - No more salary steps found
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin  //19

                                                                                // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end;   //19
                                                                        end;
                                                                    end;   //20
                                                                end; //41
                                                            end; //42
                                                                 ////////////////////////////////////////////////////////////////////////////////////////////
                                                        end; //42
                                                             ////////////////////////////////////////////////////////////////////////////////////////////
                                                    end // 33
                                                    else   //34
                                                        ;

                                                    // Insert into Failed List
                                                    //34
                                                end;   //11

                                                //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk

                                            end //35
                                            else begin  //36
                                                        //77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
                                                        // if employee gets salary outside of their grade...
                                                salGrades.Reset();
                                                salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                if salGrades.Find('-') then begin  //52
                                                                                   //////////////////////////////////////////////////////////////////////////////////////////
                                                    salGrades2.Reset();
                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                    //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 1);
                                                    if salGrades2.Find('-') then begin//23
                                                                                      //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                      // Change Basic pay and insert into the register
                                                                                      // Find the value of new salary from the steps.
                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                        if empSalaryCard.Find('-') then  //14;

                                                            //14

                                                        salaStepsAmount.Reset();
                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                        salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                 // select the new employee salary and
                                                                                                 // Update Basic Pay here
                                                            salaStepsAmount2.Reset();
                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                // At last! Insert into the Log and
                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                    salincregister.Reset();
                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                    salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                               // insert into the register
                                                                        salincregister.Init();
                                                                        salincregister."Employee No." := employees."No.";
                                                                        salincregister."Increament Month" := 'January';
                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                        salincregister."User ID" := UserId;
                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                        salincregister.Insert();
                                                                        // Update Basic
                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                        //                          empSalaryCard.MODIFY;
                                                                    end; // 6
                                                                end // 7
                                                                else begin  // 8
                                                                            //the salary in the steps is zero hence cannot insert
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                    // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                        unaffectedEmployees.Insert();
                                                                    end;   //9
                                                                end;  // 8
                                                            end  // 10
                                                            else begin  //11

                                                                ////
                                                                /////////////// increment But add 2
                                                                /////

                                                                // Dint update hence log
                                                                unaffectedEmployees.Reset();
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                               // insert into the unaffectedEmployees table
                                                                    unaffectedEmployees.Init();
                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                    unaffectedEmployees.Insert();
                                                                end; //12
                                                            end;   //11

                                                            // empSalaryCard."Basic Pay":=;
                                                        end  //13
                                                        else begin //17
                                                                   // Dint update hence log  tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt

                                                            salGrades.Reset();
                                                            salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                            salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                            if salGrades.Find('-') then begin  //52
                                                                                               //////////////////////////////////////////////////////////////////////////////////////////
                                                                salGrades2.Reset();
                                                                salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                if salGrades2.Find('-') then begin//23
                                                                                                  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                  // Change Basic pay and insert into the register
                                                                                                  // Find the value of new salary from the steps.
                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                    if empSalaryCard.Find('-') then  //14;

                                                                        //14

                                                                    salaStepsAmount.Reset();
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                    if salaStepsAmount.Find('-') then begin  //13
                                                                                                             // select the new employee salary and
                                                                                                             // Update Basic Pay here
                                                                        salaStepsAmount2.Reset();
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                        if salaStepsAmount2.Find('-') then begin   // 10

                                                                            // At last! Insert into the Log and
                                                                            if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                salincregister.Reset();
                                                                                salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not salincregister.Find('-') then begin // 6
                                                                                                                           // insert into the register
                                                                                    salincregister.Init();
                                                                                    salincregister."Employee No." := employees."No.";
                                                                                    salincregister."Increament Month" := 'January';
                                                                                    salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                    salincregister."User ID" := UserId;
                                                                                    salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                    salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                    salincregister."Job Grade" := employees."Salary Grade";
                                                                                    salincregister."Job Category" := employees."Salary Category";
                                                                                    salincregister.Insert();
                                                                                    // Update Basic
                                                                                    empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                    //                          empSalaryCard.MODIFY;
                                                                                end; // 6
                                                                            end // 7
                                                                            else begin  // 8
                                                                                        //the salary in the steps is zero hence cannot insert
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                    unaffectedEmployees.Insert();
                                                                                end;   //9
                                                                            end;  // 8
                                                                        end  // 10
                                                                        else begin  //11

                                                                            ////
                                                                            /////////////// increment But add 2
                                                                            /////

                                                                            // Dint update hence log
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                           // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end; //12
                                                                        end;   //11

                                                                        // empSalaryCard."Basic Pay":=;
                                                                    end  //13
                                                                    else begin //17
                                                                               // Dint update hence log
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                        // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                            unaffectedEmployees.Insert();
                                                                        end; //16
                                                                    end; //17

                                                                    empSalaryCard.Reset();
                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                    if empSalaryCard.Find('-') then;  //18;

                                                                    // Change Basic Pay
                                                                    // empSalaryCard."Basic Pay":=;
                                                                    //18
                                                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                end //23
                                                                else begin  //42
                                                                            // check in the next scale again
                                                                    salGrades2.Reset();
                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                    // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                    if salGrades2.Find('-') then begin //22
                                                                                                       //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                       // Change Basic pay and insert into the register
                                                                                                       // Find the value of new salary from the steps.
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then  //14;

                                                                            //14

                                                                        salaStepsAmount.Reset();
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                        // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                 // select the new employee salary and
                                                                                                                 // Update Basic Pay here
                                                                            salaStepsAmount2.Reset();
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                // At last! Insert into the Log and
                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                    salincregister.Reset();
                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                    salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                               // insert into the register
                                                                                        salincregister.Init();
                                                                                        salincregister."Employee No." := employees."No.";
                                                                                        salincregister."Increament Month" := 'January';
                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                        salincregister."User ID" := UserId;
                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                        salincregister.Insert();
                                                                                        // Update Basic
                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                        //                         empSalaryCard.MODIFY;
                                                                                    end; // 6
                                                                                end // 7
                                                                                else begin  // 8
                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end;   //9
                                                                                end;  // 8
                                                                            end  // 10
                                                                            else begin  //11
                                                                                        // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                               // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //12
                                                                            end;   //11

                                                                            // empSalaryCard."Basic Pay":=;
                                                                        end  //13
                                                                        else begin //17
                                                                                   // Dint update hence log
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end; //16
                                                                        end; //17

                                                                        empSalaryCard.Reset();
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                        // Change Basic Pay
                                                                        // empSalaryCard."Basic Pay":=;
                                                                        //18
                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                    end //22
                                                                    else begin  //41                                                                                  //nnn
                                                                        salGrades2.Reset();
                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                        if salGrades2.Find('-') then begin //21
                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                           // Change Basic pay and insert into the register
                                                                                                           // Find the value of new salary from the steps.
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                //14

                                                                            salaStepsAmount.Reset();
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                            //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                     // select the new employee salary and
                                                                                                                     // Update Basic Pay here
                                                                                salaStepsAmount2.Reset();
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                    // At last! Insert into the Log and
                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                        salincregister.Reset();
                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                   // insert into the register
                                                                                            salincregister.Init();
                                                                                            salincregister."Employee No." := employees."No.";
                                                                                            salincregister."Increament Month" := 'January';
                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                            salincregister."User ID" := UserId;
                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                            salincregister.Insert();
                                                                                            // Update Basic
                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                            //                         empSalaryCard.MODIFY;
                                                                                        end; // 6
                                                                                    end // 7
                                                                                    else begin  // 8
                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end;   //9
                                                                                    end;  // 8
                                                                                end  // 10
                                                                                else begin  //11
                                                                                            // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //12
                                                                                end;   //11

                                                                                // empSalaryCard."Basic Pay":=;
                                                                            end  //13
                                                                            else begin //17
                                                                                       // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //16
                                                                            end; //17

                                                                            empSalaryCard.Reset();
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                            // Change Basic Pay
                                                                            // empSalaryCard."Basic Pay":=;
                                                                            //18
                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                        end //21
                                                                        else begin //20
                                                                                   //error into logs - No more salary steps found
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin  //19

                                                                                // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end;   //19
                                                                        end;   //20
                                                                    end; //41
                                                                end; //42
                                                                     ////////////////////////////////////////////////////////////////////////////////////////////
                                                            end;//52
                                                        end; //17

                                                        empSalaryCard.Reset();
                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                        if empSalaryCard.Find('-') then;  //18;

                                                        // Change Basic Pay
                                                        // empSalaryCard."Basic Pay":=;
                                                        //18
                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                    end //23
                                                    else begin  //42
                                                                // check in the next scale again
                                                        salGrades2.Reset();
                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                        if salGrades2.Find('-') then begin //22
                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                           // Change Basic pay and insert into the register
                                                                                           // Find the value of new salary from the steps.
                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                            if empSalaryCard.Find('-') then  //14;

                                                                //14

                                                            salaStepsAmount.Reset();
                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                     // select the new employee salary and
                                                                                                     // Update Basic Pay here
                                                                salaStepsAmount2.Reset();
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                    // At last! Insert into the Log and
                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                        salincregister.Reset();
                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                   // insert into the register
                                                                            salincregister.Init();
                                                                            salincregister."Employee No." := employees."No.";
                                                                            salincregister."Increament Month" := 'January';
                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                            salincregister."User ID" := UserId;
                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                            salincregister.Insert();
                                                                            // Update Basic
                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                            //                         empSalaryCard.MODIFY;
                                                                        end; // 6
                                                                    end // 7
                                                                    else begin  // 8
                                                                                //the salary in the steps is zero hence cannot insert
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                        // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                            unaffectedEmployees.Insert();
                                                                        end;   //9
                                                                    end;  // 8
                                                                end  // 10
                                                                else begin  //11
                                                                            // Dint update hence log
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                   // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                        unaffectedEmployees.Insert();
                                                                    end; //12
                                                                end;   //11

                                                                // empSalaryCard."Basic Pay":=;
                                                            end  //13
                                                            else begin //17
                                                                       // Dint update hence log
                                                                unaffectedEmployees.Reset();
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                // insert into the unaffectedEmployees table
                                                                    unaffectedEmployees.Init();
                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                    unaffectedEmployees.Insert();
                                                                end; //16
                                                            end; //17

                                                            empSalaryCard.Reset();
                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                            if empSalaryCard.Find('-') then;  //18;

                                                            // Change Basic Pay
                                                            // empSalaryCard."Basic Pay":=;
                                                            //18
                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                        end //22
                                                        else begin  //41                                                                                  //nnn
                                                            salGrades2.Reset();
                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                            if salGrades2.Find('-') then begin //21
                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                               // Change Basic pay and insert into the register
                                                                                               // Find the value of new salary from the steps.
                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                if empSalaryCard.Find('-') then  //14;

                                                                    //14

                                                                salaStepsAmount.Reset();
                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                         // select the new employee salary and
                                                                                                         // Update Basic Pay here
                                                                    salaStepsAmount2.Reset();
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                        // At last! Insert into the Log and
                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                            salincregister.Reset();
                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                            salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                       // insert into the register
                                                                                salincregister.Init();
                                                                                salincregister."Employee No." := employees."No.";
                                                                                salincregister."Increament Month" := 'January';
                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                salincregister."User ID" := UserId;
                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                salincregister.Insert();
                                                                                // Update Basic
                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                //                         empSalaryCard.MODIFY;
                                                                            end; // 6
                                                                        end // 7
                                                                        else begin  // 8
                                                                                    //the salary in the steps is zero hence cannot insert
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                unaffectedEmployees.Insert();
                                                                            end;   //9
                                                                        end;  // 8
                                                                    end  // 10
                                                                    else begin  //11
                                                                                // Dint update hence log
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                       // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                            unaffectedEmployees.Insert();
                                                                        end; //12
                                                                    end;   //11

                                                                    // empSalaryCard."Basic Pay":=;
                                                                end  //13
                                                                else begin //17
                                                                           // Dint update hence log
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                    // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                        unaffectedEmployees.Insert();
                                                                    end; //16
                                                                end; //17

                                                                empSalaryCard.Reset();
                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                if empSalaryCard.Find('-') then;  //18;

                                                                // Change Basic Pay
                                                                // empSalaryCard."Basic Pay":=;
                                                                //18
                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                            end //21
                                                            else begin //20
                                                                       //error into logs - No more salary steps found
                                                                unaffectedEmployees.Reset();
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                if not unaffectedEmployees.Find('-') then begin  //19

                                                                    // insert into the unaffectedEmployees table
                                                                    unaffectedEmployees.Init();
                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                    unaffectedEmployees.Insert();
                                                                end;   //19
                                                            end;   //20
                                                        end; //41
                                                    end; //42
                                                         ////////////////////////////////////////////////////////////////////////////////////////////
                                                end;//52
                                            end;//36   salary outside scale & grade

                                        end//37  the employee is atleast 6 Months old hence eligeable for increase
                                        else begin
                                            unaffectedEmployees.Reset();
                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                            // insert into the unaffectedEmployees table
                                                unaffectedEmployees.Init();
                                                unaffectedEmployees."Employee No." := employees."No.";
                                                unaffectedEmployees."Increament Month" := 'January';
                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                unaffectedEmployees.Reason := 'The Employee is not six months old on employment...';
                                                unaffectedEmployees.Insert();
                                            end; //16
                                        end; // Insert into unaffected coz the employee is not more than six months old......
                                             //38
                                end //4
                                else
                                    if Date2DMY(Today, 2) = 7 then   //3


                                        // Increase salary fro guys who were employed between January and July
                                        if EmplMonth in [7 .. 12] then   //38

                                            // Check whether the employee is eligible for the increment
                                            if ((Date2DMY(Today, 3)) > (Date2DMY(employees."Date Of Join", 3))) then begin  //37

                                                salaStepsAmount.Reset();
                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", employees."Salary Grade");
                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                if salaStepsAmount.Find('-') then begin //35

                                                    // Basic Payfound Hence Move to the next level in the steps table
                                                    //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                                                    salaStepsAmount2.Reset();
                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", employees."Salary Grade");
                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                        // At last! Insert into the Log and
                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                            salincregister.Reset();
                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                            if not salincregister.Find('-') then begin // 6
                                                                                                       // insert into the register
                                                                salincregister.Init();
                                                                salincregister."Employee No." := employees."No.";
                                                                salincregister."Increament Month" := 'July';
                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                salincregister."User ID" := UserId;
                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                salincregister."Job Category" := employees."Salary Category";
                                                                salincregister.Insert();
                                                                // Update Basic
                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                //                      empSalaryCard.MODIFY;
                                                            end; // 6
                                                        end // 7
                                                        else begin  // 8
                                                                    //the salary in the steps is zero hence cannot insert
                                                            unaffectedEmployees.Reset();
                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                            // insert into the unaffectedEmployees table
                                                                unaffectedEmployees.Init();
                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                unaffectedEmployees.Insert();
                                                            end;   //9
                                                        end;  // 8
                                                    end  // 10
                                                    else begin  //11
                                                        salGrades.Reset();
                                                        salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                        salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                        if salGrades.Find('-') then begin //33
                                                                                          //////////////////////////////////////////////////////////////////////////////////////////
                                                            salGrades2.Reset();
                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                            //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                            if salGrades2.Find('-') then begin//23
                                                                                              //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                              // Change Basic pay and insert into the register
                                                                                              // Find the value of new salary from the steps.
                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                if empSalaryCard.Find('-') then  //14;

                                                                    //14
                                                                Clear(salcat);
                                                                Clear(salgrade);
                                                                Clear(salbasic);
                                                                salcat := employees."Salary Category";
                                                                salgrade := salGrades2."Salary Grade code";
                                                                salbasic := empSalaryCard."Basic Pay";

                                                                salaStepsAmount.Reset();
                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                         // select the new employee salary and
                                                                                                         // Update Basic Pay here
                                                                    salaStepsAmount2.Reset();
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                        // At last! Insert into the Log and
                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                            salincregister.Reset();
                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                       // insert into the register
                                                                                salincregister.Init();
                                                                                salincregister."Employee No." := employees."No.";
                                                                                salincregister."Increament Month" := 'July';
                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                salincregister."User ID" := UserId;
                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                salincregister.Insert();
                                                                                // Update Basic
                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                //                      empSalaryCard.MODIFY;
                                                                            end; // 6
                                                                        end // 7
                                                                        else begin  // 8
                                                                                    //the salary in the steps is zero hence cannot insert
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                unaffectedEmployees.Insert();
                                                                            end;   //9
                                                                        end;  // 8
                                                                    end  // 10
                                                                    else begin  //11
                                                                                // Dint update hence log
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                       // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                            unaffectedEmployees.Insert();
                                                                        end; //12
                                                                    end;   //11

                                                                    // empSalaryCard."Basic Pay":=;
                                                                end  //13
                                                                else begin //17
                                                                           // Dint update hence log
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                    // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                        unaffectedEmployees.Insert();
                                                                    end; //16
                                                                end; //17

                                                                empSalaryCard.Reset();
                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                if empSalaryCard.Find('-') then;  //18;

                                                                // Change Basic Pay
                                                                // empSalaryCard."Basic Pay":=;
                                                                //18
                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                            end //23
                                                            else begin  //42
                                                                        // check in the next scale again
                                                                salGrades.Reset();
                                                                salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                if salGrades.Find('-') then begin //33
                                                                                                  //////////////////////////////////////////////////////////////////////////////////////////
                                                                    salGrades2.Reset();
                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                    //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                    if salGrades2.Find('-') then begin//23
                                                                                                      //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                      // Change Basic pay and insert into the register
                                                                                                      // Find the value of new salary from the steps.
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then  //14;

                                                                            //14
                                                                        Clear(salcat);
                                                                        Clear(salgrade);
                                                                        Clear(salbasic);
                                                                        salcat := employees."Salary Category";
                                                                        salgrade := salGrades2."Salary Grade code";
                                                                        salbasic := empSalaryCard."Basic Pay";

                                                                        salaStepsAmount.Reset();
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                 // select the new employee salary and
                                                                                                                 // Update Basic Pay here
                                                                            salaStepsAmount2.Reset();
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                // At last! Insert into the Log and
                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                    salincregister.Reset();
                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                    salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                               // insert into the register
                                                                                        salincregister.Init();
                                                                                        salincregister."Employee No." := employees."No.";
                                                                                        salincregister."Increament Month" := 'July';
                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                        salincregister."User ID" := UserId;
                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                        salincregister.Insert();
                                                                                        // Update Basic
                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                        //                      empSalaryCard.MODIFY;
                                                                                    end; // 6
                                                                                end // 7
                                                                                else begin  // 8
                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end;   //9
                                                                                end;  // 8
                                                                            end  // 10
                                                                            else begin  //11
                                                                                        // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                               // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //12
                                                                            end;   //11

                                                                            // empSalaryCard."Basic Pay":=;
                                                                        end  //13
                                                                        else begin //17
                                                                                   // Dint update hence log
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end; //16
                                                                        end; //17

                                                                        empSalaryCard.Reset();
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                        // Change Basic Pay
                                                                        // empSalaryCard."Basic Pay":=;
                                                                        //18
                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                    end //23
                                                                    else begin  //42
                                                                                // check in the next scale again
                                                                        salGrades2.Reset();
                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                        if salGrades2.Find('-') then begin //22
                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                           // Change Basic pay and insert into the register
                                                                                                           // Find the value of new salary from the steps.
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                //14

                                                                            salaStepsAmount.Reset();
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                     // select the new employee salary and
                                                                                                                     // Update Basic Pay here
                                                                                salaStepsAmount2.Reset();
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                    // At last! Insert into the Log and
                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                        salincregister.Reset();
                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                        salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                   // insert into the register
                                                                                            salincregister.Init();
                                                                                            salincregister."Employee No." := employees."No.";
                                                                                            salincregister."Increament Month" := 'July';
                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                            salincregister."User ID" := UserId;
                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                            salincregister.Insert();
                                                                                            // Update Basic
                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                            //                     empSalaryCard.MODIFY;
                                                                                        end; // 6
                                                                                    end // 7
                                                                                    else begin  // 8
                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end;   //9
                                                                                    end;  // 8
                                                                                end  // 10
                                                                                else begin  //11
                                                                                            // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //12
                                                                                end;   //11

                                                                                // empSalaryCard."Basic Pay":=;
                                                                            end  //13
                                                                            else begin //17
                                                                                       // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //16
                                                                            end; //17

                                                                            empSalaryCard.Reset();
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                            // Change Basic Pay
                                                                            // empSalaryCard."Basic Pay":=;
                                                                            //18
                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                        end //22
                                                                        else begin  //41                                                                                  //nnn
                                                                            salGrades2.Reset();
                                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                            if salGrades2.Find('-') then begin //21
                                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                               // Change Basic pay and insert into the register
                                                                                                               // Find the value of new salary from the steps.
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then  //14;

                                                                                    //14

                                                                                salaStepsAmount.Reset();
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                                         // select the new employee salary and
                                                                                                                         // Update Basic Pay here
                                                                                    salaStepsAmount2.Reset();
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                                        // At last! Insert into the Log and
                                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                            salincregister.Reset();
                                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                                       // insert into the register
                                                                                                salincregister.Init();
                                                                                                salincregister."Employee No." := employees."No.";
                                                                                                salincregister."Increament Month" := 'July';
                                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                salincregister."User ID" := UserId;
                                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                                salincregister.Insert();
                                                                                                // Update Basic
                                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                //                         empSalaryCard.MODIFY;
                                                                                            end; // 6
                                                                                        end // 7
                                                                                        else begin  // 8
                                                                                                    //the salary in the steps is zero hence cannot insert
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end;   //9
                                                                                        end;  // 8
                                                                                    end  // 10
                                                                                    else begin  //11
                                                                                                // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                       // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //12
                                                                                    end;   //11

                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                end  //13
                                                                                else begin //17
                                                                                           // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //16
                                                                                end; //17

                                                                                empSalaryCard.Reset();
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then;  //18;

                                                                                // Change Basic Pay
                                                                                // empSalaryCard."Basic Pay":=;
                                                                                //18
                                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                            end //21
                                                                            else begin //20
                                                                                       //error into logs - No more salary steps found
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin  //19

                                                                                    // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end;   //19
                                                                            end;
                                                                        end;   //20
                                                                    end; //41
                                                                end; //42
                                                                     ////////////////////////////////////////////////////////////////////////////////////////////
                                                            end; //42
                                                                 ////////////////////////////////////////////////////////////////////////////////////////////
                                                        end // 33
                                                        else   //34
                                                            ;

                                                        // Insert into Failed List
                                                        //34
                                                    end;   //11

                                                    //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk

                                                end //35
                                                else begin  //36
                                                            //77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
                                                            // if employee gets salary outside of their grade...
                                                    salGrades.Reset();
                                                    salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                    salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                    if salGrades.Find('-') then begin  //52
                                                                                       //////////////////////////////////////////////////////////////////////////////////////////
                                                        salGrades2.Reset();
                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                        //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 1);
                                                        if salGrades2.Find('-') then begin//23
                                                                                          //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                          // Change Basic pay and insert into the register
                                                                                          // Find the value of new salary from the steps.
                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                            if empSalaryCard.Find('-') then  //14;

                                                                //14

                                                            salaStepsAmount.Reset();
                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                            salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                     // select the new employee salary and
                                                                                                     // Update Basic Pay here
                                                                salaStepsAmount2.Reset();
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                    // At last! Insert into the Log and
                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                        salincregister.Reset();
                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                        salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                   // insert into the register
                                                                            salincregister.Init();
                                                                            salincregister."Employee No." := employees."No.";
                                                                            salincregister."Increament Month" := 'July';
                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                            salincregister."User ID" := UserId;
                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                            salincregister.Insert();
                                                                            // Update Basic
                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                            //                          empSalaryCard.MODIFY;
                                                                        end; // 6
                                                                    end // 7
                                                                    else begin  // 8
                                                                                //the salary in the steps is zero hence cannot insert
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                        // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                            unaffectedEmployees.Insert();
                                                                        end;   //9
                                                                    end;  // 8
                                                                end  // 10
                                                                else begin  //11

                                                                    ////
                                                                    /////////////// increment But add 2
                                                                    /////

                                                                    // Dint update hence log
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                   // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                        unaffectedEmployees.Insert();
                                                                    end; //12
                                                                end;   //11

                                                                // empSalaryCard."Basic Pay":=;
                                                            end  //13
                                                            else begin //17
                                                                       // Dint update hence log  tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt

                                                                salGrades.Reset();
                                                                salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                if salGrades.Find('-') then begin  //52
                                                                                                   //////////////////////////////////////////////////////////////////////////////////////////
                                                                    salGrades2.Reset();
                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                    //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                    if salGrades2.Find('-') then begin//23
                                                                                                      //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                      // Change Basic pay and insert into the register
                                                                                                      // Find the value of new salary from the steps.
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then  //14;

                                                                            //14

                                                                        salaStepsAmount.Reset();
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                 // select the new employee salary and
                                                                                                                 // Update Basic Pay here
                                                                            salaStepsAmount2.Reset();
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                // At last! Insert into the Log and
                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                    salincregister.Reset();
                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                    salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                               // insert into the register
                                                                                        salincregister.Init();
                                                                                        salincregister."Employee No." := employees."No.";
                                                                                        salincregister."Increament Month" := 'July';
                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                        salincregister."User ID" := UserId;
                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                        salincregister.Insert();
                                                                                        // Update Basic
                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                        //                          empSalaryCard.MODIFY;
                                                                                    end; // 6
                                                                                end // 7
                                                                                else begin  // 8
                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end;   //9
                                                                                end;  // 8
                                                                            end  // 10
                                                                            else begin  //11

                                                                                ////
                                                                                /////////////// increment But add 2
                                                                                /////

                                                                                // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                               // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //12
                                                                            end;   //11

                                                                            // empSalaryCard."Basic Pay":=;
                                                                        end  //13
                                                                        else begin //17
                                                                                   // Dint update hence log
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end; //16
                                                                        end; //17

                                                                        empSalaryCard.Reset();
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                        // Change Basic Pay
                                                                        // empSalaryCard."Basic Pay":=;
                                                                        //18
                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                    end //23
                                                                    else begin  //42
                                                                                // check in the next scale again
                                                                        salGrades2.Reset();
                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                        if salGrades2.Find('-') then begin //22
                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                           // Change Basic pay and insert into the register
                                                                                                           // Find the value of new salary from the steps.
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                //14

                                                                            salaStepsAmount.Reset();
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                     // select the new employee salary and
                                                                                                                     // Update Basic Pay here
                                                                                salaStepsAmount2.Reset();
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                    // At last! Insert into the Log and
                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                        salincregister.Reset();
                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                        salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                   // insert into the register
                                                                                            salincregister.Init();
                                                                                            salincregister."Employee No." := employees."No.";
                                                                                            salincregister."Increament Month" := 'July';
                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                            salincregister."User ID" := UserId;
                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                            salincregister.Insert();
                                                                                            // Update Basic
                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                            //                         empSalaryCard.MODIFY;
                                                                                        end; // 6
                                                                                    end // 7
                                                                                    else begin  // 8
                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end;   //9
                                                                                    end;  // 8
                                                                                end  // 10
                                                                                else begin  //11
                                                                                            // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //12
                                                                                end;   //11

                                                                                // empSalaryCard."Basic Pay":=;
                                                                            end  //13
                                                                            else begin //17
                                                                                       // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //16
                                                                            end; //17

                                                                            empSalaryCard.Reset();
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                            // Change Basic Pay
                                                                            // empSalaryCard."Basic Pay":=;
                                                                            //18
                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                        end //22
                                                                        else begin  //41                                                                                  //nnn
                                                                            salGrades2.Reset();
                                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                            if salGrades2.Find('-') then begin //21
                                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                               // Change Basic pay and insert into the register
                                                                                                               // Find the value of new salary from the steps.
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then  //14;

                                                                                    //14

                                                                                salaStepsAmount.Reset();
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                                         // select the new employee salary and
                                                                                                                         // Update Basic Pay here
                                                                                    salaStepsAmount2.Reset();
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                                        // At last! Insert into the Log and
                                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                            salincregister.Reset();
                                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                                       // insert into the register
                                                                                                salincregister.Init();
                                                                                                salincregister."Employee No." := employees."No.";
                                                                                                salincregister."Increament Month" := 'July';
                                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                salincregister."User ID" := UserId;
                                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                                salincregister.Insert();
                                                                                                // Update Basic
                                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                //                         empSalaryCard.MODIFY;
                                                                                            end; // 6
                                                                                        end // 7
                                                                                        else begin  // 8
                                                                                                    //the salary in the steps is zero hence cannot insert
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end;   //9
                                                                                        end;  // 8
                                                                                    end  // 10
                                                                                    else begin  //11
                                                                                                // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                       // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //12
                                                                                    end;   //11

                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                end  //13
                                                                                else begin //17
                                                                                           // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //16
                                                                                end; //17

                                                                                empSalaryCard.Reset();
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then;  //18;

                                                                                // Change Basic Pay
                                                                                // empSalaryCard."Basic Pay":=;
                                                                                //18
                                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                            end //21
                                                                            else begin //20
                                                                                       //error into logs - No more salary steps found
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin  //19

                                                                                    // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end;   //19
                                                                            end;   //20
                                                                        end; //41
                                                                    end; //42
                                                                         ////////////////////////////////////////////////////////////////////////////////////////////
                                                                end;//52
                                                            end; //17

                                                            empSalaryCard.Reset();
                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                            if empSalaryCard.Find('-') then;  //18;

                                                            // Change Basic Pay
                                                            // empSalaryCard."Basic Pay":=;
                                                            //18
                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                        end //23
                                                        else begin  //42
                                                                    // check in the next scale again
                                                            salGrades2.Reset();
                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                            if salGrades2.Find('-') then begin //22
                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                               // Change Basic pay and insert into the register
                                                                                               // Find the value of new salary from the steps.
                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                if empSalaryCard.Find('-') then  //14;

                                                                    //14

                                                                salaStepsAmount.Reset();
                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                         // select the new employee salary and
                                                                                                         // Update Basic Pay here
                                                                    salaStepsAmount2.Reset();
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                        // At last! Insert into the Log and
                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                            salincregister.Reset();
                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                       // insert into the register
                                                                                salincregister.Init();
                                                                                salincregister."Employee No." := employees."No.";
                                                                                salincregister."Increament Month" := 'July';
                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                salincregister."User ID" := UserId;
                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                salincregister.Insert();
                                                                                // Update Basic
                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                //                         empSalaryCard.MODIFY;
                                                                            end; // 6
                                                                        end // 7
                                                                        else begin  // 8
                                                                                    //the salary in the steps is zero hence cannot insert
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                unaffectedEmployees.Insert();
                                                                            end;   //9
                                                                        end;  // 8
                                                                    end  // 10
                                                                    else begin  //11
                                                                                // Dint update hence log
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                       // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                            unaffectedEmployees.Insert();
                                                                        end; //12
                                                                    end;   //11

                                                                    // empSalaryCard."Basic Pay":=;
                                                                end  //13
                                                                else begin //17
                                                                           // Dint update hence log
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                    // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                        unaffectedEmployees.Insert();
                                                                    end; //16
                                                                end; //17

                                                                empSalaryCard.Reset();
                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                if empSalaryCard.Find('-') then;  //18;

                                                                // Change Basic Pay
                                                                // empSalaryCard."Basic Pay":=;
                                                                //18
                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                            end //22
                                                            else begin  //41                                                                                  //nnn
                                                                salGrades2.Reset();
                                                                salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                if salGrades2.Find('-') then begin //21
                                                                                                   //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                   // Change Basic pay and insert into the register
                                                                                                   // Find the value of new salary from the steps.
                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                    if empSalaryCard.Find('-') then  //14;

                                                                        //14

                                                                    salaStepsAmount.Reset();
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                    //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                    salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                    if salaStepsAmount.Find('-') then begin  //13
                                                                                                             // select the new employee salary and
                                                                                                             // Update Basic Pay here
                                                                        salaStepsAmount2.Reset();
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                        salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                        if salaStepsAmount2.Find('-') then begin   // 10

                                                                            // At last! Insert into the Log and
                                                                            if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                salincregister.Reset();
                                                                                salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not salincregister.Find('-') then begin // 6
                                                                                                                           // insert into the register
                                                                                    salincregister.Init();
                                                                                    salincregister."Employee No." := employees."No.";
                                                                                    salincregister."Increament Month" := 'July';
                                                                                    salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                    salincregister."User ID" := UserId;
                                                                                    salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                    salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                    salincregister."Job Grade" := employees."Salary Grade";
                                                                                    salincregister."Job Category" := employees."Salary Category";
                                                                                    salincregister.Insert();
                                                                                    // Update Basic
                                                                                    empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                    //                         empSalaryCard.MODIFY;
                                                                                end; // 6
                                                                            end // 7
                                                                            else begin  // 8
                                                                                        //the salary in the steps is zero hence cannot insert
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                    unaffectedEmployees.Insert();
                                                                                end;   //9
                                                                            end;  // 8
                                                                        end  // 10
                                                                        else begin  //11
                                                                                    // Dint update hence log
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                           // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                unaffectedEmployees.Insert();
                                                                            end; //12
                                                                        end;   //11

                                                                        // empSalaryCard."Basic Pay":=;
                                                                    end  //13
                                                                    else begin //17
                                                                               // Dint update hence log
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                        // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                            unaffectedEmployees.Insert();
                                                                        end; //16
                                                                    end; //17

                                                                    empSalaryCard.Reset();
                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                    if empSalaryCard.Find('-') then;  //18;

                                                                    // Change Basic Pay
                                                                    // empSalaryCard."Basic Pay":=;
                                                                    //18
                                                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                end //21
                                                                else begin //20
                                                                           //error into logs - No more salary steps found
                                                                    unaffectedEmployees.Reset();
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                    if not unaffectedEmployees.Find('-') then begin  //19

                                                                        // insert into the unaffectedEmployees table
                                                                        unaffectedEmployees.Init();
                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                        unaffectedEmployees.Insert();
                                                                    end;   //19
                                                                end;   //20
                                                            end; //41
                                                        end; //42
                                                             ////////////////////////////////////////////////////////////////////////////////////////////
                                                    end;//52
                                                end;//36   salary outside scale & grade

                                            end//37  the employee is atleast 6 Months old hence eligeable for increase
                                            else begin
                                                unaffectedEmployees.Reset();
                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                if (Date2DMY(Today, 2)) = 1 then
                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January')
                                                else
                                                    if (Date2DMY(Today, 2)) = 7 then
                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                // insert into the unaffectedEmployees table
                                                    unaffectedEmployees.Init();
                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                    if (Date2DMY(Today, 2)) = 1 then
                                                        unaffectedEmployees."Increament Month" := 'January'
                                                    else
                                                        if (Date2DMY(Today, 2)) = 7 then
                                                            unaffectedEmployees."Increament Month" := 'July';
                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                    unaffectedEmployees.Reason := 'The Employee is not six months old on employment...';
                                                    unaffectedEmployees.Insert();
                                                end; //16
                                            end; // Insert into unaffected coz the employee is not more than six months old......
                                                 //38
                                                 //3
                            end;  //2
                            until employees.Next() = 0;
                        //1
                        // employees.setrange()
                    end;
                }
                action(IncreamentAll)
                {
                    Caption = 'Increament for All Categories And Stages';
                    Image = AddAction;
                    Promoted = true;
                    ToolTip = 'Executes the Increament for All Categories And Stages action.';

                    trigger OnAction()
                    begin

                        // IF (("Employee Category"='') OR ("Salary Grade code"='')) THEN
                        // ERROR('Specify the Salary category and Grade first');

                        if checkMonthValidity() = false then
                            Error('You can not carry out this process in this month.');

                        if Confirm('Run Salary increment for all Categories and Employees?', false) = false then
                            exit;

                        empcat.Reset();
                        if empcat.Find('-') then //73
                            repeat
                            begin //72

                                empgrade.Reset();
                                empgrade.SetRange(empgrade."Employee Category", empcat.Code);
                                if empgrade.Find('-') then //71
                                    repeat
                                    begin//70
                                        employees.Reset();
                                        employees.SetRange(employees."Salary Category", empgrade."Employee Category");
                                        employees.SetRange(employees."Salary Grade", empgrade."Salary Grade code");
                                        // employees.SETFILTER(employees."No.",'%1|%2','0093','0097');
                                        if employees.Find('-') then     //1
                                            repeat
                                            begin //2
                                                empSalaryCard.Reset();
                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                if empSalaryCard.Find('-') then //5;

                                                    //5
                                                Clear(EmplMonth);
                                                EmplMonth := Date2DMY(employees."Date Of Join", 2);
                                                // increment for January
                                                if Date2DMY(Today, 2) = 1 then begin //4

                                                    // Increase salary fro guys who were employed between January and July
                                                    if EmplMonth in [1 .. 6] then   //38

                                                        // Check whether the employee is eligible for the increment
                                                        if ((Date2DMY(Today, 3)) > (Date2DMY(employees."Date Of Join", 3))) then begin  //37

                                                            salaStepsAmount.Reset();
                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                            salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", employees."Salary Grade");
                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                            if salaStepsAmount.Find('-') then begin //35

                                                                // Basic Payfound Hence Move to the next level in the steps table
                                                                //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                                                                salaStepsAmount2.Reset();
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", employees."Salary Grade");
                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                    // At last! Insert into the Log and
                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                        salincregister.Reset();
                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                   // insert into the register
                                                                            salincregister.Init();
                                                                            salincregister."Employee No." := employees."No.";
                                                                            salincregister."Increament Month" := 'January';
                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                            salincregister."User ID" := UserId;
                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                            salincregister.Insert();
                                                                            // Update Basic
                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                            //                      empSalaryCard.MODIFY;
                                                                        end; // 6
                                                                    end // 7
                                                                    else begin  // 8
                                                                                //the salary in the steps is zero hence cannot insert
                                                                        unaffectedEmployees.Reset();
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                        // insert into the unaffectedEmployees table
                                                                            unaffectedEmployees.Init();
                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                            unaffectedEmployees.Insert();
                                                                        end;   //9
                                                                    end;  // 8
                                                                end  // 10
                                                                else begin  //11
                                                                    salGrades.Reset();
                                                                    salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                    salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                    if salGrades.Find('-') then begin //33
                                                                                                      //////////////////////////////////////////////////////////////////////////////////////////
                                                                        salGrades2.Reset();
                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                        //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                        if salGrades2.Find('-') then begin//23
                                                                                                          //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                          // Change Basic pay and insert into the register
                                                                                                          // Find the value of new salary from the steps.
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                //14
                                                                            Clear(salcat);
                                                                            Clear(salgrade);
                                                                            Clear(salbasic);
                                                                            salcat := employees."Salary Category";
                                                                            salgrade := salGrades2."Salary Grade code";
                                                                            salbasic := empSalaryCard."Basic Pay";

                                                                            salaStepsAmount.Reset();
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                     // select the new employee salary and
                                                                                                                     // Update Basic Pay here
                                                                                salaStepsAmount2.Reset();
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                    // At last! Insert into the Log and
                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                        salincregister.Reset();
                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                   // insert into the register
                                                                                            salincregister.Init();
                                                                                            salincregister."Employee No." := employees."No.";
                                                                                            salincregister."Increament Month" := 'January';
                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                            salincregister."User ID" := UserId;
                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                            salincregister.Insert();
                                                                                            // Update Basic
                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                            //                      empSalaryCard.MODIFY;
                                                                                        end; // 6
                                                                                    end // 7
                                                                                    else begin  // 8
                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end;   //9
                                                                                    end;  // 8
                                                                                end  // 10
                                                                                else begin  //11
                                                                                            // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //12
                                                                                end;   //11

                                                                                // empSalaryCard."Basic Pay":=;
                                                                            end  //13
                                                                            else begin //17
                                                                                       // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //16
                                                                            end; //17

                                                                            empSalaryCard.Reset();
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                            // Change Basic Pay
                                                                            // empSalaryCard."Basic Pay":=;
                                                                            //18
                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                        end //23
                                                                        else begin  //42
                                                                                    // check in the next scale again
                                                                            salGrades.Reset();
                                                                            salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                            salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                            if salGrades.Find('-') then begin //33
                                                                                                              //////////////////////////////////////////////////////////////////////////////////////////
                                                                                salGrades2.Reset();
                                                                                salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                                if salGrades2.Find('-') then begin//23
                                                                                                                  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                  // Change Basic pay and insert into the register
                                                                                                                  // Find the value of new salary from the steps.
                                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                    if empSalaryCard.Find('-') then  //14;

                                                                                        //14
                                                                                    Clear(salcat);
                                                                                    Clear(salgrade);
                                                                                    Clear(salbasic);
                                                                                    salcat := employees."Salary Category";
                                                                                    salgrade := salGrades2."Salary Grade code";
                                                                                    salbasic := empSalaryCard."Basic Pay";

                                                                                    salaStepsAmount.Reset();
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                    if salaStepsAmount.Find('-') then begin  //13
                                                                                                                             // select the new employee salary and
                                                                                                                             // Update Basic Pay here
                                                                                        salaStepsAmount2.Reset();
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                        if salaStepsAmount2.Find('-') then begin   // 10

                                                                                            // At last! Insert into the Log and
                                                                                            if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                salincregister.Reset();
                                                                                                salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                                salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not salincregister.Find('-') then begin // 6
                                                                                                                                           // insert into the register
                                                                                                    salincregister.Init();
                                                                                                    salincregister."Employee No." := employees."No.";
                                                                                                    salincregister."Increament Month" := 'January';
                                                                                                    salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    salincregister."User ID" := UserId;
                                                                                                    salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                    salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                    salincregister."Job Grade" := employees."Salary Grade";
                                                                                                    salincregister."Job Category" := employees."Salary Category";
                                                                                                    salincregister.Insert();
                                                                                                    // Update Basic
                                                                                                    empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                    //                      empSalaryCard.MODIFY;
                                                                                                end; // 6
                                                                                            end // 7
                                                                                            else begin  // 8
                                                                                                        //the salary in the steps is zero hence cannot insert
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end;   //9
                                                                                            end;  // 8
                                                                                        end  // 10
                                                                                        else begin  //11
                                                                                                    // Dint update hence log
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                           // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end; //12
                                                                                        end;   //11

                                                                                        // empSalaryCard."Basic Pay":=;
                                                                                    end  //13
                                                                                    else begin //17
                                                                                               // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //16
                                                                                    end; //17

                                                                                    empSalaryCard.Reset();
                                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                    if empSalaryCard.Find('-') then;  //18;

                                                                                    // Change Basic Pay
                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                    //18
                                                                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                                end //23
                                                                                else begin  //42
                                                                                            // check in the next scale again
                                                                                    salGrades2.Reset();
                                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                    // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                                    if salGrades2.Find('-') then begin //22
                                                                                                                       //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                       // Change Basic pay and insert into the register
                                                                                                                       // Find the value of new salary from the steps.
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then  //14;

                                                                                            //14

                                                                                        salaStepsAmount.Reset();
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                        // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                 // select the new employee salary and
                                                                                                                                 // Update Basic Pay here
                                                                                            salaStepsAmount2.Reset();
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                // At last! Insert into the Log and
                                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                    salincregister.Reset();
                                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                    salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                                               // insert into the register
                                                                                                        salincregister.Init();
                                                                                                        salincregister."Employee No." := employees."No.";
                                                                                                        salincregister."Increament Month" := 'January';
                                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        salincregister."User ID" := UserId;
                                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                                        salincregister.Insert();
                                                                                                        // Update Basic
                                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                        //                     empSalaryCard.MODIFY;
                                                                                                    end; // 6
                                                                                                end // 7
                                                                                                else begin  // 8
                                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end;   //9
                                                                                                end;  // 8
                                                                                            end  // 10
                                                                                            else begin  //11
                                                                                                        // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                               // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //12
                                                                                            end;   //11

                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                        end  //13
                                                                                        else begin //17
                                                                                                   // Dint update hence log
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end; //16
                                                                                        end; //17

                                                                                        empSalaryCard.Reset();
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                                        // Change Basic Pay
                                                                                        // empSalaryCard."Basic Pay":=;
                                                                                        //18
                                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                    end //22
                                                                                    else begin  //41                                                                                  //nnn
                                                                                        salGrades2.Reset();
                                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                                        if salGrades2.Find('-') then begin //21
                                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                           // Change Basic pay and insert into the register
                                                                                                                           // Find the value of new salary from the steps.
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                                //14

                                                                                            salaStepsAmount.Reset();
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                     // select the new employee salary and
                                                                                                                                     // Update Basic Pay here
                                                                                                salaStepsAmount2.Reset();
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                    // At last! Insert into the Log and
                                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                        salincregister.Reset();
                                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                                   // insert into the register
                                                                                                            salincregister.Init();
                                                                                                            salincregister."Employee No." := employees."No.";
                                                                                                            salincregister."Increament Month" := 'January';
                                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            salincregister."User ID" := UserId;
                                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                                            salincregister.Insert();
                                                                                                            // Update Basic
                                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                            //                         empSalaryCard.MODIFY;
                                                                                                        end; // 6
                                                                                                    end // 7
                                                                                                    else begin  // 8
                                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                                        unaffectedEmployees.Reset();
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                                            unaffectedEmployees.Init();
                                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                            unaffectedEmployees.Insert();
                                                                                                        end;   //9
                                                                                                    end;  // 8
                                                                                                end  // 10
                                                                                                else begin  //11
                                                                                                            // Dint update hence log
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end; //12
                                                                                                end;   //11

                                                                                                // empSalaryCard."Basic Pay":=;
                                                                                            end  //13
                                                                                            else begin //17
                                                                                                       // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                                // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //16
                                                                                            end; //17

                                                                                            empSalaryCard.Reset();
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                                            // Change Basic Pay
                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                            //18
                                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                        end //21
                                                                                        else begin //20
                                                                                                   //error into logs - No more salary steps found
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin  //19

                                                                                                // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end;   //19
                                                                                        end;
                                                                                    end;   //20
                                                                                end; //41
                                                                            end; //42
                                                                                 ////////////////////////////////////////////////////////////////////////////////////////////
                                                                        end; //42
                                                                             ////////////////////////////////////////////////////////////////////////////////////////////
                                                                    end // 33
                                                                    else   //34
                                                                        ;

                                                                    // Insert into Failed List
                                                                    //34
                                                                end;   //11

                                                                //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk

                                                            end //35
                                                            else begin  //36
                                                                        //77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
                                                                        // if employee gets salary outside of their grade...
                                                                salGrades.Reset();
                                                                salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                if salGrades.Find('-') then begin  //52
                                                                                                   //////////////////////////////////////////////////////////////////////////////////////////
                                                                    salGrades2.Reset();
                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                    //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 1);
                                                                    if salGrades2.Find('-') then begin//23
                                                                                                      //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                      // Change Basic pay and insert into the register
                                                                                                      // Find the value of new salary from the steps.
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then  //14;

                                                                            //14

                                                                        salaStepsAmount.Reset();
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                 // select the new employee salary and
                                                                                                                 // Update Basic Pay here
                                                                            salaStepsAmount2.Reset();
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                // At last! Insert into the Log and
                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                    salincregister.Reset();
                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                    salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                               // insert into the register
                                                                                        salincregister.Init();
                                                                                        salincregister."Employee No." := employees."No.";
                                                                                        salincregister."Increament Month" := 'January';
                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                        salincregister."User ID" := UserId;
                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                        salincregister.Insert();
                                                                                        // Update Basic
                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                        //                          empSalaryCard.MODIFY;
                                                                                    end; // 6
                                                                                end // 7
                                                                                else begin  // 8
                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end;   //9
                                                                                end;  // 8
                                                                            end  // 10
                                                                            else begin  //11

                                                                                ////
                                                                                /////////////// increment But add 2
                                                                                /////

                                                                                // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                               // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //12
                                                                            end;   //11

                                                                            // empSalaryCard."Basic Pay":=;
                                                                        end  //13
                                                                        else begin //17
                                                                                   // Dint update hence log  tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt

                                                                            salGrades.Reset();
                                                                            salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                            salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                            if salGrades.Find('-') then begin  //52
                                                                                                               //////////////////////////////////////////////////////////////////////////////////////////
                                                                                salGrades2.Reset();
                                                                                salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                                if salGrades2.Find('-') then begin//23
                                                                                                                  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                  // Change Basic pay and insert into the register
                                                                                                                  // Find the value of new salary from the steps.
                                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                    if empSalaryCard.Find('-') then  //14;

                                                                                        //14

                                                                                    salaStepsAmount.Reset();
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                    if salaStepsAmount.Find('-') then begin  //13
                                                                                                                             // select the new employee salary and
                                                                                                                             // Update Basic Pay here
                                                                                        salaStepsAmount2.Reset();
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                        if salaStepsAmount2.Find('-') then begin   // 10

                                                                                            // At last! Insert into the Log and
                                                                                            if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                salincregister.Reset();
                                                                                                salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                                salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not salincregister.Find('-') then begin // 6
                                                                                                                                           // insert into the register
                                                                                                    salincregister.Init();
                                                                                                    salincregister."Employee No." := employees."No.";
                                                                                                    salincregister."Increament Month" := 'January';
                                                                                                    salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    salincregister."User ID" := UserId;
                                                                                                    salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                    salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                    salincregister."Job Grade" := employees."Salary Grade";
                                                                                                    salincregister."Job Category" := employees."Salary Category";
                                                                                                    salincregister.Insert();
                                                                                                    // Update Basic
                                                                                                    empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                    //                          empSalaryCard.MODIFY;
                                                                                                end; // 6
                                                                                            end // 7
                                                                                            else begin  // 8
                                                                                                        //the salary in the steps is zero hence cannot insert
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end;   //9
                                                                                            end;  // 8
                                                                                        end  // 10
                                                                                        else begin  //11

                                                                                            ////
                                                                                            /////////////// increment But add 2
                                                                                            /////

                                                                                            // Dint update hence log
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                           // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end; //12
                                                                                        end;   //11

                                                                                        // empSalaryCard."Basic Pay":=;
                                                                                    end  //13
                                                                                    else begin //17
                                                                                               // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //16
                                                                                    end; //17

                                                                                    empSalaryCard.Reset();
                                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                    if empSalaryCard.Find('-') then;  //18;

                                                                                    // Change Basic Pay
                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                    //18
                                                                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                                end //23
                                                                                else begin  //42
                                                                                            // check in the next scale again
                                                                                    salGrades2.Reset();
                                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                    // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                                    if salGrades2.Find('-') then begin //22
                                                                                                                       //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                       // Change Basic pay and insert into the register
                                                                                                                       // Find the value of new salary from the steps.
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then  //14;

                                                                                            //14

                                                                                        salaStepsAmount.Reset();
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                        // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                 // select the new employee salary and
                                                                                                                                 // Update Basic Pay here
                                                                                            salaStepsAmount2.Reset();
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                // At last! Insert into the Log and
                                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                    salincregister.Reset();
                                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                    salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                                               // insert into the register
                                                                                                        salincregister.Init();
                                                                                                        salincregister."Employee No." := employees."No.";
                                                                                                        salincregister."Increament Month" := 'January';
                                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        salincregister."User ID" := UserId;
                                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                                        salincregister.Insert();
                                                                                                        // Update Basic
                                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                        //                         empSalaryCard.MODIFY;
                                                                                                    end; // 6
                                                                                                end // 7
                                                                                                else begin  // 8
                                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end;   //9
                                                                                                end;  // 8
                                                                                            end  // 10
                                                                                            else begin  //11
                                                                                                        // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                               // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //12
                                                                                            end;   //11

                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                        end  //13
                                                                                        else begin //17
                                                                                                   // Dint update hence log
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end; //16
                                                                                        end; //17

                                                                                        empSalaryCard.Reset();
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                                        // Change Basic Pay
                                                                                        // empSalaryCard."Basic Pay":=;
                                                                                        //18
                                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                    end //22
                                                                                    else begin  //41                                                                                  //nnn
                                                                                        salGrades2.Reset();
                                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                                        if salGrades2.Find('-') then begin //21
                                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                           // Change Basic pay and insert into the register
                                                                                                                           // Find the value of new salary from the steps.
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                                //14

                                                                                            salaStepsAmount.Reset();
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                            //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                     // select the new employee salary and
                                                                                                                                     // Update Basic Pay here
                                                                                                salaStepsAmount2.Reset();
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                    // At last! Insert into the Log and
                                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                        salincregister.Reset();
                                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                                   // insert into the register
                                                                                                            salincregister.Init();
                                                                                                            salincregister."Employee No." := employees."No.";
                                                                                                            salincregister."Increament Month" := 'January';
                                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            salincregister."User ID" := UserId;
                                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                                            salincregister.Insert();
                                                                                                            // Update Basic
                                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                            //                         empSalaryCard.MODIFY;
                                                                                                        end; // 6
                                                                                                    end // 7
                                                                                                    else begin  // 8
                                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                                        unaffectedEmployees.Reset();
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                                            unaffectedEmployees.Init();
                                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                            unaffectedEmployees.Insert();
                                                                                                        end;   //9
                                                                                                    end;  // 8
                                                                                                end  // 10
                                                                                                else begin  //11
                                                                                                            // Dint update hence log
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end; //12
                                                                                                end;   //11

                                                                                                // empSalaryCard."Basic Pay":=;
                                                                                            end  //13
                                                                                            else begin //17
                                                                                                       // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                                // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //16
                                                                                            end; //17

                                                                                            empSalaryCard.Reset();
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                                            // Change Basic Pay
                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                            //18
                                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                        end //21
                                                                                        else begin //20
                                                                                                   //error into logs - No more salary steps found
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin  //19

                                                                                                // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end;   //19
                                                                                        end;   //20
                                                                                    end; //41
                                                                                end; //42
                                                                                     ////////////////////////////////////////////////////////////////////////////////////////////
                                                                            end;//52
                                                                        end; //17

                                                                        empSalaryCard.Reset();
                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                        // Change Basic Pay
                                                                        // empSalaryCard."Basic Pay":=;
                                                                        //18
                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                    end //23
                                                                    else begin  //42
                                                                                // check in the next scale again
                                                                        salGrades2.Reset();
                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                        if salGrades2.Find('-') then begin //22
                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                           // Change Basic pay and insert into the register
                                                                                                           // Find the value of new salary from the steps.
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                //14

                                                                            salaStepsAmount.Reset();
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                     // select the new employee salary and
                                                                                                                     // Update Basic Pay here
                                                                                salaStepsAmount2.Reset();
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                    // At last! Insert into the Log and
                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                        salincregister.Reset();
                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                        salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                   // insert into the register
                                                                                            salincregister.Init();
                                                                                            salincregister."Employee No." := employees."No.";
                                                                                            salincregister."Increament Month" := 'January';
                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                            salincregister."User ID" := UserId;
                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                            salincregister.Insert();
                                                                                            // Update Basic
                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                            //                         empSalaryCard.MODIFY;
                                                                                        end; // 6
                                                                                    end // 7
                                                                                    else begin  // 8
                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end;   //9
                                                                                    end;  // 8
                                                                                end  // 10
                                                                                else begin  //11
                                                                                            // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //12
                                                                                end;   //11

                                                                                // empSalaryCard."Basic Pay":=;
                                                                            end  //13
                                                                            else begin //17
                                                                                       // Dint update hence log
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end; //16
                                                                            end; //17

                                                                            empSalaryCard.Reset();
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                            // Change Basic Pay
                                                                            // empSalaryCard."Basic Pay":=;
                                                                            //18
                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                        end //22
                                                                        else begin  //41                                                                                  //nnn
                                                                            salGrades2.Reset();
                                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                            if salGrades2.Find('-') then begin //21
                                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                               // Change Basic pay and insert into the register
                                                                                                               // Find the value of new salary from the steps.
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then  //14;

                                                                                    //14

                                                                                salaStepsAmount.Reset();
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                                         // select the new employee salary and
                                                                                                                         // Update Basic Pay here
                                                                                    salaStepsAmount2.Reset();
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                                        // At last! Insert into the Log and
                                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                            salincregister.Reset();
                                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                            salincregister.SetRange(salincregister."Increament Month", 'January');
                                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                                       // insert into the register
                                                                                                salincregister.Init();
                                                                                                salincregister."Employee No." := employees."No.";
                                                                                                salincregister."Increament Month" := 'January';
                                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                salincregister."User ID" := UserId;
                                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                                salincregister.Insert();
                                                                                                // Update Basic
                                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                //                         empSalaryCard.MODIFY;
                                                                                            end; // 6
                                                                                        end // 7
                                                                                        else begin  // 8
                                                                                                    //the salary in the steps is zero hence cannot insert
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end;   //9
                                                                                        end;  // 8
                                                                                    end  // 10
                                                                                    else begin  //11
                                                                                                // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                       // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'January';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //12
                                                                                    end;   //11

                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                end  //13
                                                                                else begin //17
                                                                                           // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'January';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //16
                                                                                end; //17

                                                                                empSalaryCard.Reset();
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then;  //18;

                                                                                // Change Basic Pay
                                                                                // empSalaryCard."Basic Pay":=;
                                                                                //18
                                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                            end //21
                                                                            else begin //20
                                                                                       //error into logs - No more salary steps found
                                                                                unaffectedEmployees.Reset();
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                if not unaffectedEmployees.Find('-') then begin  //19

                                                                                    // insert into the unaffectedEmployees table
                                                                                    unaffectedEmployees.Init();
                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                    unaffectedEmployees."Increament Month" := 'January';
                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                    unaffectedEmployees.Insert();
                                                                                end;   //19
                                                                            end;   //20
                                                                        end; //41
                                                                    end; //42
                                                                         ////////////////////////////////////////////////////////////////////////////////////////////
                                                                end;//52
                                                            end;//36   salary outside scale & grade

                                                        end//37  the employee is atleast 6 Months old hence eligeable for increase
                                                        else begin
                                                            unaffectedEmployees.Reset();
                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January');
                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                            // insert into the unaffectedEmployees table
                                                                unaffectedEmployees.Init();
                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                unaffectedEmployees."Increament Month" := 'January';
                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                unaffectedEmployees.Reason := 'The Employee is not six months old on employment...';
                                                                unaffectedEmployees.Insert();
                                                            end; //16
                                                        end; // Insert into unaffected coz the employee is not more than six months old......
                                                             //38
                                                end //4
                                                else
                                                    if Date2DMY(Today, 2) = 7 then   //3


                                                        // Increase salary fro guys who were employed between January and July
                                                        if EmplMonth in [7 .. 12] then   //38

                                                            // Check whether the employee is eligible for the increment
                                                            if ((Date2DMY(Today, 3)) > (Date2DMY(employees."Date Of Join", 3))) then begin  //37

                                                                salaStepsAmount.Reset();
                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", employees."Salary Grade");
                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                if salaStepsAmount.Find('-') then begin //35

                                                                    // Basic Payfound Hence Move to the next level in the steps table
                                                                    //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                                                                    salaStepsAmount2.Reset();
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", employees."Salary Grade");
                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                        // At last! Insert into the Log and
                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                            salincregister.Reset();
                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                       // insert into the register
                                                                                salincregister.Init();
                                                                                salincregister."Employee No." := employees."No.";
                                                                                salincregister."Increament Month" := 'July';
                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                salincregister."User ID" := UserId;
                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                salincregister.Insert();
                                                                                // Update Basic
                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                //                      empSalaryCard.MODIFY;
                                                                            end; // 6
                                                                        end // 7
                                                                        else begin  // 8
                                                                                    //the salary in the steps is zero hence cannot insert
                                                                            unaffectedEmployees.Reset();
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                            // insert into the unaffectedEmployees table
                                                                                unaffectedEmployees.Init();
                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                unaffectedEmployees.Insert();
                                                                            end;   //9
                                                                        end;  // 8
                                                                    end  // 10
                                                                    else begin  //11
                                                                        salGrades.Reset();
                                                                        salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                        salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                        if salGrades.Find('-') then begin //33
                                                                                                          //////////////////////////////////////////////////////////////////////////////////////////
                                                                            salGrades2.Reset();
                                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                            //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                            if salGrades2.Find('-') then begin//23
                                                                                                              //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                              // Change Basic pay and insert into the register
                                                                                                              // Find the value of new salary from the steps.
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then  //14;

                                                                                    //14
                                                                                Clear(salcat);
                                                                                Clear(salgrade);
                                                                                Clear(salbasic);
                                                                                salcat := employees."Salary Category";
                                                                                salgrade := salGrades2."Salary Grade code";
                                                                                salbasic := empSalaryCard."Basic Pay";

                                                                                salaStepsAmount.Reset();
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                                         // select the new employee salary and
                                                                                                                         // Update Basic Pay here
                                                                                    salaStepsAmount2.Reset();
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                                        // At last! Insert into the Log and
                                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                            salincregister.Reset();
                                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                                       // insert into the register
                                                                                                salincregister.Init();
                                                                                                salincregister."Employee No." := employees."No.";
                                                                                                salincregister."Increament Month" := 'July';
                                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                salincregister."User ID" := UserId;
                                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                                salincregister.Insert();
                                                                                                // Update Basic
                                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                //                      empSalaryCard.MODIFY;
                                                                                            end; // 6
                                                                                        end // 7
                                                                                        else begin  // 8
                                                                                                    //the salary in the steps is zero hence cannot insert
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end;   //9
                                                                                        end;  // 8
                                                                                    end  // 10
                                                                                    else begin  //11
                                                                                                // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                       // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //12
                                                                                    end;   //11

                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                end  //13
                                                                                else begin //17
                                                                                           // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //16
                                                                                end; //17

                                                                                empSalaryCard.Reset();
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then;  //18;

                                                                                // Change Basic Pay
                                                                                // empSalaryCard."Basic Pay":=;
                                                                                //18
                                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                            end //23
                                                                            else begin  //42
                                                                                        // check in the next scale again
                                                                                salGrades.Reset();
                                                                                salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                                salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                                if salGrades.Find('-') then begin //33
                                                                                                                  //////////////////////////////////////////////////////////////////////////////////////////
                                                                                    salGrades2.Reset();
                                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                    //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                                    if salGrades2.Find('-') then begin//23
                                                                                                                      //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                      // Change Basic pay and insert into the register
                                                                                                                      // Find the value of new salary from the steps.
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then  //14;

                                                                                            //14
                                                                                        Clear(salcat);
                                                                                        Clear(salgrade);
                                                                                        Clear(salbasic);
                                                                                        salcat := employees."Salary Category";
                                                                                        salgrade := salGrades2."Salary Grade code";
                                                                                        salbasic := empSalaryCard."Basic Pay";

                                                                                        salaStepsAmount.Reset();
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                 // select the new employee salary and
                                                                                                                                 // Update Basic Pay here
                                                                                            salaStepsAmount2.Reset();
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                // At last! Insert into the Log and
                                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                    salincregister.Reset();
                                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                    salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                                               // insert into the register
                                                                                                        salincregister.Init();
                                                                                                        salincregister."Employee No." := employees."No.";
                                                                                                        salincregister."Increament Month" := 'July';
                                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        salincregister."User ID" := UserId;
                                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                                        salincregister.Insert();
                                                                                                        // Update Basic
                                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                        //                      empSalaryCard.MODIFY;
                                                                                                    end; // 6
                                                                                                end // 7
                                                                                                else begin  // 8
                                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end;   //9
                                                                                                end;  // 8
                                                                                            end  // 10
                                                                                            else begin  //11
                                                                                                        // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                               // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //12
                                                                                            end;   //11

                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                        end  //13
                                                                                        else begin //17
                                                                                                   // Dint update hence log
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end; //16
                                                                                        end; //17

                                                                                        empSalaryCard.Reset();
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                                        // Change Basic Pay
                                                                                        // empSalaryCard."Basic Pay":=;
                                                                                        //18
                                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                                    end //23
                                                                                    else begin  //42
                                                                                                // check in the next scale again
                                                                                        salGrades2.Reset();
                                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                                        if salGrades2.Find('-') then begin //22
                                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                           // Change Basic pay and insert into the register
                                                                                                                           // Find the value of new salary from the steps.
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                                //14

                                                                                            salaStepsAmount.Reset();
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                     // select the new employee salary and
                                                                                                                                     // Update Basic Pay here
                                                                                                salaStepsAmount2.Reset();
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                    // At last! Insert into the Log and
                                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                        salincregister.Reset();
                                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                        salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                                   // insert into the register
                                                                                                            salincregister.Init();
                                                                                                            salincregister."Employee No." := employees."No.";
                                                                                                            salincregister."Increament Month" := 'July';
                                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            salincregister."User ID" := UserId;
                                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                                            salincregister.Insert();
                                                                                                            // Update Basic
                                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                            //                     empSalaryCard.MODIFY;
                                                                                                        end; // 6
                                                                                                    end // 7
                                                                                                    else begin  // 8
                                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                                        unaffectedEmployees.Reset();
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                                            unaffectedEmployees.Init();
                                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                            unaffectedEmployees.Insert();
                                                                                                        end;   //9
                                                                                                    end;  // 8
                                                                                                end  // 10
                                                                                                else begin  //11
                                                                                                            // Dint update hence log
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end; //12
                                                                                                end;   //11

                                                                                                // empSalaryCard."Basic Pay":=;
                                                                                            end  //13
                                                                                            else begin //17
                                                                                                       // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                                // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //16
                                                                                            end; //17

                                                                                            empSalaryCard.Reset();
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                                            // Change Basic Pay
                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                            //18
                                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                        end //22
                                                                                        else begin  //41                                                                                  //nnn
                                                                                            salGrades2.Reset();
                                                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                                            if salGrades2.Find('-') then begin //21
                                                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                               // Change Basic pay and insert into the register
                                                                                                                               // Find the value of new salary from the steps.
                                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                                if empSalaryCard.Find('-') then  //14;

                                                                                                    //14

                                                                                                salaStepsAmount.Reset();
                                                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                                // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                         // select the new employee salary and
                                                                                                                                         // Update Basic Pay here
                                                                                                    salaStepsAmount2.Reset();
                                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                        // At last! Insert into the Log and
                                                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                            salincregister.Reset();
                                                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                                                       // insert into the register
                                                                                                                salincregister.Init();
                                                                                                                salincregister."Employee No." := employees."No.";
                                                                                                                salincregister."Increament Month" := 'July';
                                                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                                salincregister."User ID" := UserId;
                                                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                                                salincregister.Insert();
                                                                                                                // Update Basic
                                                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                                //                         empSalaryCard.MODIFY;
                                                                                                            end; // 6
                                                                                                        end // 7
                                                                                                        else begin  // 8
                                                                                                                    //the salary in the steps is zero hence cannot insert
                                                                                                            unaffectedEmployees.Reset();
                                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                                unaffectedEmployees.Init();
                                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                                unaffectedEmployees.Insert();
                                                                                                            end;   //9
                                                                                                        end;  // 8
                                                                                                    end  // 10
                                                                                                    else begin  //11
                                                                                                                // Dint update hence log
                                                                                                        unaffectedEmployees.Reset();
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                                       // insert into the unaffectedEmployees table
                                                                                                            unaffectedEmployees.Init();
                                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                            unaffectedEmployees.Insert();
                                                                                                        end; //12
                                                                                                    end;   //11

                                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                                end  //13
                                                                                                else begin //17
                                                                                                           // Dint update hence log
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end; //16
                                                                                                end; //17

                                                                                                empSalaryCard.Reset();
                                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                                if empSalaryCard.Find('-') then;  //18;

                                                                                                // Change Basic Pay
                                                                                                // empSalaryCard."Basic Pay":=;
                                                                                                //18
                                                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                            end //21
                                                                                            else begin //20
                                                                                                       //error into logs - No more salary steps found
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin  //19

                                                                                                    // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end;   //19
                                                                                            end;
                                                                                        end;   //20
                                                                                    end; //41
                                                                                end; //42
                                                                                     ////////////////////////////////////////////////////////////////////////////////////////////
                                                                            end; //42
                                                                                 ////////////////////////////////////////////////////////////////////////////////////////////
                                                                        end // 33
                                                                        else   //34
                                                                            ;

                                                                        // Insert into Failed List
                                                                        //34
                                                                    end;   //11

                                                                    //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk

                                                                end //35
                                                                else begin  //36
                                                                            //77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
                                                                            // if employee gets salary outside of their grade...
                                                                    salGrades.Reset();
                                                                    salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                    salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                    if salGrades.Find('-') then begin  //52
                                                                                                       //////////////////////////////////////////////////////////////////////////////////////////
                                                                        salGrades2.Reset();
                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                        //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 1);
                                                                        if salGrades2.Find('-') then begin//23
                                                                                                          //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                          // Change Basic pay and insert into the register
                                                                                                          // Find the value of new salary from the steps.
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                //14

                                                                            salaStepsAmount.Reset();
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                     // select the new employee salary and
                                                                                                                     // Update Basic Pay here
                                                                                salaStepsAmount2.Reset();
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                    // At last! Insert into the Log and
                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                        salincregister.Reset();
                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                        salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                   // insert into the register
                                                                                            salincregister.Init();
                                                                                            salincregister."Employee No." := employees."No.";
                                                                                            salincregister."Increament Month" := 'July';
                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                            salincregister."User ID" := UserId;
                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                            salincregister.Insert();
                                                                                            // Update Basic
                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                            //                          empSalaryCard.MODIFY;
                                                                                        end; // 6
                                                                                    end // 7
                                                                                    else begin  // 8
                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end;   //9
                                                                                    end;  // 8
                                                                                end  // 10
                                                                                else begin  //11

                                                                                    ////
                                                                                    /////////////// increment But add 2
                                                                                    /////

                                                                                    // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //12
                                                                                end;   //11

                                                                                // empSalaryCard."Basic Pay":=;
                                                                            end  //13
                                                                            else begin //17
                                                                                       // Dint update hence log  tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt

                                                                                salGrades.Reset();
                                                                                salGrades.SetRange(salGrades."Employee Category", employees."Salary Category");
                                                                                salGrades.SetRange(salGrades."Salary Grade code", employees."Salary Grade");
                                                                                if salGrades.Find('-') then begin  //52
                                                                                                                   //////////////////////////////////////////////////////////////////////////////////////////
                                                                                    salGrades2.Reset();
                                                                                    salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                    //  salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                    salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                                    if salGrades2.Find('-') then begin//23
                                                                                                                      //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                      // Change Basic pay and insert into the register
                                                                                                                      // Find the value of new salary from the steps.
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then  //14;

                                                                                            //14

                                                                                        salaStepsAmount.Reset();
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Salary Grade", salGrades2."Salary Grade code");
                                                                                        salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                        if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                 // select the new employee salary and
                                                                                                                                 // Update Basic Pay here
                                                                                            salaStepsAmount2.Reset();
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                            salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                            if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                // At last! Insert into the Log and
                                                                                                if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                    salincregister.Reset();
                                                                                                    salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                    salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                                    salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not salincregister.Find('-') then begin // 6
                                                                                                                                               // insert into the register
                                                                                                        salincregister.Init();
                                                                                                        salincregister."Employee No." := employees."No.";
                                                                                                        salincregister."Increament Month" := 'July';
                                                                                                        salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        salincregister."User ID" := UserId;
                                                                                                        salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                        salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                        salincregister."Job Grade" := employees."Salary Grade";
                                                                                                        salincregister."Job Category" := employees."Salary Category";
                                                                                                        salincregister.Insert();
                                                                                                        // Update Basic
                                                                                                        empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                        //                          empSalaryCard.MODIFY;
                                                                                                    end; // 6
                                                                                                end // 7
                                                                                                else begin  // 8
                                                                                                            //the salary in the steps is zero hence cannot insert
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end;   //9
                                                                                                end;  // 8
                                                                                            end  // 10
                                                                                            else begin  //11

                                                                                                ////
                                                                                                /////////////// increment But add 2
                                                                                                /////

                                                                                                // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                               // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //12
                                                                                            end;   //11

                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                        end  //13
                                                                                        else begin //17
                                                                                                   // Dint update hence log
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end; //16
                                                                                        end; //17

                                                                                        empSalaryCard.Reset();
                                                                                        empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                        if empSalaryCard.Find('-') then;  //18;

                                                                                        // Change Basic Pay
                                                                                        // empSalaryCard."Basic Pay":=;
                                                                                        //18
                                                                                        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                                    end //23
                                                                                    else begin  //42
                                                                                                // check in the next scale again
                                                                                        salGrades2.Reset();
                                                                                        salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                        // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                        salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                                        if salGrades2.Find('-') then begin //22
                                                                                                                           //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                           // Change Basic pay and insert into the register
                                                                                                                           // Find the value of new salary from the steps.
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then  //14;

                                                                                                //14

                                                                                            salaStepsAmount.Reset();
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                            // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                            salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                            if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                     // select the new employee salary and
                                                                                                                                     // Update Basic Pay here
                                                                                                salaStepsAmount2.Reset();
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                                salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                                if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                    // At last! Insert into the Log and
                                                                                                    if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                        salincregister.Reset();
                                                                                                        salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                        salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                                        salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not salincregister.Find('-') then begin // 6
                                                                                                                                                   // insert into the register
                                                                                                            salincregister.Init();
                                                                                                            salincregister."Employee No." := employees."No.";
                                                                                                            salincregister."Increament Month" := 'July';
                                                                                                            salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            salincregister."User ID" := UserId;
                                                                                                            salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                            salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                            salincregister."Job Grade" := employees."Salary Grade";
                                                                                                            salincregister."Job Category" := employees."Salary Category";
                                                                                                            salincregister.Insert();
                                                                                                            // Update Basic
                                                                                                            empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                            //                         empSalaryCard.MODIFY;
                                                                                                        end; // 6
                                                                                                    end // 7
                                                                                                    else begin  // 8
                                                                                                                //the salary in the steps is zero hence cannot insert
                                                                                                        unaffectedEmployees.Reset();
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                                            unaffectedEmployees.Init();
                                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                            unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                            unaffectedEmployees.Insert();
                                                                                                        end;   //9
                                                                                                    end;  // 8
                                                                                                end  // 10
                                                                                                else begin  //11
                                                                                                            // Dint update hence log
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                                   // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end; //12
                                                                                                end;   //11

                                                                                                // empSalaryCard."Basic Pay":=;
                                                                                            end  //13
                                                                                            else begin //17
                                                                                                       // Dint update hence log
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                                // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end; //16
                                                                                            end; //17

                                                                                            empSalaryCard.Reset();
                                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                                            // Change Basic Pay
                                                                                            // empSalaryCard."Basic Pay":=;
                                                                                            //18
                                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                        end //22
                                                                                        else begin  //41                                                                                  //nnn
                                                                                            salGrades2.Reset();
                                                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                                            if salGrades2.Find('-') then begin //21
                                                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                               // Change Basic pay and insert into the register
                                                                                                                               // Find the value of new salary from the steps.
                                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                                if empSalaryCard.Find('-') then  //14;

                                                                                                    //14

                                                                                                salaStepsAmount.Reset();
                                                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                                //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                                                         // select the new employee salary and
                                                                                                                                         // Update Basic Pay here
                                                                                                    salaStepsAmount2.Reset();
                                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                                                        // At last! Insert into the Log and
                                                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                            salincregister.Reset();
                                                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                                                       // insert into the register
                                                                                                                salincregister.Init();
                                                                                                                salincregister."Employee No." := employees."No.";
                                                                                                                salincregister."Increament Month" := 'July';
                                                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                                salincregister."User ID" := UserId;
                                                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                                                salincregister.Insert();
                                                                                                                // Update Basic
                                                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                                //                         empSalaryCard.MODIFY;
                                                                                                            end; // 6
                                                                                                        end // 7
                                                                                                        else begin  // 8
                                                                                                                    //the salary in the steps is zero hence cannot insert
                                                                                                            unaffectedEmployees.Reset();
                                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                                unaffectedEmployees.Init();
                                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                                unaffectedEmployees.Insert();
                                                                                                            end;   //9
                                                                                                        end;  // 8
                                                                                                    end  // 10
                                                                                                    else begin  //11
                                                                                                                // Dint update hence log
                                                                                                        unaffectedEmployees.Reset();
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                                       // insert into the unaffectedEmployees table
                                                                                                            unaffectedEmployees.Init();
                                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                            unaffectedEmployees.Insert();
                                                                                                        end; //12
                                                                                                    end;   //11

                                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                                end  //13
                                                                                                else begin //17
                                                                                                           // Dint update hence log
                                                                                                    unaffectedEmployees.Reset();
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                                        unaffectedEmployees.Init();
                                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                        unaffectedEmployees.Insert();
                                                                                                    end; //16
                                                                                                end; //17

                                                                                                empSalaryCard.Reset();
                                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                                if empSalaryCard.Find('-') then;  //18;

                                                                                                // Change Basic Pay
                                                                                                // empSalaryCard."Basic Pay":=;
                                                                                                //18
                                                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                            end //21
                                                                                            else begin //20
                                                                                                       //error into logs - No more salary steps found
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin  //19

                                                                                                    // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end;   //19
                                                                                            end;   //20
                                                                                        end; //41
                                                                                    end; //42
                                                                                         ////////////////////////////////////////////////////////////////////////////////////////////
                                                                                end;//52
                                                                            end; //17

                                                                            empSalaryCard.Reset();
                                                                            empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                            if empSalaryCard.Find('-') then;  //18;

                                                                            // Change Basic Pay
                                                                            // empSalaryCard."Basic Pay":=;
                                                                            //18
                                                                            //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

                                                                        end //23
                                                                        else begin  //42
                                                                                    // check in the next scale again
                                                                            salGrades2.Reset();
                                                                            salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                            // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                            salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 2);
                                                                            if salGrades2.Find('-') then begin //22
                                                                                                               //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                               // Change Basic pay and insert into the register
                                                                                                               // Find the value of new salary from the steps.
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then  //14;

                                                                                    //14

                                                                                salaStepsAmount.Reset();
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                // salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                if salaStepsAmount.Find('-') then begin  //13
                                                                                                                         // select the new employee salary and
                                                                                                                         // Update Basic Pay here
                                                                                    salaStepsAmount2.Reset();
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                    salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                    if salaStepsAmount2.Find('-') then begin   // 10

                                                                                        // At last! Insert into the Log and
                                                                                        if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                            salincregister.Reset();
                                                                                            salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                            salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                            salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not salincregister.Find('-') then begin // 6
                                                                                                                                       // insert into the register
                                                                                                salincregister.Init();
                                                                                                salincregister."Employee No." := employees."No.";
                                                                                                salincregister."Increament Month" := 'July';
                                                                                                salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                salincregister."User ID" := UserId;
                                                                                                salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                salincregister."Job Grade" := employees."Salary Grade";
                                                                                                salincregister."Job Category" := employees."Salary Category";
                                                                                                salincregister.Insert();
                                                                                                // Update Basic
                                                                                                empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                //                         empSalaryCard.MODIFY;
                                                                                            end; // 6
                                                                                        end // 7
                                                                                        else begin  // 8
                                                                                                    //the salary in the steps is zero hence cannot insert
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                            // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end;   //9
                                                                                        end;  // 8
                                                                                    end  // 10
                                                                                    else begin  //11
                                                                                                // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                       // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //12
                                                                                    end;   //11

                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                end  //13
                                                                                else begin //17
                                                                                           // Dint update hence log
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                    // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end; //16
                                                                                end; //17

                                                                                empSalaryCard.Reset();
                                                                                empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                if empSalaryCard.Find('-') then;  //18;

                                                                                // Change Basic Pay
                                                                                // empSalaryCard."Basic Pay":=;
                                                                                //18
                                                                                //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                            end //22
                                                                            else begin  //41                                                                                  //nnn
                                                                                salGrades2.Reset();
                                                                                salGrades2.SetRange(salGrades2."Employee Category", employees."Salary Category");
                                                                                // salGrades2.setrange(salGrades2."Salary Grade code",employees."Salary Grade");
                                                                                salGrades2.SetRange(salGrades2."Grade Level", salGrades."Grade Level" + 3);
                                                                                if salGrades2.Find('-') then begin //21
                                                                                                                   //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                                                   // Change Basic pay and insert into the register
                                                                                                                   // Find the value of new salary from the steps.
                                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                    if empSalaryCard.Find('-') then  //14;

                                                                                        //14

                                                                                    salaStepsAmount.Reset();
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Employee Category", employees."Salary Category");
                                                                                    //  salaStepsAmount.SETRANGE(salaStepsAmount."Salary Grade",salGrades2."Salary Grade code");
                                                                                    salaStepsAmount.SetRange(salaStepsAmount."Basic Salary", empSalaryCard."Basic Pay");
                                                                                    if salaStepsAmount.Find('-') then begin  //13
                                                                                                                             // select the new employee salary and
                                                                                                                             // Update Basic Pay here
                                                                                        salaStepsAmount2.Reset();
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Employee Category", employees."Salary Category");
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2."Salary Grade", salGrades2."Salary Grade code");
                                                                                        salaStepsAmount2.SetRange(salaStepsAmount2.Step, (salaStepsAmount.Step + 1));
                                                                                        if salaStepsAmount2.Find('-') then begin   // 10

                                                                                            // At last! Insert into the Log and
                                                                                            if salaStepsAmount2."Basic Salary" > 0 then begin  // 7
                                                                                                salincregister.Reset();
                                                                                                salincregister.SetRange(salincregister."Employee No.", employees."No.");
                                                                                                salincregister.SetRange(salincregister."Increament Month", 'July');
                                                                                                salincregister.SetRange(salincregister."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not salincregister.Find('-') then begin // 6
                                                                                                                                           // insert into the register
                                                                                                    salincregister.Init();
                                                                                                    salincregister."Employee No." := employees."No.";
                                                                                                    salincregister."Increament Month" := 'July';
                                                                                                    salincregister."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    salincregister."User ID" := UserId;
                                                                                                    salincregister."Prev. Salary" := empSalaryCard."Basic Pay";
                                                                                                    salincregister."Current Salary" := salaStepsAmount2."Basic Salary";
                                                                                                    salincregister."Job Grade" := employees."Salary Grade";
                                                                                                    salincregister."Job Category" := employees."Salary Category";
                                                                                                    salincregister.Insert();
                                                                                                    // Update Basic
                                                                                                    empSalaryCard."Basic Pay" := salaStepsAmount2."Basic Salary";
                                                                                                    //                         empSalaryCard.MODIFY;
                                                                                                end; // 6
                                                                                            end // 7
                                                                                            else begin  // 8
                                                                                                        //the salary in the steps is zero hence cannot insert
                                                                                                unaffectedEmployees.Reset();
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                                if not unaffectedEmployees.Find('-') then begin //9
                                                                                                                                                // insert into the unaffectedEmployees table
                                                                                                    unaffectedEmployees.Init();
                                                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                                                    unaffectedEmployees."Increament Month" := 'July';
                                                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                    unaffectedEmployees.Reason := 'salary in the steps is zero hence cannot insert.....';
                                                                                                    unaffectedEmployees.Insert();
                                                                                                end;   //9
                                                                                            end;  // 8
                                                                                        end  // 10
                                                                                        else begin  //11
                                                                                                    // Dint update hence log
                                                                                            unaffectedEmployees.Reset();
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                            unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                            if not unaffectedEmployees.Find('-') then begin//12
                                                                                                                                           // insert into the unaffectedEmployees table
                                                                                                unaffectedEmployees.Init();
                                                                                                unaffectedEmployees."Employee No." := employees."No.";
                                                                                                unaffectedEmployees."Increament Month" := 'July';
                                                                                                unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                                unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                                unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                                unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                                unaffectedEmployees.Insert();
                                                                                            end; //12
                                                                                        end;   //11

                                                                                        // empSalaryCard."Basic Pay":=;
                                                                                    end  //13
                                                                                    else begin //17
                                                                                               // Dint update hence log
                                                                                        unaffectedEmployees.Reset();
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                        if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                                        // insert into the unaffectedEmployees table
                                                                                            unaffectedEmployees.Init();
                                                                                            unaffectedEmployees."Employee No." := employees."No.";
                                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                                            unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                            unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                            unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                            unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                            unaffectedEmployees.Insert();
                                                                                        end; //16
                                                                                    end; //17

                                                                                    empSalaryCard.Reset();
                                                                                    empSalaryCard.SetRange(empSalaryCard."Employee Code", employees."No.");
                                                                                    if empSalaryCard.Find('-') then;  //18;

                                                                                    // Change Basic Pay
                                                                                    // empSalaryCard."Basic Pay":=;
                                                                                    //18
                                                                                    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                                                                end //21
                                                                                else begin //20
                                                                                           //error into logs - No more salary steps found
                                                                                    unaffectedEmployees.Reset();
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                                    if not unaffectedEmployees.Find('-') then begin  //19

                                                                                        // insert into the unaffectedEmployees table
                                                                                        unaffectedEmployees.Init();
                                                                                        unaffectedEmployees."Employee No." := employees."No.";
                                                                                        unaffectedEmployees."Increament Month" := 'July';
                                                                                        unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                                        unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                                        unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                                        unaffectedEmployees.Reason := 'There are no more salary Steps...';
                                                                                        unaffectedEmployees.Insert();
                                                                                    end;   //19
                                                                                end;   //20
                                                                            end; //41
                                                                        end; //42
                                                                             ////////////////////////////////////////////////////////////////////////////////////////////
                                                                    end;//52
                                                                end;//36   salary outside scale & grade

                                                            end//37  the employee is atleast 6 Months old hence eligeable for increase
                                                            else begin
                                                                unaffectedEmployees.Reset();
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Employee No.", employees."No.");
                                                                if (Date2DMY(Today, 2)) = 1 then
                                                                    unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'January')
                                                                else
                                                                    if (Date2DMY(Today, 2)) = 7 then
                                                                        unaffectedEmployees.SetRange(unaffectedEmployees."Increament Month", 'July');
                                                                unaffectedEmployees.SetRange(unaffectedEmployees."Increament Year", (Date2DMY(Today, 3)));
                                                                if not unaffectedEmployees.Find('-') then begin //16
                                                                                                                // insert into the unaffectedEmployees table
                                                                    unaffectedEmployees.Init();
                                                                    unaffectedEmployees."Employee No." := employees."No.";
                                                                    if (Date2DMY(Today, 2)) = 1 then
                                                                        unaffectedEmployees."Increament Month" := 'January'
                                                                    else
                                                                        if (Date2DMY(Today, 2)) = 7 then
                                                                            unaffectedEmployees."Increament Month" := 'July';
                                                                    unaffectedEmployees."Increament Year" := (Date2DMY(Today, 3));
                                                                    unaffectedEmployees."Employee Category" := employees."Salary Category";
                                                                    unaffectedEmployees."Employee Grade" := employees."Salary Grade";
                                                                    unaffectedEmployees.Reason := 'The Employee is not six months old on employment...';
                                                                    unaffectedEmployees.Insert();
                                                                end; //16
                                                            end; // Insert into unaffected coz the employee is not more than six months old......
                                                                 //38
                                                                 //3
                                            end;  //2
                                            until employees.Next() = 0;
                                        //1
                                        // employees.setrange()
                                    end; //70
                                    until empgrade.Next() = 0;
                                //71
                            end;//72
                            until empcat.Next() = 0;
                        //73
                    end;
                }
                separator(History)
                {
                    Caption = 'History';
                }
                action("Increament Register")
                {
                    Caption = 'Increament Register';
                    Image = Registered;
                    Promoted = true;
                    RunObject = Page "Salary Increament Register";
                    ToolTip = 'Executes the Increament Register action.';
                }
                action("Un-Affected Employees")
                {
                    Caption = 'Un-Affected Employees';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "Un-affected Salary Increaments";
                    ToolTip = 'Executes the Un-Affected Employees action.';
                }
                separator(Separator14)
                {
                }
                action(PostIncreament)
                {
                    Caption = 'Post Salary Inrements';
                    Image = PostDocument;
                    Promoted = true;
                    ToolTip = 'Executes the Post Salary Inrements action.';

                    trigger OnAction()
                    begin

                        Message('Please go through the Increment register \and ensure that the increments are right before posting.');
                        if Confirm('Are you sure you want to post salary increments?', false) = false then
                            exit;
                        postReverse.postRegister();
                    end;
                }
                action(ReverseIncreament)
                {
                    Caption = 'Reverse Salary Increments';
                    Image = ReverseRegister;
                    Promoted = true;
                    ToolTip = 'Executes the Reverse Salary Increments action.';

                    trigger OnAction()
                    begin

                        if Confirm('Reverse salary Increment postings?', false) = false then
                            exit;
                        postReverse.ReverseInrementPosting();
                    end;
                }
            }
        }
    }

    var
        salaStepsAmount: Record "Auto. Inreament Salary Steps";
        salaStepsAmount2: Record "Auto. Inreament Salary Steps";
        empcat: Record "Employee Categories";
        employees: Record "HR-Employee";
        empgrade: Record "Job_Salary grade/steps";
        salGrades: Record "Job_Salary grade/steps";
        salGrades2: Record "Job_Salary grade/steps";
        empSalaryCard: Record "prSalary Card";
        salincregister: Record "Salary Increament Register";
        unaffectedEmployees: Record "Un-affected Salary Increaments";
        postReverse: codeunit "Post Salary Increments";
        salgrade: Code[20];
        salcat: Code[50];
        salbasic: Decimal;
        EmplMonth: Integer;

    procedure checkMonthValidity() validity: Boolean
    begin
        validity := false;
        if ((Date2DMY(Today, 2) <> 1) and (Date2DMY(Today, 2) <> 7)) then
            validity := false
        else
            validity := true;
    end;
}
