#!/bin/bash

date="${1}"
ignore="${2}"

if [[ ! "${ignore}" ]];then
    ignore="dummy"
fi

url="https://reserve.tokyodisneyresort.jp/sp/restaurant/list/?useDate=${date}&mealDivInform=&adultNum=2&childNum=0&childAgeInform=&restaurantTypeInform=&restaurantNameCd=&wheelchairCount=0&stretcherCount=0&showWay=&reservationStatus=1&beforeUrl=https%3A%2F%2Freserve.tokyodisneyresort.jp%2Fsp%2Frestaurant%2Flist%2F%3FuseDate%3D20201129%26mealDivInform%3D%26adultNum%3D2%26childNum%3D0%26childAgeInform%3D%26restaurantTypeInform%3D%26restaurantNameCd%3D%26wheelchairCount%3D0%26stretcherCount%3D0%26showWay%3D%26reservationStatus%3D1%26wayBack%3D&wayBack="
response=$(curl -sfL --false-start "${url}" \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: max-age=0' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://reserve.tokyodisneyresort.jp/sp/restaurant/search/?pageFromDiv=1&useDate=20201129&mealDivInform=&adultNum=2&childNum=0&childAgeInform=&restaurantTypeInform=&restaurantNameCd=&wheelchairCount=0&stretcherCount=0&freeword=&showWay=&reservationStatus=1' \
  -H 'Accept-Language: ja' \
  -H 'Cookie: SOGASYNC=%7B%22UA-56274140-1%22%3A1605437458766%2C%22UA-56274140-4%22%3A1605437458768%2C%22UA-145584964-1%22%3A1605437458770%7D; JSESSIONID=9C338DB0F0817E5BF4DE814E442390C0-n1; bm_sz=05039B5F88C487495AC8C53DF9A4FAAA~YAAQ7S3AF4CF5L91AQAAxSGHywmZ+74AdsOaeZ8kqBwvZ/cR1+oBCMXeJZaYID0MXAROtoMH4Yt52Kgh+gW3Mhd+KQUcXIy6vGWKhRLUjiDMSD7yz0TeF2dd0Kp6vtESqUHf7M+sR1shp23smhGLeYmIGD6t6Dth+KEBoAnYG4D1Y6UXTm7pIXzvjcTCn7meknXvoStVesvBMA==; _gcl_au=1.1.32494672.1605437433; ak_bmsc=E77F51332446AB09A9B3B520F858C2AC17C02DEDEA660000F807B15F215C6A4A~plvFVZlqu4VdFAFgPUeP9G07qaKTV4zbscfAkJbqim7Gf1KPkZNqsVuYB/j9uJIxs+Yjiwmc8fS3Y3kyxwIl/eNJcc+1BeAN4LxbL6V5U4vE/MpOtIM8PZ5seeDn7Yk/Y5DhWWwLdQSyxaG987ZBMlLF6ZJTdMT9TbRGD1Fh2HXyBH71K6kLKPuQcisFtldCrGHDaza8MXhj01U8ZlVVofcMGNCh3FWiaUOP2FZyT/ew+Yfe/CTIhlZEfoLF83iPz+; _ga=GA1.2.673649387.1605437434; _gid=GA1.2.805502540.1605437434; _ts_yjad=1605437433686; __td_signed=true; __pp_uid=BUjycp2bLC3rLI0ptJ0VkuyR7luMTMvw; _tdim=8b7464b0-e7f0-4faa-c603-05149038738d; _im_ses.1002516=1; _dc_gtm_UA-56274140-1=1; _dc_gtm_UA-56274140-4=1; _dc_gtm_UA-145584964-1=1; akavpau_vp_reserve=1605439183~id=9b02e9a2dba6ac49506cd1cf5618f468; _gali=searchButton; AWSALB=wAORoPS9id5ayrJXsHAu5zixov/pF9YPH51/Sg76RNCvPOTw4MJ6aeHniGHyLzr8Fmyrw/8UpW3prE0fAl4vO4p5fL/XjFhc7PpRZ2odesyiju1SUcx4M658bbB7; AWSALBCORS=wAORoPS9id5ayrJXsHAu5zixov/pF9YPH51/Sg76RNCvPOTw4MJ6aeHniGHyLzr8Fmyrw/8UpW3prE0fAl4vO4p5fL/XjFhc7PpRZ2odesyiju1SUcx4M658bbB7; bm_sv=F1F1B25DA80B4514844C6598736ED394~745bFQq8t95n4BjGubULksn5BKN4G0gjGRsQJoSY2biNEQfOA0XGqhhLOVzqw9rzeeBZ6GB6f1/1xCYJOPuVWlZeW00kREqXB0yuoCLXzO5a7Xc+7CqGNN5ek/X6iq84/twRfV3yfvO+MjcfrwElmevV99SoUezk4Oz3ekp+d1Y=; _abck=840C942026594D99F3D70ABA6094FC6B~0~YAAQPS7AF59d8qJ1AQAAPsqYywTrdzEA5+mC4y/ChWpT9KlSfg5IUg35r9O/7xH9fdLx++8ytH5gPqbIMMyJzMs1OTuwztTg39Asvl23eq54qKpvQW445r7T0/NIXsO/Uxmc03G0CCjKhJAz/gm6/sCvYGzlWtDGZLJMOlJSdJOogyGz++YnYbXtUne2qOiW8PANOelq8/vQjoacXQIa2tzOpFF4eNMZiq1OELD9vOFyI45z+zCVyXCnyTELWhGlK7jbMnp8WcFNfrCbyFbm/o2by3MM0D/nbhWQmAMHT14uSgPs33VpZ4ilw2hnk28VAHYUQbncLvXmTEy8+sOg8rM=~-1~-1~-1; _td=b3021296-5483-4581-8026-0aa4cff28331; _im_id.1002516=bd394b089cb07ebd.1605437434.1.1605438591.1605437434.')

result=$(echo "${response}" | grep "hasGotReservation" -A 4 | grep "name" | grep -Ev "${ignore}" | sed -r "s/<.+>(\\S*)<\\/.+>/\1/g" | awk '{print $1}')

if [[ ! "${result}" ]];then
    echo "Not found any restaurants."
    exit 0
fi

curl -X POST --data-urlencode "payload={\"channel\": \"#notification\", \"username\": \"disney checker\", \"text\": \"レストランの空きがみつかったよ\n${result}\n${url}\", \"icon_emoji\": \":robot_face:\"}" "${SLACK_WEBHOOK_URL}"
