Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# =========================
# THEME
# =========================
$script:Cyan = [System.Drawing.Color]::FromArgb(0, 225, 255)
$script:Blue = [System.Drawing.Color]::FromArgb(40, 110, 255)
$script:Bg = [System.Drawing.Color]::FromArgb(10, 14, 25)
$script:SidebarBg = [System.Drawing.Color]::FromArgb(13, 19, 32)
$script:PanelBg = [System.Drawing.Color]::FromArgb(17, 24, 40)
$script:Muted = [System.Drawing.Color]::FromArgb(145, 164, 190)
$script:Phase = 0

# Number of sub-buttons for each main button
$script:ButtonCounts = @(12, 10, 6, 7, 3, 10, 12, 3, 14)

# Main button names
$script:MainButtonNames = @(
    "Orbdiff",
    "Spokwn",
    "Tonynoh",
    "Praiselilly",
    "RedLotus",
    "Zimmerman",
    "NirSoft",
    "Dependencies",
    "Others"
)

# OPTIONAL: customize sub-button names by group number.
# Groups not listed here will show Option 1, Option 2, etc.

# =========================
# SUB-BUTTON NAMES
# Easily rename every sub-button here.
# Keep the names in the same order as the buttons.
# =========================

$script:SubButtonNames = @{

    # 1. Orbdiff - 12 buttons
    1 = @(
        "PrefetchView",
        "BAMReveal",
        "StringParser",
        "Fileless",
        "DPS-Analyzer",
        "UserAssistView",
        "JournalParser",
        "InjGen",
        "USBDetector",
        "PFTrace",
        "CheckDeletedUSN",
        "JARParser"
    )

    # 2. Spokwn - 10 buttons
    2 = @(
        "BAM-Parser",
        "PathsParser",
        "JournalTrace",
        "KernelLiveDumpTool",
        "BamDeletedKeys",
        "Espouken Tool",
        "pcasvc-executed",
        "process-parser",
        "prefetch-parser",
        "ActivitiesCache"
    )

    # 3. Tonynoh - 6 buttons
    3 = @(
        "MeowDoomsdayFucker",
        "MeowModAnalyzer",
        "MeowResolver",
        "MeowNovowareFucker",
        "MeowImportsChecker",
        "MeowClientsFucker"
    )

    # 4. Praiselilly - 7 buttons
    4 = @(
        "PSHunter",
        "AltDetector",
        "WeHateFucker",
        "CommonDirectories",
        "HarddiskConverter",
        "Services",
        "SignedScheduledTasks"
    )

    # 5. RedLotus - 3 buttons
    5 = @(
        "RL ModAnalyzer",
        "RL TaskSentinel",
        "RL Altchecker"
    )

    # 6. Zimmerman - 10 buttons
    6 = @(
        "bstrings",
        "JLECmd",
        "JumpListExplorer",
        "MFTECmd",
        "PECmd",
        "RecentFileCacheParser",
        "RegistryExplorer",
        "ShellBagsExplorer",
        "SrumECmd",
        "TimelineExplorer"
    )

    # 7. NirSoft - 12 buttons
    7 = @(
        "FullEventLogView",
        "NetworkUsageView",
        "BrowserDownloadsView",
        "AlternateStreamView",
        "USBDeview",
        "OpenSaveFilesView",
        "ExecutedProgramList",
        "TaskSchedulerView",
        "JumpListsView",
        "WinPrefetchView",
        "RegScanner",
        "ShellBagsView"
    )

    # 8. Dependencies - 3 buttons
    8 = @(
        "NET 9.0",
        "NET 10.0",
        "VSRedist"
    )

    # 9. Others - 14 buttons
    9 = @(
        "ComputerActivityView",
        "AmcacheParser",
        "SystemInformer",
        "DIE-engine",
        "DQRKIS-FUCKER",
        "MacroDetector",
        "Jarabel",
        "Luyten",
        "VWAware",
        "Velociraptor",
        "NTFS Parser",
        "HayaBusa",
        "Everything",
        "HxD"
    )
}


# OPTIONAL: customize final information by "mainNumber-subNumber".
# Example: "1-1" is the first option under Orbdiff.
$script:InfoContent = @{
    # "1-1" = @{
    #     Title = "Orbdiff Overview"
    #     Text  = "Put your information here."
    # }
    # "1-2" = @{
    #     Title = "Another Orbdiff Option"
    #     Text  = "Put different information here."
    # }
}

