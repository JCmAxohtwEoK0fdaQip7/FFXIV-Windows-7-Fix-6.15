function game-enable { REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v DefaultSecureProtocols /t REG_DWORD /d 0x00000A00 /f
REG ADD "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v DefaultSecureProtocols /t REG_DWORD /d 0x00000A00 /f }
function game-disable { REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v DefaultSecureProtocols /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v DefaultSecureProtocols /f }
function test-registry {
$key1 = Get-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name "DefaultSecureProtocols" | select-object -ExpandProperty DefaultSecureProtocols
$key2 = Get-ItemProperty -path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name "DefaultSecureProtocols" | select-object -ExpandProperty DefaultSecureProtocols
if ($key1 -ne 2560) {
$global:status = "No"}
else {
if ($key2 -ne 2560) {
$global:status = "No"}
else {$global:status = "Yes"}}}
function text-message { 
Clear-host
Write-Host "Is FFXIV playable on Windows 7 x64?: $global:$status"
Write-Host "Enter 1 to enable     " 
Write-Host "      2 to disable    " }
$ErrorActionPreference= 'silentlycontinue'
$continue = $true
while($continue)
{
test-registry
text-message
$selection = Read-Host
switch ($selection)
{
'1' { game-enable } 
'2' { game-disable } 
}}




