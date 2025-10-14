namespace HMISBC.HMISBC;

using Microsoft.Finance.Dimension;

query 52202566 "Dimension Value"
{
    Caption = 'Dimension Value';
    QueryType = Normal;

    elements
    {
        dataitem(DimensionValue; "Dimension Value")
        {
            DataItemTableFilter = Blocked = const(false), "Dimension Value Type" = const(Standard);
            column(DimensionCode; "Dimension Code")
            {
            }
            column("Code"; "Code")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(Capital; Capital)
            {
            }

            column(ConsolidationCode; "Consolidation Code")
            {
            }
            column(DIRECTOR; DIRECTOR)
            {
            }
            column(DimensionId; "Dimension Id")
            {
            }
            column(DimensionValueID; "Dimension Value ID")
            {
            }
            column(DimensionValueType; "Dimension Value Type")
            {
            }
            column(Division; Division)
            {
            }
            column(EmailAddress; "Email Address")
            {
            }
            column(GlobalDimensionNo; "Global Dimension No.")
            {
            }
            column(HOD; HOD)
            {
            }
            column(Indentation; Indentation)
            {
            }
            column(InvoiceNoSeries; "Invoice No. Series")
            {
            }
            column(LastModifiedDateTime; "Last Modified Date Time")
            {
            }
            column(MaptoICDimensionCode; "Map-to IC Dimension Code")
            {
            }
            column(MaptoICDimensionValueCode; "Map-to IC Dimension Value Code")
            {
            }
            column(Name; Name)
            {
            }
            column(OldCode; "Old Code")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(Picture; Picture)
            {
            }
            column(ReceiptNoSeries; "Receipt No. Series")
            {
            }
            column(Recurrent; Recurrent)
            {
            }
            column(SchoolAccountant; "School Accountant")
            {
            }
            column(SchoolAdministrator; "School Administrator")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TotalExpenditure; "Total Expenditure")
            {
            }
            column(TotalIncomeCampus; "Total Income Campus")
            {
            }
            column(TotalIncomeDept; "Total Income Dept")
            {
            }
            column(Totaling; Totaling)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
