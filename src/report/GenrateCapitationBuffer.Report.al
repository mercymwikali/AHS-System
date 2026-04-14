report 85174 "Genrate  Capitation Buffer"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("HMS Appointment Form Header"; "HMS Appointment Form Header")
        {
            DataItemTableView = SORTING("Appointment No.")
                                WHERE("Insurance No" = CONST('C-00078'));
            dataitem("HMS Pharmacy Header"; "HMS Pharmacy Header")
            {
                CalcFields = "Insurance Code", "Insurance No", "Insurance Amount";
                DataItemLink = "Link No." = FIELD("Appointment No.");
                DataItemTableView = SORTING("Pharmacy No.")
                                    WHERE(Status = CONST(Completed));

                trigger OnAfterGetRecord()
                begin
                    IF NOT Buffer.GET("HMS Pharmacy Header"."Pharmacy No.") THEN BEGIN
                        Buffer.INIT();
                        Buffer."Entry No" := Buffer."Entry No" + 1;
                        Buffer."Document No" := "HMS Pharmacy Header"."Pharmacy No.";
                        Buffer."Pantient No" := "HMS Pharmacy Header"."Patient No.";
                        Buffer.PatientName := "HMS Pharmacy Header"."Search Name";
                        Buffer."Dimension Code" := Buffer."Dimension Code"::Pharmacy;
                        "HMS Pharmacy Header".CALCFIELDS("Capitation Amount");
                        Buffer.Cost := "HMS Pharmacy Header"."Capitation Amount";
                        Buffer."Visit No" := "HMS Pharmacy Header"."Link No.";
                        Buffer.Date := "HMS Pharmacy Header"."Pharmacy Date";
                        IF Buffer.Cost <> 0 THEN
                            Buffer.INSERT();
                    END;
                end;
            }
        }
        dataitem("HMS Laboratory Form Header"; "HMS Laboratory Form Header")
        {
            CalcFields = "Insurance No", "Insurance Name", "Open Charges";
            DataItemTableView = SORTING("Laboratory No.")
                                WHERE("Insurance No" = CONST('C-00078'));

            trigger OnAfterGetRecord()
            begin
                IF NOT Buffer.GET("HMS Laboratory Form Header"."Laboratory No.") THEN BEGIN
                    Buffer.INIT();
                    Buffer."Entry No" := Buffer."Entry No" + 1;
                    Buffer."Document No" := "HMS Laboratory Form Header"."Laboratory No.";
                    Buffer."Pantient No" := "HMS Laboratory Form Header"."Patient No.";
                    Buffer.PatientName := "HMS Laboratory Form Header".Surname + ' ' + "HMS Laboratory Form Header"."Middle Name" + ' ' + "HMS Laboratory Form Header"."Last Name";
                    Buffer."Dimension Code" := Buffer."Dimension Code"::Laboratory;
                    "HMS Laboratory Form Header".CALCFIELDS("Open Charges");
                    Buffer.Cost := "HMS Laboratory Form Header"."Open Charges";
                    Buffer."Visit No" := "HMS Laboratory Form Header"."Link No.";
                    Buffer.Date := "HMS Laboratory Form Header"."Laboratory Date";
                    IF Buffer.Cost <> 0 THEN
                        Buffer.INSERT(TRUE);
                END;
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        //Buffer.DELETEALL;
    end;

    var
        Buffer: Record "Capitution Buffer Report";
}
