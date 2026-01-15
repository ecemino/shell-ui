#!/bin/bash

MUSIC_DIR="muzikler/"
PLAYER_PID=""
CURRENT=0

mapfile -t PLAYLIST < <(ls "$MUSIC_DIR"/*.mp3 2>/dev/null)

if [ ${#PLAYLIST[@]} -eq 0 ]; then
    yad --error --text="Müzik klasöründe mp3 bulunamadı!"
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

    yad --title="MP3 Çalar (GUI)" \
        --width=500 --height=260 \
        --center \
        --text="🎵 Şu anki parça:\n<b>$SONG_NAME</b>" \
        --button="▶ Oynat:1" \
        --button="⏹ Durdur:2" \
        --button="⏭ Sonraki:3" \
        --button="⏮ Önceki:4" \
        --button="⏩ +5 sn:5" \
        --button="⏪ -5 sn:6" \
        --button="❌ Çıkış:7"

    RET=$?

    case $RET in
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
