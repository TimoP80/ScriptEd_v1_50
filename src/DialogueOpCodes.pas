unit DialogueOpCodes;

interface

uses SysUtils, Classes;

type
  TDialogueOpCode = record
    Code: string;       // 2-letter code, e.g. 'ps' or '$$'
    ParamCount: Integer; // 0, 1, or 2
    Description: string; // one-line description for the list
    Detail: string;      // multi-line detail shown in the help pane
  end;
  TDialogueOpCodeArray = array of TDialogueOpCode;

  TDialogueOpCodeSet = class
  public
    TestCodes: TDialogueOpCodeArray;
    ResultCodes: TDialogueOpCodeArray;
    constructor Create;
    function FormatCode(const Code: TDialogueOpCode; num1, num2: Integer;
      const CurrentField: string; ReplaceAll: Boolean): string;
  end;

implementation

constructor TDialogueOpCodeSet.Create;
begin
  // Test codes for the {Test} field on PC dialog lines.
  // Multiple codes can be combined with commas; their restrictions AND together.
  // ParamCount 0 = no numbers, 1 = one number, 2 = two numbers.
  SetLength(TestCodes, 37);
  TestCodes[0].Code := '$$';  TestCodes[0].ParamCount := 1;
    TestCodes[0].Description := 'Gold test';
    TestCodes[0].Detail :=
      'if num1 > 0, true if PC and followers have at least num1 gold' + #13#10 +
      'if num1 < 0, true if PC and followers have no more than -num1 gold';
  TestCodes[1].Code := 'al';  TestCodes[1].ParamCount := 1;
    TestCodes[1].Description := 'Alignment test';
    TestCodes[1].Detail :=
      'if num1 > 0, true if PC alignment is >= num1' + #13#10 +
      'if num1 < 0, true if PC alignment is <= -num1' + #13#10 +
      'range: -1000 (pure evil) to 1000 (pure good), 0 is neutral';
  TestCodes[2].Code := 'ar';  TestCodes[2].ParamCount := 1;
    TestCodes[2].Description := 'Area awareness';
    TestCodes[2].Detail :=
      'if num1 > 0, true if PC is aware of area num1' + #13#10 +
      'if num1 < 0, true if PC is NOT aware of area -num1' + #13#10 +
      'area indexes in data/mes/area.mes';
  TestCodes[3].Code := 'ch';  TestCodes[3].ParamCount := 1;
    TestCodes[3].Description := 'Charisma test';
    TestCodes[3].Detail :=
      'if num1 > 0, true if PC Charisma is >= num1' + #13#10 +
      'if num1 < 0, true if PC Charisma is <= -num1' + #13#10 +
      'range: 1-20, 10 is average';
  TestCodes[4].Code := 'fo';  TestCodes[4].ParamCount := 1;
    TestCodes[4].Description := 'Follower test';
    TestCodes[4].Detail :=
      'if num1 is 0, true if NPC is not a follower of PC' + #13#10 +
      'if num1 is 1, true if NPC is a follower of PC' + #13#10 +
      'num1 MUST be 0 or 1';
  TestCodes[5].Code := 'gf';  TestCodes[5].ParamCount := 2;
    TestCodes[5].Description := 'Global flag test';
    TestCodes[5].Detail :=
      'true if global flag num1 is equal to value num2' + #13#10 +
      'num1 ranges from 1000 to 3199' + #13#10 +
      'num2 must be 0 or 1';
  TestCodes[6].Code := 'gv';  TestCodes[6].ParamCount := 2;
    TestCodes[6].Description := 'Global variable test';
    TestCodes[6].Detail :=
      'true if global variable num1 is equal to value num2' + #13#10 +
      'num1 ranges from 1000 to 1999';
  TestCodes[7].Code := 'ha';  TestCodes[7].ParamCount := 1;
    TestCodes[7].Description := 'Haggle test';
    TestCodes[7].Detail :=
      'if num1 > 0, true if PC Haggle is >= num1' + #13#10 +
      'if num1 < 0, true if PC Haggle is <= -num1' + #13#10 +
      'range: 1-20, 5 is default';
  TestCodes[8].Code := 'ia';  TestCodes[8].ParamCount := 1;
    TestCodes[8].Description := 'In area test';
    TestCodes[8].Detail :=
      'if num1 > 0, true if PC is in area num1' + #13#10 +
      'if num1 < 0, true if PC is NOT in area -num1' + #13#10 +
      'area indexes in data/mes/area.mes';
  TestCodes[9].Code := 'in';  TestCodes[9].ParamCount := 1;
    TestCodes[9].Description := 'Item held test';
    TestCodes[9].Detail :=
      'if num1 >= 0, true if PC or any follower has item with name index num1' + #13#10 +
      'if num1 < 0, true if NPC has item with name index -num1' + #13#10 +
      'item indexes in data/oemes/oname.mes';
  TestCodes[10].Code := 'lc';  TestCodes[10].ParamCount := 2;
    TestCodes[10].Description := 'Local counter test';
    TestCodes[10].Detail :=
      'true if local counter num1 is equal to num2' + #13#10 +
      'num1 ranges from 0 to 3, num2 from 0 to 255';
  TestCodes[11].Code := 'le';  TestCodes[11].ParamCount := 1;
    TestCodes[11].Description := 'PC level test';
    TestCodes[11].Detail :=
      'if num1 > 0, true if PC level is >= num1' + #13#10 +
      'if num1 < 0, true if PC level is <= -num1' + #13#10 +
      'levels range from 1 to 20';
  TestCodes[12].Code := 'lf';  TestCodes[12].ParamCount := 2;
    TestCodes[12].Description := 'Local flag test';
    TestCodes[12].Detail :=
      'true if local flag num1 is equal to num2' + #13#10 +
      'num1 ranges from 0 to 31, num2 must be 0 or 1';
  TestCodes[13].Code := 'ma';  TestCodes[13].ParamCount := 1;
    TestCodes[13].Description := 'Magical aptitude test';
    TestCodes[13].Detail :=
      'if num1 > 0, true if PC Magical Aptitude is >= num1' + #13#10 +
      'if num1 < 0, true if PC Magical Aptitude is <= -num1' + #13#10 +
      'range: 0-100, 0 is default';
  TestCodes[14].Code := 'me';  TestCodes[14].ParamCount := 1;
    TestCodes[14].Description := 'NPC has met PC';
    TestCodes[14].Detail :=
      'if num1 is 0, true if NPC has not met PC before' + #13#10 +
      'if num1 is 1, true if NPC has met PC before' + #13#10 +
      'num1 MUST be 0 or 1';
  TestCodes[15].Code := 'na';  TestCodes[15].ParamCount := 1;
    TestCodes[15].Description := 'Alignment range test';
    TestCodes[15].Detail :=
      'if num1 > 0, true if PC alignment is >= -num1' + #13#10 +
      'if num1 < 0, true if PC alignment is <= num1' + #13#10 +
      'Example: na 100 is true if alignment is -100 or greater' + #13#10 +
      '        na -100 is true if alignment is -100 or lower';
  TestCodes[16].Code := 'ni';  TestCodes[16].ParamCount := 1;
    TestCodes[16].Description := 'Item NOT held test';
    TestCodes[16].Detail :=
      'if num1 >= 0, true if PC and followers do NOT have item num1' + #13#10 +
      'if num1 < 0, true if NPC does NOT have item -num1';
  TestCodes[17].Code := 'pa';  TestCodes[17].ParamCount := 1;
    TestCodes[17].Description := 'Party member test';
    TestCodes[17].Detail :=
      'if num1 > 0, true if follower with name index num1 is in PC party' + #13#10 +
      'if num1 < 0, true if follower -num1 is NOT in PC party';
  TestCodes[18].Code := 'pe';  TestCodes[18].ParamCount := 1;
    TestCodes[18].Description := 'Perception test';
    TestCodes[18].Detail :=
      'if num1 > 0, true if PC Perception is >= num1' + #13#10 +
      'if num1 < 0, true if PC Perception is <= -num1' + #13#10 +
      'range: 1-20, 10 is average';
  TestCodes[19].Code := 'pf';  TestCodes[19].ParamCount := 2;
    TestCodes[19].Description := 'PC flag test';
    TestCodes[19].Detail :=
      'true if PC flag num1 is equal to value num2' + #13#10 +
      'num1 ranges from 1000 to 3199';
  TestCodes[20].Code := 'ps';  TestCodes[20].ParamCount := 1;
    TestCodes[20].Description := 'Persuasion test';
    TestCodes[20].Detail :=
      'if num1 > 0, true if PC Persuasion is >= num1' + #13#10 +
      'if num1 < 0, true if PC Persuasion is <= -num1' + #13#10 +
      'range: 1-20, 5 is default';
  TestCodes[21].Code := 'pv';  TestCodes[21].ParamCount := 2;
    TestCodes[21].Description := 'PC variable test';
    TestCodes[21].Detail :=
      'true if PC variable num1 is equal to value num2' + #13#10 +
      'num1 ranges from 1000 to 1999';
  TestCodes[22].Code := 'qa';  TestCodes[22].ParamCount := 2;
    TestCodes[22].Description := 'Quest state >= test';
    TestCodes[22].Detail :=
      'true if quest num1 is in a state >= num2' + #13#10 +
      'states: 0 unknown, 1 mentioned, 2 active, 3 achieved,' + #13#10 +
      '4 completed, 5 other, 6 botched';
  TestCodes[23].Code := 'qb';  TestCodes[23].ParamCount := 2;
    TestCodes[23].Description := 'Quest state <= test';
    TestCodes[23].Detail :=
      'true if quest num1 is in a state <= num2' + #13#10 +
      'same state numbering as qa';
  TestCodes[24].Code := 'qu';  TestCodes[24].ParamCount := 2;
    TestCodes[24].Description := 'Quest state = test';
    TestCodes[24].Detail :=
      'true if quest num1 is in state num2' + #13#10 +
      'same state numbering as qa';
  TestCodes[25].Code := 'ra';  TestCodes[25].ParamCount := 1;
    TestCodes[25].Description := 'PC race test';
    TestCodes[25].Detail :=
      'if num1 > 0, true if PC race is num1' + #13#10 +
      'if num1 < 0, true if PC race is not -num1' + #13#10 +
      'races: 1 human, 2 dwarf, 3 elf, 4 half elf, 5 gnome,' + #13#10 +
      '6 halfling, 7 half orc, 8 half ogre';
  TestCodes[26].Code := 're';  TestCodes[26].ParamCount := 1;
    TestCodes[26].Description := 'NPC reaction test';
    TestCodes[26].Detail :=
      'if num1 > 0, true if NPC reaction to PC is >= num1' + #13#10 +
      'if num1 < 0, true if NPC reaction to PC is <= -num1' + #13#10 +
      'reaction: usually 0-100, 50 is neutral';
  TestCodes[27].Code := 'rp';  TestCodes[27].ParamCount := 1;
    TestCodes[27].Description := 'Reputation test';
    TestCodes[27].Detail :=
      'if num1 > 0, true if PC has reputation num1' + #13#10 +
      'if num1 < 0, true if PC does NOT have reputation -num1' + #13#10 +
      'reputations are 1000 or greater';
  TestCodes[28].Code := 'rq';  TestCodes[28].ParamCount := 1;
    TestCodes[28].Description := 'Rumor quelled test';
    TestCodes[28].Detail :=
      'if num1 > 0, true if rumor num1 is quelled' + #13#10 +
      'if num1 < 0, true if rumor -num1 is NOT quelled' + #13#10 +
      'rumor numbers are 1000 or greater';
  TestCodes[29].Code := 'ru';  TestCodes[29].ParamCount := 1;
    TestCodes[29].Description := 'Rumor in log test';
    TestCodes[29].Detail :=
      'if num1 > 0, true if PC has rumor num1 in log' + #13#10 +
      'if num1 < 0, true if PC does NOT have rumor -num1 in log' + #13#10 +
      'rumor numbers are 1000 or greater';
  TestCodes[30].Code := 'sc';  TestCodes[30].ParamCount := 2;
    TestCodes[30].Description := 'Spells known in college';
    TestCodes[30].Detail :=
      'if num2 > 0, true if PC knows at least num2 spells in college num1' + #13#10 +
      'if num2 <= 0, true if PC knows no more than -num2 spells in college num1' + #13#10 +
      'spell colleges: 0-15, spells known: 0-5';
  TestCodes[31].Code := 'sk';  TestCodes[31].ParamCount := 2;
    TestCodes[31].Description := 'Skill rank test';
    TestCodes[31].Detail :=
      'if num2 > 0, true if PC rank in skill num1 is >= num2' + #13#10 +
      'if num2 < 0, true if PC rank in skill num1 is <= -num2' + #13#10 +
      'skills: 0-11 basic, 12-15 tech. Rank: 0-20';
  TestCodes[32].Code := 'ss';  TestCodes[32].ParamCount := 1;
    TestCodes[32].Description := 'Story state test';
    TestCodes[32].Detail :=
      'if num1 > 0, true if current story state is >= num1' + #13#10 +
      'if num1 < 0, true if current story state is <= -num1' + #13#10 +
      'story state value ranges from 0 on up';
  TestCodes[33].Code := 'ta';  TestCodes[33].ParamCount := 1;
    TestCodes[33].Description := 'Tech aptitude test';
    TestCodes[33].Detail :=
      'if num1 > 0, true if PC Tech Aptitude is >= num1' + #13#10 +
      'if num1 < 0, true if PC Tech Aptitude is <= -num1' + #13#10 +
      'range: 0-100, 0 is default';
  TestCodes[34].Code := 'tr';  TestCodes[34].ParamCount := 2;
    TestCodes[34].Description := 'Skill training test';
    TestCodes[34].Detail :=
      'if num2 > 0, true if PC training in skill num1 is >= num2' + #13#10 +
      'if num2 < 0, true if PC training in skill num1 is <= -num2' + #13#10 +
      'training: 0 untrained to 3 master';
  TestCodes[35].Code := 'wa';  TestCodes[35].ParamCount := 1;
    TestCodes[35].Description := 'NPC waiting for leader';
    TestCodes[35].Detail :=
      'if num1 is 0, true if NPC is not currently waiting for leader' + #13#10 +
      'if num1 is 1, true if NPC is currently waiting for leader' + #13#10 +
      'num1 MUST be 0 or 1';
  TestCodes[36].Code := 'wt';  TestCodes[36].ParamCount := 1;
    TestCodes[36].Description := 'NPC wait timeout';
    TestCodes[36].Detail :=
      'if num1 is 0, true if NPC has NOT waited and time expired' + #13#10 +
      'if num1 is 1, true if NPC waited and time expired' + #13#10 +
      'num1 MUST be 0 or 1';

  // Result codes for the {Result} field on PC and NPC dialog lines.
  // Multiple codes can be combined with commas; all are triggered in order.
  SetLength(ResultCodes, 36);
  ResultCodes[0].Code := '$$';  ResultCodes[0].ParamCount := 1;
    ResultCodes[0].Description := 'Adjust PC gold';
    ResultCodes[0].Detail :=
      'if num1 >= 0, add num1 money to PC' + #13#10 +
      'if num1 < 0, remove this much gold from PC and followers';
  ResultCodes[1].Code := 'al';  ResultCodes[1].ParamCount := 1;
    ResultCodes[1].Description := 'Adjust PC alignment';
    ResultCodes[1].Detail :=
      'if +num1, add num1 to PC alignment' + #13#10 +
      'if -num1, subtract num1 from PC alignment' + #13#10 +
      'if <num1, PC alignment cannot be greater than num1' + #13#10 +
      'if >num1, PC alignment cannot be less than num1' + #13#10 +
      'if num1, set PC alignment to num1';
  ResultCodes[2].Code := 'ce';  ResultCodes[2].ParamCount := 0;
    ResultCodes[2].Description := 'Start character editor';
    ResultCodes[2].Detail :=
      'Start the character editor on the NPC in passive mode' + #13#10 +
      '(this will terminate dialog)';
  ResultCodes[3].Code := 'co';  ResultCodes[3].ParamCount := 0;
    ResultCodes[3].Description := 'Start combat';
    ResultCodes[3].Detail :=
      'Start combat between speakers and terminate dialog';
  ResultCodes[4].Code := 'et';  ResultCodes[4].ParamCount := 2;
    ResultCodes[4].Description := 'Expert training test (PC only)';
    ResultCodes[4].Detail :=
      'Tests whether PC can have expert training in skill num1.' + #13#10 +
      'If he can, continue dialog at num2.' + #13#10 +
      'If not, the NPC will say why and continue at response line.';
  ResultCodes[5].Code := 'fl';  ResultCodes[5].ParamCount := 1;
    ResultCodes[5].Description := 'Float line';
    ResultCodes[5].Detail :=
      'Float line num1 above NPC head and terminate dialog';
  ResultCodes[6].Code := 'fp';  ResultCodes[6].ParamCount := 0;
    ResultCodes[6].Description := 'Give fate point';
    ResultCodes[6].Detail :=
      'Give 1 fate point to the PC';
  ResultCodes[7].Code := 'gf';  ResultCodes[7].ParamCount := 2;
    ResultCodes[7].Description := 'Set global flag';
    ResultCodes[7].Detail :=
      'Set global flag num1 equal to value num2 (can only be 0 or 1)' + #13#10 +
      'num1 ranges from 1000 to 3199';
  ResultCodes[8].Code := 'gv';  ResultCodes[8].ParamCount := 2;
    ResultCodes[8].Description := 'Set global variable';
    ResultCodes[8].Detail :=
      'Set global variable num1 equal to value num2' + #13#10 +
      'num1 ranges from 1000 to 1999';
  ResultCodes[9].Code := 'ii';  ResultCodes[9].ParamCount := 0;
    ResultCodes[9].Description := 'Start identify UI';
    ResultCodes[9].Detail :=
      'Start the inventory UI in identify mode';
  ResultCodes[10].Code := 'in';  ResultCodes[10].ParamCount := 1;
    ResultCodes[10].Description := 'Transfer item';
    ResultCodes[10].Detail :=
      'if num1 >= 0, transfer item num1 from PC/follower to NPC' + #13#10 +
      'if num1 < 0, transfer item -num1 from NPC to PC' + #13#10 +
      'item indexes in data/oemes/oname.mes';
  ResultCodes[11].Code := 'jo';  ResultCodes[11].ParamCount := 2;
    ResultCodes[11].Description := 'NPC joins PC (PC only)';
    ResultCodes[11].Detail :=
      'Ask NPC to join PC group.' + #13#10 +
      'If num1 is 0, pay attention to charisma limits.' + #13#10 +
      'If num1 is 1, override charisma limits.' + #13#10 +
      'If successful, continue dialog at num2.' + #13#10 +
      'If not, NPC will say why and continue at response line.';
  ResultCodes[12].Code := 'lc';  ResultCodes[12].ParamCount := 2;
    ResultCodes[12].Description := 'Set local counter';
    ResultCodes[12].Detail :=
      'Set local counter num1 equal to num2';
  ResultCodes[13].Code := 'lf';  ResultCodes[13].ParamCount := 2;
    ResultCodes[13].Description := 'Set local flag';
    ResultCodes[13].Detail :=
      'Set local flag num1 equal to num2';
  ResultCodes[14].Code := 'lv';  ResultCodes[14].ParamCount := 0;
    ResultCodes[14].Description := 'NPC leaves party';
    ResultCodes[14].Detail :=
      'Make the NPC leave the party';
  ResultCodes[15].Code := 'mm';  ResultCodes[15].ParamCount := 1;
    ResultCodes[15].Description := 'Mark map area known';
    ResultCodes[15].Detail :=
      'Mark map area num1 as known on PC map' + #13#10 +
      'area indexes in data/mes/area.mes';
  ResultCodes[16].Code := 'nk';  ResultCodes[16].ParamCount := 0;
    ResultCodes[16].Description := 'Kill NPC';
    ResultCodes[16].Detail :=
      'Kill the NPC involved in this dialog';
  ResultCodes[17].Code := 'np';  ResultCodes[17].ParamCount := 2;
    ResultCodes[17].Description := 'Add newspaper';
    ResultCodes[17].Detail :=
      'Add newspaper num1 with priority num2' + #13#10 +
      '0 means no priority, 1 means high priority (tomorrow paper)';
  ResultCodes[18].Code := 'or';  ResultCodes[18].ParamCount := 1;
    ResultCodes[18].Description := 'Set NPC origin';
    ResultCodes[18].Detail :=
      'Set NPC origin to num';
  ResultCodes[19].Code := 'pf';  ResultCodes[19].ParamCount := 2;
    ResultCodes[19].Description := 'Set PC flag';
    ResultCodes[19].Detail :=
      'Set PC flag num1 equal to value num2 (can only be 0 or 1)';
  ResultCodes[20].Code := 'pv';  ResultCodes[20].ParamCount := 2;
    ResultCodes[20].Description := 'Set PC variable';
    ResultCodes[20].Detail :=
      'Set PC variable num1 equal to value num2' + #13#10 +
      'num1 ranges from 1000 to 1999';
  ResultCodes[21].Code := 'qu';  ResultCodes[21].ParamCount := 2;
    ResultCodes[21].Description := 'Set quest state';
    ResultCodes[21].Detail :=
      'Set quest num1 as being in state num2' + #13#10 +
      'states: 0 unknown, 1 mentioned, 2 active, 3 achieved,' + #13#10 +
      '4 completed, 5 other, 6 botched';
  ResultCodes[22].Code := 're';  ResultCodes[22].ParamCount := 1;
    ResultCodes[22].Description := 'Adjust NPC reaction';
    ResultCodes[22].Detail :=
      'if +num1, add num1 to NPC reaction to PC' + #13#10 +
      'if -num1, subtract num1 from NPC reaction to PC' + #13#10 +
      'if <num1, NPC reaction cannot be greater than num1' + #13#10 +
      'if >num1, NPC reaction cannot be less than num1' + #13#10 +
      'if num1, set NPC reaction to num1';
  ResultCodes[23].Code := 'ri';  ResultCodes[23].ParamCount := 0;
    ResultCodes[23].Description := 'Start repair UI';
    ResultCodes[23].Detail :=
      'Start the inventory UI in repair mode';
  ResultCodes[24].Code := 'rp';  ResultCodes[24].ParamCount := 1;
    ResultCodes[24].Description := 'Add/remove reputation';
    ResultCodes[24].Detail :=
      'if num1 > 0, add reputation num1 to PC' + #13#10 +
      'if num1 < 0, remove reputation -num1 from PC' + #13#10 +
      'reputations are 1000 or greater';
  ResultCodes[25].Code := 'rq';  ResultCodes[25].ParamCount := 1;
    ResultCodes[25].Description := 'Quell rumor';
    ResultCodes[25].Detail :=
      'Quell rumor num' + #13#10 +
      'rumor numbers are 1000 or greater';
  ResultCodes[26].Code := 'ru';  ResultCodes[26].ParamCount := 1;
    ResultCodes[26].Description := 'Add rumor';
    ResultCodes[26].Detail :=
      'Add rumor num to PC log' + #13#10 +
      'rumor numbers are 1000 or greater';
  ResultCodes[27].Code := 'sc';  ResultCodes[27].ParamCount := 0;
    ResultCodes[27].Description := 'NPC stays close';
    ResultCodes[27].Detail :=
      'NPC will stay close';
  ResultCodes[28].Code := 'so';  ResultCodes[28].ParamCount := 0;
    ResultCodes[28].Description := 'NPC spreads out';
    ResultCodes[28].Detail :=
      'NPC will spread out';
  ResultCodes[29].Code := 'ss';  ResultCodes[29].ParamCount := 1;
    ResultCodes[29].Description := 'Set story state floor';
    ResultCodes[29].Detail :=
      'Set the current story state to num1 if it is lower than num1';
  ResultCodes[30].Code := 'su';  ResultCodes[30].ParamCount := 0;
    ResultCodes[30].Description := 'Start schematic UI';
    ResultCodes[30].Detail :=
      'Start the schematic UI on the PC';
  ResultCodes[31].Code := 'tr';  ResultCodes[31].ParamCount := 2;
    ResultCodes[31].Description := 'Set skill training';
    ResultCodes[31].Detail :=
      'Set the training of skill num1 to num2' + #13#10 +
      'training: 0 untrained to 3 master';
  ResultCodes[32].Code := 'uw';  ResultCodes[32].ParamCount := 2;
    ResultCodes[32].Description := 'NPC unwait (PC only)';
    ResultCodes[32].Detail :=
      'Ask NPC to unwait and rejoin PC group (assumes NPC was told to wait).' + #13#10 +
      'If num1 is 0, pay attention to charisma limits.' + #13#10 +
      'If num1 is 1, override charisma limits.' + #13#10 +
      'If successful, continue dialog at num2.' + #13#10 +
      'If not, NPC will say why and continue at response line.';
  ResultCodes[33].Code := 'wa';  ResultCodes[33].ParamCount := 0;
    ResultCodes[33].Description := 'NPC waits here';
    ResultCodes[33].Detail :=
      'Make the NPC wait here';
  ResultCodes[34].Code := 'xp';  ResultCodes[34].ParamCount := 1;
    ResultCodes[34].Description := 'Award XP';
    ResultCodes[34].Detail :=
      'Award experience points to the PC as if he had solved' + #13#10 +
      'a quest of level num1';
  ResultCodes[35].Code := 'et';  ResultCodes[35].ParamCount := 0;
    ResultCodes[35].Description := '(placeholder)';
    ResultCodes[35].Detail := '';
end;

function TDialogueOpCodeSet.FormatCode(const Code: TDialogueOpCode;
  num1, num2: Integer; const CurrentField: string; ReplaceAll: Boolean): string;
var
  NewCode: string;
begin
  // Build the new code segment from the code + numbers.
  NewCode := Code.Code;
  if Code.ParamCount >= 1 then
    NewCode := NewCode + ' ' + IntToStr(num1);
  if Code.ParamCount >= 2 then
    NewCode := NewCode + ' ' + IntToStr(num2);

  if ReplaceAll then
    Result := NewCode
  else
  begin
    // Append to the current field, separated by comma+space if needed.
    Result := Trim(CurrentField);
    if Result = '' then
      Result := NewCode
    else
      Result := Result + ', ' + NewCode;
  end;
end;

end.
