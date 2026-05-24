unit DialogueGenerator;

interface

uses
  System.SysUtils, System.Classes, OllamaLib;

type
  TDialogueGenerator = class
  public
    class function GenerateNPCResponse(API: TOllamaAPIBase; const Model,
      NodeDescription, PlayerText: string): string; static;
    class function GeneratePlayerOptions(API: TOllamaAPIBase; const Model,
      Context: string): TStringList; static;
    class function GenerateJournalEntry(API: TOllamaAPIBase; const Model,
      Topic: string; Smart: Boolean): string; static;
    class function GenerateSmartVersion(API: TOllamaAPIBase; const Model,
      Text: string): string; static;
    class function GenerateDumbVersion(API: TOllamaAPIBase; const Model,
      Text: string): string; static;
  end;

implementation

{ TDialogueGenerator }

class function TDialogueGenerator.GenerateNPCResponse(API: TOllamaAPIBase;
  const Model, NodeDescription, PlayerText: string): string;
var
  Prompt: string;
begin
  Prompt := 'You are writing dialogue for a role-playing game.' + #13#10 +
            'NPC description: ' + NodeDescription + #13#10 +
            'Player: "' + PlayerText + '"' + #13#10 +
            'Write the NPC reply (1-2 sentences, stay in character):';
  Result := API.GenerateText(Model, Prompt);
end;

class function TDialogueGenerator.GeneratePlayerOptions(API: TOllamaAPIBase;
  const Model, Context: string): TStringList;
var
  Prompt, Response: string;
  Lines: TStringList;
  i: Integer;
begin
  Result := nil;
  Prompt := 'Context: ' + Context + #13#10 +
            'Generate exactly 3 distinct player dialogue options. Each on a separate line. ' +
            'Do not number them or add prefixes. Keep each concise (under 12 words).';
  Response := API.GenerateText(Model, Prompt);
  Lines := TStringList.Create;
  try
    Lines.Text := Response;
    Result := TStringList.Create;
    for i := 0 to Lines.Count - 1 do
    begin
      if Trim(Lines[i]) <> '' then
        Result.Add(Trim(Lines[i]));
    end;
    while Result.Count > 3 do
      Result.Delete(Result.Count - 1);
  finally
    Lines.Free;
  end;
end;

class function TDialogueGenerator.GenerateJournalEntry(API: TOllamaAPIBase;
  const Model, Topic: string; Smart: Boolean): string;
var
  Prompt: string;
begin
  if Smart then
    Prompt := 'Write a detailed, sophisticated journal entry about: ' + Topic +
              '. Include sensory details and emotional depth.'
  else
    Prompt := 'Write a simple, brief journal entry about: ' + Topic +
              '. Use short sentences and simple language.';
  Result := API.GenerateText(Model, Prompt);
end;

class function TDialogueGenerator.GenerateSmartVersion(API: TOllamaAPIBase;
  const Model, Text: string): string;
var
  Prompt: string;
begin
  Prompt := 'Rewrite the following text to sound more intelligent, articulate and refined:' + #13#10 + Text;
  Result := API.GenerateText(Model, Prompt);
end;

class function TDialogueGenerator.GenerateDumbVersion(API: TOllamaAPIBase;
  const Model, Text: string): string;
var
  Prompt: string;
begin
  Prompt := 'Rewrite the following text to sound less intelligent, more simple and crude:' + #13#10 + Text;
  Result := API.GenerateText(Model, Prompt);
end;

end.
