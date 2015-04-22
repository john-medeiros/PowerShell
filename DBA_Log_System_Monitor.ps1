
<#
    .SYNOPSIS
       Verifica se existem erros no log System do Windows.
    .DESCRIPTION
       Verifica se existem erros no log System do Windows, e reporta por email caso existam.
       É um programa para facilitar a administração do ambiente de banco de dados.

    .NOTES
    Author:
    John Medeiros
    
    Version Info:
    1.0 - 22/04/2015
        - Criação

    .LINK 
        https://github.com/john-medeiros/PowerShell
    #>


$DefaultLogDir="F:\App\local\log\"
$FileName="log_system_"+(get-date).ToString("yyyy-MM-dd_hh-mm-ss")+".txt"
$FullFileName=$DefaultLogDir+$FileName
$DateToWatch = (Get-Date).AddDays(-1)
$EmailTo = "xxxxx" 
$EmailSmtpServer = "xxxxx" 
$EmailFrom = "xxxxx"

try
    {

        $Errors = Get-EventLog -LogName "System" -After $DateToWatch -EntryType Error
        
        if ($Errors)
            {
                $Errors | Out-File -FilePath $FullFileName
                $EmailBody = "Foram encontrados erros no log do Windows que podem estar relacionados com administração do ambiente SQL Server. `n Segue anexo o arquivo de log.";
                $EmailSubject = "[DBA] - Monitoramento Log SO"

                Send-MailMessage `
                    -To $EmailTo `
                    -Subject $EmailSubject `
                    -Body $EmailBody `
                    -SmtpServer $EmailSmtpServer `
                    -Encoding ([System.Text.Encoding]::UTF8) `
                    -From $EmailFrom `
                    -Attachments $FullFileName;

            }
    }


catch
    {

        break;  
    }
        





