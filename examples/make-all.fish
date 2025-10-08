#!/usr/bin/env fish
for file in *.typ
    set name (basename $file .typ)
    echo $name
    for theme in light dark
        typst compile $file $name-$theme.svg --root .. --input theme=$theme
    end
end

rm example-setup-*.svg
