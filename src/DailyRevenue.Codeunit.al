// codeunit 52202424 "Daily Revenue"
// {
//     trigger OnRun()
//     begin
//         HMSSetup.Get();
//         filename := HMSSetup."Portal Report Path" + filenameFromApp;
//         smtpsetup.get();

//         filename := HMSSetup."Portal Report Path" + 'Daily Revenue reports ' + DELCHR(FORMAT(TODAY), '=', '/') + '.pdf';

//         IF EXISTS(filename) THEN
//             ERASE(filename);
//         RecH.RESET();
//         RecH.SETRANGE(RecH.Date, TODAY);

//         IF RecH.FIND('-') THEN
//             //Report.SaveAsPdf()
//             REPORT.SaveAsPdf(70134924, filename, RecH);

//         filename2 := HMSSetup."Portal Report Path" + 'Account Schedule ' + DELCHR(FORMAT(TODAY), '=', '/') + '.pdf';

//         AccShedule.Reset();
//         AccShedule.SetRange(AccShedule.Name, 'P&L NEW');
//         AccShedule.SetRange(AccShedule."Default Column Layout", 'M-NETCHANG');
//         //AccShedule.SetFilter(AccShedule.fisc);
//         IF AccShedule.Find('-') then
//             Report.SaveAsPdf(25, filename2, AccShedule);

//         recepient1.Add(HMSSetup."SMS Notification Email");
//         if HMSSetup."SMS Notification Email 1" <> '' then
//             recepient1.Add(HMSSetup."SMS Notification Email 1");
//         MailMessage := 'Dear Sir/Madam, please find attached Daily revenue reports ';
//         // Smail.Create('ERP System Reports', 'info@fhc.co.ke', HMSSetup."SMS Notification Email ", 'Daily Sales Revenue', '', TRUE);
//         // Smail.CreateMessage('ERP System Reports', smtpsetup."Send As", recepient1, 'Daily Sales Revenue', '');
//         // if File.Exists(filename) then
//         //     Smail.AddAttachment(filename, filename);
//         // if File.Exists(filename2) then
//         //     Smail.AddAttachment(filename2, filename2);
//         // Smail.AddBCC(recepient1);
//         // Smail.AppendBody('Dear Sir/ Madam,');
//         // Smail.AppendBody('<br>');
//         // //Smail.AppendBody(MailMessage);
//         // Smail.AppendBody('Please find the attached Daily Revenue report for your perusal');
//         // Smail.AppendBody('<br>');
//         // Smail.AppendBody('This is a system generated message do not reply');
//         // Smail.AppendBody('<br>');
//         // Smail.AppendBody('Regards');
//         // Smail.AppendBody('<br>');
//         // Smail.AppendBody('ERP System ');
//         // Smail.Send;
//     end;

//     procedure SendEmail(receiver: Text[50]; subject: Text[100]; message: Text[1000]) returnValue: Boolean
//     var
//         HRSetup: Record "HR Setup";
//         Email: codeunit email;
//         SMTPMail: Codeunit "Email Message";
//         SendToList: List of [Text];
//     begin
//         HRSetup.Get();

//         returnValue := FALSE;
//         //SMTPMailSetup.GET;
//         returnValue := false;

//         SendToList.Add(receiver);
//         SMTPMail.Create(SendToList, subject, message, true);
//         Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
//         returnValue := TRUE;
//     end;

//     var
//         AccShedule: Record "Acc. Schedule Name";
//         smtpsetup: Record "Email Sender";
//         HMSSetup: record "HMS Setup";
//         RecH: Record "Receipt Line q";
//         recepient1: List of [Text];
//         filename: Text;
//         filename2: Text;
//         filenameFromApp: Text;
//         MailMessage: Text;
// }
