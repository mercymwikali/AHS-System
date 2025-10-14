namespace PTL.HMIS;
using System.Security.AccessControl;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.Dimension;
table 52202425 "HMS Patient Appointmnt Bookng"
{
    fields
    {
        field(1; "Appointment Booking No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Appointment Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                validate(Bed);
            end;
        }
        field(3; "Appointment Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Patient No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                hmspat.Reset();
                hmspat.SetRange("Patient No.", "Patient No");
                if hmspat.Find('-') then begin
                    Surname := hmspat.Surname;
                    "Middle Name" := hmspat."Middle Name";
                    "Last Name" := hmspat."Last Name";
                    "Search Name" := hmspat."Search Name";
                    Branch := hmspat."Global Dimension 1 Code";
                    "Booked Date" := Today;
                    "Booked Time" := Time;
                    "Visit No" := hmspat."Active Visit No";
                end;
                validate(Bed);
            end;
        }
        field(5; Surname; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Search Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Doctor ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Setup Doctor"."Doctor ID";

            trigger OnValidate()
            begin
                Doc.Reset();
                Doc.SetRange("Doctor ID", "Doctor ID");
                if Doc.Find('-') then
                    "Doctors Name" := Doc."Doctors Name";
            end;
        }
        field(10; "Doctors Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Appointment Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Setup Appointment Type".Code;
        }
        field(12; "Appointment Reason"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Apppointment Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "TCA Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "TCA Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Visit No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Treatment No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Booked By"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(19; "Booked Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Booked Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Booked,Attended,Failed To Attend,Cancelled';
            OptionMembers = ,Booked,Attended,"Failed To Attend",Cancelled;
        }
        field(22; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Notified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Telephone No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(25; "Therapy Session"; Option)
        {
            OptionCaption = ' ,Morning (6am-10am),Mid-Morning (10:30-2pm),Afternoon(2pm-6pm)';
            OptionMembers = " ",Morning,"Mid-Morning",Afternoon;
        }
        field(26; "Therapy Type"; code[20])
        {
            TableRelation = "Therapy Types"."Therapy Code";
            trigger OnValidate()
            var
                Fasset: Record "Fixed Asset";
            begin
                if Fasset.Get("Therapy Type") then
                    "Dialysis Machine Name" := Fasset.Description;
            end;
        }
        field(27; "Dialysis Machine Name"; Text[200])
        {
        }
        field(30; Ward; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code" where("Branch Code" = field(Branch));
        }
        field(31; Bed; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field(Ward),
                                                       Occupied = const(false));
            trigger OnValidate()
            var
                HMSPatientAppointmentBooking: Record "HMS Patient Appointmnt Bookng";
            begin
                // TestField(Section);
                // Uncomment if Patients can book Beds and wards (Voluntary intake);
                /* if Section = Section::Therapy then begin
                    HMSPatientAppointmentBooking.Reset();
                    HMSPatientAppointmentBooking.SetRange(HMSPatientAppointmentBooking."Appointment Date", "Appointment Date");
                    HMSPatientAppointmentBooking.SetRange(HMSPatientAppointmentBooking.Ward, Ward);
                    HMSPatientAppointmentBooking.SetRange(HMSPatientAppointmentBooking.Bed, Bed);
                    HMSPatientAppointmentBooking.SetRange(HMSPatientAppointmentBooking."Therapy Session", "Therapy Session");
                    if not HMSPatientAppointmentBooking.IsEmpty then
                        Error('There is already a prior booking on %1 for the %2 session, ward %3 bed %4. Kindly book another bed or time', Format("Appointment Date"), Format("Therapy Session"), Ward, Bed);
                end; */
            end;
        }
        field(28; "Branch"; Code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(29; Section; Option)
        {
            OptionMembers = ,Therapy,Consultation,Laboratory,Imaging,Pharmacy,"Procedure";
            OptionCaption = ',Therapy,Consultation,Laboratory,Imaging,Pharmacy,Procedure';
        }
        field(32; "Booked Sessions"; Integer)
        {
            CalcFormula = count("HMS Appointment Booking Lines" where("Booking No." = field("Appointment Booking No"), "Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(33; "Appointment Slot"; code[30])
        {
            // Store the Appointment Slot which contains Start and End time
            TableRelation = "Appointment Time Slots".Name;
        }
        field(34; Reminder; Integer)
        {

        }
        field(35; "Reminder Unit"; Option)
        {
            OptionMembers = D,W;
            OptionCaption = 'Day,Week';
        }
        field(36; "Notification Option"; Option)
        {
            OptionMembers = " ",SMS,Email;
            OptionCaption = ' ,SMS,Email';
        }
        field(37; "Source No"; Code[30])
        {

        }
    }

    keys
    {
        key(Key1; "Appointment Booking No", "Appointment Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        HmsSetup.Get();
        HmsSetup.TestField("Appointment Booking Nos");
        if "Appointment Booking No" = '' then
            "Appointment Booking No" := NoSeriesMgt.GetNextNo(HmsSetup."Appointment Booking Nos", 0D, true);
    end;

    var
        hmspat: Record "HMS Patient";
        HmsSetup: Record "HMS Setup";
        Doc: Record "HMS Setup Doctor";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
