#!/usr/bin/env bash

# this will acquire the real PPI/DPI of the preferred/native mode of your monitors
# the DPI reported by `xdpyinfo` is not the real DPI, but your virtual DPI
# that may have been automatically calculated from the EDID information
# or manually set previously
# works in ZSH too
# requires xrandr, perl and bc
# in bc, only division respects scale, so we have to force a useless division

real-ppi () {
    
    while read -r display width_dimension_mm height_dimension_mm width_resolution height_resolution; do
    
        width_dimension_in="$(bc <<< "scale=6; ($width_dimension_mm * 0.039370079)/1")"
        height_dimension_in="$(bc <<< "scale=6; ($height_dimension_mm * 0.039370079)/1")"
    
        width_ppi="$(bc <<< "scale=6; $width_resolution / $width_dimension_in")"
        height_ppi="$(bc <<< "scale=6; $height_resolution / $height_dimension_in")"
    
        echo "$display $(printf "%.0f" "$width_ppi") $(printf "%.0f" "$height_ppi")"
        
    done < <(xrandr --query | perl -e 'undef $/; $s = <>; while ($s =~ 
        /
            ^                              # start of the a line
            [[:space:]\t]*
            ([^\s]+)                       # capture the name of the display device
            [[:space:]\t]+
            \bconnected\b                  # must be connected display device
            .*?
            (\d+)mm                        # capture the width dimension
            [[:space:]\t]*x[[:space:]\t]*
            (\d+)mm                        # capture the height dimension
            .*\n
            (?:                            # iterate through all the non-preferred modes for the display device
                ^[[:space:]\t]+
                [^+\n]+                    # any mode without a literal + is a non-preferred mode
                \n
            )*
            ^[[:space:]\t]+                # now capture the preferred mode
            (\d+)                          # capture the preferred resolution width
            [[:space:]\t]*x[[:space:]\t]*
            (\d+)                          # capture the preferred resolution height
            .*?
            \+                             # preferred mode has a literal +
            .*$
        /gmx
    ) {
        print "$1 $2 $3 $4 $5\n";
    }')
    
}

real-ppi
# or call it with `export DISPLAY=':0'; real-ppi`
