Report 52202458 "HMS Visit Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Patients/HMSVisitSummary.rdl';

    dataset
    {
        dataitem("HMS Appointment Form Header"; "HMS Appointment Form Header")
        {
            RequestFilterFields = "Appointment No.", "Appointment Date", "Appointment Type", Status;
            column(ReportForNavId_1; 1)
            {
            }
            column(AppointmentNo_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Appointment No.")
            {
            }
            column(AppointmentDate_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Appointment Date")
            {
            }
            column(AppointmentTime_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Appointment Time")
            {
            }
            column(AppointmentType_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Appointment Type")
            {
            }
            column(PatientType_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Patient Type")
            {
            }
            column(PatientNo_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Patient No.")
            {
            }
            column(StudentNo_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Student No.")
            {
            }
            column(EmployeeNo_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Employee No.")
            {
            }
            column(RelativeNo_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Relative No.")
            {
            }
            column(Doctor_HMSAppointmentFormHeader; "HMS Appointment Form Header".Doctor)
            {
            }
            column(Remarks_HMSAppointmentFormHeader; "HMS Appointment Form Header".Remarks)
            {
            }
            column(AgeinYears_HMSAppointmentFormHeader; "HMS Appointment Form Header"."Age in Years")
            {
            }
            column(Status_HMSAppointmentFormHeader; "HMS Appointment Form Header".Status)
            {
            }
            column(Logo; CompINf.Picture)
            {
            }
            column(CompName; CompINf.Name)
            {
            }
            column(Names; HMSPat.Surname + ' ' + HMSPat."Last Name")
            {
            }
            column(RefNo; RefNo)
            {
            }
            column(InsuranceNo; "HMS Appointment Form Header"."Insurance No")
            {
            }
            column(TelephoneNumber; HMSPats."Telephone No. 1")
            {
            }
            column(VisitTotal;VisitTotal)
            {                
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Insurance No");
                column(ReportForNavId_15; 15)
                {
                }
                column(CustomerName; Customer.Name)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                VisitTotal := 0;
                //"HMS Appointment Form Header".CALCFIELDS("Patient Type Lk" );
                if HMSPat.Get("HMS Appointment Form Header"."Patient No.") then begin
                    "HMS Appointment Form Header"."Patient Type" := HMSPat."Patient Type";
                    //"HMS Appointment Form Header".MODIFY;
                    if "HMS Appointment Form Header"."Student No." <> '' then
                        RefNo := "HMS Appointment Form Header"."Student No.";
                    if "HMS Appointment Form Header"."Employee No." <> '' then
                        RefNo := "HMS Appointment Form Header"."Employee No.";
                    if HMSPat."Adm No." <> '' then
                        RefNo := HMSPat."Adm No.";
                end;
                if "HMS Appointment Form Header"."Invoince No" <> '' then begin
                    patientCharges.Reset();
                    patientCharges.SetRange("Visit No", "HMS Appointment Form Header"."Appointment No.");
                    if patientCharges.Find('-') then begin
                        patientCharges.CalcSums("Total Amount");
                        VisitTotal := patientCharges."Total Amount";
                    end;
                end;

                HMSPats.Get("HMS Appointment Form Header"."Patient No.");
            end;

            trigger OnPreDataItem()
            begin
                CompINf.Get();
                CompINf.CalcFields(Picture);
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

    var
        CompINf: Record "Company Information";
        HMSPat: Record "HMS Patient";
        HMSPats: Record "HMS Patient";
        RefNo: Code[20];
        patientCharges: Record "HMS Patient Charges";
        VisitTotal: Decimal;
}
