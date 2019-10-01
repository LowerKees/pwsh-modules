$StorageAccountName = ''

Register-PSRepository -Name $RepoName `
        -SourceLocation $RepoPath `
        -PublishLocation $RepoPath `
        -InstallationPolicy Trusted