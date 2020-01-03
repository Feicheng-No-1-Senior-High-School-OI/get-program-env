#
#
#
#   算了，你们自己写吧，win下搞这些太累人了
#   建议 msys2 或者 wsl
#
#
#
#
### 1. 安装 Scoop
# 1.1 先设置 PowerShell 允许执行未签名脚本
set-executionpolicy remotesigned -s currentuser
# 1.2 下载 Scoop 安装脚本进行安装
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
# 1.3 添加仓库
# 添加 官方 extras 库
scoop bucket add extras
# 添加 第三方库 Ash258
scoop bucket add Ash258 'https://github.com/Ash258/scoop-Ash258.git'
# 添加 第三方库 dorado
scoop bucket add dorado 'https://git.dev.tencent.com/h404bi/dorado.git'
scoop bucket add fredjoseph 'https://github.com/fredjoseph/scoop-bucket.git'
scoop bucket add dodorz 'https://github.com/dodorz/scoop-bucket.git'
scoop bucket add nirsoft-alternative 'https://github.com/MCOfficer/scoop-nirsoft.git'

### 2. 安装基本软件
scoop install git 7zip openssh
scoop install aria2
scoop install sudo

scoop install python