FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019

WORKDIR "C:/Scripts"

ADD "Scripts/Start.ps1" "C:/Scripts"

ENTRYPOINT powershell -File Start.ps1