# Mir PluginTemplate

Ready-made project starter files for C++ (visual studio)/Lua for MIR platform

⚠️ For education purposes only. This is by no means a complete implementation and it is by no means secure!

## Installation

Download the repo with [Git](https://git-scm.com/downloads) or download it on GitHub

```bash
git clone https://github.com/wCatly/Mir-PluginTemplate.git
```

## Usage
Make the necessary linker settings

Setup:
* Release -> x86
* Properties -> VC++ Directories -> Include Directories -> MirFolder\botm_sdk\Include
* Properties -> VC++ Directories -> Libary Directories -> MirFolder\botm_sdk\Lib

A little information: you can also run it by adding these necessary files to your project, but using Linker is not the most convenient at the moment, rather than doing these tasks one by one with each new version :smile:


## Lua Development
* [LuaJIT 2.1.0-beta3](http://luajit.org/)
* Create your project:
* Copy folder Mir\\scripts\\example_lua
* Modify manifest.json (inside the folder)
* Reload the launcher

Mir is fully upwards-compatible with LuaJIT. It supports all standard Lua library functions

### LuaJIT Backwards Compatibility

In an effort to improve compatibility with existing LuaJIT scripts, the system has introduced an emulation feature that enables the execution of scripts within the environment from the directory in which they are located. This approach ensures that the behavior of functions such as "require" and "io.open" aligns with the expected behavior in a standard LuaJIT installation.

Additionally, the system now implements a per-script package system. For example, any changes made to package.path for a particular script will only affect the environment of that script, rather than the entire system.

example.lua:
```lua
botm.load = function(env)
    print("Hello from example.lua")
    return true
end
```

### LuaJIT Http Library

In response to numerous requests, we have added an easy to use http library. This library is a slightly modified version of LuaJIT-Request, allowing the requests to be non-blocking.

```lua
local request = loadscript("http-request")

request.send("https://example.com", nil, function(res, err, msg)
    print(res.code)
    print(res.body)
end)
```
Credits to the original author. Please visit his [page](https://github.com/LPGhatguy/luajit-request) for more examples and documentation:


Sidenote: More example can be find in [here](https://github.com/wCatly/Mir-PluginTemplate/tree/main/MirExample)

## C/C++ Development
When developing a C project, you need to link against botm.dll and include the botm_api header. A gcc (MSYS2 MINGW32) example is included in the folder.

libbotm_lapi_xxx.a (optional):
* Can be linked against your C/C++ project statically
* Is an archive of the most used api functions
* Ultrahigh performance - inlines api functions if link time optimization (lto) is enabled
* Other advantages: By embedding api functions in your dll, it renders your dll useless on league patches and makes it exponentially harder for cracks to crack old versions of your project. It also lets you discontinue support of your project by simply not updating it anymore
* Disadvantage: Your project needs to be manually updated with each league patch
* If a project links against libbotm_lapi it should be specified in the manifest.\n\"script_entry\" is then obsolete and replaced by the specific supported version. Your needs to be fully placed (excluding the manifest) in a subfolder with the supported version being the folder name

```json
{
    "display_name" : "My Script",
    "is_libbotm_lapi" : true,
    "12_23_483_5208_riot" : "my_script.dll",
    "13_1_487_9641_riot" : "my_script.dll"
}
```


## Manifest
Information about your plugin can be specified in a manifest.
The files format is JSON and goes into the root directory of your script

```bash
MirFolder\botm\Scripts\YourFolder
```


```json
"script entry"
[optional] "display name"
[optional] "author"
[optional] "version"
[optional] "icon"
[optional] "enabled by default"
[optional] "search_tags"
[optional] "hide_from_user"
[optional] "loadscript_id"
```
manifest.json Example:
```json
{
  
  "script_entry" : "demo_lua",
  "display_name" : "Mir Demo",
  "author" : "Mir Group",
  "version" : "1.0.0",
  "icon" : "icon.png",
  "enabled_by_defualt" : true,
  "search_tags" : "help;api;"

}
```
Sidenote: More example can be find in [here](https://github.com/wCatly/Mir-PluginTemplate/tree/main/MirExample)
## Library System
The Library System has been implemented to provide a convenient method for loading other scripts.

### Creating a Library: 
Any Script can be utilized as a library by assigning an ID to the Script, making it eligible to be loaded by other scripts. The "hide_from_user" property can also be set to "true" to prevent the library from being displayed in the launcher.

main.lua:
```lua
local lib = {}

lib.add = function(a, b)
    return a + b
end

return lib
```
manifest.json:
```json
{
    "script_entry" : "main.lua",
    "hide_from_user" : true,
    "loadscript_id" : "whatever"
}
```

### Loading a Library:
Loading a library is done by calling the loadscript function with the libraries id

```lua
local lib = loadscript("whatever")
print(lib.add(10, 10))
```
### Lua -> Dll
Loading a library, that is a script built as a dll, is called in the same way. loadscript automatically tries to load a lua binding with the same name (eg. orbwalker.dll -> orbwalker.lua)

```lua
local orb = loadscript("free-orbwalker")
print("orb", orb)
```
### Dll - > Dll
Scripts built as dll that rely on other scripts built as dlls must explicitly specify these dependencies. The "dependencies" field, consisting of a list of loadscript_ids separated by semicolons, ensures that the the dependency is loaded properly into the mir system. It also ensures that the appropriate version of the dependency, if built with libbotm_lapi, is loaded

manifest.json:
```json
{
    ...
    "dependencies" : "free-pred;free-orbwalker;"
}
```

## Images

![1](https://cdn.discordapp.com/attachments/1039895805621960744/1070021072528883842/image.png)
![2](https://cdn.discordapp.com/attachments/1039895805621960744/1070022612626964480/image.png)
![3](https://cdn.discordapp.com/attachments/1039895805621960744/1070021212186628136/image.png)