# =========================
# MAIN WINDOW
# =========================
$form = New-Object System.Windows.Forms.Form
$form.Text = "ScreenshareInfo"
$form.Size = New-Object System.Drawing.Size(1000, 650)
$form.MinimumSize = New-Object System.Drawing.Size(850, 550)
$form.StartPosition = "CenterScreen"
$form.BackColor = $script:Bg
$form.ForeColor = [System.Drawing.Color]::White
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Root layout
$root = New-Object System.Windows.Forms.TableLayoutPanel
$root.Dock = "Fill"
$root.Margin = New-Object System.Windows.Forms.Padding(0)
$root.Padding = New-Object System.Windows.Forms.Padding(0)
$root.ColumnCount = 2
$root.RowCount = 1
[void]$root.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Absolute, 215)))
[void]$root.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Percent, 100)))
[void]$root.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 100)))
$form.Controls.Add($root)

# =========================
# SIDEBAR
# =========================
$sidebar = New-Object System.Windows.Forms.Panel
$sidebar.Dock = "Fill"
$sidebar.BackColor = $script:SidebarBg
$sidebar.Margin = New-Object System.Windows.Forms.Padding(0)
$root.Controls.Add($sidebar, 0, 0)

$logo = New-Object System.Windows.Forms.Panel
$logo.Location = New-Object System.Drawing.Point(18, 20)
$logo.Size = New-Object System.Drawing.Size(52, 52)
$logo.BackColor = $script:SidebarBg
$sidebar.Controls.Add($logo)

$logo.Add_Paint({
    param($sender, $e)
    $g = $e.Graphics
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $intensity = [int](130 + 125 * [Math]::Abs([Math]::Sin($script:Phase)))
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb($intensity, 0, 225, 255), 2.5)
    $pen2 = New-Object System.Drawing.Pen($script:Blue, 2.5)
    $g.DrawRectangle($pen, 5, 5, 42, 42)
    $points = @(
        [System.Drawing.Point]::new(13, 34),
        [System.Drawing.Point]::new(21, 16),
        [System.Drawing.Point]::new(28, 30),
        [System.Drawing.Point]::new(36, 16),
        [System.Drawing.Point]::new(40, 34)
    )
    $g.DrawLines($pen2, $points)
    $pen.Dispose()
    $pen2.Dispose()
})

$brand = New-Object System.Windows.Forms.Label
$brand.Text = "ScreenshareInfo"
$brand.Location = New-Object System.Drawing.Point(78, 25)
$brand.Size = New-Object System.Drawing.Size(132, 28)
$brand.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$brand.ForeColor = $script:Cyan
$sidebar.Controls.Add($brand)

$version = New-Object System.Windows.Forms.Label
$version.Text = "NEON INTERFACE"
$version.Location = New-Object System.Drawing.Point(80, 51)
$version.Size = New-Object System.Drawing.Size(125, 20)
$version.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$version.ForeColor = $script:Muted
$sidebar.Controls.Add($version)

$separator = New-Object System.Windows.Forms.Panel
$separator.Location = New-Object System.Drawing.Point(18, 91)
$separator.Size = New-Object System.Drawing.Size(178, 1)
$separator.BackColor = [System.Drawing.Color]::FromArgb(40, 65, 85)
$sidebar.Controls.Add($separator)

# =========================
# BUTTON HELPER
# =========================
function New-AppButton {
    param(
        [string]$Text,
        [int]$X,
        [int]$Y,
        [int]$Width = 170,
        [int]$Height = 42
    )
    $b = New-Object System.Windows.Forms.Button
    $b.Text = $Text
    $b.Location = New-Object System.Drawing.Point($X, $Y)
    $b.Size = New-Object System.Drawing.Size($Width, $Height)
    $b.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $b.FlatAppearance.BorderSize = 1
    $b.FlatAppearance.BorderColor = $script:Cyan
    $b.BackColor = $script:PanelBg
    $b.ForeColor = $script:Cyan
    $b.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 10)
    $b.Cursor = [System.Windows.Forms.Cursors]::Hand
    $b.Margin = New-Object System.Windows.Forms.Padding(0)
    $b.Add_MouseEnter({ $this.BackColor = [System.Drawing.Color]::FromArgb(20, 48, 68) })
    $b.Add_MouseLeave({ $this.BackColor = $script:PanelBg })
    return $b
}

