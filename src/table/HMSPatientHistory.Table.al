table 85213 "HMS Patient History"
{
    // LookupPageID = "Units/Subject List"; 

    fields
    {
        field(50000; "Treatment No."; Code[20])
        {

        }
        field(50001; "Patient No."; Code[30])
        { //
            trigger OnValidate()
            var
                Patient: Record "HMS Patient";
            begin
                if Patient.Get("Patient No.") then begin
                    Inpatient := Patient.Inpatient;
                    "Patient Name" := Patient."Search Name";
                end;
            end;
        }
        field(50002; "Patient Name"; Text[250])
        {

        }
        field(50003; "Intake Date"; Date)
        {

        }
        field(50004; "Inpatient"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Patient No.", "Intake Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Intake Date" = 0D then
            "Intake Date" := Today;
    end;
}
