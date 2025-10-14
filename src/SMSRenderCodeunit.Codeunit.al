namespace PTL.HMISBC;

codeunit 52202464 SMSRenderCodeunit
{
    TableNo = "SMS Templates Table";
    SingleInstance = true;

    trigger OnRun()
    begin

    end;
    /* 
        Daily Summary:
        {{#Doctors}}
        - Dr. {{Name}}: {{PatientCount}} patients
        {{/Doctors}}
    */

    procedure RenderSMSMessage(TemplateText: Text; MainVars: Dictionary of [Text, Text]; Blocks: Dictionary of [Text, List of [Dictionary of [Text, Text]]]): Text
    var
        BlockName: Text;
        BlockStart: Text;
        BlockEnd: Text;
        BlockBody: Text;
        StartPos: Integer;
        EndPos: Integer;
        BlockList: List of [Dictionary of [Text, Text]];
        BlockItem: Dictionary of [Text, Text];
        RenderedBlock: Text;
        FullRendered: Text;
    begin
        // Step 1: Replace non-repeating placeholders
        TemplateText := ReplacePlaceholders(TemplateText, MainVars);

        // Step 2: Process each repeat block
        foreach BlockName in Blocks.Keys() do begin
            BlockStart := '{{#' + BlockName + '}}';
            BlockEnd := '{{/' + BlockName + '}}';

            StartPos := StrPos(TemplateText, BlockStart);
            EndPos := StrPos(TemplateText, BlockEnd);

            if (StartPos > 0) and (EndPos > StartPos) then begin
                BlockBody := CopyStr(TemplateText, StartPos + StrLen(BlockStart), EndPos - StartPos - StrLen(BlockStart));
                RenderedBlock := '';
                BlockList := Blocks.Get(BlockName);

                foreach BlockItem in BlockList do
                    RenderedBlock += ReplacePlaceholders(BlockBody, BlockItem);

                FullRendered := CopyStr(TemplateText, 1, StartPos - 1) + RenderedBlock + CopyStr(TemplateText, EndPos + StrLen(BlockEnd));
                TemplateText := FullRendered;
            end;
        end;

        exit(TemplateText);
    end;

    procedure ReplacePlaceholders(TextIn: Text; Variables: Dictionary of [Text, Text]): Text
    var
        TemplateKey: Text;
        Value: Text;
    begin
        foreach TemplateKey in Variables.Keys() do begin
            Value := Variables.Get(TemplateKey);
            TextIn := TextIn.Replace('{{' + TemplateKey + '}}', Value);
        end;
        exit(TextIn);
    end;

    procedure EncodeToGSM7(InputText: Text): Text
    var
        CharIndex: Integer;
        EncodedText: Text;
        Char: Char;
    begin
        EncodedText := '';
        for CharIndex := 1 to StrLen(InputText) do begin
            Char := InputText[CharIndex];
            if IsGSM7Char(Char) then
                EncodedText += Format(Char)
            else
                EncodedText += '?';
        end;
        exit(EncodedText);
    end;

    procedure IsGSM7Char(Char: Char): Boolean
    var
        Allowed: TextConst ENU = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 @£$!èéùìòÇØøÅåΔ_ΦΓΛΩΠΨΣΘΞÆæÉ!"#¤%&''()*+,-./:;<=>?¡ÄÖÑÜäöñüà';
    begin
        exit(StrPos(Allowed, Format(Char)) > 0);
    end;
}
