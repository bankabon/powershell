#フォルダー監視用


$folderToWatch = "C:\Path\To\Watched\Folder" #監視するフォルダーに書き換えてください。
$acrobatReaderPath = "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
$printerName = "Your Printer Name"　#プリンターのデバイス名を割り当て

# フォルダー監視の設定
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folderToWatch
$watcher.Filter = "*.pdf"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# ファイルが追加されたときのアクション
$onCreated = Register-ObjectEvent $watcher "Created" -Action {
    $pdfFilePath = $Event.SourceEventArgs.FullPath
    Write-Host "New PDF detected: $pdfFilePath"
    
    # Acrobat Readerを使って印刷
    $printCommand = "/p /h $printerName"
    Start-Process -FilePath $acrobatReaderPath -ArgumentList "$pdfFilePath $printCommand" -Wait
    
    Write-Host "Printing finished for $pdfFilePath"
}

# 監視を続ける
do {
    Start-Sleep -Seconds 1
} while ($true)
