try {
    Push-Location
    Set-Location "src"
    # At some point let's get auxdir working, k?
    # Invoke-Expression 'latexmk -pdfxe -auxdir=auxfiles -outdir=out -synctex=1 -file-line-error -interaction=nonstopmode'
    Invoke-Expression 'latexmk -pdfxe -outdir=out -synctex=1 -file-line-error -interaction=nonstopmode'
} finally {
    Pop-Location
}

# $TexDir = "src"
# $Cmd = "latexmk"
# # We want an organised folder structure with something like
# # project/
# #   fonts/
# #   images/
# #   src/
# #     tex files only
# #   out/
# # This means we either compile from project and reference ./fonts etc in our tex files
# # or we compile from src/ (with the cd flag) and reference ../fonts etc
# # Compiling with cd means it doesn't matter where our actual working dir is so it should be less brittle
# # Otherwise all our dependency paths need to be written from where we run latexmk, not where the tex file is
# $CmdArgs = "-pdfxe -outdir=out -synctex=1 -file-line-error -interaction=nonstopmode"
# Get-ChildItem (Join-Path $PSScriptRoot $TexDir "*.tex") | ForEach-Object {Invoke-Expression "$cmd $_ $CmdArgs"}
# # iex "$Cmd src/resume.tex $CmdArgs"