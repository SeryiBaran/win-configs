Script: *list-drives.ps1*
========================

This PowerShell script lists all local drives as a table.

Parameters
----------
```powershell
PS> ./list-drives.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./list-drives.ps1



Name Root Used (GB) Free (GB)
---- ---- --------- ---------
C    C:\     6648,1     744,2

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Lists all drives
.DESCRIPTION
	This PowerShell script lists all local drives as a table.
.EXAMPLE
	PS> ./list-drives.ps1

	Name Root Used (GB) Free (GB)
	---- ---- --------- ---------
	C    C:\     6648,1     744,2
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-PSDrive -PSProvider FileSystem | format-table -property Name,Root,@{n="Used (GB)";e={[math]::Round($_.Used/1GB,1)}},@{n="Free (GB)";e={[math]::Round($_.Free/1GB,1)}}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of list-drives.ps1 as of 01/25/2024 13:58:39)*