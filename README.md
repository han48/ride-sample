# ride-sample
RIDE Sample

# Setup

## Install chooclatery (Windows package manager)

```shell
Get-ExecutionPolicy
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## Install Python and AutoIt

```shell
choco install autoit
choco install python
choco install appium-desktop
```

https://github.com/appium/appium-desktop/releases

## Install RIDE

```shell
pip install pywin32
pip install wxPython
pip install robotframework
pip install robotframework-ride
pip install robotframework-autoitlibrary
```

## Run ride

```shell
ride
```