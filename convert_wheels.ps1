<#
.SYNOPSIS
    Converts shared-wheel GIF animations to PNG sprite sheets for the WheelOfFortune mod.
.DESCRIPTION
    Reads .gif files from an input folder, composites their frames, scales them to the
    standard frame size, and writes a PNG sprite sheet to the assets folder.
    Also updates the ANIM_META table in ui/spin_animation.lua to match new frame counts.
.PARAMETER InputDir
    Folder containing the source .gif files. Defaults to .\input (auto-created if absent).
.PARAMETER OutputDir
    Folder to write the PNG sprite sheets. Defaults to .\assets.
.PARAMETER AnimFile
    Path to spin_animation.lua. Defaults to .\ui\spin_animation.lua.
.PARAMETER FrameSize
    Pixel size per frame (square). Defaults to 240.
.PARAMETER Cols
    Number of columns in the sprite sheet grid. Defaults to 10.
.PARAMETER Spf
    Seconds per frame written into ANIM_META for new animations. Defaults to 0.04.
.EXAMPLE
    .\convert_wheels.ps1
.EXAMPLE
    .\convert_wheels.ps1 -InputDir "C:\Downloads\new_wheels"
#>
param(
    [string]$InputDir  = (Join-Path $PSScriptRoot "input"),
    [string]$OutputDir = (Join-Path $PSScriptRoot "assets"),
    [string]$AnimFile  = (Join-Path $PSScriptRoot "ui\spin_animation.lua"),
    [int]$FrameSize    = 240,
    [int]$Cols         = 10,
    [double]$Spf       = 0.04
)

Add-Type -AssemblyName System.Drawing

# ---------------------------------------------------------------------------
# Name mapping: GIF base name (after stripping leading NN_ prefix)
# -> PNG target name used in assets/ and ANIM_META.
# Add new entries here when adding new shared effect wheels.
# ---------------------------------------------------------------------------
$NAME_MAP = @{
    "shop_taxes"         = "shop_taxes"
    "blinds"             = "blinds"
    "wrong_loyalty"      = "wrong_loyalty"
    "boss_interference"  = "boss_interference"
    "find_me"            = "find_me"
    "vampire_dream"      = "vampire_dream"
    "lucky_day"          = "lucky_day"
    "royal_glass"        = "royal_glass"
    "resource_drain"     = "resource_drain"
    "groundhog_day"      = "groundhog_day"
    "blissful_ignorance" = "blissful_ignorance"
    "random_morph"       = "random_morph"
    "evolution"          = "evolution"
    "overflow"           = "overflow"
    "joker_ov6rf7ow"     = "overflow"    # leet-speak alias from original source files
    "haha"               = "haha"
    "joker_haha"         = "haha"
}

