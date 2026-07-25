namespace PTL.Hospital;
using HMISBC.HMISBC;
using Microsoft.Sales.Customer;

report 85196 ValidateAppointments
{
    ApplicationArea = All;
    Caption = 'ValidateAppointments';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = Confirmed;
            trigger OnAfterGetRecord()
            begin
                CalcFields(Balance, "Sales (LCY)");
                if (Balance = 0) and ("Sales (LCY)" = 0) then begin
                    Customer.Confirmed := true;
                    Customer.Modify();
                end;
            end;
            trigger OnPostDataItem()
            begin
                Message('done');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        HMSObservationFormHeader: Record "HMS Observation Form Header";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        HMSProcesses: Codeunit "HMS Processes";
}
