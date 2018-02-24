# SSHSessions
Svendsen Tech's SSH-Sessions module provides SSH session creation, management and interaction from PowerShell. Lets you execute commands via SSH against Linux and certain network equipment, etc.

Check out the comprehensive online documentation here on my blog:
https://www.powershelladmin.com/wiki/SSH_from_PowerShell_using_the_SSH.NET_library 

There is also fairly extensive built-in documentation (needs an update).

The module is available from Microsoft's PowerShell Gallery: https://www.powershellgallery.com/packages/SSHSessions

You can suppress the ansible-styled output by passing the -Quiet switch parameter to Invoke-SshCommand, if you only want to collect results and process them programmatically, with no visual feedback on the way, which is useful if there's a lot of text returned.

![alt tag](/img/SSH-Sessions-v2.1-demo.png)