# Sidebar navigation
$navHome = New-AppButton "Home" 18 120 178 42
$navTools = New-AppButton "Tools" 18 172 178 42
$sidebar.Controls.AddRange(@($navHome, $navTools))

$status = New-Object System.Windows.Forms.Label
$status.Text = "SYSTEM ONLINE"
$status.Location = New-Object System.Drawing.Point(20, 565)
$status.Size = New-Object System.Drawing.Size(180, 24)
$status.Anchor = [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Bottom
$status.ForeColor = [System.Drawing.Color]::FromArgb(60, 230, 160)
$status.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$sidebar.Controls.Add($status)
$sidebar.Add_Resize({ $status.Top = $sidebar.ClientSize.Height - 38 })

# =========================
# MAIN AREA
# =========================
$main = New-Object System.Windows.Forms.TableLayoutPanel
$main.Dock = "Fill"
$main.Margin = New-Object System.Windows.Forms.Padding(0)
$main.Padding = New-Object System.Windows.Forms.Padding(0)
$main.ColumnCount = 1
$main.RowCount = 2
[void]$main.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Percent, 100)))
[void]$main.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Absolute, 110)))
[void]$main.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 100)))
$root.Controls.Add($main, 1, 0)

$header = New-Object System.Windows.Forms.Panel
$header.Dock = "Fill"
$header.BackColor = $script:Bg
$header.Margin = New-Object System.Windows.Forms.Padding(0)
$main.Controls.Add($header, 0, 0)

$heading = New-Object System.Windows.Forms.Label
$heading.Text = "Welcome back."
$heading.Location = New-Object System.Drawing.Point(30, 20)
$heading.Size = New-Object System.Drawing.Size(650, 43)
$heading.Font = New-Object System.Drawing.Font("Segoe UI", 25, [System.Drawing.FontStyle]::Bold)
$heading.ForeColor = [System.Drawing.Color]::White
$header.Controls.Add($heading)

$subtitle = New-Object System.Windows.Forms.Label
$subtitle.Text = "Your own space. Your own tools."
$subtitle.Location = New-Object System.Drawing.Point(33, 67)
$subtitle.Size = New-Object System.Drawing.Size(650, 26)
$subtitle.ForeColor = $script:Muted
$header.Controls.Add($subtitle)

# Page host
$pagesHost = New-Object System.Windows.Forms.Panel
$pagesHost.Dock = "Fill"
$pagesHost.BackColor = $script:Bg
$pagesHost.Margin = New-Object System.Windows.Forms.Padding(0)
$main.Controls.Add($pagesHost, 0, 1)

$homePage = New-Object System.Windows.Forms.Panel
$homePage.Dock = "Fill"
$homePage.BackColor = $script:Bg
$pagesHost.Controls.Add($homePage)

$toolsPage = New-Object System.Windows.Forms.Panel
$toolsPage.Dock = "Fill"
$toolsPage.BackColor = $script:Bg
$pagesHost.Controls.Add($toolsPage)

$layerPage = New-Object System.Windows.Forms.Panel
$layerPage.Dock = "Fill"
$layerPage.BackColor = $script:Bg
$layerPage.Visible = $false
$pagesHost.Controls.Add($layerPage)

# =========================
# HOME PAGE
# =========================
$card = New-Object System.Windows.Forms.Panel
$card.Location = New-Object System.Drawing.Point(30, 20)
$card.Size = New-Object System.Drawing.Size(690, 180)
$card.Anchor = "Top, Left, Right"
$card.BackColor = $script:PanelBg
$homePage.Controls.Add($card)

$accent = New-Object System.Windows.Forms.Panel
$accent.Location = New-Object System.Drawing.Point(0, 0)
$accent.Size = New-Object System.Drawing.Size(4, 180)
$accent.BackColor = $script:Cyan
$card.Controls.Add($accent)

