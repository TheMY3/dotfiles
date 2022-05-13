#/bin/zsh

nb=$(checkupdates | wc -l)

if [[ $nb -ge 150 ]]
then
    class="high"
elif [[ $nb -ge 100 ]]
then
    class="medium"
elif [[ $nb -ge 50 ]]
then
    class="low"
else
    class="zero"
fi

echo -e "{\"class\":\"$class\",\"text\":$nb}"
