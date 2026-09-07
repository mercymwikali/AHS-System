namespace HospitalSystem.HospitalSystem;

tableextension 85033 HMSAppointmentFormHeaderExt extends "HMS Appointment Form Header"
{
    fields
    {
        field(85000; "SHA OTP Code"; Code[20])
        {
            Caption = 'SHA OTP Code';
            DataClassification = ToBeClassified;
        }
        field(85001; "OTP Recorded Date"; DateTime)
        {
            Caption = 'OTP Recorded Date';
            DataClassification = ToBeClassified;
        }
        field(85002; "SHA Patient CR ID"; Text[100])
        {
            Caption = 'SHA Patient CR ID';
            DataClassification = ToBeClassified;
        }
        field(85003; "SHA Consent Request ID"; Text[100])
        {
            Caption = 'SHA Consent Request ID';
            DataClassification = ToBeClassified;
        }
        field(85004; "SHA Authorization ID"; Text[100])
        {
            Caption = 'SHA Authorization ID';
            DataClassification = ToBeClassified;
        }
        field(85005; "SHA Authorization Code"; Text[100])
        {
            Caption = 'SHA Authorization Code';
            DataClassification = ToBeClassified;
        }
        field(85006; "SHA Authorization GUID"; Text[100])
        {
            Caption = 'SHA Authorization GUID';
            DataClassification = ToBeClassified;
        }
        field(85007; "SHA Authorization Status"; Text[100])
        {
            Caption = 'SHA Authorization Status';
            DataClassification = ToBeClassified;
        }
        field(85008; "SHA Visit ID"; Text[100])
        {
            Caption = 'SHA Visit ID';
            DataClassification = ToBeClassified;
        }
        field(85009; "SHA Visit Number"; Text[100])
        {
            Caption = 'SHA Visit Number';
            DataClassification = ToBeClassified;
        }
        field(85010; "SHA Claim Status"; Text[50])
        {
            Caption = 'SHA Claim Status';
            DataClassification = ToBeClassified;
        }
        field(85011; "SHA Service Type"; Text[50])
        {
            Caption = 'SHA Service Type';
            DataClassification = ToBeClassified;
        }
        field(85012; "SHA Visit Start"; DateTime)
        {
            Caption = 'SHA Visit Start';
            DataClassification = ToBeClassified;
        }
        field(85013; "SHA Invoice ID"; Text[100])
        {
            Caption = 'SHA Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(85014; "SHA Invoice Number"; Text[100])
        {
            Caption = 'SHA Invoice Number';
            DataClassification = ToBeClassified;
        }
        field(85015; "SHA Scheme Code"; Text[50])
        {
            Caption = 'SHA Scheme Code';
            DataClassification = ToBeClassified;
        }
        field(85016; "SHA Scheme Name"; Text[250])
        {
            Caption = 'SHA Scheme Name';
            DataClassification = ToBeClassified;
        }
       
    }
}