$cardTitle = New-Object System.Windows.Forms.Label
$cardTitle.Text = "SCREENSHAREINFO DASHBOARD"
$cardTitle.Location = New-Object System.Drawing.Point(25, 20)
$cardTitle.Size = New-Object System.Drawing.Size(620, 30)
$cardTitle.Font = New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)
$cardTitle.ForeColor = $script:Cyan
$card.Controls.Add($cardTitle)

$cardText = New-Object System.Windows.Forms.Label
$cardText.Text = "Welcome to ScreenshareInfo.`r`nChoose Tools to open your custom panels."
$cardText.Location = New-Object System.Drawing.Point(26, 60)
$cardText.Size = New-Object System.Drawing.Size(600, 48)
$cardText.ForeColor = $script:Muted
$card.Controls.Add($cardText)

$clock = New-Object System.Windows.Forms.Label
$clock.Location = New-Object System.Drawing.Point(26, 125)
$clock.Size = New-Object System.Drawing.Size(600, 25)
$clock.Font = New-Object System.Drawing.Font("Consolas", 11)
$clock.ForeColor = [System.Drawing.Color]::White
$card.Controls.Add($clock)

$hello = New-AppButton "Say Hello" 30 225 160 45
$showTime = New-AppButton "Show Date & Time" 205 225 180 45
$about = New-AppButton "About ScreenshareInfo" 400 225 230 45
$homePage.Controls.AddRange(@($hello, $showTime, $about))

$notice = New-Object System.Windows.Forms.Label
$notice.Text = "Ready."
$notice.Location = New-Object System.Drawing.Point(32, 285)
$notice.Size = New-Object System.Drawing.Size(650, 35)
$notice.ForeColor = $script:Cyan
$homePage.Controls.Add($notice)

$hello.Add_Click({
    $notice.Text = "Hello! ScreenshareInfo is running."
    [System.Media.SystemSounds]::Asterisk.Play()
})
$showTime.Add_Click({ $notice.Text = "Current time: " + (Get-Date -Format "HH:mm:ss") })
$about.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        "ScreenshareInfo`r`nCustom PowerShell Windows Forms application.`r`nVersion 1.0",
        "About ScreenshareInfo",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    ) | Out-Null
})

# =========================
# LAYER NAVIGATION
# =========================
$script:CurrentMainButton = 0
$script:CurrentLayer = "Home"

function Show-HomePage {
    $script:CurrentLayer = "Home"
    $homePage.Visible = $true
    $toolsPage.Visible = $false
    $layerPage.Visible = $false
    $homePage.BringToFront()
    $heading.Text = "Welcome back."
    $subtitle.Text = "Your own space. Your own tools."
}

function Show-ToolsPage {
    $script:CurrentLayer = "Tools"
    $homePage.Visible = $false
    $toolsPage.Visible = $true
    $layerPage.Visible = $false
    $toolsPage.BringToFront()
    $heading.Text = "Tools"
    $subtitle.Text = "Choose one of your nine custom buttons."
}

