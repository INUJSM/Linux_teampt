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
    return
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
