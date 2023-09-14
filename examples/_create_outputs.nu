#!/usr/bin/env nu
# nushell script to create all outputs of the .typ documents in pdf and png

let source_files = (ls *.typ | get name)
print $'(ansi bo)found following typst files:(ansi reset) ($source_files | str join ", ")'

def compile_typst [file, --png] {
    let run_result = (if $png {
        let file_without_ext = ($file | str replace '(.*).typ' '$1')
        do { typst c $file $'($file_without_ext)_page{n}.png' --root .. }
    } else {
        do { typst c $file --root .. }
    } | complete)
    if $run_result.exit_code == 0 {
        if $png {
            print $"- Compiled `($file)` to png\(s\)"
        } else {
            print $"- Compiled `($file)` to pdf"
        }
    } else {
        print $"- (ansi red) Got error while compiling `($file):`(ansi reset)"
        print $run_result.stderr
    }
}

for file in $source_files {
    compile_typst $file
    compile_typst $file --png
}

print $'(ansi bo)Done!'