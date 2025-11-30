#!/bin/bash

# ==========================================
# [Main] 환경 설정 및 초기화
# ==========================================
# 전역 변수로 설정하여 모듈에서도 접근 가능하도록 export 합니다.
export DIARY_DIR="$HOME/.my_diary"

# 디렉터리가 없으면 생성하고 Git을 초기화합니다.
if [ ! -d "$DIARY_DIR" ]; then
    mkdir -p "$DIARY_DIR"
    cd "$DIARY_DIR"
    git init > /dev/null
    echo "📂 초기 설정 완료: $DIARY_DIR"
fi

# ==========================================
# [Main] 모듈 로더 함수
# ==========================================
# 기능별 스크립트가 존재하면 source로 불러오고 함수를 실행합니다.
run_module() {
    local script_name="$1"
    local func_name="$2"

    if [ -f "./$script_name" ]; then
        source "./$script_name"
        $func_name
    else
        echo "⚠️  해당 기능 모듈($script_name)이 현재 브랜치/디렉터리에 없습니다."
        echo "    (기능이 아직 구현되지 않았거나 파일이 누락되었습니다.)"
    fi
}

# ==========================================
# [Main] 메인 실행 루프
# ==========================================
while true; do
    echo ""
    echo "=============================="
    echo "   🐧 BASH SECRET DIARY"
    echo "=============================="
    echo "0. ⚙️  GitHub 설정"
    echo "1. 작성 (Write)"
    echo "2. 조회 (Read)"
    echo "3. 수정 (Modify)"
    echo "4. 삭제 (Delete)"
    echo "5. 백업 (Push)"
    echo "6. 동기화 (Pull)"
    echo "8. 종료 (Exit)"
    echo -n "선택 >> "
    read choice

    case $choice in
        0) run_module "func_github.sh" "setup_github" ;;
        1) run_module "func_write.sh" "write_diary" ;;
        2) run_module "func_read.sh" "read_diary" ;;
        3) run_module "func_modify.sh" "modify_diary" ;;
        4) run_module "func_delete.sh" "delete_diary" ;;
        5) run_module "func_backup.sh" "perform_backup" ;;
        6) run_module "func_sync.sh" "synchronize_diary" ;;
        8) echo "프로그램을 종료합니다."; break ;;
        *) echo "잘못된 입력입니다." ;;
    esac
done