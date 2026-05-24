----------------------------------
ScriptEd v1.50 BETA BUILD 8 README
----------------------------------

ScriptEd is a tool for editing Arcanum script files in 
text format. The original version of the program was 
created back in 2001. Since I lost the source code to
it and couldn't recover it in any way, I decided to 
rewrite the tool completely from scratch.

The tool is now bigger, better, faster and has more 
features than before.

NOTE: You need to run ScriptEd as administrator if installing to C:\Program Files (x86)
      Windows seems very restrictive with file permissions otherwise.

List of changes since Build 7:
(The full changelog can be found in your installation
directory) 

- Added support for generating text with Ollama. Automatically detects if the server is running. 
You'll need to install Ollama from https://ollama.com/ and then pull some models from command line 
by using "ollama pull <modelname>", you can find all available models at https://ollama.com/search. 
These will be automatically detected by ScriptEd.
  AI Support currently enabled for generating npc responses, player options and journal entries. 
More AI enhancements will be added later.
 Also note: The performance of the AI text generation depends on your hardware (CPU, GPU, Memory) 
and how many parameters the model has, so it might take a while for the Ollama server to generate 
 a response. On my setup (Ryzen 5600X & GTX 1070 + 16gb of DDR4 RAM), it takes around 30 seconds
 up to one minute to generate text with mistral:7b. The <7B parameter models are much faster
and more suitable for rapid dialogue creation.
 
- Rewrote and optimized some of the script compiler code with some help from ChatGPT.
  The special case transofmr Attachee into basic prototype (num) was broken but was eventually
  fixed after a bit of debugging. Same goes for have (obj) try to steal 100 coins from (obj), this
  had problems compiling but now it should work fine.

- Command line script compiler updated with the new ArcanumSCRLib code.

- Added hints to various sections of the dialogue editor

- Updated app icon to a new one generated with DALL-E 3 through ChatGPT

- Dialogue Editor window enhancements: Added the npc text and player options to the tree view so they 
  are visible at all times. Also changed the treeview to a HTML formatted component. When you edit either 
  NPC text or player options, these items are updated as well.
  NOTE: they are for display only, you cannot edit them from the tree nodes directly.