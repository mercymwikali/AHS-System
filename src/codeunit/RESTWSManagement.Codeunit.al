Codeunit 85046 "REST WS Management"
{
    trigger OnRun()
    begin
    end;

    [TryFunction]
    procedure CallRESTWebService(BaseUrl: Text; Method: Text; RestMethod: Text; var HttpContent: dotnet HttpContent; var HttpResponseMessage: dotnet HttpResponseMessage)
    var
        HttpClient: dotnet HttpClient;
        Uri: dotnet Uri;
    begin
        HttpClient := HttpClient.HttpClient();
        HttpClient.BaseAddress := Uri.Uri(BaseUrl);

        case RestMethod of
            'GET':
                HttpResponseMessage := HttpClient.GetAsync(Method).Result;
            'POST':
                HttpResponseMessage := HttpClient.PostAsync(Method, HttpContent).Result;
            'PUT':
                HttpResponseMessage := HttpClient.PutAsync(Method, HttpContent).Result;
            'DELETE':
                HttpResponseMessage := HttpClient.DeleteAsync(Method).Result;
        end;

        HttpResponseMessage.EnsureSuccessStatusCode(); // Throws an error when no success
    end;
}
