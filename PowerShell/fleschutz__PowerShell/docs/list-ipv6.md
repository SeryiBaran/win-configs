Script: *list-ipv6.ps1*
========================

This PowerShell script lists the state of IPv6 on all network interfaces of the local computer.

Parameters
----------
```powershell
PS> ./list-ipv6.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./list-ipv6.ps1
Name                         Enabled
----                         -------
Ethernet                        True
vEthernet (WSL)                 True
Bluetooth Network Connection    True

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
	Lists IPv6 states
.DESCRIPTION
	This PowerShell script lists the state of IPv6 on all network interfaces of the local computer.
.EXAMPLE
	PS> ./list-ipv6.ps1
	Name                         Enabled
	----                         -------
	Ethernet                        True
	vEthernet (WSL)                 True
	Bluetooth Network Connection    True
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-NetAdapterBinding -name '*' -componentID 'ms_tcpip6' | Format-Table -autoSize -property Name,Enabled 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of list-ipv6.ps1 as of 01/25/2024 13:58:39)*