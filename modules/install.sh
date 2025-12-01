function install_program() {
    echo "--- [7] 프로그램 설치 (단축 명령어 등록) ---"
    
    CURRENT_SCRIPT=$(realpath "$0")
    
    CMD_NAME="diary"
    
    if [[ "$SHELL" == *"zsh"* ]]; then
        RC_FILE="$HOME/.zshrc"
        MY_SHELL="zsh"
    else
        RC_FILE="$HOME/.bashrc"
        MY_SHELL="bash"
    fi
    
    echo "[!] 감지된 쉘: $MY_SHELL ($RC_FILE)"

    if grep -q "alias $CMD_NAME=" "$RC_FILE"; then
        echo "⚠️ 이미 '$CMD_NAME' 명령어가 등록되어 있습니다."
    else
        echo "" >> "$RC_FILE"
        echo "# Secret Database Diary Shortcut" >> "$RC_FILE"
        echo "alias $CMD_NAME='\"$CURRENT_SCRIPT\"'" >> "$RC_FILE"
        echo "[성공] 설정 파일에 등록되었습니다: $CMD_NAME"
    fi
    
    print_line
    echo "⚠️ 설정을 즉시 적용하려면 쉘(터미널)을 새로고침 해야 합니다."
    echo "   (주의: 프로그램이 즉시 종료되고 터미널이 리셋됩니다.)"
    echo -n "   지금 적용하시겠습니까? (y/n): "
    read answer

    if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
        echo "[!] 쉘을 다시 로드합니다..."
        exec "$MY_SHELL"
    else
        echo "[!] 적용을 취소했습니다. 나중에 터미널을 껐다 켜거나 'source $RC_FILE'을 입력하세요."
    fi
}