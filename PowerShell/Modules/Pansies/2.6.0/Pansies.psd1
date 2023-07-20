@{

# Script module or binary module file associated with this manifest.
RootModule = 'Pansies.psm1'

# Version number of this module.
ModuleVersion = '2.6.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '6c376de1-1baf-4d52-9666-d46f6933bc16'

# Author of this module
Author = 'Joel Bennett'

# Company or vendor of this module
CompanyName = 'HuddledMasses.org'

# Copyright statement for this module
Copyright = '(c) 2017 Joel Bennett. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A PowerShell module for handling color and cursor positioning via ANSI escape sequences'

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies =

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @("Pansies.format.ps1xml")

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @( "lib\Pansies.dll" )

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# A default Prefix for for Cmdlets to export
# DefaultCommandPrefix = "Pansies"

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @('New-Text', 'New-Hyperlink', 'Write-Host', 'Get-Gradient', 'Get-Complement', 'Get-ColorWheel')

# Variables to export from this module
# VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'Text', 'Url'

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{
    PSData = @{
        # ModuleBuilder will set the pre-release value
        Prerelease = ''

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("ANSI", "EscapeSequences", "VirtualTerminal", "Color")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/PoshCode/Pansies/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/PoshCode/Pansies'

        # A URL to an icon representing this module.
        IconUri = 'https://github.com/PoshCode/Pansies/blob/resources/Pansies_32.gif?raw=true'

        # ReleaseNotes of this module
        ReleaseNotes = '
        2.6.0: Make X11Palette an ArgumentCompleter:
            - It will tab-complete X11 color names. If you Ctrl+Space you get the list with preview swatches...
                [ArgumentCompleter([PoshCode.Pansies.Palettes.X11Palette])]
        2.5.0: Add a RGBColor constructor for the X11ColorName enum
            - So you can cast color names to RGBColor:
                using namespace PoshCode.Pansies
                using namespace PoshCode.Pansies.Palettes
                [RGBColor][X11ColorName]::Maroon2
        2.4.0: Switch to IPSMetadata serialization
            - Also add some cast constructors
            - Also add pipeline parameterSets for Get-Complement and Get-Cradient
            - Also minimize the whitespace when outputting color formatted
            - Also enabled emoji and nerdfont entities by default
        2.3.1: Fix index problem decoding entities
        2.3.0: Add emoji support
            - Also add nerdfont support
        2.2.0: Add static methods for speed optimization
        2.1.0: Hyperlinks
            - Added New-Hyperlink (alias URL) now that Windows Terminal supports them.
              Note that Windows Console (conhost) _does not_ support hyperlinks, and any terminal which does not will ignore them.
              For compatibility, always use the Uri as the text (i.e. do not pass the object parameter).
            - Added -PersistentColor option to reset the Foreground and Background for each object output when outputting arrays.
        2.0.0: Breaking change for the library:
            - Merge the "Colormine" namespace into PoshCode.Pansies
              Originally, this was a 3rd party MIT licensed library by @THEJoeZack.
              He pulled his repo, so I am now just integrating it into Pansies
            - Expose Complement and Gradient in the C# library for others to use
                - Add GetComplement() method to RgbColor
                - Add PoshCode.Pansies.Gradient class with GetGradient static method
                - Add Get-Complement and Get-Gradient wrappers in module assembly
        1.3.0: The color provider release
            - Add a RgbColor PSProvider that can convert colors to their escape sequences
            - Add Fg: drive and Bg: drive so you can "$Fg:Red$Bg:Blue$YourMessage"
            - Add support for x11 color names to make the drives more useful
        1.2.2: Use full namespace + class name for RgbColor
        1.2.1: Fix cmdlet export so New-Text and Write-Host show back up
               Make EXTERNALHELP work for functions
               Provide help for Get-Complement
        1.2.0: Better support for using ConsoleColors
               Added Get-Complement to calculate the HSL complement or contrasting colors
               Fixed ConsolePalette so it reads the current console colors when possible
        1.1.0: Support for serialization by the Configuration module
               Fix output of "bright" color object in ConEmu (workaround ConEmu bug)
        1.0.0: Pre-release version with support for RGB colors
        '

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion       = '5.1'
    CompatiblePSEditions    = @('Core','Desktop')
}
