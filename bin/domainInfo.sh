#/usr/bin/env bash

# for a specified domain, print:
#   - whether it's registered
#   - whether it has >0 MX records
#   - whether it's a Company API 200
#   - the category from Company API if it's available

set -e
set -o pipefail

TF=$(mktemp "${TMPDIR:-/tmp}"/domainInfo.XXXX)
: ${API_KEY:?"Must not be empty"}

company () {
    local url="https://api.fullcontact.com/v2/company/lookup?domain=$1&apiKey=$API_KEY"
    curl -sS "$url" > $TF
    local status=$(cat $TF | jq -r '.status')
    local category=$(cat $TF | jq -r '.category[0].code' | sed 's/^null$//')
    printf "\"%s\",\"%s\"\n" "$status" "$category"
}

dns () {
    local result=$(nslookup -type=MX $1)
    case "$result" in
        *NXDOMAIN*)
            printf "0,";;
        *)
            printf "1,";;
    esac
    case "$result" in
        *"mail exchanger"*)
            printf "1,";;
        *)
            printf "0,";;
    esac
}

main () {
    printf "\"%s\"," "$1"
    dns "$1"
    company "$1"
}

main "$1"
