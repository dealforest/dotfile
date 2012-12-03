# -*- sh -*-

source ~/.zsh.d/package.zsh

# cdd

source $(package-directory cdd)
function chpwd() {
    _reg_pwd_screennum
}

# autojump

package-install github joelthelion/autojump
source $(package-directory joelthelion/autojump)/bin/autojump.zsh
