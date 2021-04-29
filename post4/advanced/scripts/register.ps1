Write-Host "Going to configure Agent..."

Write-Host "C:\agent\config.cmd --unattended --url "https://dev.azure.com/patrickkoch" --auth PAT --pool "TestPool" --token "2j6wyebyfesu2kdezg2t6excp2s2drlc6lgwqauibzelo73o6qma" --agent "myAgent" --replace"

C:\agent\config.cmd --unattended --url "https://dev.azure.com/patrickkoch" --auth PAT --pool "TestPool" --token "2j6wyebyfesu2kdezg2t6excp2s2drlc6lgwqauibzelo73o6qma" --agent "myAgent" --replace

Write-Host "Going to run Agent..."

C:\agent\run.cmd --once