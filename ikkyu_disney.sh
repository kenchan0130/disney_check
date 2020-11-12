#!/bin/bash

FROM_DATE="${1}"
TO_DATE=$((FROM_DATE + 1))

echo "Seaching ${FROM_DATE} - ${TO_DATE}..."

RESPONSE=$(curl -sfL "https://www.ikyu.com/ap/SearchRoomsApiHandler.ashx?adc=1&aid=00001563&cid=${FROM_DATE}&cod=${TO_DATE}&discsort=0&ipb=0&lc=1&ppc=2&rc=1&si=1&st=1&vc=999" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36')
EXIST=$(echo "${RESPONSE}" | jq ".AcmList[0].RmList[] | select(.RemainingRmCnt > 0)")

if [[ "${EXIST}" ]];then
    curl -X POST --data-urlencode "payload={\"channel\": \"#notification\", \"username\": \"disney checker\", \"text\": \"${FROM_DATE}の部屋が見つかったよ https://www.ikyu.com/00001563\", \"icon_emoji\": \":bot:\"}" "${SLACK_WEBHOOK_URL}"
fi
