function Register-CudapModulesRepo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateSet("D", "T", "A", "P")]
        [string]$Environment = "P"
    )
    $ErrorActionPreference = 'stop'
    $RepoName = "CudapModules$Environment" 
    $Subscription = switch -Regex($Environment) {
        "[AP]" { "Cudap" }
        default { "CudapNonProd" }
    }
    Set-AzContext -Subscription $Subscription
    Unregister-PSRepository -Name $RepoName -ErrorAction SilentlyContinue
    try { net.exe use Q: /delete } catch { Write-Host "No network drive mapped to Q drive" }
    # Get info about the fileshare that hosts the modules
    $ResourceGroupName = "we$($Environment)01cudapmodulesrg".ToLower()
    $StorageAccountName = "we$($Environment)01modulestorage01".ToLower()
    $StorageAccount = Get-AzStorageAccount -Name $StorageAccountName `
        -ResourceGroupName $ResourceGroupName
    $StorageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $StorageAccount.ResourceGroupName `
            -Name $StorageAccountName
    ).Value[0]
    $ShareName = "moduleshare"
    # Maps the fileshare to a local disk
    Write-Host "Mapping file share to Q drive"
    net.exe use Q: \\$StorageAccountName.file.core.windows.net\$ShareName `
        $StorageAccountKey  `
        /persistent:Yes  `
        /user:Azure\$StorageAccountName
    $RepoPath = "\\$StorageAccountName.file.core.windows.net\$ShareName\Modules"
    # Registering the fileshare as a psRepository
    Register-PSRepository -Name $RepoName `
        -SourceLocation $RepoPath `
        -PublishLocation $RepoPath `
        -InstallationPolicy Trusted
    Write-Host "$RepoName registered"
    Find-Module -Repository $RepoName | Format-Table
}
Register-CudapModulesRepo