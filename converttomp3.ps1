Param(
    [Parameter(HelpMessage="Path to directory containing audio files")]
    [String]$Path = 'C:\Users\Theo\Music\SoulSeekDownloads\complete',
    [Parameter(HelpMessage="List of file types to convert to mp3")]
    [String[]]$Extensions = (".flac", ".webm"),
    [Parameter(HelpMessage="display more information during execution")]
    [boolean]$v = $false,
    [Parameter(HelpMessage="retain original files")]
    [boolean]$RetainFiles = $false
)
Function GetFile {
    Param($Path = '.\')
    Read-Host
    Get-ChildItem -Path $Path | ForEach-Object {
        Write-Host "$_"
        if ($_.PSIsContainer) {
            GetFile -Path $_.FullName
        }
        if ($Extensions -contains $_.Extension) {
            $formattedFullName = $_.FullName.Substring(0, $_.FullName.Length - $_.Extension.Length) + ".mp3"
            $ffmpegArgs ="`"" + $_.FullName + "`" `"" + $formattedFullName+  "`""
            if($v) {
            Write-Host $formattedFullName
            $ffmpegArgs = $ffmpegArgs.StartsWith("loglevel verbose -i ")
            Write-Host $ffmpegArgs
            }
            else {
                $ffmpegArgs = $ffmpegArgs.StartsWith("loglevel error -i ")
            }
            Start-Process -FilePath ffmpeg.exe -ArgumentList $ffmpegArgs -Wait -NoNewWindow
            if(!$RetainFiles) {
                Remove-Item -Path $_.FullName
            }
        }
    }
}
$confirm = Read-Host "Confirm default args:`nPath: $Path`nExtensions: $Extensions`nConfirm [y/N]"
if($confirm -clike "y"){
    GetFile $Path
}