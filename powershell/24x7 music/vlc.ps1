$music_url = "https://live.musopen.org:8085/streamvbr0?1729888126216"
$process = Get-Process -name "vlc" -ErrorAction SilentlyContinue

if($process) {
    Stop-Process -name "vlc"
} else {
    Start-Process "vlc" -ArgumentList $music_url, "--intf", "dummy", "--loop"
}