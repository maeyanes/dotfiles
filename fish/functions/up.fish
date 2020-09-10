function up
    sudo -v

    echo -e '####################################\n# Pull repos \n####################################'
    pull_repos

    echo -e '####################################\n# Software Update \n####################################'
    sudo softwareupdate --install --all

    echo -e '####################################\n# Brew \n####################################'
    bbc
    brew update
    brew upgrade
    mas upgrade
    brew outdated --cask --greedy --verbose | ack --invert-match latest | awk '{print $1;}' | xargs brew upgrade --cask
    brew cleanup
    brew doctor

    echo -e '####################################\n# Pip \n####################################'
    pip-sync ~/.system-config/pip/requirements.txt

    echo -e '####################################\n# Yarn \n####################################'
    yarn global upgrade --silent 2>&1 | ack --invert-match warning

    echo -e '####################################\n# Oh-My-Fish \n####################################'
    omf update;

    echo -e '####################################\n# Done \n####################################'
end