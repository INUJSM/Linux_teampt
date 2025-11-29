#!/bin/bash

# ========================================================
# Secret Diary Project (Folder Structure Version)
# Repository: https://github.com/INUJSM/secret_database.git
# ========================================================

# [핵심] 스크립트가 있는 실제 폴더 위치를 변수로 저장
BASE_DIR=$(dirname "$(realpath "$0")")
cd "$BASE_DIR" || exit

# [변경] 일기 데이터를 저장할 하위 폴더 지정
DATA_DIR="data"

# 데이터 폴더가 없으면 생성
if [ ! -d "$DATA_DIR" ]; then
    mkdir -p "$DATA_DIR"
fi

# [자동 이사] 혹시 바깥(루트)에 있는 일기 파일이 있다면 data 폴더로 이동``
mv *.enc "$DATA_DIR" 2>/dev/null

DIARY_EXT=".enc"        # 암호화된 일기 파일 확장자
TEMP_FILE=".temp_edit"  # 수정 시 사용할 임시 파일 (숨김 처리)

# --------------------------------------------------------
# 유틸리티 함수
# --------------------------------------------------------

function print_line() {
    echo "------------------------------------------------------"
}

function show_list() {
    echo " [ 저장된 일기 목록 ]"
    
    # [수정] data 폴더 안의 파일만 조회
    # 파일이 하나도 없으면 ls가 에러를 뱉으므로 2>/dev/null 처리
    count=$(ls "$DATA_DIR"/*${DIARY_EXT} 2>/dev/null | wc -l)
    
    if [ "$count" -eq 0 ]; then
        echo " (저장된 일기가 없습니다)"
        return 1
    fi

    # 경로(data/)를 빼고 파일명만 예쁘게 출력
    ls "$DATA_DIR"/*${DIARY_EXT} | xargs -n 1 basename
    return 0
}

# --------------------------------------------------------
# 핵심 기능 함수
# --------------------------------------------------------

# 0. GitHub 레포지토리 및 토큰 설정
function setup_github() {
    print_line
    echo " >> [0] GitHub 연결 설정 (레포지토리 & 토큰)"
    current_url=$(git remote get-url origin 2>/dev/null)
    
    if [ $? -eq 0 ] && [ -n "$current_url" ]; then
        echo " -------------------------------------------------"
        echo " [!] 이미 연결된 저장소 정보가 감지되었습니다."
        echo " 현재 URL: $current_url"
        echo " -------------------------------------------------"
        echo -n " 기존 설정을 덮어쓰고 새로 설정하시겠습니까? (y/n): "
        read confirm
        
        if [ "$confirm" != "y" ]; then
            echo " [안내] 설정 변경을 취소하고 메뉴로 돌아갑니다."
            return
        fi
        echo ""
    else
        echo " [안내] 현재 연결된 원격 저장소가 없습니다. 설정을 시작합니다."
    fi

    echo " [안내] GitHub 아이디와 토큰(Token)을 입력하면"
    echo "        매번 로그인할 필요 없이 자동 연동됩니다."
    
    echo ""
    echo -n " GitHub 사용자 ID (예: INUJSM): "
    read git_id
    
    echo -n " GitHub Repository 주소 (예: https://github.com/INUJSM/secret_database.git): "
    read git_url
    
    echo -n " Personal Access Token (입력 시 안 보임): "
    read -s git_token
    echo ""
    echo ""

    if [ -z "$git_id" ] || [ -z "$git_url" ] || [ -z "$git_token" ]; then
        echo " [오류] 모든 항목을 입력해야 합니다."
        return
    fi

    clean_url=$(echo "$git_url" | sed 's/https:\/\///')
    auth_url="https://${git_id}:${git_token}@${clean_url}"

    echo " 설정을 변경 중입니다..."
    
    git remote get-url origin &> /dev/null
    if [ $? -eq 0 ]; then
        git remote set-url origin "$auth_url"
    else
        git remote add origin "$auth_url"
    fi

    if [ $? -eq 0 ]; then
        echo " [성공] GitHub 설정이 완료되었습니다!"
        echo " 이제 비밀번호 입력 없이 백업/동기화가 가능합니다."
    else
        echo " [실패] Git 설정 변경에 실패했습니다."
    fi
}

# 1. 일기 쓰기 기능
function write_diary() {
    
}

# 2. 일기 조회 기능
function read_diary() {
    return
}

# 3. 일기 수정 기능
function edit_diary() {
    return
}

# 4. 일기 삭제 기능
function delete_diary() {
    return
}

# 5. 일기 백업 기능
function backup_diary() {
    return
}

# 6. 일기 동기화 기능
function sync_diary() {
    return
}

# 7. 프로그램 설치
function install_program() {
    return
}

# --------------------------------------------------------
# 메인 루프
# --------------------------------------------------------

while true; do
    print_line
    echo "      Secret Database Diary"
    print_line
    echo " 0. GitHub 설정 (토큰/주소 변경)"
    echo " 1. 일기 쓰기"
    echo " 2. 일기 조회"
    echo " 3. 일기 수정"
    echo " 4. 일기 삭제"
    echo " 5. 일기 백업 (Push)"
    echo " 6. 동기화    (Pull)"
    echo " 7. 설치      (명령어 등록)"
    echo " q. 종료"
    print_line
    echo -n " 메뉴 선택: "
    read choice

    case "$choice" in
        0) setup_github ;;
        1) write_diary ;;
        2) read_diary ;;
        3) edit_diary ;;
        4) delete_diary ;;
        5) backup_diary ;;
        6) sync_diary ;;
        7) install_program ;;
        q) echo " 프로그램을 종료합니다."; exit 0 ;;
        *) echo " 잘못된 입력입니다." ;;
    esac
    echo ""
done
