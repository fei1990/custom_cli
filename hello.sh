#!/usr/bin/env bash

set -e
echo "$HOME"
MOFANG_CLI_HOME=$HOME/.mofang-cli
rm -rf $MOFANG_CLI_HOME
mkdir -p $MOFANG_CLI_HOME
git -C $MOFANG_CLI_HOME clone git@code.sohuno.com:MOBILE-BASIC/mofang-executable.git
MOFANG_CLI_PATH=$MOFANG_CLI_HOME/mofang-executable
add_mofang_to_path() {
    rc_files=("$HOME/.bashrc" "$HOME/.zshrc")
    for rc_file in ${rc_files[@]}; do
        if [ -e "$rc_file" ]; then
            found_rc_file=true
            echo "Updating $rc_file"
            if grep -qF "export PATH=\"${MOFANG_CLI_PATH}/mofang-cli:\$PATH\"" "$rc_file"; then
                echo ""
            else
                echo "export PATH=\"${MOFANG_CLI_PATH}/mofang-cli:\$PATH\"" >>$rc_file
            fi
        fi
    done
    if [ ! $found_rc_file ]; then
        echo "Unable to determine shell type. Please add mofang to your PATH manually."
        echo "export PATH=\"${MOFANG_CLI_PATH}/mofang-cli:\$PATH\""
    fi
}
add_mofang_to_path
source $HOME/.bashrc
source $HOME/.zshrc
echo "🎉🎉🎉 mofang-cli has been installed!"
echo "✨✨✨Close and reopen your terminal to start using mofang-cli✨✨✨"
