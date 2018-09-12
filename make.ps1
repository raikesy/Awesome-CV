# This script aims to replicate the functionality of the CircleCI build natively in Windows
# It assumes a working Miktex and Perl installation
# It will compile each root tex file in src/
# The tricky part will be extracting the PDFs while still ensuring we don't break latexmks intelligent builds

# nonstopmode vs batchmode
# This script is just for local build so we can always look at the log files to inspect for errors
# and we don't really want pages and pages of crap in stdout, so we want batchmode 
# file-line-error
# Let's leave it out for now, errors stick out more without it

# Note that latexmk -c requires pointing to the right tex file and outdir otherwise it won't work

function lmk ($cleanFlag) {
    try {
        Push-Location
        Set-Location "src"
        # At some point let's get auxdir working, k?
        Invoke-Expression "latexmk -pdfxe -outdir=out -quiet $cleanFlag"
    }
    finally {
        Pop-Location
    }
}

# Copies out compiled PDFs, skipping when not needed
function extract () {
    # Get-ChildItem src/out/*.pdf | ForEach-Object {if (-not (test-path ./$($_.Name) -or )) {echo "Copy $_"}}
    $outPDFs = Get-ChildItem src/out/*.pdf
    foreach ($outPDF in $outPDFs) {
        # If there is no extracted PDF or an older extracted pdf copy it
        $pdfName = $outPDF.Name
        if (-not (Test-Path ./$pdfName) -or $outPDF.LastWriteTime -lt {Get-Item ./$pdfName}.LastWriteTime) {
            Copy-Item -Force $outPDF .
        }
    }
}

# Passes through an argument to latexmk, but only if there's one so we can't go too crazy
if ($args.Length -eq 0) {
    lmk ""
}
elseif ($args.Length -eq 1) {
    $arg = $args[0]
    if ($arg -like "c") {
        lmk "-C"
    }
    elseif ($arg -like "e") {
        # Copy-Item src/out/*.pdf .
        extract
    }
}
