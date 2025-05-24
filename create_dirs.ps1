$modules = @(
    "settings",
    "notifications",
    "case_management",
    "publish_case",
    "consultation",
    "direct_case_request",
    "onboarding"
)

foreach ($module in $modules) {
    $dirs = @(
        "bindings",
        "controllers",
        "views",
        "widgets"
    )
    
    foreach ($dir in $dirs) {
        $path = "lib\app\modules\$module\$dir"
        if (-not (Test-Path $path)) {
            New-Item -ItemType Directory -Path $path -Force
            Write-Host "Created directory: $path"
        }
    }
} 