# ---------------------------------------------------------------------------
# Convert a single GIF to a PNG sprite sheet.
# Returns @{ frames; cols; rows }
# ---------------------------------------------------------------------------
function Convert-WheelGif {
    param(
        [string]$GifPath,
        [string]$PngPath,
        [int]$FrameSize,
        [int]$Cols
    )

    $gif = [System.Drawing.Image]::FromFile($GifPath)
    $dim = [System.Drawing.Imaging.FrameDimension]::Time
    [int]$frameCount = $gif.GetFrameCount($dim)
    [int]$gifW = $gif.Width
    [int]$gifH = $gif.Height

    [int]$rows   = [Math]::Ceiling([double]$frameCount / [double]$Cols)
    [int]$sheetW = $Cols * $FrameSize
    [int]$sheetH = $rows * $FrameSize

    $sheet = New-Object System.Drawing.Bitmap($sheetW, $sheetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $sg = [System.Drawing.Graphics]::FromImage($sheet)
    $sg.Clear([System.Drawing.Color]::Transparent)
    $sg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $sg.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $sg.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    # Compositing canvas accumulates frame content to handle GIF transparency/delta frames.
    $canvas = New-Object System.Drawing.Bitmap($gifW, $gifH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $cg = [System.Drawing.Graphics]::FromImage($canvas)
    $cg.Clear([System.Drawing.Color]::Transparent)

    for ($i = 0; $i -lt $frameCount; $i++) {
        $gif.SelectActiveFrame($dim, $i) | Out-Null
        $cg.DrawImage($gif, [int]0, [int]0, $gifW, $gifH)

        [int]$col = $i % $Cols
        [int]$row = [Math]::Floor([double]$i / [double]$Cols)
        [int]$dx  = $col * $FrameSize
        [int]$dy  = $row * $FrameSize
        $sg.DrawImage($canvas, $dx, $dy, $FrameSize, $FrameSize)
    }

    $cg.Dispose(); $canvas.Dispose(); $sg.Dispose()
    $sheet.Save($PngPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $sheet.Dispose(); $gif.Dispose()

    return @{ frames = $frameCount; cols = $Cols; rows = $rows }
}

# ---------------------------------------------------------------------------
# Update a single key in the ANIM_META table in spin_animation.lua.
# Returns $true if the key was found and replaced.
# ---------------------------------------------------------------------------
function Update-AnimMeta {
    param(
        [string]$LuaPath,
        [string]$Key,
        [int]$Frames,
        [int]$Cols,
        [int]$Rows,
        [double]$Spf
    )

    $content = [System.IO.File]::ReadAllText($LuaPath)

    # Keys are padded to 18 chars for column alignment (longest key: blissful_ignorance).
    $paddedKey    = $Key.PadRight(18)
    $paddedFrames = $Frames.ToString().PadRight(3)
    $paddedRows   = $Rows.ToString().PadRight(2)
    $spfStr       = $Spf.ToString("0.00", [System.Globalization.CultureInfo]::InvariantCulture)
    $newLine      = "`t${paddedKey}= { frames = ${paddedFrames}, cols = ${Cols}, rows = ${paddedRows}, spf = ${spfStr} },"

    # Match the existing ANIM_META line for this key regardless of its current values.
    $pattern = "(?m)`t" + [regex]::Escape($Key) + "\s*=\s*\{[^}]+\},"

    if ($content -notmatch $pattern) { return $false }

    $content = $content -replace $pattern, $newLine
    [System.IO.File]::WriteAllText($LuaPath, $content, (New-Object System.Text.UTF8Encoding $false))
    return $true
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
if (-not (Test-Path $InputDir)) {
    New-Item -ItemType Directory -Path $InputDir | Out-Null
    Write-Host "Created input folder: $InputDir" -ForegroundColor Yellow
    Write-Host "Place your .gif wheel files there and re-run the script."
    exit 0
}

if (-not (Test-Path $OutputDir)) {
    Write-Error "Output directory not found: $OutputDir"
    exit 1
}

$gifs = Get-ChildItem $InputDir -Filter "*.gif" | Sort-Object Name
if (-not $gifs) {
    Write-Warning "No .gif files found in: $InputDir"
    exit 0
}

$converted = 0
$skipped   = 0

foreach ($gif in $gifs) {
    # Strip leading numeric prefix (e.g. "02_", "15_") then look up the PNG name.
    $baseName = $gif.BaseName -replace '^\d+_', ''

    $pngName = $NAME_MAP[$baseName]
    if (-not $pngName) {
        Write-Warning "No mapping for '$baseName' (from '$($gif.Name)') - skipping. Add it to the NAME_MAP table if needed."
        $skipped++
        continue
    }

    $pngPath = Join-Path $OutputDir "$pngName.png"
    Write-Host "  $($gif.Name)  ->  $pngName.png" -ForegroundColor Cyan

    $meta = Convert-WheelGif -GifPath $gif.FullName -PngPath $pngPath `
        -FrameSize $FrameSize -Cols $Cols

    $luaStatus = "ANIM_META: key not found"
    if (Test-Path $AnimFile) {
        $ok = Update-AnimMeta -LuaPath $AnimFile -Key $pngName `
            -Frames $meta.frames -Cols $meta.cols -Rows $meta.rows -Spf $Spf
        $luaStatus = if ($ok) { "ANIM_META updated" } else { "ANIM_META: key not found" }
    }

    Write-Host "    $($meta.frames) frames  $($meta.cols)x$($meta.rows) grid  ${FrameSize}px/frame  $luaStatus" -ForegroundColor Green
    $converted++
}

Write-Host ""
Write-Host "Done: $converted converted, $skipped skipped." -ForegroundColor Yellow
