Codeunit 85003 "Custom Approvals Codeunit"
{
    trigger OnRun()
    begin
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: label 'This record is not supported by related approval workflow.';
        OnCancelBudgetApprovalRequestTxt: label 'An Approval of a Budget is canceled';
        OnCancelChargeWeiverApprovalRequestTxt: label 'An Approval Request for ChargeWeiver has been Cancelled';
        OnCancelHrEmployeeReqApprovalRequestTxt: label 'An Approval request for Employee Requsition is Cancelled';
        OnCancelHrJobsApprovalRequestTxt: label 'An Approval Request for a Job Position has been cancelled.';
        OnCancelHrLeaveApprovalRequestTxt: label 'An Approval Request for Leave Application has been Cancelled';
        OnCancelImprestApprovalRequestTxt: label 'An Approval of a Imprest is canceled';
        OnCancelImprestSurrenderApprovalRequestTxt: label 'An Approval of a Imprest Surrender is canceled';
        OnCancelInterbankApprovalRequestTxt: label 'An Approval of a Interbank is canceled';
        OnCancelInvestimentApprovalRequestTxt: label 'An Approval Request for Investiment Application has been Cancelled';
        OnCancelPaymentApprovalRequestTxt: label 'An Approval of a Payment is canceled';
        OnCancelStaffAdvanceApprovalRequestTxt: label 'An Approval of a Staff Advance is canceled';
        OnCancelStaffAdvanceSurrenderApprovalRequestTxt: label 'An Approval of a Staff Advance Surrender is canceled';
        OnCancelStaffClaimApprovalRequestTxt: label 'An Approval of a Staff Claim is canceled';
        OnCancelStoreRequisitionApprovalRequestTxt: label 'An Approval of a Store Requisition is canceled';
        OnCancelTransferOrderApprovalRequestTxt: label 'An Approval Request for Transfer Order has been Cancelled';
        OnCancelTransportApprovalRequestTxt: label 'An Approval Request for Transport has been Cancelled';
        OnCancelVoteApprovalRequestTxt: label 'An Approval of a Vote is canceled';
        OnSendBudgetApprovalRequestTxt: label 'Approval of a Budget is requested';

        OnSendChargeWeiverApprovalRequestTxt: label 'An Approval Request for Charge Weiver has been Requested.';
        OnSendHrEmployeeReqApprovalRequestTxt: label 'An Approval request for Employee Requsition is Requested.';
        // "**Dynsoft Hr**": ;
        OnSendHrJobsApprovalRequestTxt: label 'An Approval Request for a Job Position has been requested.';
        OnSendHrLeaveApprovalRequestTxt: label 'An Approval Request for Leave application has been Requested.';
        OnSendImprestApprovalRequestTxt: label 'Approval of a Imprest is requested';
        OnSendImprestSurrenderApprovalRequestTxt: label 'Approval of a Imprest Surrender is requested';
        OnSendInterbankApprovalRequestTxt: label 'Approval of a Interbank is requested';
        // "***Investment*****": ;
        OnSendInvestimentApprovalRequestTxt: label 'An Approval Request for Investiment application has been Requested.';
        OnSendPaymentApprovalRequestTxt: label 'Approval of a Payment is requested';
        OnSendStaffAdvanceApprovalRequestTxt: label 'Approval of a Staff Advance is requested';
        OnSendStaffAdvanceSurrenderApprovalRequestTxt: label 'Approval of a Staff Advance Surrender is requested';
        OnSendStaffClaimApprovalRequestTxt: label 'Approval of a Staff Claim is requested';
        OnSendStoreRequisitionApprovalRequestTxt: label 'Approval of a Store Requisition is requested';

        OnSendTransferOrderApprovalRequestTxt: label 'An Approval Request for Transfer Order has been Requested.';
        //"*****End Academics*******": ;
        //Fleet
        OnSendTransportApprovalRequestTxt: label 'An Approval Request for Transport has been Requested.';
        OnSendVoteApprovalRequestTxt: label 'Approval of a Vote Transfer is requested';
        RunWorkflowOnCancelBudgetForApprovalCode: label 'RUNWORKFLOWONCANCELBUDGETFORAPPROVAL';
        RunWorkflowOnCancelChargeWeiverApprovalCode: label 'RUNWORKFLOWONCANCELCHARGEWEIVERFORAPPROVAL';
        RunWorkflowOnCancelHrEmployeeReqForApprovalCode: label 'RUNWORKFLOWONCANCELHREMPLOYEEREQFORAPPROVAL';
        RunWorkflowOnCancelHrJobsForApprovalCode: label 'RUNWORKFLOWONCANCELHRJOBSFORAPPROVAL';
        RunWorkflowOnCancelHrLeaveForApprovalCode: label 'RUNWORKFLOWONCANCELHRLEAVEFORAPPROVAL';
        RunWorkflowOnCancelImprestForApprovalCode: label 'RUNWORKFLOWONCANCELIMPRESTFORAPPROVAL';
        RunWorkflowOnCancelImprestSurrenderForApprovalCode: label 'RUNWORKFLOWONCANCELIMPRESTSURRENDERFORAPPROVAL';
        RunWorkflowOnCancelInterbankForApprovalCode: label 'RUNWORKFLOWONCANCELINTERBANKFORAPPROVAL';
        RunWorkflowOnCancelInvestimentForApprovalCode: label 'RUNWORKFLOWONCANCELINVESTIMENTFORAPPROVAL';
        RunWorkflowOnCancelPaymentForApprovalCode: label 'RUNWORKFLOWONCANCELPAYMENTFORAPPROVAL';
        RunWorkflowOnCancelStaffAdvanceForApprovalCode: label 'RUNWORKFLOWONCANCELSTAFFADVANCEFORAPPROVAL';
        RunWorkflowOnCancelStaffAdvanceSurrenderForApprovalCode: label 'RUNWORKFLOWONCANCELSTAFFADVANCESURRENDERFORAPPROVAL';
        RunWorkflowOnCancelStaffClaimForApprovalCode: label 'RUNWORKFLOWONCANCELSTAFFCLAIMFORAPPROVAL';
        RunWorkflowOnCancelStoreRequisitionForApprovalCode: label 'RUNWORKFLOWONCANCELSTOREREQUISITIONFORAPPROVAL';
        RunWorkflowOnCancelTransferOrderApprovalCode: label 'RUNWORKFLOWONCANCELTRANSFERORDERFORAPPROVAL';
        RunWorkflowOnCancelTransportApprovalCode: label 'RUNWORKFLOWONCANCELTRANSPORTFORAPPROVAL';
        RunWorkflowOnCancelVoteForApprovalCode: label 'RUNWORKFLOWONCANCELVOTEFORAPPROVAL';
        RunWorkflowOnSendBudgetForApprovalCode: label 'RUNWORKFLOWONSENDBUDGETFORAPPROVAL';
        RunWorkflowOnSendChargeWeiverForApprovalCode: label 'RUNWORKFLOWONSENDCHARGEWEIVERFORAPPROVAL';
        RunWorkflowOnSendHrEmployeeReqForApprovalCode: label 'RUNWORKFLOWONSENDHREMPLOYEEREQFORAPPROVAL';
        RunWorkflowOnSendHrJobsForApprovalCode: label 'RUNWORKFLOWONSENDHRJOBSFORAPPROVAL';
        RunWorkflowOnSendHrLeaveForApprovalCode: label 'RUNWORKFLOWONSENDHRLEAVEFORAPPROVAL';
        RunWorkflowOnSendImprestForApprovalCode: label 'RUNWORKFLOWONSENDIMPRESTFORAPPROVAL';
        RunWorkflowOnSendImprestSurrenderForApprovalCode: label 'RUNWORKFLOWONSENDIMPRESTSURRENDERFORAPPROVAL';
        RunWorkflowOnSendInterbankForApprovalCode: label 'RUNWORKFLOWONSENDINTERBANKFORAPPROVAL';
        RunWorkflowOnSendInvestimentForApprovalCode: label 'RUNWORKFLOWONSENDINVESTIMENTFORAPPROVAL';
        RunWorkflowOnSendPaymentForApprovalCode: label 'RUNWORKFLOWONSENDPAYMENTFORAPPROVAL';
        RunWorkflowOnSendStaffAdvanceForApprovalCode: label 'RUNWORKFLOWONSENDSTAFFADVANCEFORAPPROVAL';
        RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode: label 'RUNWORKFLOWONSENDSTAFFADVANCESURRENDERFORAPPROVAL';
        RunWorkflowOnSendStaffClaimForApprovalCode: label 'RUNWORKFLOWONSENDSTAFFCLAIMFORAPPROVAL';
        RunWorkflowOnSendStoreRequisitionForApprovalCode: label 'RUNWORKFLOWONSENDSTOREREQUISITIONFORAPPROVAL';
        RunWorkflowOnSendTransferOrderForApprovalCode: label 'RUNWORKFLOWONSENDTRANSFERORDERFORAPPROVAL';
        RunWorkflowOnSendTransportForApprovalCode: label 'RUNWORKFLOWONSENDTRANSPORTFORAPPROVAL';
        RunWorkflowOnSendVoteForApprovalCode: label 'RUNWORKFLOWONSENDVOTEFORAPPROVAL';
        UnsupportedRecordTypeErr: label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';

    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Payments Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPaymentForApprovalCode));
            Database::"InterBank Transfers":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendInterbankForApprovalCode));
            //Database::"Staff Claims Header":
            //      exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffClaimForApprovalCode));
            Database::"Staff Advance Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffAdvanceForApprovalCode));
            Database::"Staff Advance Surrender Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode));
            Database::"Imprest Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendImprestForApprovalCode));
            Database::"Imprest Surrender Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendImprestSurrenderForApprovalCode));
            Database::"Staff Claims Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffClaimForApprovalCode));
            //new store
            Database::"Store Requistion Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStoreRequisitionForApprovalCode));

            Database::"G/L Budget Name":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBudgetForApprovalCode));
            // DATABASE::Workplan:
            //   EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendWorkplanForApprovalCode));
            Database::"Vote Transfer":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendVoteForApprovalCode));
            //Investiment
            Database::"Bank Account":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendInvestimentForApprovalCode));
            //HR
            //Leave

            Database::"HR Leave Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendHrLeaveForApprovalCode));

            Database::"HR Jobs":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendHrJobsForApprovalCode));

            // DATABASE::"HR Training App Header":
            //  EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendHrTrainingForApprovalCode));

            Database::"HR Employee Requisitions":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendHrEmployeeReqForApprovalCode));

            //  DATABASE::"HR Employee Transfer Header":
            //  EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendHrEmpTransForApprovalCode));

            //  DATABASE::"HR Promo. Recommend Header":
            //  EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendHrPromotionForApprovalCode));

            // DATABASE::"HR Transport Requisition":
            // EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendHrTransportForApprovalCode));

            // DATABASE::"HR Transport Requisition":
            // EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendHrTransportForApprovalCode));

            // DATABASE::"HR Asset Transfer Header":
            // EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendAssetTransferForApprovalCode));

            // DATABASE::"HR Employee Confirmation":
            //  EXIT(CheckApprovalsWorkflowEnabledCode(Variant,RunWorkflowOnSendHrConfirmationForApprovalCode));

            //HR

            //Academics

            // Database::"Part Time Requisition":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendParttimeForApprovalCode));
            Database::"FLT-Transport Requisition":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTransportForApprovalCode));

            //Academics End
            // Grants

            // Database::"Jobs":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendProposalForApprovalCode));
            // Database::"Conference Attendance":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendConferenceForApprovalCode));

            Database::"HMS Patient Charges Weiver":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendChargeWeiverForApprovalCode));
            Database::"Transfer Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTransferOrderForApprovalCode));
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    begin
        begin
            if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
                Error(NoWorkflowEnabledErr);
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkflowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPaymentForApprovalCode, Database::"Payments Header", OnSendPaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPaymentForApprovalCode, Database::"Payments Header", OnCancelPaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendInterbankForApprovalCode, Database::"InterBank Transfers", OnSendInterbankApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelInterbankForApprovalCode, Database::"InterBank Transfers", OnCancelInterbankApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffClaimForApprovalCode, Database::"Staff Claims Header", OnSendStaffClaimApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffClaimForApprovalCode, Database::"Staff Claims Header", OnCancelStaffClaimApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffAdvanceForApprovalCode, Database::"Staff Advance Header", OnSendStaffAdvanceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffAdvanceForApprovalCode, Database::"Staff Advance Header", OnCancelStaffAdvanceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode, Database::"Staff Advance Surrender Header", OnSendStaffAdvanceSurrenderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffAdvanceSurrenderForApprovalCode, Database::"Staff Advance Surrender Header", OnCancelStaffAdvanceSurrenderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendImprestForApprovalCode, Database::"Imprest Header", OnSendImprestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelImprestForApprovalCode, Database::"Imprest Header", OnCancelImprestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendImprestSurrenderForApprovalCode, Database::"Imprest Surrender Header", OnSendImprestSurrenderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelImprestSurrenderForApprovalCode, Database::"Imprest Surrender Header", OnCancelImprestSurrenderApprovalRequestTxt, 0, false);
        //new store
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStoreRequisitionForApprovalCode, Database::"Store Requistion Header", OnSendStoreRequisitionApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStoreRequisitionForApprovalCode, Database::"Store Requistion Header", OnCancelStoreRequisitionApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffClaimForApprovalCode, Database::"Staff Claims Header", OnSendStaffClaimApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffClaimForApprovalCode, Database::"Staff Claims Header", OnCancelStaffClaimApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBudgetForApprovalCode, Database::"G/L Budget Name", OnSendBudgetApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBudgetForApprovalCode, Database::"G/L Budget Name", OnCancelBudgetApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        //RunWorkflowOnSendWorkplanForApprovalCode,DATABASE::Workplan,OnSendWorkplanApprovalRequestTxt,0,FALSE);
        //WorkFlowEventHandling.AddEventToLibrary(
        //RunWorkflowOnCancelWorkplanForApprovalCode,DATABASE::Workplan,OnCancelWorkplanApprovalRequestTxt,0,FALSE);
        //WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendVoteForApprovalCode, Database::"Vote Transfer", OnSendVoteApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelVoteForApprovalCode, Database::"Vote Transfer", OnCancelVoteApprovalRequestTxt, 0, false);
        //Investiment
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendInvestimentForApprovalCode, Database::"Bank Account", OnSendInvestimentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelInvestimentForApprovalCode, Database::"Bank Account", OnCancelInvestimentApprovalRequestTxt, 0, false);

        //HR

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrLeaveForApprovalCode, Database::"HR Leave Application", OnSendHrLeaveApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrLeaveForApprovalCode, Database::"HR Leave Application", OnCancelHrLeaveApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrJobsForApprovalCode, Database::"HR Jobs", OnSendHrJobsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrJobsForApprovalCode, Database::"HR Jobs", OnCancelHrJobsApprovalRequestTxt, 0, false);
        /*
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrTrainingForApprovalCode,DATABASE::"HR Training App Header",OnSendHrTrainingApprovalRequestTxt,0,FALSE);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrTrainingForApprovalCode,DATABASE::"HR Training App Header",OnCancelHrTrainingApprovalRequestTxt,0,FALSE);
        */

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrEmployeeReqForApprovalCode, Database::"HR Employee Requisitions", OnSendHrEmployeeReqApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrEmployeeReqForApprovalCode, Database::"HR Employee Requisitions", OnCancelHrEmployeeReqApprovalRequestTxt, 0, false);
        /*
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrEmpTransForApprovalCode,DATABASE::"HR Employee Transfer Header",OnSendHrEmpTransApprovalRequestTxt,0,FALSE);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrEmpTransForApprovalCode,DATABASE::"HR Employee Transfer Header",OnCancelHrEmpTransApprovalRequestTxt,0,FALSE);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrPromotionForApprovalCode,DATABASE::"HR Promo. Recommend Header",OnSendHrPromotionApprovalRequestTxt,0,FALSE);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrPromotionForApprovalCode,DATABASE::"HR Promo. Recommend Header",OnCancelHrPromotionApprovalRequestTxt,0,FALSE);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrTransportForApprovalCode,DATABASE::"HR Transport Requisition",OnSendHrTransportApprovalRequestTxt,0,FALSE);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrTransportForApprovalCode,DATABASE::"HR Transport Requisition",OnCancelHrTransportApprovalRequestTxt,0,FALSE);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAssetTransferForApprovalCode,DATABASE::"HR Asset Transfer Header",OnSendAssetTransferApprovalRequestTxt,0,FALSE);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAssetTransferForApprovalCode,DATABASE::"HR Asset Transfer Header",OnCancelAssetTransferApprovalRequestTxt,0,FALSE);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrConfirmationForApprovalCode,DATABASE::"HR Employee Confirmation",OnSendHrConfirmationApprovalRequestTxt,0,FALSE);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrConfirmationForApprovalCode,DATABASE::"HR Employee Confirmation",OnCancelHrConfirmationApprovalRequestTxt,0,FALSE);
        */
        //HR

        //------Academics
        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnSendApplicationFormForApprovalCode, Database::"Application Form Header", OnSendApplicationFormApprovalRequestTxt, 0, false);
        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnCancelApplicationFormForApprovalCode, Database::"Application Form Header", OnCancelApplicationFormApprovalRequestTxt, 0, false);

        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnSendGraduationForApprovalCode, Database::"Graduation Request", OnSendGraduationApprovalRequestTxt, 0, false);
        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnCancelGraduationApprovalCode, Database::"Graduation Request", OnCanceGraduationApprovalRequestTxt, 0, false);

        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnSendStdReqForApprovalCode, Database::"Student Requisitions", OnSendStdReqApprovalRequestTxt, 0, false);
        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnCancelStdReqApprovalCode, Database::"Student Requisitions", OnCanceStdReqApprovalRequestTxt, 0, false);

        // WorkFlowEventHandling.AddEventToLibrary(
        //         RunWorkflowOnSendParttimeForApprovalCode, Database::"Part Time Requisition", OnSendParttimeApprovalRequestTxt, 0, false);
        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnCancelParttimeApprovalCode, Database::"Part Time Requisition", OnCanceParttimeApprovalRequestTxt, 0, false);
        //Academics End
        //Fleet
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnSendTransportForApprovalCode, Database::"FLT-Transport Requisition", OnSendTransportApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTransportApprovalCode, Database::"FLT-Transport Requisition", OnCancelTransportApprovalRequestTxt, 0, false);
        //Grants
        // WorkFlowEventHandling.AddEventToLibrary(
        //       RunWorkflowOnSendProposalForApprovalCode, Database::Jobs, OnSendProposalApprovalRequestTxt, 0, false);
        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnCancelProposalApprovalCode, Database::Jobs, OnCancelProposalApprovalRequestTxt, 0, false);

        // WorkFlowEventHandling.AddEventToLibrary(
        //              RunWorkflowOnSendConferenceForApprovalCode, Database::"Conference Attendance", OnSendConferenceApprovalRequestTxt, 0, false);
        // WorkFlowEventHandling.AddEventToLibrary(
        // RunWorkflowOnCancelConferenceApprovalCode, Database::"Conference Attendance", OnCancelConferenceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
                             RunWorkflowOnSendChargeWeiverForApprovalCode, Database::"HMS Patient Charges Weiver", OnSendChargeWeiverApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
                RunWorkflowOnCancelChargeWeiverApprovalCode, Database::"HMS Patient Charges Weiver", OnCancelChargeWeiverApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
                        RunWorkflowOnCancelTransferOrderApprovalCode, Database::"Transfer Header", OnCancelTransferOrderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
                             RunWorkflowOnSendTransferOrderForApprovalCode, Database::"Transfer Header", OnSendTransferOrderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTransferOrderApprovalCode, Database::"Transfer Header", OnCancelTransferOrderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
                             RunWorkflowOnSendTransferOrderForApprovalCode, Database::"Transfer Header", OnSendTransferOrderApprovalRequestTxt, 0, false);
    end;

    local procedure RunWorkflowOnSendApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Codeunit", 'OnSendDocForApproval', '', false, false)]
    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin

        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Payments Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentForApprovalCode, Variant);
            Database::"InterBank Transfers":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInterbankForApprovalCode, Variant);
            Database::"Staff Claims Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffClaimForApprovalCode, Variant);
            Database::"Staff Advance Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffAdvanceForApprovalCode, Variant);
            Database::"Staff Advance Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode, Variant);
            Database::"Imprest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestForApprovalCode, Variant);
            Database::"Imprest Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestSurrenderForApprovalCode, Variant);
            //new store
            Database::"Store Requistion Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStoreRequisitionForApprovalCode, Variant);

            //DATABASE::"Staff Claims Header":
            //   WorkflowManagement.HandleEvent(RunWorkflowOnSendOvertimeForApprovalCode,Variant);
            Database::"G/L Budget Name":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBudgetForApprovalCode, Variant);
            //DATABASE::Workplan:
            //  WorkflowManagement.HandleEvent(RunWorkflowOnSendWorkplanForApprovalCode,Variant);
            Database::"Vote Transfer":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendVoteForApprovalCode, Variant);
            //Investiment
            Database::"Bank Account":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInvestimentForApprovalCode, Variant);
            //HR

            Database::"HR Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrLeaveForApprovalCode, Variant);

            Database::"HR Jobs":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrJobsForApprovalCode, Variant);

            Database::"HR Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrEmployeeReqForApprovalCode, Variant);

            /*
              DATABASE::"HR Training App Header":
              WorkflowManagement.HandleEvent(RunWorkflowOnSendHrTrainingForApprovalCode,Variant);

              DATABASE::"HR Employee Transfer Header":
              WorkflowManagement.HandleEvent(RunWorkflowOnSendHrEmpTransForApprovalCode,Variant);

              DATABASE::"HR Promo. Recommend Header":
              WorkflowManagement.HandleEvent(RunWorkflowOnSendHrPromotionForApprovalCode,Variant);

              DATABASE::"HR Transport Requisition":
              WorkflowManagement.HandleEvent(RunWorkflowOnSendHrTransportForApprovalCode,Variant);

              DATABASE::"HR Asset Transfer Header":
              WorkflowManagement.HandleEvent(RunWorkflowOnSendAssetTransferForApprovalCode,Variant);

              DATABASE::"HR Employee Confirmation":
              WorkflowManagement.HandleEvent(RunWorkflowOnSendHrConfirmationForApprovalCode,Variant);
              */
            //HR

            // Database::"Application Form Header":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendApplicationFormForApprovalCode, Variant);

            // Database::"Graduation Request":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendGraduationForApprovalCode, Variant);

            // Database::"Student Requisitions":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendStdReqForApprovalCode, Variant);
            // Database::"Part Time Requisition":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendParttimeForApprovalCode, Variant);

            Database::"FLT-Transport Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportForApprovalCode, Variant);

            //Grants
            // Database::Jobs:
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendProposalForApprovalCode, Variant);

            // Database::"Conference Attendance":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendConferenceForApprovalCode, Variant);
            Database::"HMS Patient Charges Weiver":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendChargeWeiverForApprovalCode, Variant);
            Database::"Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTransferOrderForApprovalCode, Variant);

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Codeunit", 'OnCancelDocApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Payments Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentForApprovalCode, Variant);
            Database::"InterBank Transfers":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInterbankForApprovalCode, Variant);
            Database::"Staff Claims Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffClaimForApprovalCode, Variant);
            Database::"Staff Advance Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffAdvanceForApprovalCode, Variant);
            Database::"Staff Advance Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffAdvanceSurrenderForApprovalCode, Variant);
            Database::"Imprest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestForApprovalCode, Variant);
            Database::"Imprest Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestSurrenderForApprovalCode, Variant);
            //new store
            Database::"Store Requistion Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStoreRequisitionForApprovalCode, Variant);

            // DATABASE::"Staff Claims Header":
            //  WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffClaimForApprovalCode,Variant);
            Database::"G/L Budget Name":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBudgetForApprovalCode, Variant);
            // DATABASE::Workplan:
            //   WorkflowManagement.HandleEvent(RunWorkflowOnCancelWorkplanForApprovalCode,Variant);
            Database::"Vote Transfer":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelVoteForApprovalCode, Variant);
            //Investiment
            Database::"Bank Account":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInvestimentForApprovalCode, Variant);
            //HR
            Database::"HR Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrLeaveForApprovalCode, Variant);
            Database::"HR Jobs":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrJobsForApprovalCode, Variant);

            Database::"HR Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrEmployeeReqForApprovalCode, Variant);

            /*
            DATABASE::"HR Training App Header":
              WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrTrainingForApprovalCode,Variant);

            DATABASE::"HR Employee Transfer Header":
            WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrEmpTransForApprovalCode,Variant);
            DATABASE::"HR Promo. Recommend Header":
            WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrPromotionForApprovalCode,Variant);
            DATABASE::"HR Transport Requisition":
            WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrTransportForApprovalCode,Variant);
            DATABASE::"HR Asset Transfer Header":
            WorkflowManagement.HandleEvent(RunWorkflowOnCancelAssetTransferForApprovalCode,Variant);
            DATABASE::"HR Employee Confirmation":
            WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrConfirmationForApprovalCode,Variant);
            */
            //HR

            //Academics
            // Database::"Application Form Header":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelApplicationFormForApprovalCode, Variant);

            // Database::"Graduation Request":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelGraduationApprovalCode, Variant);

            // Database::"Student Requisitions":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelStdReqApprovalCode, Variant);
            // Database::"Part Time Requisition":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelParttimeApprovalCode, Variant);

            Database::"FLT-Transport Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportApprovalCode, Variant);

            // Database::Jobs:
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelProposalApprovalCode, Variant);
            // Database::"Conference Attendance":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelConferenceApprovalCode, Variant);

            Database::"HMS Patient Charges Weiver":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelChargeWeiverApprovalCode, Variant);
            Database::"Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransferOrderApprovalCode, Variant);
            //Academics
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    procedure ReOpen(var RecRef: RecordRef; Handled: Boolean)
    var
        // ParttimeReq: Record "Part Time Requisition";
        Transport: Record "FLT-Transport Requisition";
        // Job: Record Jobs;
        // Conference: Record "Conference Attendance";
        ChargeWeiver: Record "HMS Patient Charges Weiver";
        HrReq: Record "HR Employee Requisitions";
        Hrjobs: Record "HR Jobs";
        Hrleave: Record "HR Leave Application";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        InterBankTransfers: Record "InterBank Transfers";
        PaymentsHeader: Record "Payments Header";
        StaffAdvanceHeader: Record "Staff Advance Header";
        StaffAdvanceSurrenderHeader: Record "Staff Advance Surrender Header";
        StaffClaimsHeader: Record "Staff Claims Header";
        StoreRequistionHeader: Record "Store Requistion Header";
        TransferOrder: Record "Transfer Header";
        Vote: Record "Vote Transfer";
        //  RecRef: RecordRef;
        Variant: Variant;
    begin
        // RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Validate(Status, PaymentsHeader.Status::Pending);
                    PaymentsHeader.Modify();
                    Variant := PaymentsHeader;
                    Handled := true;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaimsHeader);
                    StaffClaimsHeader.Validate(Status, StaffClaimsHeader.Status::Pending);
                    StaffClaimsHeader.Modify();
                    Variant := StaffClaimsHeader;
                    Handled := true;
                end;
            Database::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvanceHeader);
                    StaffAdvanceHeader.Validate(Status, StaffAdvanceHeader.Status::Pending);
                    StaffAdvanceHeader.Modify();
                    Variant := StaffAdvanceHeader;
                    Handled := true;
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(StaffAdvanceSurrenderHeader);
                    StaffAdvanceSurrenderHeader.Validate(Status, StaffAdvanceSurrenderHeader.Status::Pending);
                    StaffAdvanceSurrenderHeader.Modify();
                    Variant := StaffAdvanceSurrenderHeader;
                    Handled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::Pending);
                    ImprestHeader.Modify();
                    Variant := ImprestHeader;
                    Handled := true;
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrenderHeader);
                    ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::Pending);
                    ImprestSurrenderHeader.Modify();
                    Variant := ImprestSurrenderHeader;
                    Handled := true;
                end;

            //new store
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequistionHeader);
                    StoreRequistionHeader.Validate(Status, StoreRequistionHeader.Status::Open);
                    StoreRequistionHeader.Modify();
                    Variant := StoreRequistionHeader;
                    Handled := true;
                end;

            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTransfers);
                    InterBankTransfers.Validate(Status, InterBankTransfers.Status::Pending);
                    InterBankTransfers.Modify();
                    Variant := InterBankTransfers;
                    Handled := true;
                end;
            /*
                        Database::"Staff Claims Header":
                            begin
                                RecRef.SetTable(OvertimeClaimHeader);
                                OvertimeClaimHeader.Validate(Status, OvertimeClaimHeader.Status::Pending);
                                OvertimeClaimHeader.Modify;
                                Variant := OvertimeClaimHeader;
                            end;
            */
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(Hrleave);
                    Hrleave.Validate(Status, Hrleave.Status::Open);
                    Hrleave.Modify();
                    Variant := Hrleave;
                    Handled := true;
                end;
            /*
              DATABASE::"G/L Budget Name":
                BEGIN
                 RecRef.SETTABLE(Budget);
                 Budget.VALIDATE(Status,Budget.Status::"0");
                 Budget.MODIFY;
                 Variant := Budget;
                END;

              DATABASE::Workplan:
                BEGIN
                 RecRef.SETTABLE(Workplan);
                 Workplan.VALIDATE(Status,Workplan.Status::"0");
                 Workplan.MODIFY;
                 Variant := Workplan;
                END;
                */

            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(Vote);
                    Vote.Validate(Status, Vote.Status::Open);
                    Vote.Modify();
                    Variant := Vote;
                    Handled := true;
                end;
            /*
            //Investiment
              DATABASE::"Bank Account":
               BEGIN
               RecRef.SETTABLE(Invest);
              Invest.VALIDATE(Status,Invest.Status::Open);
              Invest.MODIFY;
              Variant:=Invest;
              END;
            //HR
            */

            Database::"HR Jobs":
                begin
                    RecRef.SetTable(Hrjobs);
                    Hrjobs.Validate(Status, Hrjobs.Status::New);
                    Hrjobs.Modify();
                    Variant := Hrjobs;
                    Handled := true;
                end;

            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HrReq);
                    HrReq.Validate(Status, HrReq.Status::New);
                    HrReq.Modify();
                    Variant := HrReq;
                    Handled := true;
                end;
            /*
            DATABASE::"HR Training App Header":
            BEGIN
                 RecRef.SETTABLE(HrTraining);
                HrTraining.VALIDATE(Status,HrTraining.Status::New);
                HrTraining.MODIFY;
                 Variant := HrTraining;
                END;

            DATABASE::"HR Employee Transfer Header":
            BEGIN
                 RecRef.SETTABLE(HrEmpTrans);
                HrEmpTrans.VALIDATE(Status,HrEmpTrans.Status::New);
                HrEmpTrans.MODIFY;
                 Variant := HrEmpTrans;
                END;

            DATABASE::"HR Promo. Recommend Header":
            BEGIN
                 RecRef.SETTABLE(HrPromo);
                HrPromo.VALIDATE(Status,HrPromo.Status::New);
                HrPromo.MODIFY;
                 Variant := HrPromo;
                END;
            DATABASE::"HR Transport Requisition":
            BEGIN
                 RecRef.SETTABLE(HrTransport);
                HrTransport.VALIDATE(Status,HrTransport.Status::New);
                HrTransport.MODIFY;
                 Variant := HrTransport;
                END;

             DATABASE::"HR Asset Transfer Header":
             BEGIN
                 RecRef.SETTABLE(HrAssetTrans);
                HrAssetTrans.VALIDATE(Status,HrAssetTrans.Status::New);
                HrAssetTrans.MODIFY;
                 Variant := HrAssetTrans;
                END;

            DATABASE::"HR Employee Confirmation":

            BEGIN
                 RecRef.SETTABLE(HrEmpConfirm);
                HrEmpConfirm.VALIDATE(Status,HrEmpConfirm.Status::New);
                HrEmpConfirm.MODIFY;
                 Variant := HrEmpConfirm;
                END;
              */
            //HR

            //Academics-------------------
            // Database::"Application Form Header":
            //     begin
            //         RecRef.SetTable(ApplicationFormHeader);
            //         ApplicationFormHeader.TestField("Rejection Reason");
            //         ApplicationFormHeader.Validate(Status, ApplicationFormHeader.Status::"Admission Board Rejected");
            //         ApplicationFormHeader.Modify;
            //         Variant := ApplicationFormHeader;
            //         Handled := true;
            //     end;

            // Database::"Graduation Request":
            //     begin
            //         RecRef.SetTable(GraduationRequest);
            //         GraduationRequest.Validate(Status, GraduationRequest.Status::Open);
            //         GraduationRequest.Modify;
            //         Variant := GraduationRequest;
            //         Handled := true;
            //     end;

            // //----------------------------
            // Database::"Student Requisitions":
            //     begin
            //         RecRef.SetTable(StudentRequisitions);
            //         StudentRequisitions.Validate(Status, StudentRequisitions.Status::Open);
            //         StudentRequisitions.Modify;
            //         Variant := StudentRequisitions;
            //         Handled := true;
            //     end;
            // Database::"Part Time Requisition":
            //     begin
            //         RecRef.SetTable(ParttimeReq);
            //         ParttimeReq.Validate(Status, ParttimeReq.Status::Pending);
            //         ParttimeReq.Modify;
            //         Variant := ParttimeReq;
            //         Handled := true;
            //     end;
            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(Transport);
                    Transport.Validate(Status, Transport.Status::"Pending Approval");
                    Transport.Modify();
                    Variant := Transport;
                    Handled := true;
                end;
            // Database::Jobs:
            //     begin
            //         RecRef.SetTable(Job);
            //         Job.Validate(Job."Approval Status", Job."Approval Status"::Open);
            //         Job.Modify;
            //         Variant := Job;
            //         Handled := true;
            //     end;
            // Database::"Conference Attendance":
            //     begin
            //         RecRef.SetTable(Conference);
            //         Conference.Validate(Conference."Status", Conference."Status"::New);
            //         Conference.Modify;
            //         Variant := Conference;
            //         Handled := true;
            //     end;
            Database::"HMS Patient Charges Weiver":
                begin
                    RecRef.SetTable(ChargeWeiver);
                    ChargeWeiver.Validate(ChargeWeiver."Status", ChargeWeiver."Status"::New);
                    ChargeWeiver.Modify();
                    Variant := ChargeWeiver;
                    Handled := true;
                end;
            Database::"Transfer Header":
                begin
                    RecRef.SetTable(TransferOrder);
                    TransferOrder.Validate(TransferOrder."Approval Status", TransferOrder."Approval Status"::New);
                    TransferOrder.Modify();
                    Variant := TransferOrder;
                    Handled := true;
                end;

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;

    procedure Release(RecRef: RecordRef; var Handled: Boolean)
    var
        // ParttimeReq: Record "Part Time Requisition";
        Transport: Record "FLT-Transport Requisition";
        // Job: Record Jobs;
        // Conference: Record "Conference Attendance";
        ChargeWeiver: Record "HMS Patient Charges Weiver";
        HrReq: Record "HR Employee Requisitions";
        Hrleave: Record "HR Leave Application";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        InterBankTransfers: Record "InterBank Transfers";
        PaymentsHeader: Record "Payments Header";
        StaffAdvanceHeader: Record "Staff Advance Header";
        StaffAdvanceSurrenderHeader: Record "Staff Advance Surrender Header";
        OvertimeClaimHeader: Record "Staff Claims Header";
        StoreRequistionHeader: Record "Store Requistion Header";
        TransferOrder: Record "Transfer Header";
        Vote: Record "Vote Transfer";
        // RecRef: RecordRef;
        Variant: Variant;
    begin
        Handled := true;
        // RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Validate(Status, PaymentsHeader.Status::Approved);
                    PaymentsHeader.Modify();
                    Variant := PaymentsHeader;
                end;
            /*
        Database::"Staff Claims Header":
            begin
                RecRef.SetTable(StaffClaimsHeader);
                StaffClaimsHeader.Validate(Status, StaffClaimsHeader.Status::Approved);
                StaffClaimsHeader.Modify;
                Variant := StaffClaimsHeader;
            end;
            */
            Database::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvanceHeader);
                    StaffAdvanceHeader.Validate(Status, StaffAdvanceHeader.Status::Approved);
                    StaffAdvanceHeader.Modify();
                    Variant := StaffAdvanceHeader;
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(StaffAdvanceSurrenderHeader);
                    StaffAdvanceSurrenderHeader.Validate(Status, StaffAdvanceSurrenderHeader.Status::Approved);
                    StaffAdvanceSurrenderHeader.Modify();
                    Variant := StaffAdvanceSurrenderHeader;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::Approved);
                    ImprestHeader.Modify();
                    Variant := ImprestHeader;
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrenderHeader);
                    ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::Approved);
                    ImprestSurrenderHeader.Modify();
                    Variant := ImprestSurrenderHeader;
                end;
            //new store
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequistionHeader);
                    StoreRequistionHeader.Validate(Status, StoreRequistionHeader.Status::Released);
                    StoreRequistionHeader.Modify();
                    Variant := StoreRequistionHeader;
                end;
            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTransfers);
                    InterBankTransfers.Validate(Status, InterBankTransfers.Status::Approved);
                    InterBankTransfers.Modify();
                    Variant := InterBankTransfers;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(OvertimeClaimHeader);
                    OvertimeClaimHeader.Validate(Status, OvertimeClaimHeader.Status::Approved);
                    OvertimeClaimHeader.Modify();
                    Variant := OvertimeClaimHeader;
                end;

            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(Hrleave);
                    Hrleave.Validate(Status, Hrleave.Status::Released);
                    Hrleave.Modify();
                    // Hrleave.CreateLeaveLedgerEntries;
                    Variant := Hrleave;
                end;
            /*
            DATABASE::"G/L Budget Name":
              BEGIN
               RecRef.SETTABLE(Budget);
               Budget.VALIDATE(Status,Budget.Status::"2");
               Budget.MODIFY;
               Variant := Budget;
              END;
            DATABASE::Workplan:
              BEGIN
               RecRef.SETTABLE(Workplan);
               Workplan.VALIDATE(Status,Workplan.Status::"2");
               Workplan.MODIFY;
               Variant := Workplan;
              END;
              */
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(Vote);
                    Vote.Validate(Status, Vote.Status::Approved);
                    Vote.Modify();
                    Variant := Vote;
                end;

            /*
            //Investiment
              DATABASE::"Bank Account":
               BEGIN
               RecRef.SETTABLE(Invest);
              Invest.VALIDATE(Status,Invest.Status::Approved);
              Invest.MODIFY;
              Variant:=Invest;
              END;
                //Hr
            */

            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HrReq);
                    HrReq.Validate(Status, HrReq.Status::Approved);
                    HrReq.Modify();
                    Variant := HrReq;
                end;
            /*
             DATABASE::"HR Jobs":
              BEGIN
                 RecRef.SETTABLE(Hrjobs);
                 Hrjobs.VALIDATE(Status,Hrjobs.Status::Approved);
                 Hrjobs.MODIFY;
                 Variant := Hrjobs;
                END;

                 DATABASE::"HR Training App Header":
                  BEGIN
                 RecRef.SETTABLE(HrTraining);
                 HrTraining.VALIDATE(Status,HrTraining.Status::Approved);
                 HrTraining.MODIFY;
                 Variant := HrTraining;
                END;

                DATABASE::"HR Employee Transfer Header":
                BEGIN
                 RecRef.SETTABLE(HrEmpTrans);
                 HrEmpTrans.VALIDATE(Status,HrEmpTrans.Status::Approved);
                 HrEmpTrans.MODIFY;
                 Variant := HrEmpTrans;
                 END;
                 DATABASE::"HR Promo. Recommend Header":
                 BEGIN
                 RecRef.SETTABLE(HrPromo);
                 HrPromo.VALIDATE(Status,HrPromo.Status::Approved);
                 HrPromo.MODIFY;
                 Variant := HrPromo;
                END;
                DATABASE::"HR Transport Requisition":
                BEGIN
                 RecRef.SETTABLE(HrTransport);
                 HrTransport.VALIDATE(Status,HrTransport.Status::Approved);
                 HrTransport.MODIFY;
                 Variant := HrTransport;
                END;
                DATABASE::"HR Asset Transfer Header":
                BEGIN
                 RecRef.SETTABLE(HrAssetTrans);
                 HrAssetTrans.VALIDATE(Status,HrAssetTrans.Status::Approved);
                 HrAssetTrans.MODIFY;
                 Variant := HrAssetTrans;
                END;

             DATABASE::"HR Employee Confirmation":
             BEGIN
                 RecRef.SETTABLE(HrEmpConfirm);
                 HrEmpConfirm.VALIDATE(Status,HrEmpConfirm.Status::Approved);
                 HrEmpConfirm.MODIFY;
                 Variant := HrEmpConfirm;
                END;

            */
            //HR

            //Academics ----------
            // Database::"Application Form Header":
            //     begin
            //         RecRef.SetTable(ApplicationFormHeader);
            //         ApplicationFormHeader.Validate(Status, ApplicationFormHeader.Status::Approved);
            //         ApplicationFormHeader.Modify;
            //         Variant := ApplicationFormHeader;
            //     end;

            // Database::"Graduation Request":
            //     begin
            //         RecRef.SetTable(GraduationRequest);
            //         GraduationRequest.Validate(Status, GraduationRequest.Status::Approved);
            //         GraduationRequest.Modify;
            //         Variant := GraduationRequest;
            //     end;

            // Database::"Student Requisitions":
            //     begin
            //         RecRef.SetTable(StudentRequisitions);
            //         StudentRequisitions.Validate(Status, StudentRequisitions.Status::Approved);
            //         StudentRequisitions.Modify;
            //         Variant := StudentRequisitions;
            //     end;
            // Database::"Part Time Requisition":
            //     begin
            //         RecRef.SetTable(ParttimeReq);
            //         ParttimeReq.Validate(Status, ParttimeReq.Status::Approved);
            //         ParttimeReq.Modify;
            //         Variant := ParttimeReq;
            //     end;

            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(Transport);
                    Transport.Validate(Status, Transport.Status::Approved);
                    Transport.Modify();
                    Variant := Transport;
                end;
            // Database::Jobs:
            //     begin
            //         RecRef.SetTable(Job);
            //         Job.Validate(Job."Approval Status", Job."Approval Status"::Approved);
            //         Job.Modify;
            //         Variant := Job;
            //     end;
            // Database::"Conference Attendance":
            //     begin
            //         RecRef.SetTable(Conference);
            //         Conference.Validate(Conference."Status", Conference."Status"::Approved);
            //         Conference.Modify;
            //         Variant := Conference;
            //     end;

            Database::"HMS Patient Charges Weiver":
                begin
                    RecRef.SetTable(ChargeWeiver);
                    ChargeWeiver.Validate(ChargeWeiver."Status", ChargeWeiver."Status"::Approved);
                    ChargeWeiver.Modify();
                    Variant := ChargeWeiver;
                end;
            Database::"Transfer Header":
                begin
                    RecRef.SetTable(TransferOrder);
                    TransferOrder.Validate(TransferOrder."Approval Status", TransferOrder."Approval Status"::Approved);
                    TransferOrder.Validate(TransferOrder."Status", TransferOrder."Status"::Released);
                    TransferOrder.Modify();
                    Variant := TransferOrder;
                end;
            //Academics End-------

            else
                Handled := false;
        // Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;

    procedure SetStatusToPending(RecRef: RecordRef; var Variant: Variant; IsHandled: Boolean)
    var
        Transport: Record "FLT-Transport Requisition";
        // PartTimeReq: Record "Part Time Requisition";
        // Job: Record Jobs;
        // Conference: Record "Conference Attendance";
        ChargeWeiver: Record "HMS Patient Charges Weiver";
        HrReq: Record "HR Employee Requisitions";
        Hrjobs: Record "HR Jobs";
        Hrleave: Record "HR Leave Application";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        InterBankTransfers: Record "InterBank Transfers";
        PaymentsHeader: Record "Payments Header";
        StaffAdvanceHeader: Record "Staff Advance Header";
        StaffAdvanceSurrenderHeader: Record "Staff Advance Surrender Header";
        OvertimeClaimHeader: Record "Staff Claims Header";
        StoreRequistionHeader: Record "Store Requistion Header";
        TransferOrder: Record "Transfer Header";
        Vote: Record "Vote Transfer";
    begin
        // RecRef.GetTable(Variant);

        case RecRef.Number of
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Validate(Status, PaymentsHeader.Status::"Pending Approval");
                    PaymentsHeader.Modify();
                    Variant := PaymentsHeader;
                    IsHandled := true;
                end;
            /*
        Database::"Staff Claims Header":
            begin
                RecRef.SetTable(StaffClaimsHeader);
                StaffClaimsHeader.Validate(Status, StaffClaimsHeader.Status::"Pending Approval");
                StaffClaimsHeader.Modify;
                Variant := StaffClaimsHeader;
            end;
            */
            Database::"Staff Advance Header":

                begin
                    RecRef.SetTable(StaffAdvanceHeader);
                    StaffAdvanceHeader.Validate(Status, StaffAdvanceHeader.Status::"Pending Approval");
                    StaffAdvanceHeader.Modify();
                    Variant := StaffAdvanceHeader;
                    IsHandled := true;
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(StaffAdvanceSurrenderHeader);
                    StaffAdvanceSurrenderHeader.Validate(Status, StaffAdvanceSurrenderHeader.Status::"Pending Approval");
                    StaffAdvanceSurrenderHeader.Modify();
                    Variant := StaffAdvanceSurrenderHeader;
                    IsHandled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::"Pending Approval");
                    ImprestHeader.Modify();
                    Variant := ImprestHeader;
                    IsHandled := true;
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrenderHeader);
                    ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::"Pending Approval");
                    ImprestSurrenderHeader.Modify();
                    Variant := ImprestSurrenderHeader;
                    IsHandled := true;
                end;
            //new store
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequistionHeader);
                    StoreRequistionHeader.Validate(Status, StoreRequistionHeader.Status::"Pending Approval");
                    StoreRequistionHeader.Modify();
                    Variant := StoreRequistionHeader;
                    IsHandled := true;
                end;

            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTransfers);
                    InterBankTransfers.Validate(Status, InterBankTransfers.Status::"Pending Approval");
                    InterBankTransfers.Modify();
                    Variant := InterBankTransfers;
                    IsHandled := true;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(OvertimeClaimHeader);
                    OvertimeClaimHeader.Validate(Status, OvertimeClaimHeader.Status::"Pending Approval");
                    OvertimeClaimHeader.Modify();
                    Variant := OvertimeClaimHeader;
                    IsHandled := true;
                end;
            /*
              DATABASE::"G/L Budget Name":
                BEGIN
                 RecRef.SETTABLE(Budget);
                 Budget.VALIDATE(Status,Budget.Status::"1");
                 Budget.MODIFY;
                 Variant := Budget;
                END;
                DATABASE::Workplan:
                BEGIN
                 RecRef.SETTABLE(Workplan);
                 Workplan.VALIDATE(Status,Workplan.Status::"1");
                 Workplan.MODIFY;
                 Variant := Workplan;
                END;

            */
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(Vote);
                    Vote.Validate(Status, Vote.Status::"Pending Approval");
                    Vote.Modify();
                    Variant := Vote;
                    IsHandled := true;
                end;
            /*
            //Investiment
              DATABASE::"Bank Account":
               BEGIN
               RecRef.SETTABLE(Invest);
              Invest.VALIDATE(Status,Invest.Status::"Pending Approval");
              Invest.MODIFY;
              Variant:=Invest;
              END;
            //HR
            */
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(Hrleave);
                    Hrleave.Status := Hrleave.Status::"Pending Approval";
                    Hrleave.Modify();
                    Variant := Hrleave;
                    IsHandled := true;
                end;

            Database::"HR Jobs":
                begin
                    RecRef.SetTable(Hrjobs);
                    Hrjobs.Validate(Status, Hrjobs.Status::"Pending Approval");
                    Hrjobs.Modify();
                    Variant := Hrjobs;
                    IsHandled := true;
                end;

            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HrReq);
                    HrReq.Validate(Status, HrReq.Status::"Pending Approval");
                    HrReq.Modify();
                    Variant := HrReq;
                    IsHandled := true;
                end;
            /*
              DATABASE::"HR Training App Header":
              BEGIN
               RecRef.SETTABLE(HrTraining);
               HrTraining.VALIDATE(Status,HrTraining.Status::"Pending Approval");
               HrTraining.MODIFY;
               Variant := HrTraining;
              END;

          DATABASE::"HR Employee Transfer Header":
              BEGIN
               RecRef.SETTABLE( HrEmpTrans);
               HrEmpTrans.VALIDATE(Status,HrEmpTrans.Status::"Pending Approval");
               HrEmpTrans.MODIFY;
               Variant := HrEmpTrans;
              END;

          DATABASE::"HR Employee Transfer Header":
              BEGIN
               RecRef.SETTABLE( HrEmpTrans);
               HrEmpTrans.VALIDATE(Status,HrEmpTrans.Status::"Pending Approval");
               HrEmpTrans.MODIFY;
               Variant := HrEmpTrans;
              END;

          DATABASE::"HR Promo. Recommend Header":
          BEGIN
               RecRef.SETTABLE( HrPromo);
               HrPromo.VALIDATE(Status,HrPromo.Status::"Pending Approval");
               HrPromo.MODIFY;
               Variant := HrPromo;
              END;

           DATABASE::"HR Transport Requisition":
           BEGIN
               RecRef.SETTABLE(HrTransport);
               HrTransport.VALIDATE(Status,HrTransport.Status::"Pending Approval");
               HrTransport.MODIFY;
               Variant := HrTransport;
              END;

          DATABASE::"HR Asset Transfer Header":
          BEGIN
               RecRef.SETTABLE(HrAssetTrans);
               HrAssetTrans.VALIDATE(Status,HrAssetTrans.Status::"Pending Approval");
               HrAssetTrans.MODIFY;
               Variant := HrAssetTrans;
              END;

          DATABASE::"HR Employee Confirmation":
          BEGIN
               RecRef.SETTABLE(HrEmpConfirm);
               HrEmpConfirm.VALIDATE(Status,HrEmpConfirm.Status::"Pending Approval");
               HrEmpConfirm.MODIFY;
               Variant := HrEmpConfirm;
              END;
            */
            //HR
            //Academics
            // Database::"Application Form Header":
            //     begin
            //         RecRef.SetTable(ApplicationFormHeader);
            //         ApplicationFormHeader.Validate(Status, ApplicationFormHeader.Status::"Pending Approval");
            //         ApplicationFormHeader.Modify;
            //         Variant := ApplicationFormHeader;
            //         IsHandled := true;
            //     end;

            // Database::"Graduation Request":
            //     begin
            //         RecRef.SetTable(GraduationRequest);
            //         GraduationRequest.Validate(Status, GraduationRequest.Status::"Pending Approval");
            //         GraduationRequest.Modify;
            //         Variant := GraduationRequest;
            //         IsHandled := true;
            //     end;

            // //Academics

            // Database::"Student Requisitions":
            //     begin
            //         RecRef.SetTable(StudentRequisitions);
            //         StudentRequisitions.Validate(Status, StudentRequisitions.Status::"Pending Approval");
            //         StudentRequisitions.Modify;
            //         Variant := StudentRequisitions;
            //         IsHandled := true;
            //     end;
            // Database::"Part Time Requisition":
            //     begin
            //         RecRef.SetTable(PartTimeReq);
            //         PartTimeReq.Validate(Status, PartTimeReq.Status::"Pending Approval");
            //         PartTimeReq.Modify;
            //         Variant := PartTimeReq;
            //         IsHandled := true;
            //     end;
            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(Transport);
                    Transport.Validate(Status, Transport.Status::"Pending Approval");
                    Transport.Modify();
                    Variant := Transport;
                    IsHandled := true;
                end;
            // Database::Jobs:
            //     begin
            //         RecRef.SetTable(Job);
            //         Job.Validate(Job."Approval Status", Job."Approval Status"::"Pending Approval");
            //         Job.Modify;
            //         Variant := Job;
            //         IsHandled := true;
            //     end;
            // Database::"Conference Attendance":
            //     begin
            //         RecRef.SetTable(Conference);
            //         Conference.Validate(Conference."Status", Conference."Status"::"Pending Approval");
            //         Conference.Modify;
            //         Variant := Conference;
            //         IsHandled := true;
            //     end;
            Database::"HMS Patient Charges Weiver":
                begin
                    RecRef.SetTable(ChargeWeiver);
                    ChargeWeiver.Validate(ChargeWeiver.Status, ChargeWeiver."Status"::"Pending Approval");
                    ChargeWeiver.Modify();
                    Variant := ChargeWeiver;
                    IsHandled := true;
                end;
            Database::"Transfer Header":
                begin
                    RecRef.SetTable(TransferOrder);
                    TransferOrder.Validate(TransferOrder."Approval Status", TransferOrder."Approval Status"::"Pending Approval");
                    TransferOrder.Modify();
                    Variant := TransferOrder;
                    IsHandled := true;
                end;

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;
}
