Param(
    [String]$Path = 'C:\Users\Theo\Music\SoulSeekDownloads\complete',
    [String[]]$Extensions = (".flac", ".webm")
)
Function GetFile {
    Param($Path = '.\')
    Get-ChildItem -Path $Path | ForEach-Object {
        Write-Host "$_"
        if ($_.PSIsContainer) {
            GetFile -Path $_.FullName
        }
        if ($Extensions -contains $_.Extension) {
            $formattedFullName = $_.FullName.Substring(0, $_.FullName.Length - $_.Extension.Length) + ".mp3"
            Write-Host $formattedFullName
            $ffmpegArgs = "-i " +  "`"" + $_.FullName + "`" " + "`"" + $formattedFullName+  "`""
            Write-Host $ffmpegArgs
            Start-Process -FilePath ffmpeg.exe -ArgumentList $ffmpegArgs -Wait -NoNewWindow
            Remove-Item -Path $_.FullName
        }
    }
}
GetFile $Path
