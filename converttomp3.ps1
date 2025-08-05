<#
.SYNOPSIS
Convert various files to mp3 using ffmpeg
#>

[Cmdletbinding()]
Param(
    #Path to directory containing audio files
    [String]$Path = 'C:\Users\Theo\Music\SoulSeekDownloads\complete', 
    #List of file types to convert to mp3
    [String[]]$Extensions = (".flac", ".webm", ".m4a"), 
    #Retain original files
    [switch]$RetainFiles = $false
)
Function GetFile {
    Param($Path = '.\')
    Get-ChildItem  $Path -recurse | ForEach-Object {
        Write-Host "$_ "
        if (($Extensions -contains $_.Extension) -and !$_.PSIsContainer) {
            $formattedFullName = $_.FullName.Substring(0, $_.FullName.Length - $_.Extension.Length) + ".mp3"
            $ffmpegArgs ="`"" + $_.FullName + "`" `"" + $formattedFullName+  "`""
            if($VerbosePreference) {
                Write-Host $formattedFullName
                $ffmpegArgs ="-loglevel verbose -i " + $ffmpegArgs
                Write-Host $ffmpegArgs
            }
            else {
                $ffmpegArgs ="-loglevel error -i " + $ffmpegArgs
            }
            Start-Process -FilePath ffmpeg.exe -ArgumentList $ffmpegArgs -Wait -NoNewWindow
            if(-not $RetainFiles) {
                Remove-Item -LiteralPath $_.FullName
            }
        }
    }
}
$confirm = Read-Host "Confirm default args:`nPath: $Path`nExtensions: $Extensions`nConfirm [y/N]"
if($confirm -clike "y"){
    GetFile $Path
}
