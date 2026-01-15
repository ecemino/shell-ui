#!/bin/bash

MUSIC_DIR="/home/beyza/Müzik"
PLAYER_PID=""
CURRENT=0

mapfile -t PLAYLIST < <(ls "$MUSIC_DIR"/*.mp3 2>/dev/null)

if [ ${#PLAYLIST[@]} -eq 0 ]; then
    whiptail --msgbox "Müzik klasöründe mp3 bulunamadı!" 10 50
    exit 1
fi

play_song() {
    stop_song
    mpg123 "${PLAYLIST[$CURRENT]}" >/dev/null 2>&1 &
    PLAYER_PID=$!
}

stop_song() {
    if [[ -n "$PLAYER_PID" ]]; then
        kill "$PLAYER_PID" 2>/dev/null
        PLAYER_PID=""
    fi
}

jump_seconds() {
    local sec=$1
    stop_song
    mpg123 -k $((sec * 38)) "${PLAYLIST[$CURRENT]}" >/dev/null 2>&1 &
    PLAYER_PID=$!
}

while true; do
    SONG_NAME=$(basename "${PLAYLIST[$CURRENT]}")

    CHOICE=$(whiptail --title "MP3 Çalar" --menu \
    "Şu anki parça:\n$SONG_NAME" 20 60 8 \
    "1" "▶ Oynat" \
    "2" "⏹ Durdur" \
    "3" "⏭ Sonraki" \
    "4" "⏮ Önceki" \
    "5" "⏩ +5 saniye" \
    "6" "⏪ -5 saniye" \
    "7" "❌ Çıkış" \
    3>&1 1>&2 2>&3)

    case $CHOICE in
        1)
            play_song
            ;;
        2)
            stop_song
            ;;
        3)
            ((CURRENT++))
            [[ $CURRENT -ge ${#PLAYLIST[@]} ]] && CURRENT=0
            play_song
            ;;
        4)
            ((CURRENT--))
            [[ $CURRENT -lt 0 ]] && CURRENT=$((${#PLAYLIST[@]} - 1))
            play_song
            ;;
        5)
            jump_seconds 5
            ;;
        6)
            jump_seconds -5
            ;;
        7)
            stop_song
            exit 0
            ;;
    esac
done
