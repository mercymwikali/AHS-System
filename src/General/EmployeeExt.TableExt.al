namespace HMISBC.HMISBC;

using Microsoft.HumanResources.Employee;

tableextension 52202454 "Employee Ext" extends Employee
{
    fields
    {
        field(52202423; "Portal Password"; Text[180])
        {
            DataClassification = ToBeClassified;
        }
        field(52202424; "Portal OTP Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(52202425; "Portal OTP Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52202426; "Portal OTP Device"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52202427; "Portal Reset Token"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(52202428; "Portal Reset Token Expired"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52202429; "OTP Code Used Today"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52202430; "Portal Session Token"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }
}
