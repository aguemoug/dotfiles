pushd
mkdir -p ~/texmf
cd ~/texmf
git clone https://gitlab.com/aplevich/circuit_macros.git
popd

# installing dpic
git clone https://github.com/rpuntaie/dpic.git
cd dpic
make
sudo cp dpic /usr/local/bin
cd ..
rm -rf dpic

#sudo pacman -S --noconfirm m4

