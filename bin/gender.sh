#!/bin/sh

printf "%s,%s,%s,%s\n" "given" "family" "%male" "%female"
while read line; do
    given=$(echo $line | cut -d, -f1)
    family=$(echo $line | cut -d, -f2)
    response=$(curl -sS "https://api.fullcontact.com/v2/name/stats.json?givenName=$given&familyName=$family&apiKey=${API_KEY:?Must not be empty}")
    male=$(echo $response | jq -r '.name.given.male.likelihood')
    female=$(echo $response | jq -r '.name.given.female.likelihood')
    printf "%s,%s,%s,%s\n" "$given" "$family" "$male" "$female"
done
