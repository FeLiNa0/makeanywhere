# Enable autocomplete with the makeanywhere command and create an alias called 'ma'
# Check the function defined properly with
# $ functions makeanywhere
if command -v makeanywhere > /dev/null
    set -g MAKEANYWHERE (which makeanywhere)
    function makeanywhere --wraps make --description "makeanywhere --wraps make $MAKEANYWHERE"
        "$MAKEANYWHERE" $argv
    end

    alias ma makeanywhere
end