function Show-MainButtonLayer {
    param([int]$Number)
    $script:CurrentMainButton = $Number
    $script:CurrentLayer = "SubButtons"
    $homePage.Visible = $false
    $toolsPage.Visible = $false
    $layerPage.Visible = $true
    $layerPage.Controls.Clear()

    $count = $script:ButtonCounts[$Number - 1]
    $mainName = $script:MainButtonNames[$Number - 1]
    $heading.Text = $mainName
    $subtitle.Text = "$count options available. Select one to view its information."

    $backButton = New-AppButton "< Back to Tools" 30 12 150 38
    $backButton.Add_Click({ Show-ToolsPage })
    $layerPage.Controls.Add($backButton)

    $layerTitle = New-Object System.Windows.Forms.Label
    $layerTitle.Text = $mainName.ToUpperInvariant()
    $layerTitle.Location = New-Object System.Drawing.Point(30, 65)
    $layerTitle.Size = New-Object System.Drawing.Size(650, 32)
    $layerTitle.Font = New-Object System.Drawing.Font("Segoe UI", 17, [System.Drawing.FontStyle]::Bold)
    $layerTitle.ForeColor = $script:Cyan
    $layerPage.Controls.Add($layerTitle)

    $layerDescription = New-Object System.Windows.Forms.Label
    $layerDescription.Text = "Choose an option below to display its information."
    $layerDescription.Location = New-Object System.Drawing.Point(32, 100)
    $layerDescription.Size = New-Object System.Drawing.Size(680, 25)
    $layerDescription.ForeColor = $script:Muted
    $layerPage.Controls.Add($layerDescription)

    $buttonArea = New-Object System.Windows.Forms.Panel
    $buttonArea.Location = New-Object System.Drawing.Point(30, 140)
    $buttonArea.Size = New-Object System.Drawing.Size(700, 350)
    $buttonArea.Anchor = "Top, Bottom, Left, Right"
    $buttonArea.AutoScroll = $true
    $buttonArea.BackColor = $script:Bg
    $layerPage.Controls.Add($buttonArea)

    $columns = 3
    $buttonWidth = 195
    $buttonHeight = 52
    $horizontalGap = 15
    $verticalGap = 14

    for ($j = 1; $j -le $count; $j++) {
        $index = $j - 1
        $col = $index % $columns
        $row = [int][Math]::Floor($index / $columns)
        $x = 5 + ($col * ($buttonWidth + $horizontalGap))
        $y = 5 + ($row * ($buttonHeight + $verticalGap))

        $subText = "Option $j"
        if ($script:SubButtonNames.ContainsKey($Number)) {
            $names = $script:SubButtonNames[$Number]
            if ($j -le $names.Count) { $subText = $names[$j - 1] }
        }

        $subButton = New-AppButton $subText $x $y $buttonWidth $buttonHeight
        $subButton.Tag = [PSCustomObject]@{ Main = $Number; Sub = $j }
        $subButton.Add_Click({
            $mainNumber = [int]$this.Tag.Main
            $subNumber = [int]$this.Tag.Sub
            Show-InfoLayer -MainNumber $mainNumber -SubNumber $subNumber
        })
        $buttonArea.Controls.Add($subButton)
    }
}

function Show-InfoLayer {
    param([int]$MainNumber, [int]$SubNumber)

    $script:CurrentLayer = "Info"
    $homePage.Visible = $false
    $toolsPage.Visible = $false
    $layerPage.Visible = $true
    $layerPage.Controls.Clear()

    $mainName = $script:MainButtonNames[$MainNumber - 1]
    $subName = "Option $SubNumber"
    if ($script:SubButtonNames.ContainsKey($MainNumber)) {
        $names = $script:SubButtonNames[$MainNumber]
        if ($SubNumber -le $names.Count) { $subName = $names[$SubNumber - 1] }
    }

    $heading.Text = $mainName
    $subtitle.Text = "ScreenshareInfo / $mainName / $subName"

    $backButton = New-AppButton "< Back to $mainName" 30 12 220 38
    $backButton.Tag = $MainNumber
    $backButton.Add_Click({
        $mainNumber = [int]$this.Tag
        Show-MainButtonLayer -Number $mainNumber
    })
    $layerPage.Controls.Add($backButton)

    $infoTitle = New-Object System.Windows.Forms.Label
    $infoTitle.Text = "$subName"
    $infoTitle.Location = New-Object System.Drawing.Point(30, 70)
    $infoTitle.Size = New-Object System.Drawing.Size(650, 38)
    $infoTitle.Font = New-Object System.Drawing.Font("Segoe UI", 19, [System.Drawing.FontStyle]::Bold)
    $infoTitle.ForeColor = $script:Cyan
    $layerPage.Controls.Add($infoTitle)

    $pathLabel = New-Object System.Windows.Forms.Label
    $pathLabel.Text = "$mainName  >  $subName"
    $pathLabel.Location = New-Object System.Drawing.Point(33, 115)
    $pathLabel.Size = New-Object System.Drawing.Size(650, 28)
    $pathLabel.Font = New-Object System.Drawing.Font("Segoe UI", 11)
    $pathLabel.ForeColor = $script:Blue
    $layerPage.Controls.Add($pathLabel)

    $infoPanel = New-Object System.Windows.Forms.Panel
    $infoPanel.Location = New-Object System.Drawing.Point(30, 160)
    $infoPanel.Size = New-Object System.Drawing.Size(690, 280)
    $infoPanel.Anchor = "Top, Bottom, Left, Right"
    $infoPanel.BackColor = $script:PanelBg
    $layerPage.Controls.Add($infoPanel)

    $infoAccent = New-Object System.Windows.Forms.Panel
    $infoAccent.Location = New-Object System.Drawing.Point(0, 0)
    $infoAccent.Size = New-Object System.Drawing.Size(4, 280)
    $infoAccent.BackColor = $script:Cyan
    $infoPanel.Controls.Add($infoAccent)

    $infoText = New-Object System.Windows.Forms.TextBox
    $infoText.Location = New-Object System.Drawing.Point(20, 20)
    $infoText.Size = New-Object System.Drawing.Size(640, 235)
    $infoText.Anchor = "Top, Bottom, Left, Right"
    $infoText.Multiline = $true
    $infoText.ReadOnly = $true
    $infoText.ScrollBars = "Vertical"
    $infoText.BorderStyle = "None"
    $infoText.BackColor = $script:PanelBg
    $infoText.ForeColor = [System.Drawing.Color]::White
    $infoText.Font = New-Object System.Drawing.Font("Consolas", 12)

    $key = "$MainNumber-$SubNumber"
    if ($script:InfoContent.ContainsKey($key)) {
        $info = $script:InfoContent[$key]
        if ($info.Title) { $infoTitle.Text = $info.Title }
        $infoText.Text = $info.Text
    } else {
        $infoText.Text = "No information has been added for this option yet.`r`n`r`nSelected section: $mainName`r`nSelected option: $subName`r`n`r`nTo customize this page, add an entry to `$script:InfoContent near the top of the script."
    }
    $infoPanel.Controls.Add($infoText)
}

