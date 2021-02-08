#!/bin/bash

dateParam="${1}"
declare -a dateList=();
dateList=${dateParam//,/ };

response=$(curl -sLf 'https://www.tokyodisneyresort.jp/ticket/sales_status.html' \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: max-age=0' \
  -H 'sec-ch-ua: "Chromium";v="86", "\"Not\\A;Brand";v="99", "Google Chrome";v="86"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: cross-site' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://www.google.com/' \
  -H 'Accept-Language: ja' \
  -H 'Cookie: SOGASYNC=%7B%22UA-56274140-1%22%3A1605191782624%2C%22UA-145584964-1%22%3A1605191889849%7D; bm_sz=B28F05EF04E04A54A3668A2533FD4FAC~YAAQ5UZKaAvO1qR1AQAA8svivAnas1LApMOz/NpyzG7dhopFdFMwpKR7m9MEQIQ1JZ+lE/pcA+yNBlhGbifHEqKOEQMpUJCZ4CvgllaX0apnlIeseNaE9fTR5X7Tg4/BHqlmiTkkygSkQHyo5YF79ldxD0q0GbYq+eg1z5h9z/UBHZjxdtO0wusvJUvG+fJ2hJWd7ZO2wPX62Q==; _abck=F89B8EB9D0BC5869A891FD659B187258~0~YAAQ5UZKaBPO1qR1AQAAYM/ivASsaypHD8WLYFj+mEMBmGl7bthIcEr+WEueA6mqUS+gQhH8MWmlo48AwiPkrRZxjPIcvZoVbUmpQ/c+HXnXollJ7x4UyKITkKBBGnEdfEy4yDZ8EbvLeA3NPPqOWt8ewDHdeRMPr3jY8OPn6YMzpvmzQmL50JdKUW6e3FNWadgpUtyb1PtgFPkHL8AEuKot/YQ6yXccFrKtZ415Mi0tExbOBc2djtcsHzrMw6wro0rHP225LGoB9vNIRbmu85WKlKaSjQXqBXnuw9ELv+zgqkOu2Xuj/hZnuKenhm6+bpzAt1p+lMpaE+825pVIoXRdGg1N66+Jeg8gimZuJBA=~-1~||-1||~-1; _gcl_au=1.1.1023481637.1605191782; _ts_yjad=1605191782433; _ga=GA1.2.1876998547.1605191782; _gid=GA1.2.1395910150.1605191782; __pp_uid=zRL41Qg2mebvmYkjZ4BqtlA3WgVQBSVT; ak_bmsc=E972311C21CC6503CE2FB01AC65A8508684A46E5E87500006548AD5F03B24E68~plfIYx4v6A971W06lRJtKm5SDbyB5ZkOAfC5vw9WefD6gL7/Eyrprzd1hzUvMgm8l+t82yZOqyUuHfxw5wE168YCskhRF/FbJyOLccn5XxbB2tPbhCo/PQ5BR3oiVDo729Pv5dCWsDjO4gHW4GQ97gHoFxrM6nXxcXJJD8N6ePViiRWGZYivcacnmrHOgf22bGyfMCCd5M+imnf6uqwpWKlSdsgOUiVffx7nXI5LUvy4Bryyrr+MK/8IROqhnQIfvo; _fbp=fb.1.1605191782671.1617622894; __td_signed=true; _tdim=88b3b1db-f27c-43b4-df1a-6aa762a34e86; _im_ses.1002516=1; snexid=5edab013-bcfb-4202-b021-b20695a9c8ac; __zlcmid=118ja1sftVAz3C0; bm_sv=B4760B4CD2342BCE1404769CFDEC7FCD~yfLfDa/E32XOqevZ6XdOJVmHGvIHFiRmS7T6cHe84Y5LL8CxXp9jKjVhdwDBjhSX8uSDHF0+78LjwDkcQAc1pCZm/plWEFJe3N5Nb/kFKgz20OnMTDy85Vw2upi3adyAFYZ9j8FtnghlBfxyXhlbhJ5adeEXRJbcweaDYGzU79w=; _dc_gtm_UA-56274140-1=1; _td=11dd1ddb-d894-42ab-bb42-cc5aaff922da; _dc_gtm_UA-145584964-1=1; _im_id.1002516=4c2d73e54d78cd57.1605191783.1.1605192166.1605191783.' \
  --compressed)

result=""
for d in ${dateList[@]};do
  echo "Check ${d}..."
  isActiveTDS=$( echo "${response}" | perl -ne '/ticketDayDetails = (.+?);/&&print"$1"' | jq ".[] | select(.date == \"${d}\") | .tds" )
  isActiveTDL=$( echo "${response}" | perl -ne '/ticketDayDetails = (.+?);/&&print"$1"' | jq ".[] | select(.date == \"${d}\") | .tdl" )
  if [[ "${isActiveTDS}" == "null" ]] && [[ "${isActiveTDL}" == "null" ]];then
    echo "Not active date, skip ${d}..."
    continue
  fi

  if [[ "${isActiveTDS}" != "null" ]];then
    v=$( echo "${response}" | perl -ne '/ticketDayDetails = (.+?);/&&print"$1"' | jq ".[] | select(.date == \"${d}\") | select(.tds[0].ticket_class != \"is-close\" and .tds[0].ticket_class != \"is-none\")" )
  fi

  if [[ "${isActiveTDL}" != "null" ]];then
    v=$( echo "${response}" | perl -ne '/ticketDayDetails = (.+?);/&&print"$1"' | jq ".[] | select(.date == \"${d}\") | select(.tdl[0].ticket_class != \"is-close\" and .tdl[0].ticket_class != \"is-none\")" )
  fi

  if [[ ! "${v}" ]];then
    echo "Not found ticket, skip ${d}..."
    continue
  fi

  echo "Exist ticket of ${d}!!"

  if [[ "${result}" ]];then
    result="${result},${v}"
  else
    result="${v}"
  fi
done

if [[ "${result}" ]];then
  d=$( echo "[${result}]" | jq -r '.[] | .date' | sort | xargs -I{} echo "<https://reserve.tokyodisneyresort.jp/ticket/search/?outside=1&route=1&useDays=1&useDateFrom={}&parkTicketSalesForm=1|{}>" )

  curl -X POST --data-urlencode "payload={\"channel\": \"#notification\", \"username\": \"disney checker\", \"text\": \"${d}\nチケットが見つかったよ https://www.tokyodisneyresort.jp/ticket/sales_status.html\", \"icon_emoji\": \":bot:\"}" "${SLACK_WEBHOOK_URL}"
fi
