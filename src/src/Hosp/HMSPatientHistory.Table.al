table 52202683 "HMS Patient History"
{
    // LookupPageID = "Units/Subject List"; 

    fields
    {
        field(1; "Treatment No."; Code[20])
        {

        }
        field(2; "Patient No."; Code[30])
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
        field(3; "Patient Name"; Text[250])
        {

        }
        field(4; "Intake Date"; Date)
        {

        }
        field(5; "Inpatient"; Boolean)
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