# =========================
# TOOLS PAGE - 9 MAIN BUTTONS
# =========================
$toolsCard = New-Object System.Windows.Forms.Panel
$toolsCard.Location = New-Object System.Drawing.Point(30, 20)
$toolsCard.Size = New-Object System.Drawing.Size(690, 370)
$toolsCard.Anchor = "Top, Left, Right"
$toolsCard.BackColor = $script:PanelBg
$toolsPage.Controls.Add($toolsCard)

$toolsTitle = New-Object System.Windows.Forms.Label
$toolsTitle.Text = "YOUR TOOLS"
$toolsTitle.Location = New-Object System.Drawing.Point(22, 18)
$toolsTitle.Size = New-Object System.Drawing.Size(400, 30)
$toolsTitle.Font = New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)
$toolsTitle.ForeColor = $script:Cyan
$toolsCard.Controls.Add($toolsTitle)

$toolsSubtitle = New-Object System.Windows.Forms.Label
$toolsSubtitle.Text = "Select a button to open its options."
$toolsSubtitle.Location = New-Object System.Drawing.Point(24, 50)
$toolsSubtitle.Size = New-Object System.Drawing.Size(600, 24)
$toolsSubtitle.ForeColor = $script:Muted
$toolsCard.Controls.Add($toolsSubtitle)

for ($i = 1; $i -le 9; $i++) {
    $index = $i - 1
    $col = $index % 3
    $row = [int][Math]::Floor($index / 3)
    $x = 22 + ($col * 215)
    $y = 95 + ($row * 78)

    $btn = New-AppButton $script:MainButtonNames[$index] $x $y 195 55
    $btn.Tag = $i
    $btn.Add_Click({
        $number = [int]$this.Tag
        Show-MainButtonLayer -Number $number
    })
    $toolsCard.Controls.Add($btn)
}

# Navigation events
$navHome.Add_Click({ Show-HomePage })
$navTools.Add_Click({ Show-ToolsPage })

# =========================
# ANIMATION + CLOCK
# =========================
$clock.Text = Get-Date -Format "dddd, dd MMMM yyyy  HH:mm:ss"
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 80
$timer.Add_Tick({
    $script:Phase += 0.08
    if ($script:Phase -gt 6.28) { $script:Phase = 0 }
    $logo.Invalidate()
    $intensity = [int](150 + 105 * [Math]::Abs([Math]::Sin($script:Phase)))
    $accent.BackColor = [System.Drawing.Color]::FromArgb(0, $intensity, 255)
    $clock.Text = Get-Date -Format "dddd, dd MMMM yyyy  HH:mm:ss"
})

$form.Add_Shown({
    $timer.Start()
    Show-HomePage
})
$form.Add_FormClosed({
    $timer.Stop()
    $timer.Dispose()
})

[void]$form.ShowDialog()
