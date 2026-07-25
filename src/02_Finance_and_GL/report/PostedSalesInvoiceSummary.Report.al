report 85048 "Posted Sales Invoice Summary"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Funds/SalesInvoicesSummary.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Bill-to Customer No.", "Posting Date", "Shortcut Dimension 3 Code";
            column(No_; "No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Shortcut_Dimension_3_Code; "Shortcut Dimension 3 Code")
            {
            }
            column(Patient_No_; "Patient No.")
            {
            }
            column(Appointment_No; "Appointment No")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
            }
            column(Patient_Name; "Patient Name")
            {
            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {
            }
            column(MemberNo; MemberNo)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(CompInfName; CompInf.name)
            {
            }
            column(SchemeName; SchemeName)
            {
            }
            column(DateofDischarge; DateofDischarge) { }
            column(DateofAdmission; DateofAdmission) { }
            trigger OnAfterGetRecord()
            begin
                DateofDischarge := 0D;
                DateofAdmission := 0D;

                if PatRec.get("Patient No.") then begin
                    MemberNo := PatRec."Membership No";
                    SchemeName := PatRec."Scheme Name";
                end;
                HMSAppointmentFormHeader.Reset();
                HMSAppointmentFormHeader.SetRange("Appointment No.", "Sales Invoice Header"."Appointment No");
                if HMSAppointmentFormHeader.FindFirst() then begin
                    DateofAdmission := HMSAppointmentFormHeader."Appointment Date";
                    DateofDischarge := HMSAppointmentFormHeader."Appointment Date";
                end else begin
                    HMSAdmissionFormHeader.Reset();
                    HMSAdmissionFormHeader.SetRange("Admission No.", "Sales Invoice Header"."Appointment No");
                    HMSAdmissionFormHeader.SetRange(Status, HMSAdmissionFormHeader.Status::Completed);
                    if HMSAdmissionFormHeader.FindFirst() then begin
                        DateofAdmission := HMSAdmissionFormHeader."Date of Admission";
                        DateofDischarge := HMSAdmissionFormHeader."Discharge Date"
                    end;
                end;

            end;
        }
    }

    trigger OnPreReport()
    begin
        CompInf.get();
        CompInf.CalcFields(Picture);
    end;

    var
        CompInf: Record "Company Information";
        PatRec: Record "HMS Patient";
        MemberNo: Text[100];
        SchemeName: Text[100];
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        HMSAdmissionFormHeader: Record "HMS Admission Discharge Header";
        DateofAdmission: Date;
        DateofDischarge: Date;
}