# Mir PluginTemplate

[![C++][Cpp.org]][Cpp-url]
[![Visual Studio][Visualstudio.com]][Visualstudio-url]

Ready-made project starter files for C++ (visual studio) for MIR platform

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
