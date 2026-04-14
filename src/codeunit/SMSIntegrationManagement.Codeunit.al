codeunit 85020 "SMS Integration Management"
{
    trigger OnRun()
    begin
        ClearSMSBuffer()

    end;

    procedure SendSMS(ToContactNo: Text[30]; MessageTxt: Text): Boolean
    var
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        JSONManagement: Codeunit "JSON Management";
        Json: Text;
        ResponseText: Text;
        ConvertedText: Text;
        DataPoint: JsonObject;
        OutStr: OutStream;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
        SMSUri: Text;
    begin

        SMSSetup.Get();
        DataPoint.Add('apikey', SMSSetup.ApiKey);
        DataPoint.Add('partnerID', SMSSetup."Partner ID");
        DataPoint.Add('shortcode', SMSSetup.Shortcode);
        DataPoint.Add('mobile', ToContactNo);
        DataPoint.Add('message', MessageTxt);
        SMSUri := SMSSetup."Send SMS API URL";

        Content.WriteFrom(Format(DataPoint));

        // Write the text into a TempBlob stream
        // TempBlob.CreateOutStream(OutStr);
        // OutStr.WriteText(Format(DataPoint));
        // TempBlob.CreateInStream(InStr);

        // Create HTTP content and preserve exact text encoding
        // Content.WriteFrom(InStr);

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        RequestMessage.SetRequestUri(SMSUri);
        RequestMessage.Method('POST');
        RequestMessage.Content(Content);

        // Message(SMSUri);

        IsSuccessful := Client.Post(SMSUri, Content, Response);
        // IsSuccessful := Client.Send(RequestMessage, Response);
        // Message('is Successful: %1', IsSuccessful);


        if not IsSuccessful then
            exit(false);
        if GuiAllowed then begin
            Message(format(Response.IsBlockedByEnvironment()));
            Message(Response.ReasonPhrase());
        end;

        if not Response.IsSuccessStatusCode() then
            if GuiAllowed then
                Message(format(Response.HttpStatusCode()));

        Response.Content().ReadAs(ResponseText);
        Message(ResponseText);
        exit(true)
    end;

    procedure ClearSMSBuffer()
    begin
        SMSSender.Reset();
        SMSSender.SetRange(SMSSender.Status, SMSSender.Status::Pending);
        SMSSender.SetFilter(Date, '%1..', Today);

        if SMSSender.FindSet() then
            repeat
                if SendSMS(SMSSender."Phone No", SMSSender.Message) then begin
                    SMSSender.Status := SMSSender.status::Sent;
                    SMSSender.Modify();
                end;
            until SMSSender.Next() = 0;
    end;

    var
        SMSSetup: Record "SMS Setup";
        SMSSender: Record "SMS Sender";
}
