$music_url = "https://live.musopen.org:8085/streamvbr0?1729888126216"
$process = Get-Process -name "mpv" -ErrorAction SilentlyContinue

 if($process) {
    Stop-Process -name "mpv"
} else {
    Start-Process "mpv" -ArgumentList $music_url -WindowStyle Hidden
}