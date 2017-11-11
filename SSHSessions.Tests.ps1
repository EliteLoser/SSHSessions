#requires -version 3
<# Pester 4.x tests for SSH-Sessions/SSHSessions. Joakim Borger Svendsen.
Svendsen Tech.
#>

Import-Module -Name Pester -ErrorAction Stop #-Verbose:$False 
$VerbosePreference = "SilentlyContinue"
#$ComputerName = "www.svendsentech.no"
$ComputerName = ""

Import-Module -Name SSHSessions -ErrorAction Stop #-Verbose:$False

if (-not (Get-Variable -Name PesterSSHSessionsCredentials -Scope Global -ErrorAction SilentlyContinue)) {
    Write-Warning -Message "You need to: `$Global:PesterSSHSessionsCredentials = Get-Credential # and to provide the SSH user credentials before running the tests (I know this sucks...)"
    exit
}

if ($ComputerName -eq "") {
    Write-Warning -Message "You need to assign a computer name to the `$ComputerName variable at the top of SSHSessions.Tests.ps1 (I know this sucks...)"
    exit
}

Describe SshSessions {

    It "Test New-SshSession" {
        if ((Get-SshSession -ComputerName $ComputerName).Connected -eq $True) {
            Write-Verbose -Message "Terminating existing SSH session to $ComputerName." -Verbose
            $Null = Remove-SshSession -ComputerName $ComputerName -ErrorAction SilentlyContinue
        }
        $Result = New-SshSession -ComputerName $ComputerName -Credential $Global:PesterSSHSessionsCredentials -ErrorAction Stop
        $Result | Should -Be "[$ComputerName] Successfully connected."
    }

    It "Test Invoke-SshCommand. Verify simple echo statement output is as expected" {
        $Result = Invoke-SshCommand -ComputerName $ComputerName -Quiet -Command "echo 'This is a test'" -ErrorAction Stop
        $Result | Should -Be "This is a test"
    }
    
    It "Test New-SshSession's -Reconnect parameter" {
        $Result = New-SshSession -ComputerName $ComputerName -Reconnect -Credential $Global:PesterSSHSessionsCredentials `
            -ErrorAction SilentlyContinue
        $Result | Should -Match "\[$([Regex]::Escape($ComputerName))\] Successfully connected"
    }

    It "Test Remove-SshSession" {
        $Result = Remove-SshSession -ComputerName $ComputerName -ErrorAction SilentlyContinue
        $Result | Should -Match "\[$([Regex]::Escape($ComputerName))\] Now disconnected and disposed"
    }

}
